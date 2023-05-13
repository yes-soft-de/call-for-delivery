import 'dart:async';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_orders/model/order/order_details_model.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/ui/widgets/order_details_widget/custom_alert_paid_cash.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/helpers/text_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/request/order_invoice_request.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';

@injectable
class OrderStatusScreen extends StatefulWidget {
  final OrderStatusStateManager stateManager;

  const OrderStatusScreen(this.stateManager);

  @override
  OrderStatusScreenState createState() => OrderStatusScreenState();
}

class OrderStatusScreenState extends State<OrderStatusScreen> {
  String? orderId;
  States? currentState;
  OrderInvoiceRequest? invoiceRequest;
  bool makeInvoice = false;
  bool deliverOnMe = false;
  late FlutterTts flutterTts;
  StreamSubscription? stateSub;
  StreamSubscription? globalStateSub;
  late TextEditingController distanceCalculator;
  late TextEditingController paymentController;
  bool justOpen = true;
  @override
  void dispose() {
    stateSub?.cancel();
    globalStateSub?.cancel();
    distanceCalculator.dispose();
    paymentController.dispose();
    super.dispose();
  }

  OrderStatusStateManager get manager => widget.stateManager;
  LatLng? myLocation;
  @override
  void initState() {
    currentState = LoadingState(this);
    distanceCalculator = TextEditingController();
    paymentController = TextEditingController();

    stateSub = widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getIt<FlutterTextToSpeech>().init().then((value) {
      flutterTts = value;
    });
    canRequestLocation().then((value) async {
      if (value) {
        Logger().info('Location enabled', '$value');
        Geolocator.getCurrentPosition().then((event) {
          myLocation = LatLng(event.latitude, event.longitude);
          Logger().info('Location with us for the first time',
              myLocation?.toJson().toString() ?? 'null');
          setState(() {});
        });
        Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
          distanceFilter: 100,
        )).listen((event) {
          myLocation = LatLng(event.latitude, event.longitude);
          Logger().info(
              'Location with us ', myLocation?.toJson().toString() ?? 'null');
          setState(() {});
        });
      }
    });
    super.initState();
  }

  Future speak(String speak) async {
    if (speak == '') {
      return;
    }
    await flutterTts.speak(speak);
  }

  Future stop() async {
    await flutterTts.stop();
  }

  int currentIndex = 0;

  void createChatRoom(int orderId, int storeId) {
    widget.stateManager.createChatRoom(this, orderId, storeId);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  bool _isCostOk(UpdateOrderRequest request, OrderDetailsModel orderInfo) {
    if (orderInfo.orderCost == 0) {
      return (request.orderCost ?? 0) < 0;
    }
    return (request.orderCost ?? 0) <= 0;
  }

  void requestOrderProgress(
      UpdateOrderRequest request, OrderDetailsModel orderInfo) {
    if (orderInfo.state == OrderStatusEnum.DELIVERING &&
        (request.distance == null ||
            _isCostOk(request, orderInfo) && orderInfo.payment == 'cash')) {
      showDialog(
          context: context,
          builder: (ctx) {
            return CustomAlertDialog(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                content: request.distance == null
                    ? S.current.pleaseProvideDistance
                    : S.current.pleaseProvideCashReceivedFromClient);
          });
    } else {
      showDialog(
          context: context,
          routeSettings: const RouteSettings(name: '/accepting_order'),
          builder: (_) {
            return CustomAlertDialog(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (request.orderCost != null &&
                      request.state == 'delivered') {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        routeSettings: const RouteSettings(name: '/paid'),
                        builder: (_) {
                          return CustomAlertDialogForCash(
                              onPressed: (paid) {
                                Navigator.of(context).pop();
                                request.paid = paid ? 1 : 2;
                                widget.stateManager.updateOrder(request, this);
                              },
                              content: S.of(context).paidToProvider);
                        });
                  } else if (orderInfo.state == OrderStatusEnum.IN_STORE &&
                      orderInfo.payment == 'card') {
                    noNeedToTakeMoneyDialog(request);
                  } else {
                    widget.stateManager.updateOrder(request, this);
                  }
                },
                content: S.of(context).confirmUpdateOrderStatus);
          });
    }
  }

  Future<dynamic> noNeedToTakeMoneyDialog(UpdateOrderRequest request) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.current.warnning),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(S.current.dontTakeMoneyThisOrderIsPaidAlready),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    onPressed: () {
                      widget.stateManager.updateOrder(request, this);

                      Navigator.of(context).pop();
                    },
                    child: Text(S.current.accept)),
              ),
            ),
          ],
        );
      },
    );
  }

  void getOrderDetails(var orderId) {
    widget.stateManager.getOrderDetails(orderId, this);
  }

  void goBack() {
    Navigator.of(context).pop();
  }
  
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && flag) {
      orderId = args.toString();
      widget.stateManager.getOrderDetails(int.tryParse(orderId!) ?? -1, this);
      flag = false;
      refresh();
    }
    return GestureDetector(
        onTap: () {
          var focus = FocusScope.of(context);
          if (focus.canRequestFocus) {
            focus.unfocus();
          }
        },
        child: Scaffold(
          body: currentState?.getUI(context),
        ));
  }

  Future<bool> canRequestLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await loc.Location().requestService();
        if (!serviceEnabled) {
          return false;
        }
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}

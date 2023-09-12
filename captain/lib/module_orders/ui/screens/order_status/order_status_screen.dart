import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/model/order/order_details_model.dart';
import 'package:c4d/module_orders/request/order_invoice_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/order_details_widget/custom_alert_paid_cash.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/helpers/text_reader.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen();

  @override
  OrderStatusScreenState createState() => OrderStatusScreenState();
}

class OrderStatusScreenState extends State<OrderStatusScreen> {
  late States currentState;
  late OrderStatusStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  String? orderId;
  OrderInvoiceRequest? invoiceRequest;
  bool makeInvoice = false;
  bool deliverOnMe = false;
  late FlutterTts flutterTts;
  late TextEditingController distanceCalculator;
  late TextEditingController paymentController;
  bool justOpen = true;
  int currentIndex = 0;

  OrderStatusStateManager get manager => _stateManager;
  LatLng? myLocation;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();

    distanceCalculator = TextEditingController();
    paymentController = TextEditingController();

    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getIt<FlutterTextToSpeech>().init().then((value) {
      flutterTts = value;
    });
    DeepLinksService.canRequestLocation().then((value) async {
      if (value) {
        Logger.info('Location enabled', '$value');
        Geolocator.getCurrentPosition().then((event) {
          myLocation = LatLng(event.latitude, event.longitude);
          Logger.info('Location with us for the first time',
              myLocation?.toJson().toString() ?? 'null');
          setState(() {});
        });
        Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
          distanceFilter: 100,
        )).listen((event) {
          myLocation = LatLng(event.latitude, event.longitude);
          Logger.info(
              'Location with us ', myLocation?.toJson().toString() ?? 'null');
          setState(() {});
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    distanceCalculator.dispose();
    paymentController.dispose();
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
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

  void createChatRoom(int orderId, int storeId, String? storeName) {
    _stateManager.createChatRoom(this, orderId, storeId, storeName);
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
                    // payment cash show payment to provider dialog
                    if (orderInfo.payment == 'cash') {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          routeSettings: const RouteSettings(name: '/paid'),
                          builder: (_) {
                            return CustomAlertDialogForCash(
                                onPressed: (paid) {
                                  Navigator.of(context).pop();
                                  request.paid = paid ? 1 : 2;
                                  _stateManager.updateOrder(request, this);
                                },
                                content: S.of(context).paidToProvider);
                          });
                    }
                    // payment is card no need to show payment to provider dialog
                    // send the request directly
                    else {
                      _stateManager.updateOrder(request, this);
                    }
                  } else if (orderInfo.state == OrderStatusEnum.IN_STORE &&
                      orderInfo.payment == 'card') {
                    noNeedToTakeMoneyDialog(request);
                  } else {
                    _stateManager.updateOrder(request, this);
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
                      _stateManager.updateOrder(request, this);

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
    _stateManager.getOrderDetails(orderId, this);
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
      _stateManager.getOrderDetails(int.tryParse(orderId!) ?? -1, this);
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
          body: currentState.getUI(context),
        ));
  }
}

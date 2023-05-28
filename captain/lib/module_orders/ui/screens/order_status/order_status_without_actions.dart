import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status_without_actions_state_manager.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/text_reader.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_orders/request/order_invoice_request.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

@injectable
class OrderStatusWithoutActionsScreen extends StatefulWidget {
  final OrderStatusWithoutActionsStateManager stateManager;

  const OrderStatusWithoutActionsScreen(this.stateManager);

  @override
  OrderStatusWithoutActionsScreenState createState() =>
      OrderStatusWithoutActionsScreenState();
}

class OrderStatusWithoutActionsScreenState
    extends State<OrderStatusWithoutActionsScreen> {
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
  @override
  void dispose() {
    stateSub?.cancel();
    globalStateSub?.cancel();
    distanceCalculator.dispose();
    paymentController.dispose();
    super.dispose();
  }

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
    globalStateSub = getIt<GlobalStateManager>().stateStream.listen((event) {
      widget.stateManager
          .getOrderDetails(int.tryParse(orderId ?? '-1') ?? -1, this, false);
    });
    getIt<FlutterTextToSpeech>().init().then((value) {
      flutterTts = value;
    });
    DeepLinksService.canRequestLocation().then((value) async {
      if (value) {
        Logger().info('Location enabled', '$value');
        Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
          distanceFilter: 25,
        )).listen((event) {
          myLocation = LatLng(event.latitude, event.longitude);
          Logger().info(
              'Location with us ', myLocation?.toJson().toString() ?? 'null');
          if (mounted) {
            setState(() {});
          }
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

  void getOrderDetails(var orderId) {
    widget.stateManager.getOrderDetails(orderId, this);
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


}

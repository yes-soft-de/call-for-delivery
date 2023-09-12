import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/request/order_invoice_request.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status_without_actions_state_manager.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/text_reader.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class OrderStatusWithoutActionsScreen extends StatefulWidget {
  const OrderStatusWithoutActionsScreen();

  @override
  OrderStatusWithoutActionsScreenState createState() =>
      OrderStatusWithoutActionsScreenState();
}

class OrderStatusWithoutActionsScreenState
    extends State<OrderStatusWithoutActionsScreen> {
  late States currentState;
  late OrderStatusWithoutActionsStateManager _stateManager;
  late StreamSubscription _streamSubscription;
  late StreamSubscription _globalStateSub;

  String? orderId;
  OrderInvoiceRequest? invoiceRequest;
  bool makeInvoice = false;
  bool deliverOnMe = false;
  late FlutterTts flutterTts;
  late TextEditingController distanceCalculator;
  late TextEditingController paymentController;

  int currentIndex = 0;
  LatLng? myLocation;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    distanceCalculator = TextEditingController();
    paymentController = TextEditingController();
    _streamSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    _globalStateSub = getIt<GlobalStateManager>().stateStream.listen((event) {
      _stateManager.getOrderDetails(
          int.tryParse(orderId ?? '-1') ?? -1, this, false);
    });
    getIt<FlutterTextToSpeech>().init().then((value) {
      flutterTts = value;
    });
    DeepLinksService.canRequestLocation().then((value) async {
      if (value) {
        Logger.info('Location enabled', '$value');
        Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
          distanceFilter: 25,
        )).listen((event) {
          myLocation = LatLng(event.latitude, event.longitude);
          Logger.info(
              'Location with us ', myLocation?.toJson().toString() ?? 'null');
          if (mounted) {
            setState(() {});
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _globalStateSub.cancel();
    distanceCalculator.dispose();
    paymentController.dispose();
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

  void getOrderDetails(var orderId) {
    _stateManager.getOrderDetails(orderId, this);
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

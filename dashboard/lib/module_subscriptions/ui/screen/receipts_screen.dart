import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_subscriptions/request/payment/paymnet_status_request.dart';
import 'package:c4d/module_subscriptions/request/receiptsRequest.dart';
import 'package:c4d/module_subscriptions/state_manager/receipts_state_manager.dart';
import 'package:flutter/material.dart';

class ReceiptsScreen extends StatefulWidget {
  const ReceiptsScreen();

  @override
  State<ReceiptsScreen> createState() => ReceiptsScreenState();
}

class ReceiptsScreenState extends State<ReceiptsScreen> {
  late States _currentState;
  late ReceiptsStateManager _stateManager;
  late StreamSubscription _streamSubscription;

  late StoreProfileModel storeProfileModel;

  @override
  void initState() {
    _currentState = LoadingState(this);

    _stateManager = getIt();
    _streamSubscription =
        _streamSubscription = _stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void getReceipts(ReceiptsRequest request) {
    request.copyWith(storeOwnerProfileId: storeProfileModel.id);
    _stateManager.getReceipts(
      this,
      request,
    );
  }

  void makePayment(PaymentStatusRequest request, Function onSuccess) {
    _stateManager.makePayment(this, request, onSuccess);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args is StoreProfileModel) {
        storeProfileModel = args;
        flag = false;
      }
      getReceipts(ReceiptsRequest(storeOwnerProfileId: storeProfileModel.id));
    }
    return Scaffold(body: _currentState.getUI(context));
  }
}

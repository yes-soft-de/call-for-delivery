import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/state_manager/store_balance_state_manager.dart';

class StoreBalanceScreen extends StatefulWidget {
  StoreBalanceScreen();

  @override
  StoreBalanceScreenState createState() => StoreBalanceScreenState();
}

class StoreBalanceScreenState extends State<StoreBalanceScreen> {
  late States currentState;
  late StoreBalanceStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  int storeID = -1;
  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void pay(CreateStorePaymentsRequest request) {
    _stateManager.payForStore(this, request);
  }

  void deletePay(String id) {
    _stateManager.deletePayment(this, id);
  }

  void getPayments() {
    _stateManager.getBalance(this, storeID);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (storeID == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        storeID = arg;
        _stateManager.getBalance(this, storeID);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).paymentFromStore),
      body: currentState.getUI(context),
    );
  }
}

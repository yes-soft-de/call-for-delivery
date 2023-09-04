import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';

class StoreSubscriptionsFinanceScreen extends StatefulWidget {
  const StoreSubscriptionsFinanceScreen();

  @override
  State<StatefulWidget> createState() => StoreSubscriptionsFinanceScreenState();
}

class StoreSubscriptionsFinanceScreenState
    extends State<StoreSubscriptionsFinanceScreen> {
  late States _currentState;
  late StoreSubscriptionsFinanceStateManager _stateManager;
  late StreamSubscription _streamSubscription;

  String? selectedPlan;
  @override
  void initState() {
    _currentState = LoadingState(this);
    _stateManager = getIt();
    _streamSubscription = _stateManager.stateStream.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      _stateManager.getAccountBalance(this, storeID);
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  StoreSubscriptionsFinanceStateManager get manager => _stateManager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    refresh();
  }

  int storeID = -1;
  @override
  Widget build(BuildContext context) {
    if (storeID == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        storeID = arg;
        _stateManager.getAccountBalance(this, storeID);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.currentSubscriptions),
      body: _currentState.getUI(context),
    );
  }
}

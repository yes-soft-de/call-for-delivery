import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';

class StoreSubscriptionsExpiredFinanceScreen extends StatefulWidget {
  const StoreSubscriptionsExpiredFinanceScreen();

  @override
  State<StatefulWidget> createState() =>
      StoreSubscriptionsExpiredFinanceScreenState();
}

class StoreSubscriptionsExpiredFinanceScreenState
    extends State<StoreSubscriptionsExpiredFinanceScreen> {
  late States _currentState;
  late StoreSubscriptionsExpiredFinanceStateManager _stateManager;
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

  StoreSubscriptionsExpiredFinanceStateManager get manager => _stateManager;
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
      appBar:
          CustomC4dAppBar.appBar(context, title: S.current.endedSubscriptions),
      body: _currentState.getUI(context),
    );
  }
}

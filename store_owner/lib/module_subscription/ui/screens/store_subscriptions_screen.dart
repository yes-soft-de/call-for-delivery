import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_subscription/state_manager/store_subscriptions_finance_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoreSubscriptionsFinanceScreen extends StatefulWidget {
  final StoreSubscriptionsFinanceStateManager _manager;

  const StoreSubscriptionsFinanceScreen(this._manager);

  @override
  State<StatefulWidget> createState() => StoreSubscriptionsFinanceScreenState();
}

class StoreSubscriptionsFinanceScreenState
    extends State<StoreSubscriptionsFinanceScreen> {
  States? _currentState;
  String? selectedPlan;
  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    widget._manager.getAccountBalance(this);
    super.initState();
  }

  StoreSubscriptionsFinanceStateManager get manager => widget._manager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentState?.getUI(context) ?? Container(),
    );
  }
}

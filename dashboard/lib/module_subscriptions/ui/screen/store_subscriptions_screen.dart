import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
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
    getIt<GlobalStateManager>().stateStream.listen((event) {
      widget._manager.getAccountBalance(this, storeID);
    });
    super.initState();
  }

  StoreSubscriptionsFinanceStateManager get manager => widget._manager;
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
        widget._manager.getAccountBalance(this, storeID);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.current.accountBalance),
      body: _currentState?.getUI(context) ?? Container(),
    );
  }
}

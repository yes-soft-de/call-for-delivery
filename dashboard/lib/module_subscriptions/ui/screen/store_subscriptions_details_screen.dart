import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/model/store_subscriptions_financial.dart';
import 'package:c4d/module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart';
import 'package:c4d/module_subscriptions/ui/state/store_financial_subscriptions_details/store_financial_details_state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoreSubscriptionsFinanceDetailsScreen extends StatefulWidget {
  final StoreFinancialSubscriptionsDuesDetailsStateManager _manager;
  const StoreSubscriptionsFinanceDetailsScreen(
    this._manager,
  );
  @override
  State<StatefulWidget> createState() =>
      StoreSubscriptionsFinanceDetailsScreenState();
}

class StoreSubscriptionsFinanceDetailsScreenState
    extends State<StoreSubscriptionsFinanceDetailsScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = StoreSubscriptionsFinanceDetailsStateLoaded(this);
    manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  StoreFinancialSubscriptionsDuesDetailsStateManager get manager =>
      widget._manager;

  void refresh() {
    if (mounted) setState(() {});
  }

  late StoreSubscriptionsFinanceModel model;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is StoreSubscriptionsFinanceModel && flag) {
      model = args;
      flag = false;
    }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.financeSubscriptionDetails),
        body: currentState.getUI(context));
  }
}

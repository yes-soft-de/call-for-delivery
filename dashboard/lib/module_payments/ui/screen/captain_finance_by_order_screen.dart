import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_payments/state_manager/captain_finance_by_order_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';

@injectable
class CaptainFinanceByOrderScreen extends StatefulWidget {
  final CaptainFinanceByOrderStateManager _stateManager;

  CaptainFinanceByOrderScreen(this._stateManager);

  @override
  CaptainFinanceByOrderScreenState createState() =>
      CaptainFinanceByOrderScreenState();
}

class CaptainFinanceByOrderScreenState
    extends State<CaptainFinanceByOrderScreen> {
  late States currentState;
  int storeID = -1;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    getFinances();
    super.initState();
  }

  CaptainFinanceByOrderStateManager get stateManager => widget._stateManager;

  void getFinances() {
    widget._stateManager.getFinances(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).financeByOrders, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

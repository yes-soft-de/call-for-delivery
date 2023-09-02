import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_payments/state_manager/captain_finance_by_order_count_state_manager.dart';
import 'package:c4d/module_payments/ui/widget/finance_by_orders_count.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';

class CaptainFinanceByCountOrderScreen extends StatefulWidget {
  CaptainFinanceByCountOrderScreen();

  @override
  CaptainFinanceByCountOrderScreenState createState() =>
      CaptainFinanceByCountOrderScreenState();
}

class CaptainFinanceByCountOrderScreenState
    extends State<CaptainFinanceByCountOrderScreen> {
  late States currentState;
  late CaptainFinanceByOrderCountStateManager _stateManager;
  late StreamSubscription _streamSubscription;

  int storeID = -1;
  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _streamSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    getFinances();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  CaptainFinanceByOrderCountStateManager get stateManager => _stateManager;
  void getFinances() {
    _stateManager.getFinances(this);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return FinanceByOrderCountForm(
                      onSave: (request) {
                        stateManager.createFinance(this, request);
                      },
                    );
                  });
            },
            icon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add_rounded,
                  color: Theme.of(context).textTheme.labelLarge?.color ??
                      Colors.white),
            ),
            label: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                S.current.addWorkPackage,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )),
      ),
      body: currentState.getUI(context),
    );
  }
}

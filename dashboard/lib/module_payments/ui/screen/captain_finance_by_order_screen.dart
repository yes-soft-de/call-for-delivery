import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_payments/state_manager/captain_finance_by_order_state_manager.dart';
import 'package:c4d/module_payments/ui/widget/finance_by_order_form.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';

class CaptainFinanceByOrderScreen extends StatefulWidget {
  CaptainFinanceByOrderScreen();

  @override
  CaptainFinanceByOrderScreenState createState() =>
      CaptainFinanceByOrderScreenState();
}

class CaptainFinanceByOrderScreenState
    extends State<CaptainFinanceByOrderScreen> {
  late States currentState;
  late CaptainFinanceByOrderStateManager _stateManager;
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
    getFinances();
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  CaptainFinanceByOrderStateManager get stateManager => _stateManager;

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
          title: S.of(context).financeCountOrder, icon: Icons.menu, onTap: () {
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
                    return FinanceByOrderForm(
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

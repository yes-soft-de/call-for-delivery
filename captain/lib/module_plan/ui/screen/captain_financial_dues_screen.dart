import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_plan/state_manager/captain_financial_dues_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainFinancialDuesScreen extends StatefulWidget {
  final CaptainFinancialDuesStateManager _manager;

  const CaptainFinancialDuesScreen(this._manager);

  @override
  State<StatefulWidget> createState() => CaptainFinancialDuesScreenState();
}

class CaptainFinancialDuesScreenState
    extends State<CaptainFinancialDuesScreen> {
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

  CaptainFinancialDuesStateManager get manager => widget._manager;
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

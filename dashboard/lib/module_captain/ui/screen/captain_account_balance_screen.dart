import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/state_manager/captain_account_balance_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainAccountBalanceScreen extends StatefulWidget {
  final AccountBalanceStateManager _manager;

  const CaptainAccountBalanceScreen(this._manager);

  @override
  State<StatefulWidget> createState() => CaptainAccountBalanceScreenState();
}

class CaptainAccountBalanceScreenState extends State<CaptainAccountBalanceScreen> {
  States? _currentState;
  String? selectedPlan;
  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  AccountBalanceStateManager get manager => widget._manager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    refresh();
  }

  late int captainID = -1;
  bool flage = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flage) {
      if (args is int) {
        captainID = args;
      }
    }
    return Scaffold(
      body: _currentState?.getUI(context) ?? Container(),
    );
  }
}

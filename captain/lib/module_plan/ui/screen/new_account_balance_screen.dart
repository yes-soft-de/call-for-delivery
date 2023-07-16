import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/state_manager/new_account_balance_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewAccountBalanceScreen extends StatefulWidget {
  final NewAccountBalanceStateManager _manager;

  const NewAccountBalanceScreen(this._manager);

  @override
  State<StatefulWidget> createState() => NewAccountBalanceScreenState();
}

class NewAccountBalanceScreenState extends State<NewAccountBalanceScreen> {
  States? _currentState;
  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.myBalance,
      ),
      body: _currentState?.getUI(context) ?? Container(),
    );
  }
}

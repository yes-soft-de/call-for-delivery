import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/state_manager/plan_screen_state_manager.dart';
import 'package:c4d/module_plan/ui/state/plan_state.dart';
import 'package:c4d/module_plan/ui/state/plan_state_loading.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

@injectable
class PlanScreen extends StatefulWidget {
  final PlanScreenStateManager _manager;

  PlanScreen(this._manager);

  @override
  State<StatefulWidget> createState() => PlanScreenState();
}

class PlanScreenState extends State<PlanScreen> {
  PlanState? _currentState;

  @override
  void initState() {
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    widget._manager.getAccountBalance(this);
    super.initState();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    widget._manager.getAccountBalance(this);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    _currentState ??= PlanScreenStateLoading(this);
    return Scaffold(
      appBar: _currentState is PlanScreenStateError
          ? null
          : CustomC4dAppBar.appBar(context, title: S.current.myBalance),
      body: _currentState?.getUI(context) ?? Container(),
    );
  }
}

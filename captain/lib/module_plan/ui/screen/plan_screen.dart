import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/state_manager/plan_screen_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

@injectable
class PlanScreen extends StatefulWidget {
  final PlanScreenStateManager _manager;

  const PlanScreen(this._manager);

  @override
  State<StatefulWidget> createState() => PlanScreenState();
}

class PlanScreenState extends State<PlanScreen> {
  States? _currentState;
  String? planID;
  @override
  void initState() {
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  PlanScreenStateManager get manager => widget._manager;
  void refresh() {
    if (mounted) setState(() {});
  }

  void getAccount() {
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.current.myBalance),
      body: _currentState?.getUI(context) ?? Container(),
    );
  }
}

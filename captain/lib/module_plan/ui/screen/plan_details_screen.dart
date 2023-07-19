import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/my_profit_model.dart';
import 'package:c4d/module_plan/state_manager/my_profits_state_manager.dart';
import 'package:c4d/module_plan/ui/state/plan_details/plan_details_state_loaded.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlanDetailsScreen extends StatefulWidget {
  final MyProfitsStateManager _manager;

  const PlanDetailsScreen(this._manager);

  @override
  State<StatefulWidget> createState() => PlanDetailsScreenState();
}

class PlanDetailsScreenState extends State<PlanDetailsScreen> {
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

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args is MyProfitModel) {
        _currentState = PlanDetailsStateLoaded(this, args);
      }
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(
          context,
          title: S.current.planDetails,
        ),
        body: _currentState?.getUI(context) ?? Container(),
      ),
    );
  }
}

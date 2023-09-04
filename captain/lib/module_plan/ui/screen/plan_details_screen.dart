import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/my_profits_model.dart';
import 'package:c4d/module_plan/state_manager/my_profits_state_manager.dart';
import 'package:c4d/module_plan/ui/state/plan_details/plan_details_state_loaded.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PlanDetailsScreen extends StatefulWidget {
  const PlanDetailsScreen();

  @override
  State<StatefulWidget> createState() => PlanDetailsScreenState();
}

class PlanDetailsScreenState extends State<PlanDetailsScreen> {
  late States _currentState;
  late MyProfitsStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  @override
  void initState() {
    _currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
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
      if (args is MyProfitsModel) {
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
        body: _currentState.getUI(context),
      ),
    );
  }
}

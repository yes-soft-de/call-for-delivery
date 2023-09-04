import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/state_manager/activity/activity_state_manager.dart';
import 'package:c4d/module_profile/ui/states/activity_state/activity_state.dart';
import 'package:c4d/module_profile/ui/states/activity_state_loading/activity_state_loading.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen();

  @override
  State<StatefulWidget> createState() => ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> {
  late ActivityState _currentState;
  late ActivityStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  @override
  void initState() {
    _currentState = ActivityStateLoading(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).completedOrders,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: _currentState.getUI(context),
    );
  }
}

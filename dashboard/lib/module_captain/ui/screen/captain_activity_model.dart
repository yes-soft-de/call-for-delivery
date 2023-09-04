import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/request/captain_activities_filter_request.dart';
import 'package:c4d/module_captain/state_manager/captain_activity_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CaptainsActivityScreen extends StatefulWidget {
  CaptainsActivityScreen();

  @override
  CaptainsActivityScreenState createState() => CaptainsActivityScreenState();
}

class CaptainsActivityScreenState extends State<CaptainsActivityScreen> {
  late States currentState;
  late CaptainsActivityStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  late CaptainActivityFilterRequest filter;
  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    stateManager.getCaptains(this);
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    filter = CaptainActivityFilterRequest();
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  CaptainsActivityStateManager get stateManager => _stateManager;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.captainActivity, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

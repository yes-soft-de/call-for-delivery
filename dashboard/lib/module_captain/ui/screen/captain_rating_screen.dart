import 'dart:async';

import 'package:c4d/di/di_config.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/state_manager/captain_rating_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';

class CaptainsRatingScreen extends StatefulWidget {
  CaptainsRatingScreen();

  @override
  CaptainsRatingScreenState createState() => CaptainsRatingScreenState();
}

class CaptainsRatingScreenState extends State<CaptainsRatingScreen> {
  late States currentState;
  late CaptainsRatingStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    stateManager.getCaptains(this);
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  CaptainsRatingStateManager get stateManager => _stateManager;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.captainsRating, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

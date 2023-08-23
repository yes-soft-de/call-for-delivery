import 'package:c4d/di/di_config.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/state_manager/captain_list.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

class CaptainsScreen extends StatefulWidget {
  CaptainsScreen();

  @override
  CaptainsScreenState createState() => CaptainsScreenState();
}

class CaptainsScreenState extends State<CaptainsScreen> {
  late States currentState;
  late CaptainsStateManager _stateManager;
  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt<CaptainsStateManager>();
    _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });

    _stateManager.getCaptains(this);
    super.initState();
  }

  void getCaptains() {
    _stateManager.getCaptains(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).captains, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _stateManager.dispose();
    super.dispose();
  }
}

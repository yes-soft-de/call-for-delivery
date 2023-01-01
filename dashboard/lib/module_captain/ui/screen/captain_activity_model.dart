import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/request/captain_activities_filter_request.dart';
import 'package:c4d/module_captain/state_manager/captain_activity_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';

@injectable
class CaptainsActivityScreen extends StatefulWidget {
  final CaptainsActivityStateManager _stateManager;

  CaptainsActivityScreen(this._stateManager);

  @override
  CaptainsActivityScreenState createState() => CaptainsActivityScreenState();
}

class CaptainsActivityScreenState extends State<CaptainsActivityScreen> {
  late States currentState;
  CaptainActivityFilterRequest? filter;
  @override
  void initState() {
    currentState = LoadingState(this);
    stateManager.getCaptains(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    filter = CaptainActivityFilterRequest();
    super.initState();
  }

  CaptainsActivityStateManager get stateManager => widget._stateManager;

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

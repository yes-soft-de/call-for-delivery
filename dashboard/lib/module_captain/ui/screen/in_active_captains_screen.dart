import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/state_manager/in_active_captains_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';

@injectable
class InActiveCaptainsScreen extends StatefulWidget {
  final InActiveCaptainsStateManager _stateManager;

  InActiveCaptainsScreen(this._stateManager);

  @override
  InActiveCaptainsScreenState createState() => InActiveCaptainsScreenState();
}

class InActiveCaptainsScreenState extends State<InActiveCaptainsScreen> {
  late States currentState;

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    widget._stateManager.getCaptains(this);
    getIt<GlobalStateManager>().stateStream.listen((event) {
      getCaptains();
    });
    super.initState();
  }

  void getCaptains() {
    widget._stateManager.getCaptains(this);
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
          title: S.of(context).inActiveCaptains, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

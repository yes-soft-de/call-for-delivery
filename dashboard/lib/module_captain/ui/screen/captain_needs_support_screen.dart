import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/state_manager/captain_need_support_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainsNeedsSupportScreen extends StatefulWidget {
  CaptainsNeedsSupportScreen();

  @override
  CaptainsNeedsSupportScreenState createState() =>
      CaptainsNeedsSupportScreenState();
}

class CaptainsNeedsSupportScreenState
    extends State<CaptainsNeedsSupportScreen> {
  late States currentState;
  late CaptainsNeedsSupportStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    _stateManager.getCaptainSupport(this);
    super.initState();
  }

  void getClients() {
    _stateManager.getCaptainSupport(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
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
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).directSupport, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

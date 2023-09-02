import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_stores/request/filter_store_activity_request.dart';
import 'package:c4d/module_stores/state_manager/top_active_store.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TopActiveStoreScreen extends StatefulWidget {
  TopActiveStoreScreen();
  @override
  TopActiveStoreScreenState createState() => TopActiveStoreScreenState();
}

class TopActiveStoreScreenState extends State<TopActiveStoreScreen> {
  late States currentState;
  late TopActiveStateManagement _stateManager;
  late StreamSubscription _stateSubscription;

  FilterStoreActivityRequest? filter;
  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    // getIt<GlobalStateManager>().stateStream.listen((event) {
    getTopActivityStore();
    // });
    filter = FilterStoreActivityRequest();
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void getTopActivityStore() {
    _stateManager.getTopActiveStore(this);
  }

  TopActiveStateManagement get stateManager => _stateManager;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.topstoreActivity, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

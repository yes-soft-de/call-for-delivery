import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/state_manager/stores_state_manager.dart';
import 'package:c4d/utils/global/global_state_manager.dart';

class StoresScreen extends StatefulWidget {
  StoresScreen();

  @override
  StoresScreenState createState() => StoresScreenState();
}

class StoresScreenState extends State<StoresScreen> {
  late States currentState;
  late StoresStateManager _stateManager;
  late StreamSubscription _stateSubscription;
  late StreamSubscription _globalStateSubscription;

  bool canAddCategories = true;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();

    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        refresh();
      }
    });

    _globalStateSubscription =
        getIt<GlobalStateManager>().stateStream.listen((event) {
      _stateManager.getStores(this);
    });
    _stateManager.getStores(this);
    super.initState();
  }

  void getStores() {
    _stateManager.getStores(this);
  }

//  void addStore(CreateStoreRequest request) {
//    widget._stateManager.createStore(this, request);
//  }

  void updateStore(UpdateStoreRequest request, bool haveImage) {
    _stateManager.updateStore(this, request, haveImage);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _globalStateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).storesList, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      body: currentState.getUI(context),
    );
  }
}

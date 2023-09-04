import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/request/active_store_request.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/state_manager/store_profile_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class StoreInfoScreen extends StatefulWidget {
  StoreInfoScreen();

  @override
  StoreInfoScreenState createState() => StoreInfoScreenState();
}

class StoreInfoScreenState extends State<StoreInfoScreen> {
  late States currentState;
  late StoreProfileStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  bool flagArgs = true;
  StoresModel? model;

  void getStore(int id) {
    _stateManager.getStore(this, id);
  }

  void enableStore(ActiveStoreRequest request, [bool loading = true]) {
    _stateManager.enableStore(this, request, loading);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
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

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  StoreProfileStateManager get stateManager => _stateManager;
  void updateStore(UpdateStoreRequest request, bool haveImage) {
    _stateManager.updateStore(this, request, haveImage);
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && flagArgs) {
      if (args is StoresModel) {
        model = args;
        flagArgs = false;
        getStore(model?.id ?? -1);
      }
    }

    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: model?.storeOwnerName ?? S.current.storeName,
      ),
      body: currentState.getUI(context),
    );
  }
}

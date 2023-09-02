import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_stores/state_manager/stores_need_support_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class StoresNeedsSupportScreen extends StatefulWidget {
  StoresNeedsSupportScreen();

  @override
  StoreNeedsSupportScreenState createState() => StoreNeedsSupportScreenState();
}

class StoreNeedsSupportScreenState extends State<StoresNeedsSupportScreen> {
  late States currentState;
  late StoresNeedsSupportStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    _stateManager.getStores(this);
    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void getClients() {
    _stateManager.getStores(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.of(context).directSupport, icon: Icons.menu, onTap: () {
          GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
        }),
        body: currentState.getUI(context),
      ),
    );
  }
}

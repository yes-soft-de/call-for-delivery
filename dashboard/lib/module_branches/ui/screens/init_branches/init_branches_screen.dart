import 'dart:async';

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branch/branch_model.dart';
import 'package:c4d/module_branches/request/create_list_branches/create_list_branches.dart';
import 'package:c4d/module_branches/state_manager/init_branches_state_manager.dart';
import 'package:c4d/module_branches/ui/state/init_branches_state/init_branches_loaded_state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InitBranchesScreen extends StatefulWidget {
  const InitBranchesScreen();
  @override
  InitBranchesScreenState createState() => InitBranchesScreenState();
}

class InitBranchesScreenState extends State<InitBranchesScreen> {
  late States currentState;
  late InitBranchesStateManager _stateManager;
  late StreamSubscription _streamSubscription;

  // google map controller
  Completer<GoogleMapController> controller = Completer();
  late CustomInfoWindowController customInfoWindowController;
  List<BranchModel> branchLocation = [];

  @override
  void initState() {
    customInfoWindowController = CustomInfoWindowController();
    currentState = InitAccountStateSelectBranch(this);
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) async {
      await Future.delayed(Duration(seconds: 5)).whenComplete(() {
        FeatureDiscovery.discoverFeatures(
          context,
          const <String>{
            'myLocation',
            'selectedMenu',
          },
        );
      });
    });
    _stateManager = getIt();
    _streamSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  void createBranch(CreateListBranchesRequest request) {
    _stateManager.createBranch(this, request);
  }

  void moveToOrder() {
//    Navigator.of(context).pushNamedAndRemoveUntil(
//        OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.store, canGoBack: false),
      body: currentState.getUI(context),
    );
  }
}

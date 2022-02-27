import 'dart:async';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branch/branch_model.dart';
import 'package:c4d/module_branches/request/create_list_branches/create_list_branches.dart';
import 'package:c4d/module_branches/state_manager/init_branches_state_manager.dart';
import 'package:c4d/module_branches/ui/state/init_branches_state/init_branches_loaded_state.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:feature_discovery/feature_discovery.dart';

@injectable
class InitBranchesScreen extends StatefulWidget {
  final InitBranchesStateManager _manager;

  const InitBranchesScreen(this._manager);
  @override
  InitBranchesScreenState createState() => InitBranchesScreenState();
}

class InitBranchesScreenState extends State<InitBranchesScreen> {
  States? currentState;
  // google map controller
  Completer<GoogleMapController> controller = Completer();
  late CustomInfoWindowController customInfoWindowController;
  List<BranchModel> branchLocation = [];

  @override
  void initState() {
    customInfoWindowController = CustomInfoWindowController();
    currentState = InitAccountStateSelectBranch(this);
    SchedulerBinding.instance?.addPostFrameCallback((Duration duration) async {
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
    widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  void createBranch(CreateListBranchesRequest request) {
    widget._manager.createBranch(this, request);
  }

  void moveToOrder() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: CustomMandoobAppBar.appBar(context,
          title: S.current.storeAccountInit, canGoBack: false),
      body: currentState?.getUI(context),
    );
  }
}

import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/bid_orders_routes.dart';
import 'package:c4d/module_main_navigation/nav_routes.dart';
import 'package:c4d/module_profile/model/category_model/category_model.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/state_manager/init_account.state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class InitAccountScreen extends StatefulWidget {
  final InitAccountStateManager _stateManager;

  InitAccountScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => InitAccountScreenState();
}

class InitAccountScreenState extends State<InitAccountScreen> {
  late StreamSubscription _streamSubscription;
  late States currentState;
  Completer<GoogleMapController> controller = Completer();
  late CustomInfoWindowController customInfoWindowController;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        NavRoutes.ROUTE_NAV, (route) => false);
  }

  void initProfile(ProfileRequest request,List<SupplierCategoryModel> categories) {
    widget._stateManager.createProfile(request, this,categories);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getCategories(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.account, canGoBack: false),
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}

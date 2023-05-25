import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_dev/request/create_test_order_request.dart';
import 'package:c4d/module_dev/state_manager/new_order/new_test_order_state_manager.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class NewTestOrderScreen extends StatefulWidget {
  final NewTestOrderStateManager _stateManager;

  NewTestOrderScreen(
    this._stateManager,
  );

  @override
  NewTestOrderScreenState createState() => NewTestOrderScreenState();
}

class NewTestOrderScreenState extends State<NewTestOrderScreen>
    with WidgetsBindingObserver {
  late States currentState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _stateSubscription;

  void addNewOrder(CreateTestOrderRequest request) {
    widget._stateManager.createOrder(this, request);
  }

  void getBranches(List<StoresModel> stores) {
    widget._stateManager.getBranches(this, storeID ?? -1, stores);
  }

  void refresh() {
    setState(() {});
  }

  // New Order state controller
  TextEditingController orderCountController = TextEditingController();
  String? payments;
  int? branch;
  LatLng? customerLocation;
  int? storeID;
  int? costType;
  int? packageType;

  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);
    WidgetsBinding.instance.addObserver(this);
    widget._stateManager.getStores(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    orderCountController.dispose();
    _stateSubscription?.cancel();
    super.dispose();
  }

  void clear() {
    orderCountController.clear();
    branch = null;
    storeID = null;
  }

  void saveInfo(String info) {}
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
            title: S.current.newOrder, icon: Icons.menu, onTap: () {
          GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
        }),
        key: _scaffoldKey,
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}

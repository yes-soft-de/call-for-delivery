import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart';
import 'package:c4d/module_orders/state_manager/owner_orders/owner_orders.state_manager.dart';
import 'package:c4d/module_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/navigator_menu/navigator_menu.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:feature_discovery/feature_discovery.dart';

@injectable
class OwnerOrdersScreen extends StatefulWidget {
  final OwnerOrdersStateManager _stateManager;
  final NewOrderStateManager _newOrderStateManager;

  OwnerOrdersScreen(this._stateManager, this._newOrderStateManager);

  @override
  OwnerOrdersScreenState createState() => OwnerOrdersScreenState();
}

class OwnerOrdersScreenState extends State<OwnerOrdersScreen>
    with WidgetsBindingObserver {
  States? _currentState;
  ProfileModel? currentProfile;
  CompanyInfoResponse? _companyInfo;

  StreamSubscription? _stateSubscription;
  StreamSubscription? _profileSubscription;
  StreamSubscription? _companySubscription;

  Future<void> getMyOrders() async {
    widget._stateManager.getOrders(this);
  }

  void goToSubscription() {}

  void addOrderViaDeepLink(LatLng location) {
    _currentState = LoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.of(context)
          .pushNamed(OrdersRoutes.NEW_ORDER_SCREEN, arguments: location);
    });
  }

  void getInitData() {
    widget._stateManager.initDrawerData();
  }

  @override
  void initState() {
    super.initState();
    _currentState = LoadingState(this);
    getMyOrders();
    WidgetsBinding.instance?.addObserver(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
      if (_currentState is OrdersListStateOrdersLoaded) {
        FeatureDiscovery.discoverFeatures(
          context,
          const <String>{
            'newOrder',
          },
        );
      }
    });
    _profileSubscription = widget._stateManager.profileStream.listen((event) {
      currentProfile = event;
      if (mounted) {
        setState(() {});
      }
    });
    _companySubscription = widget._stateManager.companyStream.listen((event) {
      _companyInfo = event;
      if (mounted) {
        setState(() {});
      }
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      getInitData();
    });
    getInitData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalVariable.mainScreenScaffold,
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.orders, icon: Icons.sort, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }, actions: [
        CustomC4dAppBar.actionIcon(context, onTap: () {
          Navigator.of(context)
              .pushNamed(MyNotificationsRoutes.MY_NOTIFICATIONS);
        }, icon: Icons.notifications_rounded)
      ]),
      drawer: NavigatorMenu(
        profileModel: currentProfile,
      ),
      floatingActionButton: DescribedFeatureOverlay(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(S.current.newOrder),
        description: Text(S.current.newOrderHint),
        overflowMode: OverflowMode.extendBackground,
        featureId: 'newOrder',
        tapTarget: Text(
          S.current.newOrder,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            )),
            onPressed: () {
              Navigator.of(context).pushNamed(OrdersRoutes.NEW_ORDER_SCREEN);
            },
            icon: Icon(Icons.add_rounded,
                color: Theme.of(context).textTheme.button?.color),
            label: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(S.current.newOrder,
                  style: Theme.of(context).textTheme.button),
            )),
      ),
      body: _currentState?.getUI(context),
    );
  }

  @override
  void dispose() {
    if (_stateSubscription != null) {
      _stateSubscription?.cancel();
    }
    if (_profileSubscription != null) {
      _profileSubscription?.cancel();
    }
    if (_companySubscription != null) {
      _companySubscription?.cancel();
    }
    super.dispose();
  }
}

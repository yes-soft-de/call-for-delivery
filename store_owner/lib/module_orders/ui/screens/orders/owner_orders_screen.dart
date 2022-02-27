import 'dart:async';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
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
  OwnerOrdersListState? _currentState;
  ProfileModel? currentProfile;
  CompanyInfoResponse? _companyInfo;

  StreamSubscription? _stateSubscription;
  StreamSubscription? _profileSubscription;
  StreamSubscription? _companySubscription;

  void getMyOrders() {}

  void goToSubscription() {}

  void addOrderViaDeepLink(LatLng location) {
    _currentState = OrdersListStateInit(this);
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
    WidgetsBinding.instance?.addObserver(this);

    _currentState = OrdersListStateInit(this);

    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
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
    DeepLinksService.checkForGeoLink().then((value) {
      if (value != null) {
        Navigator.of(context).pushNamed(
          OrdersRoutes.NEW_ORDER_SCREEN,
          arguments: value,
        );
      }
    });
    getInitData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (ModalRoute.of(context)?.settings.name ==
        OrdersRoutes.NEW_ORDER_SCREEN) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalVariable.mainScreenScaffold,
      appBar: CustomMandoobAppBar.appBar(context,
          title: S.current.orders, icon: Icons.sort, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }),
      drawer: NavigatorMenu(
        profileModel: currentProfile,
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

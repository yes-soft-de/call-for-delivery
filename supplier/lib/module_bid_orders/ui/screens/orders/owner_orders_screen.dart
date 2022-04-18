import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_about/model/company_info_model.dart';
import 'package:c4d/module_bid_orders/bid_orders_routes.dart';
import 'package:c4d/module_bid_orders/request/order_filter_request.dart';
import 'package:c4d/module_bid_orders/state_manager/owner_orders/owner_orders.state_manager.dart';
import 'package:c4d/module_bid_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/module_bid_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:c4d/navigator_menu/navigator_menu.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:feature_discovery/feature_discovery.dart';

@injectable
class OwnerOrdersScreen extends StatefulWidget {
  final OwnerOrdersStateManager _stateManager;
  final OwnerOrdersStateManager _newOrderStateManager;

  OwnerOrdersScreen(this._stateManager, this._newOrderStateManager);

  @override
  OwnerOrdersScreenState createState() => OwnerOrdersScreenState();
}

class OwnerOrdersScreenState extends State<OwnerOrdersScreen>
    with WidgetsBindingObserver {
  late States _currentState;
  ProfileModel? currentProfile;
  CompanyInfoModel? _companyInfo;

  StreamSubscription? _stateSubscription;
  StreamSubscription? _profileSubscription;
  StreamSubscription? _companySubscription;
  StreamSubscription? _globalStateManager;

  Future<void> getMyOrdersFilter([loading = true]) async {
    widget._stateManager.getOrdersFilters(
        this, FilterOrderRequest(state: orderFilter ?? 'pending'), loading);
  }

  void goToSubscription() {}

  void addOrderViaDeepLink(LatLng location) {
    _currentState = LoadingState(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.of(context)
          .pushNamed('', arguments: location);
    });
  }

  void getInitData() {
    widget._stateManager.initDrawerData();
  }

  bool featureFlag = true;
  @override
  void initState() {
    super.initState();
    _currentState = LoadingState(this);
    getInitData();
    widget._stateManager.watcher(this, true);
    WidgetsBinding.instance?.addObserver(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
      if (_currentState is OrdersListStateOrdersLoaded && featureFlag) {
        featureFlag = false;
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

    _globalStateManager =
        getIt<GlobalStateManager>().stateStream.listen((event) {
      if (mounted) {
        getInitData();
        getMyOrdersFilter(false);
      }
    });
  }

  String? orderFilter;
  int currentIndex = 0;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalVariable.mainScreenScaffold,
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.orders, icon: Icons.sort, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      },actions: [
          CustomC4dAppBar.actionIcon(context, onTap: () {
            Navigator.of(context)
                .pushNamed(MyNotificationsRoutes.MY_NOTIFICATIONS);
          }, icon: Icons.notifications_rounded,),
          ]
      ),
      drawer: NavigatorMenu(
        profileModel: currentProfile,
        company: _companyInfo,
      ),
      floatingActionButton: ElevatedButton.icon(
          onPressed:(){},
          icon: Icon(Icons.add_rounded,
              color: Theme.of(context).textTheme.button?.color),
          label: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(S.current.newOrder,
                style: Theme.of(context).textTheme.button),
          )),
      body: Column(
        children: [
          FilterBar(
            cursorRadius: BorderRadius.circular(25),
            animationDuration: Duration(milliseconds: 350),
            backgroundColor: Theme.of(context).backgroundColor,
            currentIndex: currentIndex,
            borderRadius: BorderRadius.circular(25),
            floating: true,
            height: 40,
            cursorColor: currentIndex == 0
                ? Theme.of(context).colorScheme.primary
                : StatusHelper.getOrderStatusColor(OrderStatusEnum.IN_STORE),
            items: [
              FilterItem(label: S.current.pendingOrders),
              FilterItem(label: S.current.onGoingOrder),
            ],
            onItemSelected: (index) {
              if (index == 0) {
                orderFilter = 'pending';
              } else {
                orderFilter = 'ongoing';
              }
              currentIndex = index;
              getMyOrdersFilter();
            },
            selectedContent: Theme.of(context).textTheme.button!.color!,
            unselectedContent: Theme.of(context).textTheme.headline6!.color!,
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(child: _currentState.getUI(context))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    _profileSubscription?.cancel();
    _companySubscription?.cancel();

    _globalStateManager?.cancel();
    super.dispose();
  }

  Future<bool> dismiss() async {
    return false;
  }
}

import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/ui/screens/ongoing_chat_rooms_screen.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:c4d/module_orders/model/company_info_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart';
import 'package:c4d/module_orders/state_manager/owner_orders/owner_orders.state_manager.dart';
import 'package:c4d/module_orders/ui/state/owner_orders/orders.state.dart';
import 'package:c4d/module_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:c4d/module_subscription/model/can_make_order_model.dart';
import 'package:c4d/module_subscription/subscriptions_routes.dart';
import 'package:c4d/navigator_menu/navigator_menu.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/helpers/subscription_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:new_version/new_version.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

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
  late States _currentState;
  ProfileModel? currentProfile;
  CanMakeOrderModel? status;

  CompanyInfoModel? _companyInfo;
  StreamSubscription? _stateSubscription;
  StreamSubscription? _profileSubscription;
  StreamSubscription? _companySubscription;
  StreamSubscription? _statusSubscription;
  StreamSubscription? _globalStateManager;

  Future<void> getMyOrdersFilter([loading = true]) async {
    widget._stateManager.getOrdersFilters(
        this, FilterOrderRequest(state: orderFilter ?? 'pending'), loading);
  }

  void goToSubscription() {}

  void addOrderViaDeepLink(LatLng location) {
    _currentState = LoadingState(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context)
          .pushNamed(OrdersRoutes.NEW_ORDER_SCREEN, arguments: location);
    });
  }

  void getInitData() {
    widget._stateManager.initDrawerData();
  }

  bool featureFlag = true;
  Future<void> checkForUpdates(context) async {
    final newVersion = NewVersion();
    final VersionStatus? status = await newVersion.getVersionStatus();
    if (status?.canUpdate == true) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        dialogTitle: S.current.newVersion,
        dialogText: S.current.newVersionHint
            .replaceAll('^', status.localVersion)
            .replaceAll('&', status.storeVersion),
        updateButtonText: S.current.update,
        dismissButtonText: S.current.later,
      );
    }
  }

  bool openedBottom = false;
  @override
  void initState() {
    super.initState();
    getIt<FireNotificationService>().refreshToken();
    _currentState = LoadingState(this);
    getInitData();
    widget._stateManager.watcher(this, true);
    WidgetsBinding.instance.addObserver(this);
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
    _statusSubscription = widget._stateManager.statusStream.listen((event) {
      status = event;
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
    DeepLinksService.checkForGeoLink().then((value) {
      if (value != null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            SettingRoutes.COPY_LINK_SCREEN, (route) => false,
            arguments: value);
      }
    });
    checkForUpdates(context);
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
      },
          colorIcon: currentIndex == 0
              ? null
              : StatusHelper.getOrderStatusColor(OrderStatusEnum.IN_STORE),
          actions: [
            CustomC4dAppBar.actionIcon(context, onTap: () {
              Navigator.of(context)
                  .pushNamed(MyNotificationsRoutes.MY_NOTIFICATIONS);
            },
                icon: Icons.notifications_rounded,
                colorIcon: currentIndex == 0
                    ? null
                    : StatusHelper.getOrderStatusColor(
                        OrderStatusEnum.IN_STORE)),
            CustomC4dAppBar.actionIcon(context, onTap: () {
              Navigator.of(context).pushNamed(ChatRoutes.roomChatList);
            },
                icon: Icons.chat_rounded,
                colorIcon: currentIndex == 0
                    ? null
                    : StatusHelper.getOrderStatusColor(
                        OrderStatusEnum.IN_STORE))
          ]),
      drawer: NavigatorMenu(
        profileModel: currentProfile,
        company: _companyInfo,
        isUnlimitedPackage: status?.unlimitedPackage ?? false,
        screenState: this,
      ),
      floatingActionButton: Visibility(
        visible: openedBottom == false,
        child: DescribedFeatureOverlay(
          onDismiss: dismiss,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(S.current.newOrder),
          description: Text(S.current.newOrderHint),
          featureId: 'newOrder',
          tapTarget: Text(
            S.current.newOrder,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: currentIndex == 0
                      ? null
                      : StatusHelper.getOrderStatusColor(
                          OrderStatusEnum.IN_STORE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
              onPressed: status != null
                  ? () {
                      if (status?.canCreateOrder == true) {
                        Navigator.of(context)
                            .pushNamed(OrdersRoutes.NEW_ORDER_SCREEN);
                      } else if (status?.status == S.current.inactiveStore) {
                        Fluttertoast.showToast(msg: S.current.inactiveStore);
                      } else {
                        Navigator.of(context).pushNamed(
                            SubscriptionsRoutes.SUBSCRIPTIONS_SCREEN);
                        CustomFlushBarHelper.createError(
                                title: S.current.warnning,
                                message:
                                    SubscriptionsStatusHelper.getStatusMessage(
                                        status?.status ?? ''))
                            .show(context);
                      }
                    }
                  : null,
              icon: Icon(Icons.add_rounded,
                  color: Theme.of(context).textTheme.button?.color),
              label: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(S.current.newOrder,
                    style: Theme.of(context).textTheme.button),
              )),
        ),
      ),
      body: Column(
        children: [
          Visibility(
              visible: status?.canCreateOrder == false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).colorScheme.error),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        S.current.warnning,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                          SubscriptionsStatusHelper.getStatusMessage(
                            status?.status ?? '',
                          ),
                          style: TextStyle(color: Colors.white)),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          getInitData();
                        },
                      ),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 16,
          ),
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
          Expanded(
              child: SwipeDetector(
                  onSwipe: (dir, offset) {
                    if (dir == SwipeDirection.left ||
                        dir == SwipeDirection.right ||
                        dir == SwipeDirection.up) {
                      openedBottom = true;
                      setState(() {});
                      GlobalVariable.mainScreenScaffold.currentState
                          ?.showBottomSheet(
                            (ctx) {
                              return getOngoingChatRoom();
                            },
                            backgroundColor: Theme.of(context).backgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25))),
                            constraints: BoxConstraints(
                              minHeight: 150,
                              maxHeight: 500,
                            ),
                          )
                          .closed
                          .whenComplete(() {
                            openedBottom = false;
                            setState(() {});
                          });
                    }
                  },
                  child: _currentState.getUI(context)))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    _profileSubscription?.cancel();
    _companySubscription?.cancel();
    _statusSubscription?.cancel();
    _globalStateManager?.cancel();
    super.dispose();
  }

  Future<bool> dismiss() async {
    return false;
  }

  Widget getOngoingChatRoom() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          // space
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: getIt<OngoingOrderChatScreen>(),
          ),
        ],
      ),
    );
  }
}

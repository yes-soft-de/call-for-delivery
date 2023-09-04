import 'dart:async';

import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_chat/presistance/chat_hive_helper.dart';
import 'package:c4d/module_chat/repository/chat/chat_repository.dart';
import 'package:c4d/module_deep_links/repository/deep_link_local_repository.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_navigation/menu.dart';
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:c4d/module_orders/state_manager/captain_orders/captain_orders.dart';
import 'package:c4d/module_profile/model/daily_model.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latlong2/latlong.dart';

class CaptainOrdersScreen extends StatefulWidget {
  const CaptainOrdersScreen();

  @override
  State<StatefulWidget> createState() => CaptainOrdersScreenState();
}

class CaptainOrdersScreenState extends State<CaptainOrdersScreen> {
  late States currentState;
  late CaptainOrdersListStateManager _stateManager;
  late StreamSubscription _stateSubscription;
  late StreamSubscription _profileSubscription;
  late StreamSubscription _companySubscription;
  late StreamSubscription _financeSubscription;
  late StreamSubscription _supportMessages;
  late StreamSubscription _globalStateSubscription;
  late StreamSubscription? _firebaseSubscription;

  ProfileModel? _currentProfile;
  DailyFinanceModel? _currentFinance;
  int currentPage = 0;

  String? _lastMessageFromSupportDate;
  ValueNotifier<bool> _isLastMessageFromAdminHasntSeenYet =
      ValueNotifier(false);
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final advancedController = AdvancedDrawerController();
  LatLng? currentLocation;
  CaptainOrdersListStateManager get stateManager => _stateManager;

  @override
  void initState() {
    super.initState();
    _stateManager = getIt();
    farOrders = NotificationsPrefHelper().getFarOrder();
    canRequestLocation();
    getIt<FireNotificationService>().refreshToken();
    currentState = LoadingState(this, picture: true);
    _stateManager.getProfile(this);
    _stateManager.getMyOrders(this);
    _firebaseSubscription =
        FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      _stateManager.getMyOrders(this, false);
    });
    _globalStateSubscription =
        getIt<GlobalStateManager>().stateStream.listen((event) {
      _stateManager.getProfile(this);
      _stateManager.getProfitSummary(this);
    });
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    _profileSubscription = _stateManager.profileStream.listen((event) {
      _currentProfile = event;
      if (_currentProfile != null) {
        somethingMissingInProfileData =
            _currentProfile?.address?.isNotEmpty == false ||
                _currentProfile?.city?.isNotEmpty == false;
      }
      if (mounted) {
        setState(() {});
      }
      if (_currentProfile != null && _currentProfile!.roomID != null) {
        subscribeToDirectSupportMessages(_currentProfile!.roomID!);
        ChatHiveHelper().setDirectSupportRom(_currentProfile!.roomID!);
      }
      _stateManager.getUpdates(this);
    });

    _financeSubscription = _stateManager.profitStream.listen((event) {
      _currentFinance = event;
      if (mounted) {
        setState(() {});
      }
    });

    currentPage = NotificationsPrefHelper().getHomeIndex();
    if (NotificationsPrefHelper().getHomeIndex() == 1) {
      NotificationsPrefHelper().setHomeIndex(1);
    }
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _profileSubscription.cancel();
    _companySubscription.cancel();
    _financeSubscription.cancel();
    _supportMessages.cancel();
    _supportMessages.cancel();
    _globalStateSubscription.cancel();
    _firebaseSubscription?.cancel();
    stateManager.dispose();
    super.dispose();
  }

  void getMyOrders([String? trigger]) {
    _stateManager.getProfile(this);
    _stateManager.getProfitSummary(this);
    _stateManager.getMyOrders(this);
    if (trigger != null) {
      FireStoreHelper().backgroundThread(trigger);
    }
  }

  Future<void> refreshOrders() async {
    _stateManager.getProfile(this);
    _stateManager.getProfitSummary(this);
    _stateManager.getMyOrders(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void requestAuthorization() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AuthorizationRoutes.LOGIN_SCREEN,
        (r) => false,
      );
    });
  }

  void changeStatus(bool isOnline) {
    _stateManager.updateProfileStatus(this, isOnline);
  }

  void moveTo(String route, dynamic argument) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamed(route, arguments: argument);
    });
  }

  subscribeToDirectSupportMessages(String roomID) {
    _supportMessages =
        getIt<ChatRepository>().requestMessages(roomID).listen((event) {
      try {
        Map<String, dynamic> lastMessage =
            event.docs.last.data() as Map<String, dynamic>;

        _lastMessageFromSupportDate = lastMessage['sentDate'] ?? '';
        bool isAdmin = lastMessage['isAdmin'] ?? false;

        if (_lastMessageFromSupportDate !=
                NotificationsPrefHelper()
                    .getLastMessageHasBeenSeenFromSupport() &&
            isAdmin) {
          _isLastMessageFromAdminHasntSeenYet.value = true;
        }
      } catch (e) {
        _isLastMessageFromAdminHasntSeenYet.value = false;
      }
    });
  }

  bool farOrders = false;

  // to ignore calling [canRequestLocation()] when its not necessary
  bool _requestLocationIsPausedNow = false;
  // the delay between each geo request
  Duration _requestLocationDelayDuration = const Duration(seconds: 10);

  void canRequestLocation() {
    try {
      if (_requestLocationIsPausedNow) {
        return;
      }
      _requestLocationIsPausedNow = true;
      Future.delayed(_requestLocationDelayDuration).then(
        (value) {
          _requestLocationIsPausedNow = false;
        },
      );
      DeepLinksService.canRequestLocation().then((value) async {
        if (value) {
          Logger.info('Location enabled', '$value');
          Geolocator.getPositionStream(
              locationSettings: const LocationSettings(
            distanceFilter: 1000,
          )).listen((event) {
            currentLocation = LatLng(event.latitude, event.longitude);
            DeepLinkLocalRepository.clearCachedDistances();
            Logger.info('Location with us ',
                currentLocation?.toJson().toString() ?? 'null');
            if (mounted) {
              setState(() {});
            }
          });
        }
      });
    } catch (e) {
      Logger.error('GEO Locator', e.toString(), StackTrace.current);
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (mounted) {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning, message: S.current.errorHappened)
                .show(context);
          }
        },
      );
    }
  }

  bool somethingMissingInProfileData = false;
  @override
  Widget build(BuildContext context) {
    if (currentLocation == null) canRequestLocation();
    return Scaffold(
      key: drawerKey,
      body: AdvancedDrawer(
        controller: advancedController,
        rtlOpening: Localizations.localeOf(context).languageCode != 'en',
        childDecoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
        backdropColor: Theme.of(context).colorScheme.background,
        drawer: MenuScreen(this, _currentProfile ?? ProfileModel.empty(),
            _currentFinance ?? DailyFinanceModel.empty()),
        child: Scaffold(
          appBar: CustomC4dAppBar.appBar(context,
              showBadge: somethingMissingInProfileData,
              colorBadge: Colors.amber,
              colorIcon: currentState is ErrorState
                  ? Theme.of(context).colorScheme.error
                  : (currentPage == 1
                      ? null
                      : StatusHelper.getOrderStatusColor(
                          OrderStatusEnum.GOT_CAPTAIN)),
              actions: [
                Column(
                  children: [
                    Expanded(
                      child: Switch(
                          value: farOrders,
                          activeColor: Theme.of(context).colorScheme.secondary,
                          onChanged: (bool value) {
                            farOrders = value;
                            NotificationsPrefHelper().setFarOrders(value);
                            refresh();
                          }),
                    ),
                    SizedBox(
                      child: Text(
                        S.current.farOrders,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: farOrders ? Colors.green : Colors.red),
                        textScaleFactor: 1,
                      ),
                    ),
                  ],
                ),
                ValueListenableBuilder(
                  builder: (context, box, _) {
                    return CustomC4dAppBar.actionIcon(context,
                        showBadge: _isLastMessageFromAdminHasntSeenYet.value,
                        onTap: () {
                      _isLastMessageFromAdminHasntSeenYet.value = false;
                      if (_lastMessageFromSupportDate != null) {
                        NotificationsPrefHelper()
                            .setLastMessageHasBeenSeenFromSupport(
                                _lastMessageFromSupportDate ?? '');
                      }
                      if (_currentProfile != null) {
                        Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                            arguments: ChatArgument(
                                roomID: _currentProfile!.roomID ?? '',
                                userType: 'Admin'));
                      }
                    },
                        icon: Icons.support_agent_rounded,
                        colorIcon: currentPage == 1
                            ? null
                            : StatusHelper.getOrderStatusColor(
                                OrderStatusEnum.GOT_CAPTAIN));
                  },
                  valueListenable: _isLastMessageFromAdminHasntSeenYet,
                ),
                ValueListenableBuilder(
                  builder: (context, box, _) {
                    return CustomC4dAppBar.actionIcon(context,
                        showBadge: NotificationsPrefHelper()
                                .getNewLocalNotification() !=
                            null, onTap: () {
                      Navigator.of(context)
                          .pushNamed(MyNotificationsRoutes.MY_NOTIFICATIONS);
                    },
                        icon: Icons.notifications_rounded,
                        colorIcon: currentPage == 1
                            ? null
                            : StatusHelper.getOrderStatusColor(
                                OrderStatusEnum.GOT_CAPTAIN));
                  },
                  valueListenable: Hive.box('Notifications').listenable(
                      keys: [NotificationsPrefHelper().NEW_NOTIFICATION]),
                ),
              ],
              title: S.of(context).home,
              icon: Icons.sort_rounded, onTap: () {
            advancedController.showDrawer();
          }),
          bottomNavigationBar: Visibility(
            visible: currentState is ErrorState == false,
            child: SnakeNavigationBar.color(
              behaviour: SnakeBarBehaviour.pinned,
              snakeShape: SnakeShape.rectangle,
              snakeViewColor: currentPage == 1
                  ? Theme.of(context).colorScheme.primary
                  : StatusHelper.getOrderStatusColor(
                      OrderStatusEnum.GOT_CAPTAIN),
              selectedItemColor: Colors.white,
              unselectedItemColor: Theme.of(context).disabledColor,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              currentIndex: currentPage,
              onTap: (index) {
                currentPage = index;
                getMyOrders();
                refresh();
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.directions_car,
                    ),
                    label: S.current.myOrders),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.map_outlined),
                    label: S.current.nearbyOrders),
              ],
            ),
          ),
          body: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: currentState.getUI(context)),
        ),
      ),
    );
  }
}

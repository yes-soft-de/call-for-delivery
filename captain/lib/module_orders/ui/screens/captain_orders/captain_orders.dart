import 'dart:async';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_navigation/menu.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/state_manager/captain_orders/captain_orders.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';

@injectable
class CaptainOrdersScreen extends StatefulWidget {
  final CaptainOrdersListStateManager _stateManager;

  const CaptainOrdersScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => CaptainOrdersScreenState();
}

class CaptainOrdersScreenState extends State<CaptainOrdersScreen> {
  States? currentState;
  ProfileModel? _currentProfile;
  CompanyInfoResponse? _companyInfo;
  int currentPage = 0;
  PageController ordersPageController = PageController(initialPage: 0);
  StreamSubscription? _stateSubscription;
  StreamSubscription? _profileSubscription;
  StreamSubscription? _companySubscription;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  final advancedController = AdvancedDrawerController();

  void getMyOrders() {
    ordersPageController = PageController(initialPage: currentPage);
    widget._stateManager.getProfile(this);
    widget._stateManager.getMyOrders(this);
  }

  Future<void> refreshOrders() async {
    ordersPageController = PageController(initialPage: currentPage);
    widget._stateManager.getProfile(this);
    widget._stateManager.getMyOrders(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void requestAuthorization() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AuthorizationRoutes.LOGIN_SCREEN,
        (r) => false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this, picture: true);
    widget._stateManager.getProfile(this);
    //widget._stateManager.companyInfo();
    widget._stateManager.getMyOrders(this);
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      widget._stateManager.getMyOrders(this, false);
    });
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    _profileSubscription = widget._stateManager.profileStream.listen((event) {
      _currentProfile = event;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      body: AdvancedDrawer(
        controller: advancedController,
        rtlOpening: Localizations.localeOf(context).languageCode != 'en',
        childDecoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
        backdropColor: Theme.of(context).backgroundColor,
        child: Scaffold(
          appBar: CustomC4dAppBar.appBar(context,
              colorIcon: currentState is ErrorState
                  ? Theme.of(context).colorScheme.error
                  : null,
              actions: [
                CustomC4dAppBar.actionIcon(context, onTap: () {
                  Navigator.of(context)
                      .pushNamed(MyNotificationsRoutes.MY_NOTIFICATIONS);
                }, icon: Icons.notifications_rounded)
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
              snakeViewColor: Theme.of(context).colorScheme.primary,
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
                ordersPageController.animateToPage(currentPage,
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.linear);
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
              child: currentState?.getUI(context)),
        ),
        drawer: MenuScreen(this, _currentProfile ?? ProfileModel.empty()),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _stateSubscription?.cancel();
    _profileSubscription?.cancel();
    _companySubscription?.cancel();
    widget._stateManager.newActionSubscription?.cancel();
  }
}

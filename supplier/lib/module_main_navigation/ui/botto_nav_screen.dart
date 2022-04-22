import 'dart:async';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_about/model/company_info_model.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/my_offer_order_screen.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/ongoing_order_screen.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/open_orders_screen.dart';
import 'package:c4d/module_main_navigation/state_manager/bottom_nav_state_manager.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/navigator_menu/navigator_menu.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainNavigation extends StatefulWidget {
  final BottomNavStateManager _stateManager;

  MainNavigation(this._stateManager);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedPage = 0;
  PageController homeController = PageController(initialPage: 0);

  ProfileModel? currentProfile;
  CompanyInfoModel? _companyInfo;

  StreamSubscription? _profileSubscription;
  StreamSubscription? _companySubscription;

  void getInitData() {
    widget._stateManager.initDrawerData();
  }

  bool featureFlag = true;
  @override
  void initState() {
    super.initState();
    getInitData();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: GlobalVariable.mainScreenScaffold,
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.orders, icon: Icons.sort, onTap: () {
          GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
        }, actions: [
          CustomC4dAppBar.actionIcon(
            context,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(MyNotificationsRoutes.MY_NOTIFICATIONS);
            },
            icon: Icons.notifications_rounded,
          ),
        ]),
        bottomNavigationBar:SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.pinned,
            snakeShape: SnakeShape.rectangle,
            selectedItemColor: Colors.white,
            snakeViewColor: Theme.of(context).primaryColorDark,
            unselectedItemColor: Theme.of(context).disabledColor,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            elevation: 5.0,
            currentIndex: selectedPage,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: S.of(context).newOrder,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                label: S.of(context).myOffers,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.motorcycle_sharp),
                label: S.of(context).onGoingOrder,
              ),
            ],
            onTap: (int index) {
              selectedPage = index;
              homeController.animateToPage(index,
                  duration: Duration(milliseconds: 15), curve: Curves.ease);
            }
        ),
        drawer: NavigatorMenu(
          profileModel: currentProfile,
          company: _companyInfo,
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: homeController,
            onPageChanged: (index) {
              setState(() => selectedPage = index);
            },
            children: <Widget>[
              getIt<OpenOrdersScreen>(),
              getIt<OfferOrdersScreen>(),
              getIt<OnGoingOrdersScreen>(),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _profileSubscription?.cancel();
    _companySubscription?.cancel();

    super.dispose();
  }
}

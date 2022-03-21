import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_orders_loaded.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class MenuScreen extends StatelessWidget {
  final CaptainOrdersScreenState screenState;
  final ProfileModel profileModel;
  const MenuScreen(this.screenState, this.profileModel);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
        child: Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomNetworkImage(
                        background: Theme.of(context).scaffoldBackgroundColor,
                        imageSource: profileModel.image ??
                            'https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png',
                        width: double.maxFinite,
                        height: double.maxFinite,
                      ),
                    ),
                  ),
                ),
              ),
              Center(child: Text(profileModel.name ?? S.current.username)),
              Container(
                height: 32,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ProfileRoutes.EDIT_ACTIVITY_SCREEN);
                },
                leading: const Icon(Icons.account_circle_rounded),
                title: Text(S.of(context).profile),
              ),
              ListTileSwitch(
                value: profileModel.isOnline ?? false,
                leading: const Icon(Icons.wifi_rounded),
                onChanged: (mode) {
                  profileModel.isOnline = mode;
                  screenState.refresh();
                },
                visualDensity: VisualDensity.comfortable,
                switchType: SwitchType.cupertino,
                switchActiveColor: Theme.of(context).colorScheme.primary,
                title: Text(
                  S.of(context).myStatus,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(OrdersRoutes.ORDER_LOGS);
                },
                leading: const Icon(Icons.history),
                title: Text(S.of(context).orderLog),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(MyNotificationsRoutes.UPDATES_SCREEN);
                },
                leading: const Icon(Icons.notifications_active_rounded),
                title: Text(S.of(context).notices),
              ),
              ListTile(
                onTap: () {
                  if (screenState.currentState
                      is CaptainOrdersListStateOrdersLoaded) {
                    screenState.currentState = LoadingState(screenState);
                    screenState.getMyOrders();
                  }
                  Navigator.of(context).pushNamed(SettingRoutes.ROUTE_SETTINGS);
                },
                leading: const Icon(Icons.settings),
                title: Text(S.of(context).settings),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(SettingRoutes.TERMS);
                },
                leading: const Icon(Icons.supervised_user_circle),
                title: Text(S.of(context).termsOfService),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(SettingRoutes.PRIVECY);
                },
                leading: const Icon(Icons.privacy_tip),
                title: Text(S.of(context).privacyPolicy),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(PlanRoutes.PLAN_ROUTE);
                },
                leading: const Icon(Icons.account_balance_rounded),
                title: Text(S.of(context).myBalance),
              ),
            ],
          ),
        ),
        DefaultTextStyle(
          style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.w500),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: const Text('Yes Soft | C4D Captain'),
          ),
        ),
      ],
    ));
  }
}

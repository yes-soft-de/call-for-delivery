import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_loading.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_orders_loaded.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:c4d/utils/components/progresive_image.dart';

class MenuScreen extends StatelessWidget {
  final CaptainOrdersScreenState screenState;
  final ProfileModel profileModel;
  MenuScreen(this.screenState, this.profileModel);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
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
              Text(profileModel.name ?? S.current.username),
              Container(
                height: 32,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ProfileRoutes.EDIT_ACTIVITY_SCREEN);
                },
                leading: Icon(Icons.account_circle_rounded),
                title: Text('${S.of(context).profile}'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(PlanRoutes.PLAN_ROUTE);
                },
                leading: Icon(Icons.account_balance_rounded),
                title: Text('${S.of(context).myBalance}'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(OrdersRoutes.ORDER_LOGS);
                },
                leading: Icon(Icons.history),
                title: Text('${S.of(context).orderLog}'),
              ),
              ListTile(
                onTap: () {
                  if (screenState.currentState
                      is CaptainOrdersListStateOrdersLoaded) {
                    screenState.currentState =
                        CaptainOrdersListStateLoading(screenState);
                    screenState.getMyOrders();
                  }
                  Navigator.of(context).pushNamed(SettingRoutes.ROUTE_SETTINGS);
                },
                leading: Icon(Icons.settings),
                title: Text('${S.of(context).settings}'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(SettingRoutes.TERMS);
                },
                leading: Icon(Icons.supervised_user_circle),
                title: Text('${S.of(context).termsOfService}'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(SettingRoutes.PRIVECY);
                },
                leading: Icon(Icons.privacy_tip),
                title: Text('${S.of(context).privacyPolicy}'),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).disabledColor,
                    fontWeight: FontWeight.w500),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Yes Soft | Mandoob Captain'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

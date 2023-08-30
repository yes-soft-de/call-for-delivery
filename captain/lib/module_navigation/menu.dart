import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_profile/model/daily_model.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state_orders_loaded.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MenuScreen extends StatelessWidget {
  final CaptainOrdersScreenState screenState;
  final ProfileModel profileModel;
  final DailyFinanceModel dailyFinance;
  const MenuScreen(
    this.screenState,
    this.profileModel,
    this.dailyFinance,
  );

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
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Stack(
                          children: [
                            CustomNetworkImage(
                              background:
                                  Theme.of(context).scaffoldBackgroundColor,
                              imageSource: profileModel.image ??
                                  'https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png',
                              width: double.maxFinite,
                              height: double.maxFinite,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          profileModel.averageRating
                                                  ?.toStringAsFixed(1) ??
                                              '0',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              Center(child: Text(profileModel.name ?? S.current.username)),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(PlanRoutes.MY_PROFIT);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                S.current.yourBalanceToday,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                '${dailyFinance.dailyTotal.toStringAsFixed(2)} ${S.current.Riyal}',
                                style: TextStyle(
                                  color: dailyFinance.dailyTotal > 0
                                      ? Colors.red
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     height: 16,
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).disabledColor,
                      //       borderRadius: BorderRadius.circular(25),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   width: 125,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(25),
                      //     color: Theme.of(context).colorScheme.primaryContainer,
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           S.current.totalEarnedProfit,
                      //           style: const TextStyle(
                      //             fontSize: 13,
                      //           ),
                      //         ),
                      //         Text(
                      //           dailyFinance.totalProfit.toStringAsFixed(2) +
                      //               S.current.sar,
                      //           style: TextStyle(
                      //             color: Theme.of(context).colorScheme.primary,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: profileModel.address?.isEmpty == true ||
                    profileModel.city?.isEmpty == true,
                child: Flushbar(
                  backgroundColor: Colors.amber,
                  icon: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  message: profileModel.address?.isEmpty == true
                      ? S.current.addressIsMissing
                      : S.current.cityIsMissing,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ProfileRoutes.EDIT_ACTIVITY_SCREEN);
                },
                leading: const Icon(Icons.account_circle_rounded),
                title: Text(S.of(context).profile),
                trailing: Visibility(
                  visible: profileModel.address?.isEmpty == true ||
                      profileModel.city?.isEmpty == true,
                  child: const Icon(
                    Icons.info,
                    color: Colors.amber,
                  ),
                ),
              ),
              ListTileSwitch(
                  value: profileModel.isOnline ?? false,
                  leading: const Icon(Icons.circle_notifications),
                  onChanged: (mode) {
                    profileModel.isOnline = mode;
                    screenState.refresh();
                    screenState.changeStatus(mode);
                  },
                  visualDensity: VisualDensity.comfortable,
                  switchType: SwitchType.cupertino,
                  switchActiveColor: Theme.of(context).colorScheme.primary,
                  title: Row(
                    children: [
                      Text(S.current.orderNotifications),
                      const Spacer(),
                      Text(
                        profileModel.isOnline == true ? ' ON ' : ' OFF ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: profileModel.isOnline == true
                                ? Colors.green
                                : Colors.red),
                      )
                    ],
                  )),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(PlanRoutes.MY_PROFIT);
                },
                leading: const Icon(Icons.account_balance_rounded),
                title: Text(
                  S.of(context).myProfits,
                ),
              ),
              // ListTile(
              //   onTap: () {
              //     Navigator.of(context).pushNamed(PlanRoutes.BALANCE_ROUTE);
              //   },
              //   leading: const Icon(Icons.account_balance_rounded),
              //   title: Text(S.of(context).myBalance),
              // ),
              // ListTile(
              //   onTap: () {
              //     Navigator.of(context)
              //         .pushNamed(ProfileRoutes.ACCOUNT_BALANCE_SCREEN);
              //   },
              //   leading: const Icon(Icons.payments_rounded),
              //   title: Text(S.of(context).payments),
              // ),
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
                title: Text(S.of(context).addsAndOffers),
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
              Visibility(
                visible: profileModel.roomID != null,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                        arguments: ChatArgument(
                            roomID: profileModel.roomID ?? '',
                            userType: 'Admin'));
                  },
                  leading: const Icon(Icons.support_agent_rounded),
                  title: Text(S.of(context).directSupport),
                ),
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
              FutureBuilder(
                  future: getVersion(),
                  builder: (ctx, AsyncSnapshot<PackageInfo> snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snap.hasData) {
                      PackageInfo packageInfo = snap.data!;
                      String appName = packageInfo.appName;
                      String packageName = packageInfo.packageName;
                      String version = packageInfo.version;
                      String buildNumber = packageInfo.buildNumber;
                      return Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/icon/logo.jpeg',
                              width: 75,
                              height: 75,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Text(appName),
                          Text(
                            version,
                            style: TextStyle(
                                color: Theme.of(context).disabledColor),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  })
            ],
          ),
        ),
      ],
    ));
  }

  Future<PackageInfo> getVersion() async {
    return await PackageInfo.fromPlatform();
  }
}

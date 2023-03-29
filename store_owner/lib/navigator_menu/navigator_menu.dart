import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_about/about_routes.dart';
import 'package:c4d/module_bidorder/bid_orders_routes.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_orders/model/company_info_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:c4d/module_subscription/subscriptions_routes.dart';
import 'package:c4d/navigator_menu/custom_nav_tile.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NavigatorMenu extends StatefulWidget {
  final double? width;
  final ProfileModel? profileModel;
  final CompanyInfoModel? company;
  final bool isUnlimitedPackage;
  final OwnerOrdersScreenState screenState;
  NavigatorMenu(
      {this.width = 275,
      this.profileModel,
      this.company,
      this.isUnlimitedPackage = false,
      required this.screenState});

  @override
  _NavigatorMenuState createState() => _NavigatorMenuState();
}

class _NavigatorMenuState extends State<NavigatorMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var drawerHeader = SizedBox(
      height: 215,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 125,
              width: 125,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).backgroundColor,
                        spreadRadius: 1.5,
                        blurRadius: 6,
                        offset: Offset(-0.2, 0))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CustomNetworkImage(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    imageSource: widget.profileModel?.image ?? ImageAsset.LOGO),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              widget.profileModel?.name ?? S.current.loading,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              thickness: 2.5,
              color: Theme.of(context).backgroundColor,
            ),
          ],
        ),
      ),
    );
    return Container(
        width: widget.width,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: Localizations.localeOf(context).languageCode == 'ar'
                ? BorderRadius.horizontal(left: Radius.circular(25))
                : BorderRadius.horizontal(right: Radius.circular(25))),
        child: CustomListView.custom(children: [
          // personal info
          drawerHeader,
          CustomNavTile(
              icon: Icons.person,
              onTap: () {
                Navigator.of(context).pushNamed(ProfileRoutes.PROFILE_SCREEN);
              },
              title: S.current.myProfile),
          Visibility(
            visible: widget.isUnlimitedPackage == false,
            child: CustomNavTile(
                icon: Icons.account_balance_rounded,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(SubscriptionsRoutes.SUBSCRIPTIONS_DUES_SCREEN);
                },
                title: S.current.myBalance),
          ),
          Divider(
            indent: 32,
            endIndent: 32,
            thickness: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
          // my work info
          Visibility(
            visible: widget.isUnlimitedPackage == false,
            child: CustomNavTile(
                icon: Icons.subscriptions_rounded,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(SubscriptionsRoutes.SUBSCRIPTIONS_SCREEN);
                },
                title: S.current.mySubscription),
          ),
          CustomNavTile(
              icon: Icons.compare_arrows_rounded,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(OrdersRoutes.OWNER_LOGS_ORDERS_SCREEN);
              },
              title: S.current.myOrders),
          CustomNavTile(
              icon: Icons.payments_rounded,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(OrdersRoutes.ORDERS_CASH_SCREEN);
              },
              title: S.current.confirmOrderCash),
          CustomNavTile(
              icon: Icons.chat_rounded,
              onTap: () {
                Navigator.of(context).pop();
                widget.screenState.openedBottom = true;
                widget.screenState.setState(() {});
                GlobalVariable.mainScreenScaffold.currentState
                    ?.showBottomSheet(
                      (ctx) {
                        return widget.screenState.getOngoingChatRoom();
                      },
                      backgroundColor: Theme.of(context).backgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25))),
                      constraints: BoxConstraints(
                        minHeight: 150,
                        maxHeight: 500,
                      ),
                    )
                    .closed
                    .whenComplete(() {
                      widget.screenState.openedBottom = false;
                      widget.screenState.setState(() {});
                    });
              },
              title: S.current.onGoingOrderChatRooms),
          CustomNavTile(
              icon: Icons.hide_source_rounded,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(OrdersRoutes.OWNER_HIDDEN_ORDERS_SCREEN);
              },
              title: S.current.hiddenOrder),

          CustomNavTile(
              icon: Icons.store_rounded,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(BranchesRoutes.BRANCHES_LIST_SCREEN);
              },
              title: S.current.branchManagement),
          Divider(
            indent: 32,
            endIndent: 32,
            thickness: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
          //BID-ORDER
          Visibility(
            visible: false,
            child: CustomNavTile(
                icon: Icons.production_quantity_limits,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(BidOrdersRoutes.OPEN_ORDERS_SCREEN);
                },
                title: S.current.openOrder),
          ),
          Visibility(
            visible: false,
            child: CustomNavTile(
                icon: Icons.bookmark_border,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(BidOrdersRoutes.NEW_ORDER_SCREEN);
                },
                title: S.current.newBidOrder),
          ),
          Visibility(
            visible: false,
            child: CustomNavTile(
                icon: Icons.compare_arrows_rounded,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(BidOrdersRoutes.LOGS_BID_ORDERS_SCREEN);
                },
                title: S.current.myBidOrder),
          ),
          Visibility(
            visible: false,
            child: Divider(
              indent: 32,
              endIndent: 32,
              thickness: 2.5,
              color: Theme.of(context).backgroundColor,
            ),
          ),

          // support
          CustomNavTile(
              icon: Icons.notifications_active_rounded,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(MyNotificationsRoutes.UPDATES_SCREEN);
              },
              title: S.current.adsAndOffers),
          Visibility(
            visible: widget.company != null,
            child: CustomNavTile(
                icon: FontAwesomeIcons.whatsappSquare,
                onTap: () {
                  var url = 'https://wa.me/${widget.company?.whatsapp}';
                  canLaunch(url).then((value) {
                    if (value) {
                      launch(url);
                    }
                  });
                },
                title: S.current.whatsapp),
          ),
          Visibility(
            visible: widget.profileModel != null,
            child: CustomNavTile(
                icon: Icons.support_agent_rounded,
                onTap: () {
                  Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                      arguments: ChatArgument(
                        userType: 'admin',
                        support: true,
                        roomID: widget.profileModel?.roomId ?? '',
                      ));
                },
                title: S.current.directSupport),
          ),
          Divider(
            indent: 32,
            endIndent: 32,
            thickness: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
          // settings
          CustomNavTile(
              icon: Icons.settings_rounded,
              onTap: () {
                GlobalVariable.mainScreenScaffold.currentState?.openEndDrawer();
                Navigator.of(context).pushNamed(SettingRoutes.ROUTE_SETTINGS);
              },
              title: S.current.settings),
          CustomNavTile(
              icon: Icons.privacy_tip_rounded,
              onTap: () {
                Navigator.of(context).pushNamed(SettingRoutes.PRIVECY);
              },
              title: S.current.privacyPolicy),
          CustomNavTile(
              icon: Icons.verified_user_rounded,
              onTap: () {
                Navigator.of(context).pushNamed(SettingRoutes.TERMS);
              },
              title: S.current.termsOfService),
          Visibility(
            visible: widget.company != null,
            child: CustomNavTile(
                icon: Icons.info,
                onTap: () {
                  Navigator.of(context).pushNamed(AboutRoutes.ROUTE_COMPANY);
                },
                title: S.current.companyInfo),
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
                          'assets/icon/logo.jpg',
                          width: 75,
                          height: 75,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Text(appName),
                      Text(
                        version,
                        style:
                            TextStyle(color: Theme.of(context).disabledColor),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              })
        ]));
  }

  Future<PackageInfo> getVersion() async {
    return await PackageInfo.fromPlatform();
  }
}

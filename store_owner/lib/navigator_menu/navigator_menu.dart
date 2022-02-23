import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/profile_routes.dart';
import 'package:c4d/navigator_menu/custom_nav_tile.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigatorMenu extends StatefulWidget {
  final double? width;
  NavigatorMenu({this.width = 275});

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
                    imageSource: ImageAsset.LOGO),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'username',
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
          drawerHeader,
          CustomNavTile(
              icon: Icons.person,
              onTap: () {
                Navigator.of(context).pushNamed(ProfileRoutes.ACTIVITY_SCREEN);
              },
              title: S.current.myProfile),
          CustomNavTile(
              icon: Icons.account_balance_rounded,
              onTap: () {},
              title: S.current.myBalance),
          CustomNavTile(
              icon: Icons.compare_arrows_rounded,
              onTap: () {},
              title: S.current.myOrders),
          CustomNavTile(
              icon: Icons.store_rounded,
              onTap: () {},
              title: S.current.branchManagement),
          CustomNavTile(
              icon: FontAwesomeIcons.whatsappSquare,
              onTap: () {},
              title: S.current.directSupport),
          CustomNavTile(
              icon: Icons.chat_rounded,
              onTap: () {},
              title: S.current.directSupport),
          CustomNavTile(
              icon: Icons.privacy_tip_rounded,
              onTap: () {},
              title: S.current.privacyPolicy),
          CustomNavTile(
              icon: Icons.verified_user_rounded,
              onTap: () {},
              title: S.current.termsOfService)
        ]));
  }
}

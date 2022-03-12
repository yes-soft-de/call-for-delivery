import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/categories_module.dart';
import 'package:c4d/module_company/company_module.dart';
import 'package:c4d/module_main/main_module.dart';
import 'package:c4d/module_notice/notice_module.dart';
import 'package:c4d/module_settings/settings_module.dart';
import 'package:c4d/module_stores/stores_module.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// current last index is 19
class NavigatorMenu extends StatefulWidget {
  final Function(StatefulWidget) onTap;
  final StatefulWidget currentPage;
  final double? width;
  NavigatorMenu({this.width, required this.onTap, required this.currentPage});

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
//      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Image.asset(ImageAsset.DELIVERY),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
    return SafeArea(
      child: Container(
          width: widget.width,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: Localizations.localeOf(context).languageCode == 'ar'
                  ? BorderRadius.horizontal(left: Radius.circular(12))
                  : BorderRadius.horizontal(right: Radius.circular(12))),
          child: CustomListView.custom(children: [
            drawerHeader,

            customListTile(getIt<MainModule>().homeScreen, S.current.home,
                FontAwesomeIcons.home),
            // Store
            customExpansionTile(
                title: S.current.stores,
                icon: FontAwesomeIcons.store,
                children: [
                  customListTile(getIt<StoresModule>().storesScreen,
                      S.current.storesList, Icons.storefront_rounded, true),
                  customListTile(
                      getIt<StoresModule>().storesInActiveScreen,
                      S.current.storesInActive,
                      FontAwesomeIcons.storeSlash,
                      true),
                ],
                page: widget.currentPage),
            // packages
            customExpansionTile(
                title: S.current.packages,
                icon: Icons.backpack_outlined,
                children: [
                  customListTile(getIt<CategoriesModule>().packageCategoriesScreen,
                      S.current.categories, Icons.category, true),
//                  customListTile(getIt<CategoriesModule>().subCategoriesScreen,
//                      S.current.subCategories, FontAwesomeIcons.square, true),
                  customListTile(
                      getIt<CategoriesModule>().packagesScreen,
                      S.current.packages,
                      FontAwesomeIcons.wolfPackBattalion,
                      true),
                ],
                page: widget.currentPage),

            customListTile(getIt<NoticeModule>().noticeScreen, S.current.notice,
                FontAwesomeIcons.stickyNote),
            customExpansionTile(
                title: S.current.directSupport,
                icon: FontAwesomeIcons.headphonesAlt,
                children: [
                  customListTile(getIt<StoresModule>().supportScreen,
                      S.current.stores,  Icons.storefront_rounded, true),
                ],
                page: widget.currentPage),
            customExpansionTile(
                title: S.current.companyInfo,
                icon: FontAwesomeIcons.solidCopyright,
                children: [
                  customListTile(
                      getIt<CompanyModule>().companyFinanceScreen,
                      S.current.companyFinance,
                      FontAwesomeIcons.moneyCheckAlt,
                      true),
                  customListTile(getIt<CompanyModule>().companyProfileScreen,
                      S.current.contactInfo, Icons.info, true),
                ],
                page: widget.currentPage),

            customListTile(getIt<SettingsModule>().settingsScreen,
                S.current.settings, FontAwesomeIcons.cog),
          ])),
    );
  }

  Widget customListTile(StatefulWidget page, String title, IconData icon,
      [bool subtitle = false]) {
    bool selected = page.runtimeType.toString() ==
        widget.currentPage.runtimeType.toString();
    double? size =
        icon.fontPackage == 'font_awesome_flutter' ? (subtitle ? 18 : 22) : 26;
    if (size == 26 && subtitle) {
      size = 20;
    }

    return Padding(
      key: ValueKey(page.runtimeType),
      padding: EdgeInsets.only(
          left: subtitle ? 16.0 : 8.0, right: subtitle ? 16 : 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: selected ? Theme.of(context).primaryColor : null,
            borderRadius: BorderRadius.circular(25)),
        child: ListTile(
          minLeadingWidth: subtitle ? 4 : null,
          visualDensity: VisualDensity(vertical: -2),
          onTap: () {
            widget.onTap(page);
            GlobalVariable.mainScreenScaffold.currentState?.openEndDrawer();
            setState(() {});
          },
          leading:
              Icon(icon, color: selected ? Colors.white : null, size: size),
          title: Text(
            title,
            style: TextStyle(
                color: selected ? Colors.white : null,
                fontSize: subtitle ? 14 : null),
          ),
        ),
      ),
    );
  }

  Widget customExpansionTile(
      {required StatefulWidget page,
      required String title,
      required IconData icon,
      required List<Widget> children}) {
    bool extended = false;
    for (var i in children) {
      if (i.key.toString() == '[<${page.runtimeType}>]') {
        extended = true;
        break;
      }
    }
    double? size = icon.fontPackage == 'font_awesome_flutter' ? 22 : 26;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: extended,
          title: Text(title),
          leading: Icon(
            icon,
            size: size,
          ),
          children: children,
        ),
      ),
    );
  }
}

import 'package:c4d/consts/urls.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_captain/captains_module.dart';
import 'package:c4d/module_captain/ui/screen/captain_dues_screen.dart';
import 'package:c4d/module_captain/ui/screen/captain_needs_support_screen.dart';
import 'package:c4d/module_captain/ui/screen/captains_list_screen.dart';
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart';
import 'package:c4d/module_categories/categories_module.dart';
import 'package:c4d/module_company/company_module.dart';
import 'package:c4d/module_dev/dev_module.dart';
import 'package:c4d/module_external_delivery_companies/external_delivery_companies_module.dart';
import 'package:c4d/module_external_delivery_companies/model/feature_model.dart';
import 'package:c4d/module_external_delivery_companies/request/feature_request/feature_request.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/show_confirm_dialog.dart';
import 'package:c4d/module_notice/notice_module.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_conflict_distance_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_pending_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders_receive_cash_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders_without_distance_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_hours_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_count_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_screen.dart';
import 'package:c4d/module_settings/settings_module.dart';
import 'package:c4d/module_statistics/ui/screen/statistics_screen.dart';
import 'package:c4d/module_stores/stores_module.dart';
import 'package:c4d/module_stores/ui/screen/stores_screen.dart';
import 'package:c4d/module_supplier/supplier_module.dart';
import 'package:c4d/module_supplier_categories/categories_supplier_module.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigatorMenu extends StatefulWidget {
  final dynamic Function(StatefulWidget) onTap;
  final StatefulWidget currentPage;
  final double? width;
  NavigatorMenu({this.width, required this.onTap, required this.currentPage});

  @override
  _NavigatorMenuState createState() => _NavigatorMenuState();
}

class _NavigatorMenuState extends State<NavigatorMenu> {
  ValueNotifier<bool> isExternalCompanyServiceActive = ValueNotifier(false);

  @override
  void initState() {
    getIt<GlobalStateManager>().stateStream.listen((event) {
      if (event is StatefulWidget) {
        widget.onTap(event);
        setState(() {});
      }
    });
    super.initState();

    _getFeatureStatus();
  }

  _updateFeature(bool newValue) {
    getIt<ExternalDeliveryCompaniesService>()
        .updateFeatureStatus(FeatureRequest(featureStatus: newValue))
        .then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? '',
          );
        } else {
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.dataUpdatedSuccessfully,
          );
        }
        _getFeatureStatus();
      },
    );
  }

  _getFeatureStatus() {
    getIt<ExternalDeliveryCompaniesService>().getFeatureStatus().then(
      (value) {
        if (value.hasError) {
        } else if (value.isEmpty) {
        } else {
          value as FeatureModel;
          isExternalCompanyServiceActive.value = value.data.featureStatus;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var drawerHeader = SizedBox(
//      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(ImageAsset.DELIVERY)),
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
          child: ListView(children: [
            drawerHeader,
            customListTile(
                StatisticsScreen(), S.current.home, FontAwesomeIcons.home),
            // order
            customExpansionTile(
                title: S.current.orders,
                icon: FontAwesomeIcons.boxes,
                children: [
                  customListTile(OrderPendingScreen(),
                      S.current.orderedNotAccepted, FontAwesomeIcons.box, true),
                  customListTile(NewOrderScreen(), S.current.newOrder,
                      Icons.add_rounded, true)
                ],
                page: widget.currentPage),

            // report
            customExpansionTile(
                title: S.current.reports,
                icon: Icons.report,
                children: [
                  customListTile(
                      OrdersWithoutDistanceScreen(),
                      S.current.orderWithoutDistance,
                      Icons.edit_road_rounded,
                      true),
                  customListTile(
                      OrderDistanceConflictScreen(),
                      S.current.orderConflictDistances,
                      Icons.edit_road_rounded,
                      true),
                  customListTile(
                      getIt<StoresModule>().captainNotArrivedScreen,
                      S.current.captainNotArrived,
                      Icons.storefront_rounded,
                      true),
                  customListTile(OrdersReceiveCashScreen(),
                      S.current.ordersCash, Icons.payments_rounded, true),
                  customListTile(getIt<CaptainsModule>().captainsRatingsScreen,
                      S.current.captainsRating, Icons.star_rounded, true),
                  customListTile(
                      getIt<CaptainsModule>().captainsActivityScreen,
                      S.current.captainActivity,
                      Icons.show_chart_rounded,
                      true),
                  customListTile(getIt<StoresModule>().topActiveStoreScreen,
                      S.current.topstoreActivity, FontAwesomeIcons.store, true),
                ],
                page: widget.currentPage),

            // captain
            customExpansionTile(
                title: S.current.captains,
                icon: FontAwesomeIcons.car,
                children: [
                  customListTile(CaptainsScreen(), S.current.captains,
                      FontAwesomeIcons.solidListAlt, true),
                  customListTile(
                      InActiveCaptainsScreen(),
                      S.current.inActiveCaptains,
                      FontAwesomeIcons.solidAddressCard,
                      true),
                ],
                page: widget.currentPage),
            // Store
            customExpansionTile(
                title: S.current.stores,
                icon: FontAwesomeIcons.store,
                children: [
                  customListTile(StoresScreen(), S.current.storesList,
                      Icons.storefront_rounded, true),
                  customListTile(
                      getIt<StoresModule>().storesInActiveScreen,
                      S.current.storesInActive,
                      FontAwesomeIcons.storeSlash,
                      true),
                ],
                page: widget.currentPage),
            // external delivery company's
            customExpansionTile(
                title: S.current.externalTriggers,
                icon: FontAwesomeIcons.link,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Icon(Icons.stop_circle),
                        Text(S.current.onOff),
                        SizedBox(),
                        SizedBox(),
                        ValueListenableBuilder(
                          builder: (context, value, child) {
                            return Switch(
                              thumbColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              activeColor: Colors.green,
                              value: isExternalCompanyServiceActive.value,
                              onChanged: (value) {
                                showConfirmDialog(
                                  context,
                                  hasCancelButton: true,
                                  title: S.current.areYouSureAboutEdit,
                                  confirmButtonColor: Colors.amber,
                                  confirmButtonTitle: Text(
                                    S.current.confirm,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  message: value
                                      ? S.current.featureWillBeOnAfterConfirm
                                      : S.current.featureWillBeOffAfterConfirm,
                                  onConfirm: () {
                                    isExternalCompanyServiceActive.value =
                                        value;
                                    setState(() {});
                                    _updateFeature(value);
                                  },
                                );
                              },
                            );
                          },
                          valueListenable: isExternalCompanyServiceActive,
                        ),
                      ],
                    ),
                  ),
                  customListTile(
                      getIt<ExternalDeliveryCompaniesModule>()
                          .externalDeliveryCompaniesScreen,
                      S.current.deliveryCompanies,
                      FontAwesomeIcons.box,
                      true),
                ],
                page: widget.currentPage),
            // support
            customExpansionTile(
                title: S.current.directSupport,
                icon: FontAwesomeIcons.headphonesAlt,
                children: [
                  customListTile(getIt<StoresModule>().supportScreen,
                      S.current.stores, Icons.storefront_rounded, true),
                  customListTile(CaptainsNeedsSupportScreen(),
                      S.current.captains, FontAwesomeIcons.car, true),
                  Visibility(
                    visible: false,
                    child: customListTile(getIt<SupplierModule>().supportScreen,
                        S.current.suppliers, FontAwesomeIcons.car, true),
                  ),
                ],
                page: widget.currentPage),
            // notice
            customListTile(getIt<NoticeModule>().noticeScreen, S.current.notice,
                FontAwesomeIcons.stickyNote),
            // packages
            customExpansionTile(
                title: S.current.packages,
                icon: Icons.backpack_outlined,
                children: [
                  customListTile(
                      getIt<CategoriesModule>().packageCategoriesScreen,
                      S.current.categories,
                      Icons.category,
                      true),
//                  customListTile(getIt<CategoriesModule>().subCategoriesScreen,
//                      S.current.subCategories, FontAwesomeIcons.square, true),
                  customListTile(
                      getIt<CategoriesModule>().packagesScreen,
                      S.current.packages,
                      FontAwesomeIcons.wolfPackBattalion,
                      true),

                  customListTile(
                      getIt<CaptainsModule>().captainOffersScreen,
                      S.current.captainsOffer,
                      FontAwesomeIcons.solidListAlt,
                      true),
                ],
                page: widget.currentPage),
            // captain finance
            customExpansionTile(
                title: S.current.captainFinance,
                icon: Icons.account_balance_rounded,
                children: [
                  customListTile(CaptainFinanceByHoursScreen(),
                      S.current.financeByHours, FontAwesomeIcons.clock, true),
                  customListTile(CaptainFinanceByCountOrderScreen(),
                      S.current.financeByOrders, FontAwesomeIcons.boxes, true),
                  customListTile(CaptainFinanceByOrderScreen(),
                      S.current.financeCountOrder, FontAwesomeIcons.box, true),
                ],
                page: widget.currentPage),
            // dues
            customExpansionTile(
                title: S.current.duesPayments,
                icon: FontAwesomeIcons.moneyBillTransfer,
                children: [
                  customListTile(CaptainDuesScreen(), S.current.captainDues,
                      FontAwesomeIcons.moneyBills, true),
                  customListTile(
                      getIt<StoresModule>().storesDuesScreen,
                      S.current.storesCashRequest,
                      FontAwesomeIcons.moneyBills,
                      true),
                ],
                page: widget.currentPage),

            // supplier
            Visibility(
              visible: false,
              child: customExpansionTile(
                  title: S.current.suppliers,
                  icon: Icons.backpack_outlined,
                  children: [
                    customListTile(
                        getIt<SupplierCategoriesModule>().categoriesScreen,
                        S.current.suppliersCategories,
                        Icons.category,
                        true),
                    customListTile(
                        getIt<SupplierModule>().inActiveSupplierScreen,
                        S.current.inActiveSupplier,
                        FontAwesomeIcons.square,
                        true),
                    customListTile(
                        getIt<SupplierModule>().suppliersScreen,
                        S.current.suppliers,
                        FontAwesomeIcons.wolfPackBattalion,
                        true),
                    //                  customListTile(
                    //                      getIt<CaptainsModule>().captainOffersScreen,
                    //                      S.current.captainsOffer,
                    //                      FontAwesomeIcons.solidListAlt,
                    //                      true),
                  ],
                  page: widget.currentPage),
            ),
            // company
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
            // dev
            Visibility(
              visible: 'http://134.209.241.49' == Urls.DOMAIN,
              child: customExpansionTile(
                  title: S.current.dev,
                  icon: FontAwesomeIcons.dev,
                  children: [
                    customListTile(getIt<DevModule>().newTestOrderScreen,
                        S.current.newOrder, FontAwesomeIcons.dev, true),
                  ],
                  page: widget.currentPage),
            ),
            // setting
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
          left: subtitle ? 16.0 : 8.0,
          right: subtitle ? 16 : 8.0,
          bottom: selected ? 8 : 0,
          top: selected ? 8 : 0),
      child: Container(
        decoration: BoxDecoration(
            color: selected ? Theme.of(context).colorScheme.primary : null,
            borderRadius: BorderRadius.circular(25),
            boxShadow: selected
                ? [
                    BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 4,
                        offset: Offset(0.5, 0.5)),
                  ]
                : null,
            gradient: selected
                ? LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    Theme.of(context).colorScheme.primary.withOpacity(0.9),
                    Theme.of(context).colorScheme.primary,
                  ])
                : null),
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

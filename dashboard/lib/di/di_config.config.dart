// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hive/util/argument_hive_helper.dart' as _i4;
import '../main.dart' as _i248;
import '../module_auth/authoriazation_module.dart' as _i140;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i30;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i6;
import '../module_auth/service/auth_service/auth_service.dart' as _i31;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i42;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i44;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i53;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i89;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i95;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i119;
import '../module_bid_order/bid_order_module.dart' as _i142;
import '../module_bid_order/manager/bid_order_manager.dart' as _i66;
import '../module_bid_order/repository/bid_order_repository.dart' as _i32;
import '../module_bid_order/service/bid_order_service.dart' as _i67;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i68;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i69;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i141;
import '../module_branches/branches_module.dart' as _i243;
import '../module_branches/manager/branches_manager.dart' as _i70;
import '../module_branches/repository/branches_repository.dart' as _i33;
import '../module_branches/service/branches_list_service.dart' as _i143;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i144;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i173;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i204;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i207;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i224;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i242;
import '../module_captain/captains_module.dart' as _i244;
import '../module_captain/hive/captain_hive_helper.dart' as _i9;
import '../module_captain/manager/captains_manager.dart' as _i71;
import '../module_captain/repository/captains_repository.dart' as _i34;
import '../module_captain/service/captains_service.dart' as _i72;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i145;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i156;
import '../module_captain/state_manager/captain_dues_state_manager.dart'
    as _i147;
import '../module_captain/state_manager/captain_list.dart' as _i73;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i157;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i151;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i146;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i155;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i158;
import '../module_captain/state_manager/captin_rating_details_state_manager.dart'
    as _i74;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i94;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i118;
import '../module_captain/ui/screen/captain_activity_details_screen.dart'
    as _i208;
import '../module_captain/ui/screen/captain_activity_model.dart' as _i209;
import '../module_captain/ui/screen/captain_dues_screen.dart' as _i8;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i10;
import '../module_captain/ui/screen/captain_rating_screen.dart' as _i210;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i7;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i152;
import '../module_captain/ui/screen/captin_rating_details_state.dart' as _i159;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i185;
import '../module_categories/categories_module.dart' as _i211;
import '../module_categories/manager/categories_manager.dart' as _i75;
import '../module_categories/repository/categories_repository.dart' as _i35;
import '../module_categories/service/store_categories_service.dart' as _i76;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i113;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i114;
import '../module_categories/ui/screen/categories_screen.dart' as _i160;
import '../module_categories/ui/screen/packages_screen.dart' as _i184;
import '../module_chat/chat_module.dart' as _i212;
import '../module_chat/manager/chat/chat_manager.dart' as _i77;
import '../module_chat/presistance/chat_hive_helper.dart' as _i12;
import '../module_chat/repository/chat/chat_repository.dart' as _i36;
import '../module_chat/service/chat/char_service.dart' as _i78;
import '../module_chat/state_manager/chat_state_manager.dart' as _i79;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i161;
import '../module_company/company_module.dart' as _i245;
import '../module_company/manager/company_manager.dart' as _i80;
import '../module_company/repository/company_repository.dart' as _i38;
import '../module_company/service/company_service.dart' as _i81;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i162;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i163;
import '../module_company/ui/screen/company_finance_screen.dart' as _i213;
import '../module_company/ui/screen/company_profile_screen.dart' as _i214;
import '../module_deep_links/repository/deep_link_repository.dart' as _i39;
import '../module_delivary_car/cars_module.dart' as _i11;
import '../module_dev/dev_module.dart' as _i218;
import '../module_dev/hive/order_hive_helper.dart' as _i21;
import '../module_dev/manager/dev_manager.dart' as _i82;
import '../module_dev/repository/dev_repository.dart' as _i40;
import '../module_dev/service/orders/dev.service.dart' as _i83;
import '../module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i101;
import '../module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i177;
import '../module_external_delivery_companies/external_delivery_companies_module.dart'
    as _i222;
import '../module_external_delivery_companies/manager/external_delivery_companies_manager.dart'
    as _i84;
import '../module_external_delivery_companies/repository/external_delivery_companies_repository.dart'
    as _i41;
import '../module_external_delivery_companies/service/external_delivery_companies_service.dart'
    as _i85;
import '../module_external_delivery_companies/state_manager/assign_order_to_external_company_state_manager.dart'
    as _i139;
import '../module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart'
    as _i164;
import '../module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart'
    as _i165;
import '../module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart'
    as _i86;
import '../module_external_delivery_companies/state_manager/external_orders_state_manager.dart'
    as _i87;
import '../module_external_delivery_companies/ui/screen/assign_order_to_external_company_screen.dart'
    as _i206;
import '../module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart'
    as _i217;
import '../module_external_delivery_companies/ui/screen/edit_delivery_company_setting_screen.dart'
    as _i219;
import '../module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart'
    as _i168;
import '../module_external_delivery_companies/ui/screen/external_orders_screen.dart'
    as _i169;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i16;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i17;
import '../module_main/main_module.dart' as _i175;
import '../module_main/manager/home_manager.dart' as _i90;
import '../module_main/repository/home_repository.dart' as _i43;
import '../module_main/sceen/home_screen.dart' as _i171;
import '../module_main/sceen/main_screen.dart' as _i19;
import '../module_main/service/home_service.dart' as _i91;
import '../module_main/state_manager/home_state_manager.dart' as _i92;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i96;
import '../module_my_notifications/my_notifications_module.dart' as _i225;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i45;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i97;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i98;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i138;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i176;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i205;
import '../module_network/http_client/http_client.dart' as _i3;
import '../module_notice/manager/notice_manager.dart' as _i102;
import '../module_notice/notice_module.dart' as _i226;
import '../module_notice/repository/notice_repository.dart' as _i46;
import '../module_notice/service/notice_service.dart' as _i103;
import '../module_notice/state_manager/notice_state_manager.dart' as _i104;
import '../module_notice/ui/screen/notice_screen.dart' as _i178;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i20;
import '../module_notifications/repository/notification_repo.dart' as _i47;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i88;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i15;
import '../module_orders/hive/order_hive_helper.dart' as _i22;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i49;
import '../module_orders/orders_module.dart' as _i23;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i48;
import '../module_orders/service/orders/orders.service.dart' as _i50;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i100;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i99;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i64;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i105;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i106;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i107;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i111;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i108;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i109;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i112;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i110;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i52;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i54;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i59;
import '../module_payments/manager/payments_manager.dart' as _i115;
import '../module_payments/payments_module.dart' as _i24;
import '../module_payments/repository/payments_repository.dart' as _i51;
import '../module_payments/service/payments_service.dart' as _i116;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i148;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i149;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i150;
import '../module_payments/state_manager/captain_payment_state_manager.dart'
    as _i153;
import '../module_payments/state_manager/captain_previous_payments.dart'
    as _i154;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i117;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i125;
import '../module_settings/settings_module.dart' as _i120;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i37;
import '../module_settings/ui/settings_page/settings_page.dart' as _i55;
import '../module_splash/splash_module.dart' as _i121;
import '../module_splash/ui/screen/splash_screen.dart' as _i56;
import '../module_statistics/manager/statistic_manager.dart' as _i122;
import '../module_statistics/repository/statistics_repository.dart' as _i57;
import '../module_statistics/service/statistics_service.dart' as _i123;
import '../module_statistics/state_manager/statistics_state_manager.dart'
    as _i124;
import '../module_statistics/ui/statistics_module.dart' as _i25;
import '../module_stores/hive/store_hive_helper.dart' as _i26;
import '../module_stores/manager/stores_manager.dart' as _i126;
import '../module_stores/repository/stores_repository.dart' as _i58;
import '../module_stores/service/store_service.dart' as _i127;
import '../module_stores/state_manager/edit_store_setting_state_manager.dart'
    as _i166;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i170;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i179;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i180;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i181;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i182;
import '../module_stores/state_manager/store_dues_state_manager.dart' as _i187;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i189;
import '../module_stores/state_manager/stores_dues_state_manager.dart' as _i194;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i195;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i196;
import '../module_stores/state_manager/stores_state_manager.dart' as _i128;
import '../module_stores/state_manager/top_active_store.dart' as _i136;
import '../module_stores/stores_module.dart' as _i246;
import '../module_stores/ui/screen/edit_store_setting_screen.dart' as _i220;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i227;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i228;
import '../module_stores/ui/screen/order/order_top_active_store.dart' as _i183;
import '../module_stores/ui/screen/store_info_screen.dart' as _i231;
import '../module_stores/ui/screen/stores_dues/store_dues_screen.dart' as _i230;
import '../module_stores/ui/screen/stores_dues/stores_dues_screen.dart'
    as _i234;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i235;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i236;
import '../module_stores/ui/screen/top_active_store_screen.dart' as _i137;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i129;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i60;
import '../module_subscriptions/service/subscriptions_service.dart' as _i130;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i167;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i174;
import '../module_subscriptions/state_manager/receipts_state_manager.dart'
    as _i186;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i188;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i190;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i191;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i193;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i198;
import '../module_subscriptions/subscriptions_module.dart' as _i237;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i221;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i215;
import '../module_subscriptions/ui/screen/receipts_screen.dart' as _i229;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i192;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i232;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i233;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i216;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i197;
import '../module_supplier/manager/supplier_manager.dart' as _i63;
import '../module_supplier/repository/supplier_repository.dart' as _i62;
import '../module_supplier/service/supplier_service.dart' as _i134;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i172;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i199;
import '../module_supplier/state_manager/supplier_list.dart' as _i135;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i201;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i202;
import '../module_supplier/supplier_module.dart' as _i247;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i223;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i238;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i203;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i240;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i241;
import '../module_supplier_categories/categories_supplier_module.dart' as _i239;
import '../module_supplier_categories/manager/categories_manager.dart' as _i131;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i61;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i132;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i133;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i200;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i27;
import '../module_theme/service/theme_service/theme_service.dart' as _i29;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i65;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i28;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i93;
import '../utils/global/global_state_manager.dart' as _i14;
import '../utils/helpers/firestore_helper.dart' as _i13;
import '../utils/logger/logger.dart' as _i18;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.ApiClient>(() => _i3.ApiClient());
  gh.factory<_i4.ArgumentHiveHelper>(() => _i4.ArgumentHiveHelper());
  gh.factory<_i5.AuthPrefsHelper>(() => _i5.AuthPrefsHelper());
  gh.factory<_i6.AuthRepository>(() => _i6.AuthRepository(gh<_i3.ApiClient>()));
  gh.factory<_i7.CaptainAssignOrderScreen>(
      () => _i7.CaptainAssignOrderScreen());
  gh.factory<_i8.CaptainDuesScreen>(() => _i8.CaptainDuesScreen());
  gh.factory<_i9.CaptainsHiveHelper>(() => _i9.CaptainsHiveHelper());
  gh.factory<_i10.CaptainsNeedsSupportScreen>(
      () => _i10.CaptainsNeedsSupportScreen());
  gh.factory<_i11.CarsModule>(() => _i11.CarsModule());
  gh.factory<_i12.ChatHiveHelper>(() => _i12.ChatHiveHelper());
  gh.factory<_i13.FireStoreHelper>(() => _i13.FireStoreHelper());
  gh.singleton<_i14.GlobalStateManager>(_i14.GlobalStateManager());
  gh.factory<_i15.LocalNotificationService>(
      () => _i15.LocalNotificationService());
  gh.factory<_i16.LocalizationPreferencesHelper>(
      () => _i16.LocalizationPreferencesHelper());
  gh.factory<_i17.LocalizationService>(
      () => _i17.LocalizationService(gh<_i16.LocalizationPreferencesHelper>()));
  gh.factory<_i18.Logger>(() => _i18.Logger());
  gh.factory<_i19.MainScreen>(() => _i19.MainScreen());
  gh.factory<_i20.NotificationsPrefHelper>(
      () => _i20.NotificationsPrefHelper());
  gh.factory<_i21.OrderHiveHelper>(() => _i21.OrderHiveHelper());
  gh.factory<_i22.OrderHiveHelper>(() => _i22.OrderHiveHelper());
  gh.factory<_i23.OrdersModule>(() => _i23.OrdersModule());
  gh.factory<_i24.PaymentsModule>(() => _i24.PaymentsModule());
  gh.factory<_i25.StatisticsModule>(() => _i25.StatisticsModule());
  gh.factory<_i26.StoresHiveHelper>(() => _i26.StoresHiveHelper());
  gh.factory<_i27.ThemePreferencesHelper>(() => _i27.ThemePreferencesHelper());
  gh.factory<_i28.UploadRepository>(() => _i28.UploadRepository());
  gh.factory<_i29.AppThemeDataService>(
      () => _i29.AppThemeDataService(gh<_i27.ThemePreferencesHelper>()));
  gh.factory<_i30.AuthManager>(
      () => _i30.AuthManager(gh<_i6.AuthRepository>()));
  gh.factory<_i31.AuthService>(() => _i31.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i30.AuthManager>(),
      ));
  gh.factory<_i32.BidOrderRepository>(() => _i32.BidOrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i33.BranchesRepository>(() => _i33.BranchesRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i34.CaptainsRepository>(() => _i34.CaptainsRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i35.CategoriesRepository>(() => _i35.CategoriesRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i36.ChatRepository>(() => _i36.ChatRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i37.ChooseLocalScreen>(
      () => _i37.ChooseLocalScreen(gh<_i17.LocalizationService>()));
  gh.factory<_i38.CompanyRepository>(() => _i38.CompanyRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i39.DeepLinkRepository>(() => _i39.DeepLinkRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i40.DevRepository>(() => _i40.DevRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i41.ExternalDeliveryCompaniesRepository>(
      () => _i41.ExternalDeliveryCompaniesRepository(
            gh<_i3.ApiClient>(),
            gh<_i31.AuthService>(),
          ));
  gh.factory<_i42.ForgotPassStateManager>(
      () => _i42.ForgotPassStateManager(gh<_i31.AuthService>()));
  gh.factory<_i43.HomeRepository>(() => _i43.HomeRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i44.LoginStateManager>(
      () => _i44.LoginStateManager(gh<_i31.AuthService>()));
  gh.factory<_i45.MyNotificationsRepository>(
      () => _i45.MyNotificationsRepository(
            gh<_i3.ApiClient>(),
            gh<_i31.AuthService>(),
          ));
  gh.factory<_i46.NoticeRepository>(() => _i46.NoticeRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i47.NotificationRepo>(() => _i47.NotificationRepo(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i48.OrderRepository>(() => _i48.OrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i49.OrdersManager>(
      () => _i49.OrdersManager(gh<_i48.OrderRepository>()));
  gh.factory<_i50.OrdersService>(
      () => _i50.OrdersService(gh<_i49.OrdersManager>()));
  gh.factory<_i51.PaymentsRepository>(() => _i51.PaymentsRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i52.RecycleOrderStateManager>(
      () => _i52.RecycleOrderStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i53.RegisterStateManager>(
      () => _i53.RegisterStateManager(gh<_i31.AuthService>()));
  gh.factory<_i54.SearchForOrderStateManager>(
      () => _i54.SearchForOrderStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i55.SettingsScreen>(() => _i55.SettingsScreen(
        gh<_i31.AuthService>(),
        gh<_i17.LocalizationService>(),
        gh<_i29.AppThemeDataService>(),
      ));
  gh.factory<_i56.SplashScreen>(
      () => _i56.SplashScreen(gh<_i31.AuthService>()));
  gh.factory<_i57.StatisticsRepository>(() => _i57.StatisticsRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i58.StoresRepository>(() => _i58.StoresRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i59.SubOrdersStateManager>(
      () => _i59.SubOrdersStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i60.SubscriptionsRepository>(() => _i60.SubscriptionsRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i61.SupplierCategoriesRepository>(
      () => _i61.SupplierCategoriesRepository(
            gh<_i3.ApiClient>(),
            gh<_i31.AuthService>(),
          ));
  gh.factory<_i62.SupplierRepository>(() => _i62.SupplierRepository(
        gh<_i3.ApiClient>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i63.SuppliersManager>(
      () => _i63.SuppliersManager(gh<_i62.SupplierRepository>()));
  gh.factory<_i64.UpdateOrderStateManager>(
      () => _i64.UpdateOrderStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i65.UploadManager>(
      () => _i65.UploadManager(gh<_i28.UploadRepository>()));
  gh.factory<_i66.BidOrderManager>(
      () => _i66.BidOrderManager(gh<_i32.BidOrderRepository>()));
  gh.factory<_i67.BidOrderService>(
      () => _i67.BidOrderService(gh<_i66.BidOrderManager>()));
  gh.factory<_i68.BidOrderStateManager>(
      () => _i68.BidOrderStateManager(gh<_i67.BidOrderService>()));
  gh.factory<_i69.BidOrdersScreen>(
      () => _i69.BidOrdersScreen(gh<_i68.BidOrderStateManager>()));
  gh.factory<_i70.BranchesManager>(
      () => _i70.BranchesManager(gh<_i33.BranchesRepository>()));
  gh.factory<_i71.CaptainsManager>(
      () => _i71.CaptainsManager(gh<_i34.CaptainsRepository>()));
  gh.factory<_i72.CaptainsService>(
      () => _i72.CaptainsService(gh<_i71.CaptainsManager>()));
  gh.factory<_i73.CaptainsStateManager>(
      () => _i73.CaptainsStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i74.CaptinRatingDetailsStateManager>(
      () => _i74.CaptinRatingDetailsStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i75.CategoriesManager>(
      () => _i75.CategoriesManager(gh<_i35.CategoriesRepository>()));
  gh.factory<_i76.CategoriesService>(
      () => _i76.CategoriesService(gh<_i75.CategoriesManager>()));
  gh.factory<_i77.ChatManager>(
      () => _i77.ChatManager(gh<_i36.ChatRepository>()));
  gh.factory<_i78.ChatService>(() => _i78.ChatService(gh<_i77.ChatManager>()));
  gh.factory<_i79.ChatStateManager>(
      () => _i79.ChatStateManager(gh<_i78.ChatService>()));
  gh.factory<_i80.CompanyManager>(
      () => _i80.CompanyManager(gh<_i38.CompanyRepository>()));
  gh.factory<_i81.CompanyService>(
      () => _i81.CompanyService(gh<_i80.CompanyManager>()));
  gh.factory<_i82.DevManager>(() => _i82.DevManager(gh<_i40.DevRepository>()));
  gh.factory<_i83.DevService>(() => _i83.DevService(gh<_i82.DevManager>()));
  gh.factory<_i84.ExternalDeliveryCompaniesManager>(() =>
      _i84.ExternalDeliveryCompaniesManager(
          gh<_i41.ExternalDeliveryCompaniesRepository>()));
  gh.factory<_i85.ExternalDeliveryCompaniesService>(() =>
      _i85.ExternalDeliveryCompaniesService(
          gh<_i84.ExternalDeliveryCompaniesManager>()));
  gh.factory<_i86.ExternalDeliveryCompaniesStateManager>(() =>
      _i86.ExternalDeliveryCompaniesStateManager(
          gh<_i85.ExternalDeliveryCompaniesService>()));
  gh.factory<_i87.ExternalOrdersStateManager>(() =>
      _i87.ExternalOrdersStateManager(
          gh<_i85.ExternalDeliveryCompaniesService>()));
  gh.factory<_i88.FireNotificationService>(
      () => _i88.FireNotificationService(gh<_i47.NotificationRepo>()));
  gh.factory<_i89.ForgotPassScreen>(
      () => _i89.ForgotPassScreen(gh<_i42.ForgotPassStateManager>()));
  gh.factory<_i90.HomeManager>(
      () => _i90.HomeManager(gh<_i43.HomeRepository>()));
  gh.factory<_i91.HomeService>(() => _i91.HomeService(gh<_i90.HomeManager>()));
  gh.factory<_i92.HomeStateManager>(
      () => _i92.HomeStateManager(gh<_i91.HomeService>()));
  gh.factory<_i93.ImageUploadService>(
      () => _i93.ImageUploadService(gh<_i65.UploadManager>()));
  gh.factory<_i94.InActiveCaptainsStateManager>(
      () => _i94.InActiveCaptainsStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i95.LoginScreen>(
      () => _i95.LoginScreen(gh<_i44.LoginStateManager>()));
  gh.factory<_i96.MyNotificationsManager>(
      () => _i96.MyNotificationsManager(gh<_i45.MyNotificationsRepository>()));
  gh.factory<_i97.MyNotificationsService>(
      () => _i97.MyNotificationsService(gh<_i96.MyNotificationsManager>()));
  gh.factory<_i98.MyNotificationsStateManager>(
      () => _i98.MyNotificationsStateManager(
            gh<_i97.MyNotificationsService>(),
            gh<_i31.AuthService>(),
          ));
  gh.factory<_i99.NewOrderLinkStateManager>(
      () => _i99.NewOrderLinkStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i100.NewOrderStateManager>(
      () => _i100.NewOrderStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i101.NewTestOrderStateManager>(
      () => _i101.NewTestOrderStateManager(gh<_i83.DevService>()));
  gh.factory<_i102.NoticeManager>(
      () => _i102.NoticeManager(gh<_i46.NoticeRepository>()));
  gh.factory<_i103.NoticeService>(
      () => _i103.NoticeService(gh<_i102.NoticeManager>()));
  gh.factory<_i104.NoticeStateManager>(
      () => _i104.NoticeStateManager(gh<_i103.NoticeService>()));
  gh.factory<_i105.OrderActionLogsStateManager>(
      () => _i105.OrderActionLogsStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i106.OrderCaptainLogsStateManager>(
      () => _i106.OrderCaptainLogsStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i107.OrderCashCaptainStateManager>(
      () => _i107.OrderCashCaptainStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i108.OrderDistanceConflictStateManager>(
      () => _i108.OrderDistanceConflictStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i109.OrderPendingStateManager>(
      () => _i109.OrderPendingStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i110.OrderWithoutDistanceStateManager>(
      () => _i110.OrderWithoutDistanceStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i111.OrdersCashStoreStateManager>(
      () => _i111.OrdersCashStoreStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i112.OrdersReceiveCashStateManager>(
      () => _i112.OrdersReceiveCashStateManager(gh<_i50.OrdersService>()));
  gh.factory<_i113.PackageCategoriesStateManager>(
      () => _i113.PackageCategoriesStateManager(gh<_i76.CategoriesService>()));
  gh.factory<_i114.PackagesStateManager>(
      () => _i114.PackagesStateManager(gh<_i76.CategoriesService>()));
  gh.factory<_i115.PaymentsManager>(
      () => _i115.PaymentsManager(gh<_i51.PaymentsRepository>()));
  gh.factory<_i116.PaymentsService>(
      () => _i116.PaymentsService(gh<_i115.PaymentsManager>()));
  gh.factory<_i117.PaymentsToCaptainStateManager>(
      () => _i117.PaymentsToCaptainStateManager(gh<_i116.PaymentsService>()));
  gh.factory<_i118.PlanScreenStateManager>(
      () => _i118.PlanScreenStateManager(gh<_i116.PaymentsService>()));
  gh.factory<_i119.RegisterScreen>(
      () => _i119.RegisterScreen(gh<_i53.RegisterStateManager>()));
  gh.factory<_i120.SettingsModule>(() => _i120.SettingsModule(
        gh<_i55.SettingsScreen>(),
        gh<_i37.ChooseLocalScreen>(),
      ));
  gh.factory<_i121.SplashModule>(
      () => _i121.SplashModule(gh<_i56.SplashScreen>()));
  gh.factory<_i122.StatisticManager>(
      () => _i122.StatisticManager(gh<_i57.StatisticsRepository>()));
  gh.factory<_i123.StatisticsService>(
      () => _i123.StatisticsService(gh<_i122.StatisticManager>()));
  gh.factory<_i124.StatisticsStateManager>(
      () => _i124.StatisticsStateManager(gh<_i123.StatisticsService>()));
  gh.factory<_i125.StoreBalanceStateManager>(
      () => _i125.StoreBalanceStateManager(gh<_i116.PaymentsService>()));
  gh.factory<_i126.StoreManager>(
      () => _i126.StoreManager(gh<_i58.StoresRepository>()));
  gh.factory<_i127.StoresService>(
      () => _i127.StoresService(gh<_i126.StoreManager>()));
  gh.factory<_i128.StoresStateManager>(() => _i128.StoresStateManager(
        gh<_i127.StoresService>(),
        gh<_i93.ImageUploadService>(),
      ));
  gh.factory<_i129.SubscriptionsManager>(
      () => _i129.SubscriptionsManager(gh<_i60.SubscriptionsRepository>()));
  gh.factory<_i130.SubscriptionsService>(
      () => _i130.SubscriptionsService(gh<_i129.SubscriptionsManager>()));
  gh.factory<_i131.SupplierCategoriesManager>(() =>
      _i131.SupplierCategoriesManager(gh<_i61.SupplierCategoriesRepository>()));
  gh.factory<_i132.SupplierCategoriesService>(() =>
      _i132.SupplierCategoriesService(gh<_i131.SupplierCategoriesManager>()));
  gh.factory<_i133.SupplierCategoriesStateManager>(
      () => _i133.SupplierCategoriesStateManager(
            gh<_i132.SupplierCategoriesService>(),
            gh<_i93.ImageUploadService>(),
          ));
  gh.factory<_i134.SupplierService>(
      () => _i134.SupplierService(gh<_i63.SuppliersManager>()));
  gh.factory<_i135.SuppliersStateManager>(
      () => _i135.SuppliersStateManager(gh<_i134.SupplierService>()));
  gh.factory<_i136.TopActiveStateManagment>(
      () => _i136.TopActiveStateManagment(gh<_i127.StoresService>()));
  gh.factory<_i137.TopActiveStoreScreen>(
      () => _i137.TopActiveStoreScreen(gh<_i136.TopActiveStateManagment>()));
  gh.factory<_i138.UpdatesStateManager>(() => _i138.UpdatesStateManager(
        gh<_i97.MyNotificationsService>(),
        gh<_i31.AuthService>(),
      ));
  gh.factory<_i139.AssignOrderToExternalCompanyStateManager>(() =>
      _i139.AssignOrderToExternalCompanyStateManager(
          gh<_i85.ExternalDeliveryCompaniesService>()));
  gh.factory<_i140.AuthorizationModule>(() => _i140.AuthorizationModule(
        gh<_i95.LoginScreen>(),
        gh<_i119.RegisterScreen>(),
        gh<_i89.ForgotPassScreen>(),
      ));
  gh.factory<_i141.BidOrderDetailsScreen>(
      () => _i141.BidOrderDetailsScreen(gh<_i68.BidOrderStateManager>()));
  gh.factory<_i142.BidOrderModule>(
      () => _i142.BidOrderModule(gh<_i69.BidOrdersScreen>()));
  gh.factory<_i143.BranchesListService>(
      () => _i143.BranchesListService(gh<_i70.BranchesManager>()));
  gh.factory<_i144.BranchesListStateManager>(
      () => _i144.BranchesListStateManager(gh<_i143.BranchesListService>()));
  gh.factory<_i145.CaptainActivityDetailsStateManager>(() =>
      _i145.CaptainActivityDetailsStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i146.CaptainAssignOrderStateManager>(
      () => _i146.CaptainAssignOrderStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i147.CaptainDuesStateManager>(
      () => _i147.CaptainDuesStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i148.CaptainFinanceByHoursStateManager>(() =>
      _i148.CaptainFinanceByHoursStateManager(gh<_i116.PaymentsService>()));
  gh.factory<_i149.CaptainFinanceByOrderCountStateManager>(() =>
      _i149.CaptainFinanceByOrderCountStateManager(
          gh<_i116.PaymentsService>()));
  gh.factory<_i150.CaptainFinanceByOrderStateManager>(() =>
      _i150.CaptainFinanceByOrderStateManager(gh<_i116.PaymentsService>()));
  gh.factory<_i151.CaptainOfferStateManager>(
      () => _i151.CaptainOfferStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i152.CaptainOffersScreen>(
      () => _i152.CaptainOffersScreen(gh<_i151.CaptainOfferStateManager>()));
  gh.factory<_i153.CaptainPaymentStateManager>(
      () => _i153.CaptainPaymentStateManager(gh<_i116.PaymentsService>()));
  gh.factory<_i154.CaptainPreviousPaymentsStateManager>(() =>
      _i154.CaptainPreviousPaymentsStateManager(gh<_i116.PaymentsService>()));
  gh.factory<_i155.CaptainProfileStateManager>(
      () => _i155.CaptainProfileStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i156.CaptainsActivityStateManager>(
      () => _i156.CaptainsActivityStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i157.CaptainsNeedsSupportStateManager>(
      () => _i157.CaptainsNeedsSupportStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i158.CaptainsRatingStateManager>(
      () => _i158.CaptainsRatingStateManager(gh<_i72.CaptainsService>()));
  gh.factory<_i159.CaptinRatingDetailsScreen>(() =>
      _i159.CaptinRatingDetailsScreen(
          gh<_i74.CaptinRatingDetailsStateManager>()));
  gh.factory<_i160.CategoriesScreen>(
      () => _i160.CategoriesScreen(gh<_i113.PackageCategoriesStateManager>()));
  gh.factory<_i161.ChatPage>(() => _i161.ChatPage(
        gh<_i79.ChatStateManager>(),
        gh<_i93.ImageUploadService>(),
        gh<_i31.AuthService>(),
        gh<_i12.ChatHiveHelper>(),
      ));
  gh.factory<_i162.CompanyFinanceStateManager>(
      () => _i162.CompanyFinanceStateManager(gh<_i81.CompanyService>()));
  gh.factory<_i163.CompanyProfileStateManager>(
      () => _i163.CompanyProfileStateManager(gh<_i81.CompanyService>()));
  gh.factory<_i164.DeliveryCompanyAllSettingsStateManager>(() =>
      _i164.DeliveryCompanyAllSettingsStateManager(
          gh<_i85.ExternalDeliveryCompaniesService>()));
  gh.factory<_i165.EditDeliveryCompanySettingScreenStateManager>(() =>
      _i165.EditDeliveryCompanySettingScreenStateManager(
          gh<_i85.ExternalDeliveryCompaniesService>()));
  gh.factory<_i166.EditStoreSettingStateManager>(
      () => _i166.EditStoreSettingStateManager(
            gh<_i127.StoresService>(),
            gh<_i93.ImageUploadService>(),
          ));
  gh.factory<_i167.EditSubscriptionStateManager>(() =>
      _i167.EditSubscriptionStateManager(gh<_i130.SubscriptionsService>()));
  gh.factory<_i168.ExternalDeliveryCompaniesScreen>(() =>
      _i168.ExternalDeliveryCompaniesScreen(
          gh<_i86.ExternalDeliveryCompaniesStateManager>()));
  gh.factory<_i169.ExternalOrderScreen>(
      () => _i169.ExternalOrderScreen(gh<_i87.ExternalOrdersStateManager>()));
  gh.factory<_i170.FilterOrderTopStateManager>(
      () => _i170.FilterOrderTopStateManager(gh<_i127.StoresService>()));
  gh.factory<_i171.HomeScreen>(
      () => _i171.HomeScreen(gh<_i92.HomeStateManager>()));
  gh.factory<_i172.InActiveSupplierStateManager>(
      () => _i172.InActiveSupplierStateManager(gh<_i134.SupplierService>()));
  gh.factory<_i173.InitBranchesStateManager>(
      () => _i173.InitBranchesStateManager(gh<_i143.BranchesListService>()));
  gh.factory<_i174.InitSubscriptionStateManager>(() =>
      _i174.InitSubscriptionStateManager(gh<_i130.SubscriptionsService>()));
  gh.factory<_i175.MainModule>(() => _i175.MainModule(
        gh<_i19.MainScreen>(),
        gh<_i171.HomeScreen>(),
      ));
  gh.factory<_i176.MyNotificationsScreen>(() =>
      _i176.MyNotificationsScreen(gh<_i98.MyNotificationsStateManager>()));
  gh.factory<_i177.NewTestOrderScreen>(
      () => _i177.NewTestOrderScreen(gh<_i101.NewTestOrderStateManager>()));
  gh.factory<_i178.NoticeScreen>(
      () => _i178.NoticeScreen(gh<_i104.NoticeStateManager>()));
  gh.factory<_i179.OrderCaptainNotArrivedStateManager>(() =>
      _i179.OrderCaptainNotArrivedStateManager(gh<_i127.StoresService>()));
  gh.factory<_i180.OrderLogsStateManager>(
      () => _i180.OrderLogsStateManager(gh<_i127.StoresService>()));
  gh.factory<_i181.OrderStatusStateManager>(
      () => _i181.OrderStatusStateManager(gh<_i127.StoresService>()));
  gh.factory<_i182.OrderTimeLineStateManager>(
      () => _i182.OrderTimeLineStateManager(gh<_i127.StoresService>()));
  gh.factory<_i183.OrdersTopActiveStoreScreen>(() =>
      _i183.OrdersTopActiveStoreScreen(gh<_i170.FilterOrderTopStateManager>()));
  gh.factory<_i184.PackagesScreen>(
      () => _i184.PackagesScreen(gh<_i114.PackagesStateManager>()));
  gh.factory<_i185.PlanScreen>(
      () => _i185.PlanScreen(gh<_i118.PlanScreenStateManager>()));
  gh.factory<_i186.ReceiptsStateManager>(
      () => _i186.ReceiptsStateManager(gh<_i130.SubscriptionsService>()));
  gh.factory<_i187.StoreDuesStateManager>(() => _i187.StoreDuesStateManager(
        gh<_i127.StoresService>(),
        gh<_i116.PaymentsService>(),
      ));
  gh.factory<_i188.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i188.StoreFinancialSubscriptionsDuesDetailsStateManager(
            gh<_i116.PaymentsService>(),
            gh<_i130.SubscriptionsService>(),
          ));
  gh.factory<_i189.StoreProfileStateManager>(
      () => _i189.StoreProfileStateManager(
            gh<_i127.StoresService>(),
            gh<_i93.ImageUploadService>(),
          ));
  gh.factory<_i190.StoreSubscriptionManagementStateManager>(() =>
      _i190.StoreSubscriptionManagementStateManager(
          gh<_i130.SubscriptionsService>()));
  gh.factory<_i191.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i191.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i130.SubscriptionsService>()));
  gh.factory<_i192.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i192.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i188.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i193.StoreSubscriptionsFinanceStateManager>(() =>
      _i193.StoreSubscriptionsFinanceStateManager(
          gh<_i130.SubscriptionsService>()));
  gh.factory<_i194.StoresDuesStateManager>(
      () => _i194.StoresDuesStateManager(gh<_i127.StoresService>()));
  gh.factory<_i195.StoresInActiveStateManager>(
      () => _i195.StoresInActiveStateManager(
            gh<_i127.StoresService>(),
            gh<_i93.ImageUploadService>(),
          ));
  gh.factory<_i196.StoresNeedsSupportStateManager>(
      () => _i196.StoresNeedsSupportStateManager(gh<_i127.StoresService>()));
  gh.factory<_i197.SubscriptionManagementScreen>(() =>
      _i197.SubscriptionManagementScreen(
          gh<_i190.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i198.SubscriptionToCaptainOfferStateManager>(() =>
      _i198.SubscriptionToCaptainOfferStateManager(
          gh<_i130.SubscriptionsService>()));
  gh.factory<_i199.SupplierAdsStateManager>(
      () => _i199.SupplierAdsStateManager(gh<_i134.SupplierService>()));
  gh.factory<_i200.SupplierCategoriesScreen>(() =>
      _i200.SupplierCategoriesScreen(
          gh<_i133.SupplierCategoriesStateManager>()));
  gh.factory<_i201.SupplierNeedsSupportStateManager>(() =>
      _i201.SupplierNeedsSupportStateManager(gh<_i134.SupplierService>()));
  gh.factory<_i202.SupplierProfileStateManager>(
      () => _i202.SupplierProfileStateManager(gh<_i134.SupplierService>()));
  gh.factory<_i203.SuppliersScreen>(
      () => _i203.SuppliersScreen(gh<_i135.SuppliersStateManager>()));
  gh.factory<_i204.UpdateBranchStateManager>(
      () => _i204.UpdateBranchStateManager(gh<_i143.BranchesListService>()));
  gh.factory<_i205.UpdateScreen>(
      () => _i205.UpdateScreen(gh<_i138.UpdatesStateManager>()));
  gh.factory<_i206.AssignOrderToExternalCompanyScreen>(() =>
      _i206.AssignOrderToExternalCompanyScreen(
          gh<_i139.AssignOrderToExternalCompanyStateManager>()));
  gh.factory<_i207.BranchesListScreen>(
      () => _i207.BranchesListScreen(gh<_i144.BranchesListStateManager>()));
  gh.factory<_i208.CaptainActivityDetailsScreen>(() =>
      _i208.CaptainActivityDetailsScreen(
          gh<_i145.CaptainActivityDetailsStateManager>()));
  gh.factory<_i209.CaptainsActivityScreen>(() =>
      _i209.CaptainsActivityScreen(gh<_i156.CaptainsActivityStateManager>()));
  gh.factory<_i210.CaptainsRatingScreen>(
      () => _i210.CaptainsRatingScreen(gh<_i158.CaptainsRatingStateManager>()));
  gh.factory<_i211.CategoriesModule>(() => _i211.CategoriesModule(
        gh<_i160.CategoriesScreen>(),
        gh<_i184.PackagesScreen>(),
      ));
  gh.factory<_i212.ChatModule>(() => _i212.ChatModule(gh<_i161.ChatPage>()));
  gh.factory<_i213.CompanyFinanceScreen>(
      () => _i213.CompanyFinanceScreen(gh<_i162.CompanyFinanceStateManager>()));
  gh.factory<_i214.CompanyProfileScreen>(
      () => _i214.CompanyProfileScreen(gh<_i163.CompanyProfileStateManager>()));
  gh.factory<_i215.CreateSubscriptionScreen>(() =>
      _i215.CreateSubscriptionScreen(gh<_i174.InitSubscriptionStateManager>()));
  gh.factory<_i216.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i216.CreateSubscriptionToCaptainOfferScreen(
          gh<_i198.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i217.DeliveryCompanyAllSettingsScreen>(() =>
      _i217.DeliveryCompanyAllSettingsScreen(
          gh<_i164.DeliveryCompanyAllSettingsStateManager>()));
  gh.factory<_i218.DevModule>(
      () => _i218.DevModule(gh<_i177.NewTestOrderScreen>()));
  gh.factory<_i219.EditDeliveryCompanySettingScreen>(() =>
      _i219.EditDeliveryCompanySettingScreen(
          gh<_i165.EditDeliveryCompanySettingScreenStateManager>()));
  gh.factory<_i220.EditStoreSettingScreen>(() =>
      _i220.EditStoreSettingScreen(gh<_i166.EditStoreSettingStateManager>()));
  gh.factory<_i221.EditSubscriptionScreen>(() =>
      _i221.EditSubscriptionScreen(gh<_i167.EditSubscriptionStateManager>()));
  gh.factory<_i222.ExternalDeliveryCompaniesModule>(
      () => _i222.ExternalDeliveryCompaniesModule(
            gh<_i168.ExternalDeliveryCompaniesScreen>(),
            gh<_i217.DeliveryCompanyAllSettingsScreen>(),
            gh<_i219.EditDeliveryCompanySettingScreen>(),
            gh<_i206.AssignOrderToExternalCompanyScreen>(),
            gh<_i169.ExternalOrderScreen>(),
          ));
  gh.factory<_i223.InActiveSupplierScreen>(() =>
      _i223.InActiveSupplierScreen(gh<_i172.InActiveSupplierStateManager>()));
  gh.factory<_i224.InitBranchesScreen>(
      () => _i224.InitBranchesScreen(gh<_i173.InitBranchesStateManager>()));
  gh.factory<_i225.MyNotificationsModule>(() => _i225.MyNotificationsModule(
        gh<_i176.MyNotificationsScreen>(),
        gh<_i205.UpdateScreen>(),
      ));
  gh.factory<_i226.NoticeModule>(
      () => _i226.NoticeModule(gh<_i178.NoticeScreen>()));
  gh.factory<_i227.OrderCaptainNotArrivedScreen>(() =>
      _i227.OrderCaptainNotArrivedScreen(
          gh<_i179.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i228.OrderTimeLineScreen>(
      () => _i228.OrderTimeLineScreen(gh<_i182.OrderTimeLineStateManager>()));
  gh.factory<_i229.ReceiptsScreen>(
      () => _i229.ReceiptsScreen(gh<_i186.ReceiptsStateManager>()));
  gh.factory<_i230.StoreDuesScreen>(
      () => _i230.StoreDuesScreen(gh<_i187.StoreDuesStateManager>()));
  gh.factory<_i231.StoreInfoScreen>(
      () => _i231.StoreInfoScreen(gh<_i189.StoreProfileStateManager>()));
  gh.factory<_i232.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i232.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i191.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i233.StoreSubscriptionsFinanceScreen>(() =>
      _i233.StoreSubscriptionsFinanceScreen(
          gh<_i193.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i234.StoresDuesScreen>(
      () => _i234.StoresDuesScreen(gh<_i194.StoresDuesStateManager>()));
  gh.factory<_i235.StoresInActiveScreen>(
      () => _i235.StoresInActiveScreen(gh<_i195.StoresInActiveStateManager>()));
  gh.factory<_i236.StoresNeedsSupportScreen>(() =>
      _i236.StoresNeedsSupportScreen(
          gh<_i196.StoresNeedsSupportStateManager>()));
  gh.factory<_i237.SubscriptionsModule>(() => _i237.SubscriptionsModule(
        gh<_i192.StoreSubscriptionsFinanceDetailsScreen>(),
        gh<_i233.StoreSubscriptionsFinanceScreen>(),
        gh<_i197.SubscriptionManagementScreen>(),
        gh<_i232.StoreSubscriptionsExpiredFinanceScreen>(),
        gh<_i215.CreateSubscriptionScreen>(),
        gh<_i216.CreateSubscriptionToCaptainOfferScreen>(),
        gh<_i221.EditSubscriptionScreen>(),
        gh<_i229.ReceiptsScreen>(),
      ));
  gh.factory<_i238.SupplierAdsScreen>(
      () => _i238.SupplierAdsScreen(gh<_i199.SupplierAdsStateManager>()));
  gh.factory<_i239.SupplierCategoriesModule>(() =>
      _i239.SupplierCategoriesModule(gh<_i200.SupplierCategoriesScreen>()));
  gh.factory<_i240.SupplierNeedsSupportScreen>(() =>
      _i240.SupplierNeedsSupportScreen(
          gh<_i201.SupplierNeedsSupportStateManager>()));
  gh.factory<_i241.SupplierProfileScreen>(() =>
      _i241.SupplierProfileScreen(gh<_i202.SupplierProfileStateManager>()));
  gh.factory<_i242.UpdateBranchScreen>(
      () => _i242.UpdateBranchScreen(gh<_i204.UpdateBranchStateManager>()));
  gh.factory<_i243.BranchesModule>(() => _i243.BranchesModule(
        gh<_i207.BranchesListScreen>(),
        gh<_i242.UpdateBranchScreen>(),
        gh<_i224.InitBranchesScreen>(),
      ));
  gh.factory<_i244.CaptainsModule>(() => _i244.CaptainsModule(
        gh<_i152.CaptainOffersScreen>(),
        gh<_i185.PlanScreen>(),
        gh<_i210.CaptainsRatingScreen>(),
        gh<_i159.CaptinRatingDetailsScreen>(),
        gh<_i209.CaptainsActivityScreen>(),
        gh<_i208.CaptainActivityDetailsScreen>(),
      ));
  gh.factory<_i245.CompanyModule>(() => _i245.CompanyModule(
        gh<_i214.CompanyProfileScreen>(),
        gh<_i213.CompanyFinanceScreen>(),
      ));
  gh.factory<_i246.StoresModule>(() => _i246.StoresModule(
        gh<_i231.StoreInfoScreen>(),
        gh<_i235.StoresInActiveScreen>(),
        gh<_i236.StoresNeedsSupportScreen>(),
        gh<_i227.OrderCaptainNotArrivedScreen>(),
        gh<_i228.OrderTimeLineScreen>(),
        gh<_i137.TopActiveStoreScreen>(),
        gh<_i183.OrdersTopActiveStoreScreen>(),
        gh<_i234.StoresDuesScreen>(),
        gh<_i230.StoreDuesScreen>(),
        gh<_i220.EditStoreSettingScreen>(),
      ));
  gh.factory<_i247.SupplierModule>(() => _i247.SupplierModule(
        gh<_i223.InActiveSupplierScreen>(),
        gh<_i203.SuppliersScreen>(),
        gh<_i241.SupplierProfileScreen>(),
        gh<_i240.SupplierNeedsSupportScreen>(),
        gh<_i238.SupplierAdsScreen>(),
      ));
  gh.factory<_i248.MyApp>(() => _i248.MyApp(
        gh<_i29.AppThemeDataService>(),
        gh<_i17.LocalizationService>(),
        gh<_i88.FireNotificationService>(),
        gh<_i15.LocalNotificationService>(),
        gh<_i121.SplashModule>(),
        gh<_i140.AuthorizationModule>(),
        gh<_i212.ChatModule>(),
        gh<_i120.SettingsModule>(),
        gh<_i175.MainModule>(),
        gh<_i246.StoresModule>(),
        gh<_i211.CategoriesModule>(),
        gh<_i245.CompanyModule>(),
        gh<_i243.BranchesModule>(),
        gh<_i226.NoticeModule>(),
        gh<_i244.CaptainsModule>(),
        gh<_i24.PaymentsModule>(),
        gh<_i239.SupplierCategoriesModule>(),
        gh<_i247.SupplierModule>(),
        gh<_i11.CarsModule>(),
        gh<_i142.BidOrderModule>(),
        gh<_i23.OrdersModule>(),
        gh<_i237.SubscriptionsModule>(),
        gh<_i225.MyNotificationsModule>(),
        gh<_i25.StatisticsModule>(),
        gh<_i218.DevModule>(),
        gh<_i222.ExternalDeliveryCompaniesModule>(),
      ));
  return getIt;
}

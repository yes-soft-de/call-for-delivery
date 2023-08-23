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
import '../main.dart' as _i272;
import '../module_auth/authoriazation_module.dart' as _i140;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i25;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i6;
import '../module_auth/service/auth_service/auth_service.dart' as _i26;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i37;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i39;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i48;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i84;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i90;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i116;
import '../module_bid_order/bid_order_module.dart' as _i142;
import '../module_bid_order/manager/bid_order_manager.dart' as _i61;
import '../module_bid_order/repository/bid_order_repository.dart' as _i27;
import '../module_bid_order/service/bid_order_service.dart' as _i62;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i63;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i64;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i141;
import '../module_branches/branches_module.dart' as _i267;
import '../module_branches/manager/branches_manager.dart' as _i65;
import '../module_branches/repository/branches_repository.dart' as _i28;
import '../module_branches/service/branches_list_service.dart' as _i143;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i144;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i173;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i214;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i218;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i244;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i266;
import '../module_captain/captains_module.dart' as _i268;
import '../module_captain/hive/captain_hive_helper.dart' as _i7;
import '../module_captain/manager/captains_manager.dart' as _i66;
import '../module_captain/repository/captains_repository.dart' as _i29;
import '../module_captain/service/captains_service.dart' as _i67;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i145;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i156;
import '../module_captain/state_manager/captain_dues_state_manager.dart'
    as _i147;
import '../module_captain/state_manager/captain_list.dart' as _i68;
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
    as _i69;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i89;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i114;
import '../module_captain/ui/screen/captain_activity_details_screen.dart'
    as _i219;
import '../module_captain/ui/screen/captain_activity_model.dart' as _i228;
import '../module_captain/ui/screen/captain_dues_screen.dart' as _i221;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i229;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i227;
import '../module_captain/ui/screen/captain_rating_screen.dart' as _i230;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i220;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i152;
import '../module_captain/ui/screen/captin_rating_details_state.dart' as _i159;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i193;
import '../module_categories/categories_module.dart' as _i231;
import '../module_categories/manager/categories_manager.dart' as _i70;
import '../module_categories/repository/categories_repository.dart' as _i30;
import '../module_categories/service/store_categories_service.dart' as _i71;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i109;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i110;
import '../module_categories/ui/screen/categories_screen.dart' as _i160;
import '../module_categories/ui/screen/packages_screen.dart' as _i191;
import '../module_chat/chat_module.dart' as _i232;
import '../module_chat/manager/chat/chat_manager.dart' as _i72;
import '../module_chat/presistance/chat_hive_helper.dart' as _i9;
import '../module_chat/repository/chat/chat_repository.dart' as _i31;
import '../module_chat/service/chat/char_service.dart' as _i73;
import '../module_chat/state_manager/chat_state_manager.dart' as _i74;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i161;
import '../module_company/company_module.dart' as _i269;
import '../module_company/manager/company_manager.dart' as _i75;
import '../module_company/repository/company_repository.dart' as _i33;
import '../module_company/service/company_service.dart' as _i76;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i162;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i163;
import '../module_company/ui/screen/company_finance_screen.dart' as _i233;
import '../module_company/ui/screen/company_profile_screen.dart' as _i234;
import '../module_deep_links/repository/deep_link_repository.dart' as _i34;
import '../module_delivary_car/cars_module.dart' as _i8;
import '../module_dev/dev_module.dart' as _i238;
import '../module_dev/hive/order_hive_helper.dart' as _i19;
import '../module_dev/manager/dev_manager.dart' as _i77;
import '../module_dev/repository/dev_repository.dart' as _i35;
import '../module_dev/service/orders/dev.service.dart' as _i78;
import '../module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i96;
import '../module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i179;
import '../module_external_delivery_companies/external_delivery_companies_module.dart'
    as _i242;
import '../module_external_delivery_companies/manager/external_delivery_companies_manager.dart'
    as _i79;
import '../module_external_delivery_companies/repository/external_delivery_companies_repository.dart'
    as _i36;
import '../module_external_delivery_companies/service/external_delivery_companies_service.dart'
    as _i80;
import '../module_external_delivery_companies/state_manager/assign_order_to_external_company_state_manager.dart'
    as _i139;
import '../module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart'
    as _i164;
import '../module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart'
    as _i165;
import '../module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart'
    as _i81;
import '../module_external_delivery_companies/state_manager/external_orders_state_manager.dart'
    as _i82;
import '../module_external_delivery_companies/ui/screen/assign_order_to_external_company_screen.dart'
    as _i217;
import '../module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart'
    as _i237;
import '../module_external_delivery_companies/ui/screen/edit_delivery_company_setting_screen.dart'
    as _i239;
import '../module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart'
    as _i168;
import '../module_external_delivery_companies/ui/screen/external_orders_screen.dart'
    as _i169;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i13;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i14;
import '../module_main/main_module.dart' as _i175;
import '../module_main/manager/home_manager.dart' as _i85;
import '../module_main/repository/home_repository.dart' as _i38;
import '../module_main/sceen/home_screen.dart' as _i171;
import '../module_main/sceen/main_screen.dart' as _i16;
import '../module_main/service/home_service.dart' as _i86;
import '../module_main/state_manager/home_state_manager.dart' as _i87;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i91;
import '../module_my_notifications/my_notifications_module.dart' as _i245;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i40;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i92;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i93;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i138;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i176;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i215;
import '../module_network/http_client/http_client.dart' as _i3;
import '../module_notice/manager/notice_manager.dart' as _i97;
import '../module_notice/notice_module.dart' as _i246;
import '../module_notice/repository/notice_repository.dart' as _i41;
import '../module_notice/service/notice_service.dart' as _i98;
import '../module_notice/state_manager/notice_state_manager.dart' as _i99;
import '../module_notice/ui/screen/notice_screen.dart' as _i180;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i17;
import '../module_notifications/repository/notification_repo.dart' as _i42;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i83;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i12;
import '../module_orders/hive/order_hive_helper.dart' as _i18;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i44;
import '../module_orders/orders_module.dart' as _i251;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i43;
import '../module_orders/service/orders/orders.service.dart' as _i45;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i95;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i94;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i59;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i100;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i101;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i102;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i107;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i103;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i104;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i108;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i105;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i47;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i49;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i54;
import '../module_orders/ui/screens/new_order/new_order_link.dart' as _i177;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i178;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i137;
import '../module_orders/ui/screens/order_actions_log_screen.dart' as _i181;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i106;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i188;
import '../module_orders/ui/screens/order_conflict_distance_screen.dart'
    as _i183;
import '../module_orders/ui/screens/order_pending_screen.dart' as _i185;
import '../module_orders/ui/screens/orders_receive_cash_screen.dart' as _i189;
import '../module_orders/ui/screens/recycle_order/recycle_order_screen.dart'
    as _i115;
import '../module_orders/ui/screens/search_for_order_screen.dart' as _i117;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i127;
import '../module_payments/manager/payments_manager.dart' as _i111;
import '../module_payments/payments_module.dart' as _i252;
import '../module_payments/repository/payments_repository.dart' as _i46;
import '../module_payments/service/payments_service.dart' as _i112;
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
    as _i113;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i123;
import '../module_payments/ui/screen/all_amount_captains_screen.dart' as _i216;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i223;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i222;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i224;
import '../module_payments/ui/screen/captain_payment_screen.dart' as _i225;
import '../module_payments/ui/screen/captain_previous_payments_screen.dart'
    as _i226;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i192;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i195;
import '../module_settings/settings_module.dart' as _i118;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i32;
import '../module_settings/ui/settings_page/settings_page.dart' as _i50;
import '../module_splash/splash_module.dart' as _i119;
import '../module_splash/ui/screen/splash_screen.dart' as _i51;
import '../module_statistics/manager/statistic_manager.dart' as _i120;
import '../module_statistics/repository/statistics_repository.dart' as _i52;
import '../module_statistics/service/statistics_service.dart' as _i121;
import '../module_statistics/state_manager/statistics_state_manager.dart'
    as _i122;
import '../module_statistics/ui/statistics_module.dart' as _i20;
import '../module_stores/hive/store_hive_helper.dart' as _i21;
import '../module_stores/manager/stores_manager.dart' as _i124;
import '../module_stores/repository/stores_repository.dart' as _i53;
import '../module_stores/service/store_service.dart' as _i125;
import '../module_stores/state_manager/edit_store_setting_state_manager.dart'
    as _i166;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i170;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i182;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i184;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i186;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i187;
import '../module_stores/state_manager/store_dues_state_manager.dart' as _i196;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i198;
import '../module_stores/state_manager/stores_dues_state_manager.dart' as _i203;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i204;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i205;
import '../module_stores/state_manager/stores_state_manager.dart' as _i126;
import '../module_stores/state_manager/top_active_store.dart' as _i135;
import '../module_stores/stores_module.dart' as _i270;
import '../module_stores/ui/screen/edit_store_setting_screen.dart' as _i240;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i247;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i248;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i249;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i250;
import '../module_stores/ui/screen/order/order_top_active_store.dart' as _i190;
import '../module_stores/ui/screen/store_info_screen.dart' as _i255;
import '../module_stores/ui/screen/stores_dues/store_dues_screen.dart' as _i254;
import '../module_stores/ui/screen/stores_dues/stores_dues_screen.dart'
    as _i258;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i259;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i260;
import '../module_stores/ui/screen/stores_screen.dart' as _i206;
import '../module_stores/ui/screen/top_active_store_screen.dart' as _i136;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i128;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i55;
import '../module_subscriptions/service/subscriptions_service.dart' as _i129;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i167;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i174;
import '../module_subscriptions/state_manager/receipts_state_manager.dart'
    as _i194;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i197;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i199;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i200;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i202;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i208;
import '../module_subscriptions/subscriptions_module.dart' as _i261;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i241;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i235;
import '../module_subscriptions/ui/screen/receipts_screen.dart' as _i253;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i201;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i256;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i257;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i236;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i207;
import '../module_supplier/manager/supplier_manager.dart' as _i58;
import '../module_supplier/repository/supplier_repository.dart' as _i57;
import '../module_supplier/service/supplier_service.dart' as _i133;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i172;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i209;
import '../module_supplier/state_manager/supplier_list.dart' as _i134;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i211;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i212;
import '../module_supplier/supplier_module.dart' as _i271;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i243;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i262;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i213;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i264;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i265;
import '../module_supplier_categories/categories_supplier_module.dart' as _i263;
import '../module_supplier_categories/manager/categories_manager.dart' as _i130;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i56;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i131;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i132;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i210;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i22;
import '../module_theme/service/theme_service/theme_service.dart' as _i24;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i60;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i23;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i88;
import '../utils/global/global_state_manager.dart' as _i11;
import '../utils/helpers/firestore_helper.dart' as _i10;
import '../utils/logger/logger.dart' as _i15;

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
  gh.factory<_i7.CaptainsHiveHelper>(() => _i7.CaptainsHiveHelper());
  gh.factory<_i8.CarsModule>(() => _i8.CarsModule());
  gh.factory<_i9.ChatHiveHelper>(() => _i9.ChatHiveHelper());
  gh.factory<_i10.FireStoreHelper>(() => _i10.FireStoreHelper());
  gh.singleton<_i11.GlobalStateManager>(_i11.GlobalStateManager());
  gh.factory<_i12.LocalNotificationService>(
      () => _i12.LocalNotificationService());
  gh.factory<_i13.LocalizationPreferencesHelper>(
      () => _i13.LocalizationPreferencesHelper());
  gh.factory<_i14.LocalizationService>(
      () => _i14.LocalizationService(gh<_i13.LocalizationPreferencesHelper>()));
  gh.factory<_i15.Logger>(() => _i15.Logger());
  gh.factory<_i16.MainScreen>(() => _i16.MainScreen());
  gh.factory<_i17.NotificationsPrefHelper>(
      () => _i17.NotificationsPrefHelper());
  gh.factory<_i18.OrderHiveHelper>(() => _i18.OrderHiveHelper());
  gh.factory<_i19.OrderHiveHelper>(() => _i19.OrderHiveHelper());
  gh.factory<_i20.StatisticsModule>(() => _i20.StatisticsModule());
  gh.factory<_i21.StoresHiveHelper>(() => _i21.StoresHiveHelper());
  gh.factory<_i22.ThemePreferencesHelper>(() => _i22.ThemePreferencesHelper());
  gh.factory<_i23.UploadRepository>(() => _i23.UploadRepository());
  gh.factory<_i24.AppThemeDataService>(
      () => _i24.AppThemeDataService(gh<_i22.ThemePreferencesHelper>()));
  gh.factory<_i25.AuthManager>(
      () => _i25.AuthManager(gh<_i6.AuthRepository>()));
  gh.factory<_i26.AuthService>(() => _i26.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i25.AuthManager>(),
      ));
  gh.factory<_i27.BidOrderRepository>(() => _i27.BidOrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i28.BranchesRepository>(() => _i28.BranchesRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i29.CaptainsRepository>(() => _i29.CaptainsRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i30.CategoriesRepository>(() => _i30.CategoriesRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i31.ChatRepository>(() => _i31.ChatRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i32.ChooseLocalScreen>(
      () => _i32.ChooseLocalScreen(gh<_i14.LocalizationService>()));
  gh.factory<_i33.CompanyRepository>(() => _i33.CompanyRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i34.DeepLinkRepository>(() => _i34.DeepLinkRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i35.DevRepository>(() => _i35.DevRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i36.ExternalDeliveryCompaniesRepository>(
      () => _i36.ExternalDeliveryCompaniesRepository(
            gh<_i3.ApiClient>(),
            gh<_i26.AuthService>(),
          ));
  gh.factory<_i37.ForgotPassStateManager>(
      () => _i37.ForgotPassStateManager(gh<_i26.AuthService>()));
  gh.factory<_i38.HomeRepository>(() => _i38.HomeRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i39.LoginStateManager>(
      () => _i39.LoginStateManager(gh<_i26.AuthService>()));
  gh.factory<_i40.MyNotificationsRepository>(
      () => _i40.MyNotificationsRepository(
            gh<_i3.ApiClient>(),
            gh<_i26.AuthService>(),
          ));
  gh.factory<_i41.NoticeRepository>(() => _i41.NoticeRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i42.NotificationRepo>(() => _i42.NotificationRepo(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i43.OrderRepository>(() => _i43.OrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i44.OrdersManager>(
      () => _i44.OrdersManager(gh<_i43.OrderRepository>()));
  gh.factory<_i45.OrdersService>(
      () => _i45.OrdersService(gh<_i44.OrdersManager>()));
  gh.factory<_i46.PaymentsRepository>(() => _i46.PaymentsRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i47.RecycleOrderStateManager>(
      () => _i47.RecycleOrderStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i48.RegisterStateManager>(
      () => _i48.RegisterStateManager(gh<_i26.AuthService>()));
  gh.factory<_i49.SearchForOrderStateManager>(
      () => _i49.SearchForOrderStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i50.SettingsScreen>(() => _i50.SettingsScreen(
        gh<_i26.AuthService>(),
        gh<_i14.LocalizationService>(),
        gh<_i24.AppThemeDataService>(),
      ));
  gh.factory<_i51.SplashScreen>(
      () => _i51.SplashScreen(gh<_i26.AuthService>()));
  gh.factory<_i52.StatisticsRepository>(() => _i52.StatisticsRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i53.StoresRepository>(() => _i53.StoresRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i54.SubOrdersStateManager>(
      () => _i54.SubOrdersStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i55.SubscriptionsRepository>(() => _i55.SubscriptionsRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i56.SupplierCategoriesRepository>(
      () => _i56.SupplierCategoriesRepository(
            gh<_i3.ApiClient>(),
            gh<_i26.AuthService>(),
          ));
  gh.factory<_i57.SupplierRepository>(() => _i57.SupplierRepository(
        gh<_i3.ApiClient>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i58.SuppliersManager>(
      () => _i58.SuppliersManager(gh<_i57.SupplierRepository>()));
  gh.factory<_i59.UpdateOrderStateManager>(
      () => _i59.UpdateOrderStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i60.UploadManager>(
      () => _i60.UploadManager(gh<_i23.UploadRepository>()));
  gh.factory<_i61.BidOrderManager>(
      () => _i61.BidOrderManager(gh<_i27.BidOrderRepository>()));
  gh.factory<_i62.BidOrderService>(
      () => _i62.BidOrderService(gh<_i61.BidOrderManager>()));
  gh.factory<_i63.BidOrderStateManager>(
      () => _i63.BidOrderStateManager(gh<_i62.BidOrderService>()));
  gh.factory<_i64.BidOrdersScreen>(
      () => _i64.BidOrdersScreen(gh<_i63.BidOrderStateManager>()));
  gh.factory<_i65.BranchesManager>(
      () => _i65.BranchesManager(gh<_i28.BranchesRepository>()));
  gh.factory<_i66.CaptainsManager>(
      () => _i66.CaptainsManager(gh<_i29.CaptainsRepository>()));
  gh.factory<_i67.CaptainsService>(
      () => _i67.CaptainsService(gh<_i66.CaptainsManager>()));
  gh.factory<_i68.CaptainsStateManager>(
      () => _i68.CaptainsStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i69.CaptinRatingDetailsStateManager>(
      () => _i69.CaptinRatingDetailsStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i70.CategoriesManager>(
      () => _i70.CategoriesManager(gh<_i30.CategoriesRepository>()));
  gh.factory<_i71.CategoriesService>(
      () => _i71.CategoriesService(gh<_i70.CategoriesManager>()));
  gh.factory<_i72.ChatManager>(
      () => _i72.ChatManager(gh<_i31.ChatRepository>()));
  gh.factory<_i73.ChatService>(() => _i73.ChatService(gh<_i72.ChatManager>()));
  gh.factory<_i74.ChatStateManager>(
      () => _i74.ChatStateManager(gh<_i73.ChatService>()));
  gh.factory<_i75.CompanyManager>(
      () => _i75.CompanyManager(gh<_i33.CompanyRepository>()));
  gh.factory<_i76.CompanyService>(
      () => _i76.CompanyService(gh<_i75.CompanyManager>()));
  gh.factory<_i77.DevManager>(() => _i77.DevManager(gh<_i35.DevRepository>()));
  gh.factory<_i78.DevService>(() => _i78.DevService(gh<_i77.DevManager>()));
  gh.factory<_i79.ExternalDeliveryCompaniesManager>(() =>
      _i79.ExternalDeliveryCompaniesManager(
          gh<_i36.ExternalDeliveryCompaniesRepository>()));
  gh.factory<_i80.ExternalDeliveryCompaniesService>(() =>
      _i80.ExternalDeliveryCompaniesService(
          gh<_i79.ExternalDeliveryCompaniesManager>()));
  gh.factory<_i81.ExternalDeliveryCompaniesStateManager>(() =>
      _i81.ExternalDeliveryCompaniesStateManager(
          gh<_i80.ExternalDeliveryCompaniesService>()));
  gh.factory<_i82.ExternalOrdersStateManager>(() =>
      _i82.ExternalOrdersStateManager(
          gh<_i80.ExternalDeliveryCompaniesService>()));
  gh.factory<_i83.FireNotificationService>(
      () => _i83.FireNotificationService(gh<_i42.NotificationRepo>()));
  gh.factory<_i84.ForgotPassScreen>(
      () => _i84.ForgotPassScreen(gh<_i37.ForgotPassStateManager>()));
  gh.factory<_i85.HomeManager>(
      () => _i85.HomeManager(gh<_i38.HomeRepository>()));
  gh.factory<_i86.HomeService>(() => _i86.HomeService(gh<_i85.HomeManager>()));
  gh.factory<_i87.HomeStateManager>(
      () => _i87.HomeStateManager(gh<_i86.HomeService>()));
  gh.factory<_i88.ImageUploadService>(
      () => _i88.ImageUploadService(gh<_i60.UploadManager>()));
  gh.factory<_i89.InActiveCaptainsStateManager>(
      () => _i89.InActiveCaptainsStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i90.LoginScreen>(
      () => _i90.LoginScreen(gh<_i39.LoginStateManager>()));
  gh.factory<_i91.MyNotificationsManager>(
      () => _i91.MyNotificationsManager(gh<_i40.MyNotificationsRepository>()));
  gh.factory<_i92.MyNotificationsService>(
      () => _i92.MyNotificationsService(gh<_i91.MyNotificationsManager>()));
  gh.factory<_i93.MyNotificationsStateManager>(
      () => _i93.MyNotificationsStateManager(
            gh<_i92.MyNotificationsService>(),
            gh<_i26.AuthService>(),
          ));
  gh.factory<_i94.NewOrderLinkStateManager>(
      () => _i94.NewOrderLinkStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i95.NewOrderStateManager>(
      () => _i95.NewOrderStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i96.NewTestOrderStateManager>(
      () => _i96.NewTestOrderStateManager(gh<_i78.DevService>()));
  gh.factory<_i97.NoticeManager>(
      () => _i97.NoticeManager(gh<_i41.NoticeRepository>()));
  gh.factory<_i98.NoticeService>(
      () => _i98.NoticeService(gh<_i97.NoticeManager>()));
  gh.factory<_i99.NoticeStateManager>(
      () => _i99.NoticeStateManager(gh<_i98.NoticeService>()));
  gh.factory<_i100.OrderActionLogsStateManager>(
      () => _i100.OrderActionLogsStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i101.OrderCaptainLogsStateManager>(
      () => _i101.OrderCaptainLogsStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i102.OrderCashCaptainStateManager>(
      () => _i102.OrderCashCaptainStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i103.OrderDistanceConflictStateManager>(
      () => _i103.OrderDistanceConflictStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i104.OrderPendingStateManager>(
      () => _i104.OrderPendingStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i105.OrderWithoutDistanceStateManager>(
      () => _i105.OrderWithoutDistanceStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i106.OrdersCashCaptainScreen>(() =>
      _i106.OrdersCashCaptainScreen(gh<_i102.OrderCashCaptainStateManager>()));
  gh.factory<_i107.OrdersCashStoreStateManager>(
      () => _i107.OrdersCashStoreStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i108.OrdersReceiveCashStateManager>(
      () => _i108.OrdersReceiveCashStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i109.PackageCategoriesStateManager>(
      () => _i109.PackageCategoriesStateManager(gh<_i71.CategoriesService>()));
  gh.factory<_i110.PackagesStateManager>(
      () => _i110.PackagesStateManager(gh<_i71.CategoriesService>()));
  gh.factory<_i111.PaymentsManager>(
      () => _i111.PaymentsManager(gh<_i46.PaymentsRepository>()));
  gh.factory<_i112.PaymentsService>(
      () => _i112.PaymentsService(gh<_i111.PaymentsManager>()));
  gh.factory<_i113.PaymentsToCaptainStateManager>(
      () => _i113.PaymentsToCaptainStateManager(gh<_i112.PaymentsService>()));
  gh.factory<_i114.PlanScreenStateManager>(
      () => _i114.PlanScreenStateManager(gh<_i112.PaymentsService>()));
  gh.factory<_i115.RecycleOrderScreen>(
      () => _i115.RecycleOrderScreen(gh<_i47.RecycleOrderStateManager>()));
  gh.factory<_i116.RegisterScreen>(
      () => _i116.RegisterScreen(gh<_i48.RegisterStateManager>()));
  gh.factory<_i117.SearchForOrderScreen>(
      () => _i117.SearchForOrderScreen(gh<_i49.SearchForOrderStateManager>()));
  gh.factory<_i118.SettingsModule>(() => _i118.SettingsModule(
        gh<_i50.SettingsScreen>(),
        gh<_i32.ChooseLocalScreen>(),
      ));
  gh.factory<_i119.SplashModule>(
      () => _i119.SplashModule(gh<_i51.SplashScreen>()));
  gh.factory<_i120.StatisticManager>(
      () => _i120.StatisticManager(gh<_i52.StatisticsRepository>()));
  gh.factory<_i121.StatisticsService>(
      () => _i121.StatisticsService(gh<_i120.StatisticManager>()));
  gh.factory<_i122.StatisticsStateManager>(
      () => _i122.StatisticsStateManager(gh<_i121.StatisticsService>()));
  gh.factory<_i123.StoreBalanceStateManager>(
      () => _i123.StoreBalanceStateManager(gh<_i112.PaymentsService>()));
  gh.factory<_i124.StoreManager>(
      () => _i124.StoreManager(gh<_i53.StoresRepository>()));
  gh.factory<_i125.StoresService>(
      () => _i125.StoresService(gh<_i124.StoreManager>()));
  gh.factory<_i126.StoresStateManager>(() => _i126.StoresStateManager(
        gh<_i125.StoresService>(),
        gh<_i88.ImageUploadService>(),
      ));
  gh.factory<_i127.SubOrdersScreen>(
      () => _i127.SubOrdersScreen(gh<_i54.SubOrdersStateManager>()));
  gh.factory<_i128.SubscriptionsManager>(
      () => _i128.SubscriptionsManager(gh<_i55.SubscriptionsRepository>()));
  gh.factory<_i129.SubscriptionsService>(
      () => _i129.SubscriptionsService(gh<_i128.SubscriptionsManager>()));
  gh.factory<_i130.SupplierCategoriesManager>(() =>
      _i130.SupplierCategoriesManager(gh<_i56.SupplierCategoriesRepository>()));
  gh.factory<_i131.SupplierCategoriesService>(() =>
      _i131.SupplierCategoriesService(gh<_i130.SupplierCategoriesManager>()));
  gh.factory<_i132.SupplierCategoriesStateManager>(
      () => _i132.SupplierCategoriesStateManager(
            gh<_i131.SupplierCategoriesService>(),
            gh<_i88.ImageUploadService>(),
          ));
  gh.factory<_i133.SupplierService>(
      () => _i133.SupplierService(gh<_i58.SuppliersManager>()));
  gh.factory<_i134.SuppliersStateManager>(
      () => _i134.SuppliersStateManager(gh<_i133.SupplierService>()));
  gh.factory<_i135.TopActiveStateManagment>(
      () => _i135.TopActiveStateManagment(gh<_i125.StoresService>()));
  gh.factory<_i136.TopActiveStoreScreen>(
      () => _i136.TopActiveStoreScreen(gh<_i135.TopActiveStateManagment>()));
  gh.factory<_i137.UpdateOrderScreen>(
      () => _i137.UpdateOrderScreen(gh<_i59.UpdateOrderStateManager>()));
  gh.factory<_i138.UpdatesStateManager>(() => _i138.UpdatesStateManager(
        gh<_i92.MyNotificationsService>(),
        gh<_i26.AuthService>(),
      ));
  gh.factory<_i139.AssignOrderToExternalCompanyStateManager>(() =>
      _i139.AssignOrderToExternalCompanyStateManager(
          gh<_i80.ExternalDeliveryCompaniesService>()));
  gh.factory<_i140.AuthorizationModule>(() => _i140.AuthorizationModule(
        gh<_i90.LoginScreen>(),
        gh<_i116.RegisterScreen>(),
        gh<_i84.ForgotPassScreen>(),
      ));
  gh.factory<_i141.BidOrderDetailsScreen>(
      () => _i141.BidOrderDetailsScreen(gh<_i63.BidOrderStateManager>()));
  gh.factory<_i142.BidOrderModule>(
      () => _i142.BidOrderModule(gh<_i64.BidOrdersScreen>()));
  gh.factory<_i143.BranchesListService>(
      () => _i143.BranchesListService(gh<_i65.BranchesManager>()));
  gh.factory<_i144.BranchesListStateManager>(
      () => _i144.BranchesListStateManager(gh<_i143.BranchesListService>()));
  gh.factory<_i145.CaptainActivityDetailsStateManager>(() =>
      _i145.CaptainActivityDetailsStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i146.CaptainAssignOrderStateManager>(
      () => _i146.CaptainAssignOrderStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i147.CaptainDuesStateManager>(
      () => _i147.CaptainDuesStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i148.CaptainFinanceByHoursStateManager>(() =>
      _i148.CaptainFinanceByHoursStateManager(gh<_i112.PaymentsService>()));
  gh.factory<_i149.CaptainFinanceByOrderCountStateManager>(() =>
      _i149.CaptainFinanceByOrderCountStateManager(
          gh<_i112.PaymentsService>()));
  gh.factory<_i150.CaptainFinanceByOrderStateManager>(() =>
      _i150.CaptainFinanceByOrderStateManager(gh<_i112.PaymentsService>()));
  gh.factory<_i151.CaptainOfferStateManager>(
      () => _i151.CaptainOfferStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i152.CaptainOffersScreen>(
      () => _i152.CaptainOffersScreen(gh<_i151.CaptainOfferStateManager>()));
  gh.factory<_i153.CaptainPaymentStateManager>(
      () => _i153.CaptainPaymentStateManager(gh<_i112.PaymentsService>()));
  gh.factory<_i154.CaptainPreviousPaymentsStateManager>(() =>
      _i154.CaptainPreviousPaymentsStateManager(gh<_i112.PaymentsService>()));
  gh.factory<_i155.CaptainProfileStateManager>(
      () => _i155.CaptainProfileStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i156.CaptainsActivityStateManager>(
      () => _i156.CaptainsActivityStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i157.CaptainsNeedsSupportStateManager>(
      () => _i157.CaptainsNeedsSupportStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i158.CaptainsRatingStateManager>(
      () => _i158.CaptainsRatingStateManager(gh<_i67.CaptainsService>()));
  gh.factory<_i159.CaptinRatingDetailsScreen>(() =>
      _i159.CaptinRatingDetailsScreen(
          gh<_i69.CaptinRatingDetailsStateManager>()));
  gh.factory<_i160.CategoriesScreen>(
      () => _i160.CategoriesScreen(gh<_i109.PackageCategoriesStateManager>()));
  gh.factory<_i161.ChatPage>(() => _i161.ChatPage(
        gh<_i74.ChatStateManager>(),
        gh<_i88.ImageUploadService>(),
        gh<_i26.AuthService>(),
        gh<_i9.ChatHiveHelper>(),
      ));
  gh.factory<_i162.CompanyFinanceStateManager>(
      () => _i162.CompanyFinanceStateManager(gh<_i76.CompanyService>()));
  gh.factory<_i163.CompanyProfileStateManager>(
      () => _i163.CompanyProfileStateManager(gh<_i76.CompanyService>()));
  gh.factory<_i164.DeliveryCompanyAllSettingsStateManager>(() =>
      _i164.DeliveryCompanyAllSettingsStateManager(
          gh<_i80.ExternalDeliveryCompaniesService>()));
  gh.factory<_i165.EditDeliveryCompanySettingScreenStateManager>(() =>
      _i165.EditDeliveryCompanySettingScreenStateManager(
          gh<_i80.ExternalDeliveryCompaniesService>()));
  gh.factory<_i166.EditStoreSettingStateManager>(
      () => _i166.EditStoreSettingStateManager(
            gh<_i125.StoresService>(),
            gh<_i88.ImageUploadService>(),
          ));
  gh.factory<_i167.EditSubscriptionStateManager>(() =>
      _i167.EditSubscriptionStateManager(gh<_i129.SubscriptionsService>()));
  gh.factory<_i168.ExternalDeliveryCompaniesScreen>(() =>
      _i168.ExternalDeliveryCompaniesScreen(
          gh<_i81.ExternalDeliveryCompaniesStateManager>()));
  gh.factory<_i169.ExternalOrderScreen>(
      () => _i169.ExternalOrderScreen(gh<_i82.ExternalOrdersStateManager>()));
  gh.factory<_i170.FilterOrderTopStateManager>(
      () => _i170.FilterOrderTopStateManager(gh<_i125.StoresService>()));
  gh.factory<_i171.HomeScreen>(
      () => _i171.HomeScreen(gh<_i87.HomeStateManager>()));
  gh.factory<_i172.InActiveSupplierStateManager>(
      () => _i172.InActiveSupplierStateManager(gh<_i133.SupplierService>()));
  gh.factory<_i173.InitBranchesStateManager>(
      () => _i173.InitBranchesStateManager(gh<_i143.BranchesListService>()));
  gh.factory<_i174.InitSubscriptionStateManager>(() =>
      _i174.InitSubscriptionStateManager(gh<_i129.SubscriptionsService>()));
  gh.factory<_i175.MainModule>(() => _i175.MainModule(
        gh<_i16.MainScreen>(),
        gh<_i171.HomeScreen>(),
      ));
  gh.factory<_i176.MyNotificationsScreen>(() =>
      _i176.MyNotificationsScreen(gh<_i93.MyNotificationsStateManager>()));
  gh.factory<_i177.NewOrderLinkScreen>(
      () => _i177.NewOrderLinkScreen(gh<_i94.NewOrderLinkStateManager>()));
  gh.factory<_i178.NewOrderScreen>(
      () => _i178.NewOrderScreen(gh<_i95.NewOrderStateManager>()));
  gh.factory<_i179.NewTestOrderScreen>(
      () => _i179.NewTestOrderScreen(gh<_i96.NewTestOrderStateManager>()));
  gh.factory<_i180.NoticeScreen>(
      () => _i180.NoticeScreen(gh<_i99.NoticeStateManager>()));
  gh.factory<_i181.OrderActionLogsScreen>(() =>
      _i181.OrderActionLogsScreen(gh<_i100.OrderActionLogsStateManager>()));
  gh.factory<_i182.OrderCaptainNotArrivedStateManager>(() =>
      _i182.OrderCaptainNotArrivedStateManager(gh<_i125.StoresService>()));
  gh.factory<_i183.OrderDistanceConflictScreen>(() =>
      _i183.OrderDistanceConflictScreen(
          gh<_i103.OrderDistanceConflictStateManager>()));
  gh.factory<_i184.OrderLogsStateManager>(
      () => _i184.OrderLogsStateManager(gh<_i125.StoresService>()));
  gh.factory<_i185.OrderPendingScreen>(
      () => _i185.OrderPendingScreen(gh<_i104.OrderPendingStateManager>()));
  gh.factory<_i186.OrderStatusStateManager>(
      () => _i186.OrderStatusStateManager(gh<_i125.StoresService>()));
  gh.factory<_i187.OrderTimeLineStateManager>(
      () => _i187.OrderTimeLineStateManager(gh<_i125.StoresService>()));
  gh.factory<_i188.OrdersCashStoreScreen>(() =>
      _i188.OrdersCashStoreScreen(gh<_i107.OrdersCashStoreStateManager>()));
  gh.factory<_i189.OrdersReceiveCashScreen>(() =>
      _i189.OrdersReceiveCashScreen(gh<_i108.OrdersReceiveCashStateManager>()));
  gh.factory<_i190.OrdersTopActiveStoreScreen>(() =>
      _i190.OrdersTopActiveStoreScreen(gh<_i170.FilterOrderTopStateManager>()));
  gh.factory<_i191.PackagesScreen>(
      () => _i191.PackagesScreen(gh<_i110.PackagesStateManager>()));
  gh.factory<_i192.PaymentsToCaptainScreen>(() =>
      _i192.PaymentsToCaptainScreen(gh<_i113.PaymentsToCaptainStateManager>()));
  gh.factory<_i193.PlanScreen>(
      () => _i193.PlanScreen(gh<_i114.PlanScreenStateManager>()));
  gh.factory<_i194.ReceiptsStateManager>(
      () => _i194.ReceiptsStateManager(gh<_i129.SubscriptionsService>()));
  gh.factory<_i195.StoreBalanceScreen>(
      () => _i195.StoreBalanceScreen(gh<_i123.StoreBalanceStateManager>()));
  gh.factory<_i196.StoreDuesStateManager>(() => _i196.StoreDuesStateManager(
        gh<_i125.StoresService>(),
        gh<_i112.PaymentsService>(),
      ));
  gh.factory<_i197.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i197.StoreFinancialSubscriptionsDuesDetailsStateManager(
            gh<_i112.PaymentsService>(),
            gh<_i129.SubscriptionsService>(),
          ));
  gh.factory<_i198.StoreProfileStateManager>(
      () => _i198.StoreProfileStateManager(
            gh<_i125.StoresService>(),
            gh<_i88.ImageUploadService>(),
          ));
  gh.factory<_i199.StoreSubscriptionManagementStateManager>(() =>
      _i199.StoreSubscriptionManagementStateManager(
          gh<_i129.SubscriptionsService>()));
  gh.factory<_i200.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i200.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i129.SubscriptionsService>()));
  gh.factory<_i201.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i201.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i197.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i202.StoreSubscriptionsFinanceStateManager>(() =>
      _i202.StoreSubscriptionsFinanceStateManager(
          gh<_i129.SubscriptionsService>()));
  gh.factory<_i203.StoresDuesStateManager>(
      () => _i203.StoresDuesStateManager(gh<_i125.StoresService>()));
  gh.factory<_i204.StoresInActiveStateManager>(
      () => _i204.StoresInActiveStateManager(
            gh<_i125.StoresService>(),
            gh<_i88.ImageUploadService>(),
          ));
  gh.factory<_i205.StoresNeedsSupportStateManager>(
      () => _i205.StoresNeedsSupportStateManager(gh<_i125.StoresService>()));
  gh.factory<_i206.StoresScreen>(
      () => _i206.StoresScreen(gh<_i126.StoresStateManager>()));
  gh.factory<_i207.SubscriptionManagementScreen>(() =>
      _i207.SubscriptionManagementScreen(
          gh<_i199.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i208.SubscriptionToCaptainOfferStateManager>(() =>
      _i208.SubscriptionToCaptainOfferStateManager(
          gh<_i129.SubscriptionsService>()));
  gh.factory<_i209.SupplierAdsStateManager>(
      () => _i209.SupplierAdsStateManager(gh<_i133.SupplierService>()));
  gh.factory<_i210.SupplierCategoriesScreen>(() =>
      _i210.SupplierCategoriesScreen(
          gh<_i132.SupplierCategoriesStateManager>()));
  gh.factory<_i211.SupplierNeedsSupportStateManager>(() =>
      _i211.SupplierNeedsSupportStateManager(gh<_i133.SupplierService>()));
  gh.factory<_i212.SupplierProfileStateManager>(
      () => _i212.SupplierProfileStateManager(gh<_i133.SupplierService>()));
  gh.factory<_i213.SuppliersScreen>(
      () => _i213.SuppliersScreen(gh<_i134.SuppliersStateManager>()));
  gh.factory<_i214.UpdateBranchStateManager>(
      () => _i214.UpdateBranchStateManager(gh<_i143.BranchesListService>()));
  gh.factory<_i215.UpdateScreen>(
      () => _i215.UpdateScreen(gh<_i138.UpdatesStateManager>()));
  gh.factory<_i216.AllAmountCaptainsScreen>(() =>
      _i216.AllAmountCaptainsScreen(gh<_i153.CaptainPaymentStateManager>()));
  gh.factory<_i217.AssignOrderToExternalCompanyScreen>(() =>
      _i217.AssignOrderToExternalCompanyScreen(
          gh<_i139.AssignOrderToExternalCompanyStateManager>()));
  gh.factory<_i218.BranchesListScreen>(
      () => _i218.BranchesListScreen(gh<_i144.BranchesListStateManager>()));
  gh.factory<_i219.CaptainActivityDetailsScreen>(() =>
      _i219.CaptainActivityDetailsScreen(
          gh<_i145.CaptainActivityDetailsStateManager>()));
  gh.factory<_i220.CaptainAssignOrderScreen>(() =>
      _i220.CaptainAssignOrderScreen(
          gh<_i146.CaptainAssignOrderStateManager>()));
  gh.factory<_i221.CaptainDuesScreen>(
      () => _i221.CaptainDuesScreen(gh<_i147.CaptainDuesStateManager>()));
  gh.factory<_i222.CaptainFinanceByCountOrderScreen>(() =>
      _i222.CaptainFinanceByCountOrderScreen(
          gh<_i149.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i223.CaptainFinanceByHoursScreen>(() =>
      _i223.CaptainFinanceByHoursScreen(
          gh<_i148.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i224.CaptainFinanceByOrderScreen>(() =>
      _i224.CaptainFinanceByOrderScreen(
          gh<_i150.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i225.CaptainPaymentScreen>(
      () => _i225.CaptainPaymentScreen(gh<_i153.CaptainPaymentStateManager>()));
  gh.factory<_i226.CaptainPreviousPaymentsScreen>(() =>
      _i226.CaptainPreviousPaymentsScreen(
          gh<_i154.CaptainPreviousPaymentsStateManager>()));
  gh.factory<_i227.CaptainProfileScreen>(
      () => _i227.CaptainProfileScreen(gh<_i155.CaptainProfileStateManager>()));
  gh.factory<_i228.CaptainsActivityScreen>(() =>
      _i228.CaptainsActivityScreen(gh<_i156.CaptainsActivityStateManager>()));
  gh.factory<_i229.CaptainsNeedsSupportScreen>(() =>
      _i229.CaptainsNeedsSupportScreen(
          gh<_i157.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i230.CaptainsRatingScreen>(
      () => _i230.CaptainsRatingScreen(gh<_i158.CaptainsRatingStateManager>()));
  gh.factory<_i231.CategoriesModule>(() => _i231.CategoriesModule(
        gh<_i160.CategoriesScreen>(),
        gh<_i191.PackagesScreen>(),
      ));
  gh.factory<_i232.ChatModule>(() => _i232.ChatModule(gh<_i161.ChatPage>()));
  gh.factory<_i233.CompanyFinanceScreen>(
      () => _i233.CompanyFinanceScreen(gh<_i162.CompanyFinanceStateManager>()));
  gh.factory<_i234.CompanyProfileScreen>(
      () => _i234.CompanyProfileScreen(gh<_i163.CompanyProfileStateManager>()));
  gh.factory<_i235.CreateSubscriptionScreen>(() =>
      _i235.CreateSubscriptionScreen(gh<_i174.InitSubscriptionStateManager>()));
  gh.factory<_i236.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i236.CreateSubscriptionToCaptainOfferScreen(
          gh<_i208.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i237.DeliveryCompanyAllSettingsScreen>(() =>
      _i237.DeliveryCompanyAllSettingsScreen(
          gh<_i164.DeliveryCompanyAllSettingsStateManager>()));
  gh.factory<_i238.DevModule>(
      () => _i238.DevModule(gh<_i179.NewTestOrderScreen>()));
  gh.factory<_i239.EditDeliveryCompanySettingScreen>(() =>
      _i239.EditDeliveryCompanySettingScreen(
          gh<_i165.EditDeliveryCompanySettingScreenStateManager>()));
  gh.factory<_i240.EditStoreSettingScreen>(() =>
      _i240.EditStoreSettingScreen(gh<_i166.EditStoreSettingStateManager>()));
  gh.factory<_i241.EditSubscriptionScreen>(() =>
      _i241.EditSubscriptionScreen(gh<_i167.EditSubscriptionStateManager>()));
  gh.factory<_i242.ExternalDeliveryCompaniesModule>(
      () => _i242.ExternalDeliveryCompaniesModule(
            gh<_i168.ExternalDeliveryCompaniesScreen>(),
            gh<_i237.DeliveryCompanyAllSettingsScreen>(),
            gh<_i239.EditDeliveryCompanySettingScreen>(),
            gh<_i217.AssignOrderToExternalCompanyScreen>(),
            gh<_i169.ExternalOrderScreen>(),
          ));
  gh.factory<_i243.InActiveSupplierScreen>(() =>
      _i243.InActiveSupplierScreen(gh<_i172.InActiveSupplierStateManager>()));
  gh.factory<_i244.InitBranchesScreen>(
      () => _i244.InitBranchesScreen(gh<_i173.InitBranchesStateManager>()));
  gh.factory<_i245.MyNotificationsModule>(() => _i245.MyNotificationsModule(
        gh<_i176.MyNotificationsScreen>(),
        gh<_i215.UpdateScreen>(),
      ));
  gh.factory<_i246.NoticeModule>(
      () => _i246.NoticeModule(gh<_i180.NoticeScreen>()));
  gh.factory<_i247.OrderCaptainNotArrivedScreen>(() =>
      _i247.OrderCaptainNotArrivedScreen(
          gh<_i182.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i248.OrderDetailsScreen>(
      () => _i248.OrderDetailsScreen(gh<_i186.OrderStatusStateManager>()));
  gh.factory<_i249.OrderLogsScreen>(
      () => _i249.OrderLogsScreen(gh<_i184.OrderLogsStateManager>()));
  gh.factory<_i250.OrderTimeLineScreen>(
      () => _i250.OrderTimeLineScreen(gh<_i187.OrderTimeLineStateManager>()));
  gh.factory<_i251.OrdersModule>(() => _i251.OrdersModule(
        gh<_i106.OrdersCashCaptainScreen>(),
        gh<_i188.OrdersCashStoreScreen>(),
        gh<_i137.UpdateOrderScreen>(),
        gh<_i185.OrderPendingScreen>(),
        gh<_i178.NewOrderScreen>(),
        gh<_i181.OrderActionLogsScreen>(),
        gh<_i189.OrdersReceiveCashScreen>(),
        gh<_i127.SubOrdersScreen>(),
        gh<_i177.NewOrderLinkScreen>(),
        gh<_i117.SearchForOrderScreen>(),
        gh<_i115.RecycleOrderScreen>(),
        gh<_i183.OrderDistanceConflictScreen>(),
      ));
  gh.factory<_i252.PaymentsModule>(() => _i252.PaymentsModule(
        gh<_i222.CaptainFinanceByCountOrderScreen>(),
        gh<_i223.CaptainFinanceByHoursScreen>(),
        gh<_i224.CaptainFinanceByOrderScreen>(),
        gh<_i192.PaymentsToCaptainScreen>(),
        gh<_i195.StoreBalanceScreen>(),
        gh<_i225.CaptainPaymentScreen>(),
        gh<_i216.AllAmountCaptainsScreen>(),
        gh<_i226.CaptainPreviousPaymentsScreen>(),
      ));
  gh.factory<_i253.ReceiptsScreen>(
      () => _i253.ReceiptsScreen(gh<_i194.ReceiptsStateManager>()));
  gh.factory<_i254.StoreDuesScreen>(
      () => _i254.StoreDuesScreen(gh<_i196.StoreDuesStateManager>()));
  gh.factory<_i255.StoreInfoScreen>(
      () => _i255.StoreInfoScreen(gh<_i198.StoreProfileStateManager>()));
  gh.factory<_i256.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i256.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i200.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i257.StoreSubscriptionsFinanceScreen>(() =>
      _i257.StoreSubscriptionsFinanceScreen(
          gh<_i202.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i258.StoresDuesScreen>(
      () => _i258.StoresDuesScreen(gh<_i203.StoresDuesStateManager>()));
  gh.factory<_i259.StoresInActiveScreen>(
      () => _i259.StoresInActiveScreen(gh<_i204.StoresInActiveStateManager>()));
  gh.factory<_i260.StoresNeedsSupportScreen>(() =>
      _i260.StoresNeedsSupportScreen(
          gh<_i205.StoresNeedsSupportStateManager>()));
  gh.factory<_i261.SubscriptionsModule>(() => _i261.SubscriptionsModule(
        gh<_i201.StoreSubscriptionsFinanceDetailsScreen>(),
        gh<_i257.StoreSubscriptionsFinanceScreen>(),
        gh<_i207.SubscriptionManagementScreen>(),
        gh<_i256.StoreSubscriptionsExpiredFinanceScreen>(),
        gh<_i235.CreateSubscriptionScreen>(),
        gh<_i236.CreateSubscriptionToCaptainOfferScreen>(),
        gh<_i241.EditSubscriptionScreen>(),
        gh<_i253.ReceiptsScreen>(),
      ));
  gh.factory<_i262.SupplierAdsScreen>(
      () => _i262.SupplierAdsScreen(gh<_i209.SupplierAdsStateManager>()));
  gh.factory<_i263.SupplierCategoriesModule>(() =>
      _i263.SupplierCategoriesModule(gh<_i210.SupplierCategoriesScreen>()));
  gh.factory<_i264.SupplierNeedsSupportScreen>(() =>
      _i264.SupplierNeedsSupportScreen(
          gh<_i211.SupplierNeedsSupportStateManager>()));
  gh.factory<_i265.SupplierProfileScreen>(() =>
      _i265.SupplierProfileScreen(gh<_i212.SupplierProfileStateManager>()));
  gh.factory<_i266.UpdateBranchScreen>(
      () => _i266.UpdateBranchScreen(gh<_i214.UpdateBranchStateManager>()));
  gh.factory<_i267.BranchesModule>(() => _i267.BranchesModule(
        gh<_i218.BranchesListScreen>(),
        gh<_i266.UpdateBranchScreen>(),
        gh<_i244.InitBranchesScreen>(),
      ));
  gh.factory<_i268.CaptainsModule>(() => _i268.CaptainsModule(
        gh<_i152.CaptainOffersScreen>(),
        gh<_i227.CaptainProfileScreen>(),
        gh<_i229.CaptainsNeedsSupportScreen>(),
        gh<_i193.PlanScreen>(),
        gh<_i220.CaptainAssignOrderScreen>(),
        gh<_i230.CaptainsRatingScreen>(),
        gh<_i159.CaptinRatingDetailsScreen>(),
        gh<_i228.CaptainsActivityScreen>(),
        gh<_i219.CaptainActivityDetailsScreen>(),
        gh<_i221.CaptainDuesScreen>(),
      ));
  gh.factory<_i269.CompanyModule>(() => _i269.CompanyModule(
        gh<_i234.CompanyProfileScreen>(),
        gh<_i233.CompanyFinanceScreen>(),
      ));
  gh.factory<_i270.StoresModule>(() => _i270.StoresModule(
        gh<_i206.StoresScreen>(),
        gh<_i255.StoreInfoScreen>(),
        gh<_i259.StoresInActiveScreen>(),
        gh<_i195.StoreBalanceScreen>(),
        gh<_i260.StoresNeedsSupportScreen>(),
        gh<_i248.OrderDetailsScreen>(),
        gh<_i249.OrderLogsScreen>(),
        gh<_i247.OrderCaptainNotArrivedScreen>(),
        gh<_i250.OrderTimeLineScreen>(),
        gh<_i136.TopActiveStoreScreen>(),
        gh<_i190.OrdersTopActiveStoreScreen>(),
        gh<_i258.StoresDuesScreen>(),
        gh<_i254.StoreDuesScreen>(),
        gh<_i240.EditStoreSettingScreen>(),
      ));
  gh.factory<_i271.SupplierModule>(() => _i271.SupplierModule(
        gh<_i243.InActiveSupplierScreen>(),
        gh<_i213.SuppliersScreen>(),
        gh<_i265.SupplierProfileScreen>(),
        gh<_i264.SupplierNeedsSupportScreen>(),
        gh<_i262.SupplierAdsScreen>(),
      ));
  gh.factory<_i272.MyApp>(() => _i272.MyApp(
        gh<_i24.AppThemeDataService>(),
        gh<_i14.LocalizationService>(),
        gh<_i83.FireNotificationService>(),
        gh<_i12.LocalNotificationService>(),
        gh<_i119.SplashModule>(),
        gh<_i140.AuthorizationModule>(),
        gh<_i232.ChatModule>(),
        gh<_i118.SettingsModule>(),
        gh<_i175.MainModule>(),
        gh<_i270.StoresModule>(),
        gh<_i231.CategoriesModule>(),
        gh<_i269.CompanyModule>(),
        gh<_i267.BranchesModule>(),
        gh<_i246.NoticeModule>(),
        gh<_i268.CaptainsModule>(),
        gh<_i252.PaymentsModule>(),
        gh<_i263.SupplierCategoriesModule>(),
        gh<_i271.SupplierModule>(),
        gh<_i8.CarsModule>(),
        gh<_i142.BidOrderModule>(),
        gh<_i251.OrdersModule>(),
        gh<_i261.SubscriptionsModule>(),
        gh<_i245.MyNotificationsModule>(),
        gh<_i20.StatisticsModule>(),
        gh<_i238.DevModule>(),
        gh<_i242.ExternalDeliveryCompaniesModule>(),
      ));
  return getIt;
}

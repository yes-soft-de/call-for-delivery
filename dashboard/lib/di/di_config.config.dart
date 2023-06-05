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

import '../hive/util/argument_hive_helper.dart' as _i3;
import '../main.dart' as _i278;
import '../module_auth/authoriazation_module.dart' as _i142;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i24;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i21;
import '../module_auth/service/auth_service/auth_service.dart' as _i25;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i36;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i39;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i48;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i85;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i90;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i118;
import '../module_bid_order/bid_order_module.dart' as _i144;
import '../module_bid_order/manager/bid_order_manager.dart' as _i60;
import '../module_bid_order/repository/bid_order_repository.dart' as _i26;
import '../module_bid_order/service/bid_order_service.dart' as _i61;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i62;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i63;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i143;
import '../module_branches/branches_module.dart' as _i272;
import '../module_branches/manager/branches_manager.dart' as _i64;
import '../module_branches/repository/branches_repository.dart' as _i27;
import '../module_branches/service/branches_list_service.dart' as _i145;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i146;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i178;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i220;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i223;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i248;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i271;
import '../module_captain/captains_module.dart' as _i273;
import '../module_captain/hive/captain_hive_helper.dart' as _i5;
import '../module_captain/manager/captains_manager.dart' as _i65;
import '../module_captain/repository/captains_repository.dart' as _i28;
import '../module_captain/service/captains_service.dart' as _i66;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i141;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i148;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i159;
import '../module_captain/state_manager/captain_finance_daily_state_manager.dart'
    as _i153;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i154;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i155;
import '../module_captain/state_manager/captain_list.dart' as _i67;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i160;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i156;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i149;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i158;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i161;
import '../module_captain/state_manager/captin_rating_details_state_manager.dart'
    as _i68;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i89;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i116;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i147;
import '../module_captain/ui/screen/captain_activity_details_screen.dart'
    as _i224;
import '../module_captain/ui/screen/captain_activity_model.dart' as _i233;
import '../module_captain/ui/screen/captain_finance_daily_screen.dart' as _i229;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i230;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i231;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i234;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i232;
import '../module_captain/ui/screen/captain_rating_screen.dart' as _i235;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i225;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i162;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i157;
import '../module_captain/ui/screen/captin_rating_details_state.dart' as _i163;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i199;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i176;
import '../module_categories/categories_module.dart' as _i237;
import '../module_categories/manager/categories_manager.dart' as _i72;
import '../module_categories/repository/categories_repository.dart' as _i30;
import '../module_categories/service/store_categories_service.dart' as _i73;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i111;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i112;
import '../module_categories/ui/screen/categories_screen.dart' as _i165;
import '../module_categories/ui/screen/packages_screen.dart' as _i197;
import '../module_chat/chat_module.dart' as _i238;
import '../module_chat/manager/chat/chat_manager.dart' as _i74;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i31;
import '../module_chat/service/chat/char_service.dart' as _i75;
import '../module_chat/state_manager/chat_state_manager.dart' as _i76;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i166;
import '../module_company/company_module.dart' as _i274;
import '../module_company/manager/company_manager.dart' as _i77;
import '../module_company/repository/company_repository.dart' as _i32;
import '../module_company/service/company_service.dart' as _i78;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i167;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i168;
import '../module_company/ui/screen/company_finance_screen.dart' as _i239;
import '../module_company/ui/screen/company_profile_screen.dart' as _i240;
import '../module_deep_links/repository/deep_link_repository.dart' as _i33;
import '../module_delivary_car/cars_module.dart' as _i236;
import '../module_delivary_car/manager/cars_manager.dart' as _i69;
import '../module_delivary_car/repository/cars_repository.dart' as _i29;
import '../module_delivary_car/service/cars_service.dart' as _i70;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i71;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i164;
import '../module_dev/dev_module.dart' as _i244;
import '../module_dev/hive/order_hive_helper.dart' as _i15;
import '../module_dev/manager/dev_manager.dart' as _i79;
import '../module_dev/repository/dev_repository.dart' as _i34;
import '../module_dev/service/orders/dev.service.dart' as _i80;
import '../module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i96;
import '../module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i183;
import '../module_external_delivery_companies/external_delivery_companies_module.dart'
    as _i246;
import '../module_external_delivery_companies/manager/external_delivery_companies_manager.dart'
    as _i81;
import '../module_external_delivery_companies/repository/external_delivery_companies_repository.dart'
    as _i35;
import '../module_external_delivery_companies/service/external_delivery_companies_service.dart'
    as _i82;
import '../module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart'
    as _i171;
import '../module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart'
    as _i83;
import '../module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart'
    as _i243;
import '../module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart'
    as _i173;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i11;
import '../module_main/main_module.dart' as _i275;
import '../module_main/manager/home_manager.dart' as _i86;
import '../module_main/repository/home_repository.dart' as _i37;
import '../module_main/sceen/home_screen.dart' as _i175;
import '../module_main/sceen/main_screen.dart' as _i249;
import '../module_main/service/home_service.dart' as _i87;
import '../module_main/state_manager/home_state_manager.dart' as _i88;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i91;
import '../module_my_notifications/my_notifications_module.dart' as _i250;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i40;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i92;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i93;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i140;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i180;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i221;
import '../module_network/http_client/http_client.dart' as _i19;
import '../module_notice/manager/notice_manager.dart' as _i97;
import '../module_notice/notice_module.dart' as _i251;
import '../module_notice/repository/notice_repository.dart' as _i41;
import '../module_notice/service/notice_service.dart' as _i98;
import '../module_notice/state_manager/notice_state_manager.dart' as _i99;
import '../module_notice/ui/screen/notice_screen.dart' as _i184;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import '../module_notifications/repository/notification_repo.dart' as _i42;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i84;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import '../module_orders/hive/order_hive_helper.dart' as _i14;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i44;
import '../module_orders/orders_module.dart' as _i256;
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
    as _i108;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i103;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i104;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i105;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i109;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i106;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i47;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i49;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i54;
import '../module_orders/ui/screens/new_order/new_order_link.dart' as _i181;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i182;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i139;
import '../module_orders/ui/screens/order_actions_log_screen.dart' as _i185;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i107;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i194;
import '../module_orders/ui/screens/order_conflict_distance_screen.dart'
    as _i188;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i189;
import '../module_orders/ui/screens/order_pending_screen.dart' as _i191;
import '../module_orders/ui/screens/orders_captain_screen.dart' as _i186;
import '../module_orders/ui/screens/orders_receive_cash_screen.dart' as _i195;
import '../module_orders/ui/screens/orders_without_distance_screen.dart'
    as _i110;
import '../module_orders/ui/screens/recycle_order/recycle_order_screen.dart'
    as _i117;
import '../module_orders/ui/screens/search_for_order_screen.dart' as _i119;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i129;
import '../module_payments/manager/payments_manager.dart' as _i113;
import '../module_payments/payments_module.dart' as _i257;
import '../module_payments/repository/payments_repository.dart' as _i46;
import '../module_payments/service/payments_service.dart' as _i114;
import '../module_payments/state_manager/captain_daily_finance_state_manager.dart'
    as _i169;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i150;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i151;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i152;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i115;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i125;
import '../module_payments/ui/screen/all_amount_captains_screen.dart' as _i222;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i227;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i226;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i228;
import '../module_payments/ui/screen/daily_payments_screen.dart' as _i170;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i198;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i201;
import '../module_settings/settings_module.dart' as _i120;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i22;
import '../module_settings/ui/settings_page/settings_page.dart' as _i50;
import '../module_splash/splash_module.dart' as _i121;
import '../module_splash/ui/screen/splash_screen.dart' as _i51;
import '../module_statistics/manager/statistic_manager.dart' as _i122;
import '../module_statistics/repository/statistics_repository.dart' as _i52;
import '../module_statistics/service/statistics_service.dart' as _i123;
import '../module_statistics/state_manager/statistics_state_manager.dart'
    as _i124;
import '../module_statistics/ui/screen/statistics_screen.dart' as _i200;
import '../module_statistics/ui/statistics_module.dart' as _i258;
import '../module_stores/hive/store_hive_helper.dart' as _i16;
import '../module_stores/manager/stores_manager.dart' as _i126;
import '../module_stores/repository/stores_repository.dart' as _i53;
import '../module_stores/service/store_service.dart' as _i127;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i174;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i187;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i190;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i192;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i193;
import '../module_stores/state_manager/store_dues_state_manager.dart' as _i202;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i204;
import '../module_stores/state_manager/stores_dues_state_manager.dart' as _i209;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i210;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i211;
import '../module_stores/state_manager/stores_state_manager.dart' as _i128;
import '../module_stores/state_manager/top_active_store.dart' as _i137;
import '../module_stores/stores_module.dart' as _i276;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i252;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i253;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i254;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i255;
import '../module_stores/ui/screen/order/order_top_active_store.dart' as _i196;
import '../module_stores/ui/screen/store_info_screen.dart' as _i260;
import '../module_stores/ui/screen/stores_dues/store_dues_screen.dart' as _i259;
import '../module_stores/ui/screen/stores_dues/stores_dues_screen.dart'
    as _i263;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i264;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i265;
import '../module_stores/ui/screen/stores_screen.dart' as _i212;
import '../module_stores/ui/screen/top_active_store_screen.dart' as _i138;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i130;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i55;
import '../module_subscriptions/service/subscriptions_service.dart' as _i131;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i172;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i179;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i203;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i205;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i206;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i208;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i214;
import '../module_subscriptions/subscriptions_module.dart' as _i266;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i245;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i241;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i207;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i261;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i262;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i242;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i213;
import '../module_supplier/manager/supplier_manager.dart' as _i58;
import '../module_supplier/repository/supplier_repository.dart' as _i57;
import '../module_supplier/service/supplier_service.dart' as _i135;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i177;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i215;
import '../module_supplier/state_manager/supplier_list.dart' as _i136;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i217;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i218;
import '../module_supplier/supplier_module.dart' as _i277;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i247;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i267;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i219;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i269;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i270;
import '../module_supplier_categories/categories_supplier_module.dart' as _i268;
import '../module_supplier_categories/manager/categories_manager.dart' as _i132;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i56;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i133;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i134;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i216;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i17;
import '../module_theme/service/theme_service/theme_service.dart' as _i20;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i23;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i18;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i38;
import '../utils/global/global_state_manager.dart' as _i8;
import '../utils/helpers/firestore_helper.dart' as _i7;
import '../utils/logger/logger.dart' as _i12;

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
  gh.factory<_i3.ArgumentHiveHelper>(() => _i3.ArgumentHiveHelper());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.CaptainsHiveHelper>(() => _i5.CaptainsHiveHelper());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
  gh.factory<_i7.FireStoreHelper>(() => _i7.FireStoreHelper());
  gh.singleton<_i8.GlobalStateManager>(_i8.GlobalStateManager());
  gh.factory<_i9.LocalNotificationService>(
      () => _i9.LocalNotificationService());
  gh.factory<_i10.LocalizationPreferencesHelper>(
      () => _i10.LocalizationPreferencesHelper());
  gh.factory<_i11.LocalizationService>(
      () => _i11.LocalizationService(gh<_i10.LocalizationPreferencesHelper>()));
  gh.factory<_i12.Logger>(() => _i12.Logger());
  gh.factory<_i13.NotificationsPrefHelper>(
      () => _i13.NotificationsPrefHelper());
  gh.factory<_i14.OrderHiveHelper>(() => _i14.OrderHiveHelper());
  gh.factory<_i15.OrderHiveHelper>(() => _i15.OrderHiveHelper());
  gh.factory<_i16.StoresHiveHelper>(() => _i16.StoresHiveHelper());
  gh.factory<_i17.ThemePreferencesHelper>(() => _i17.ThemePreferencesHelper());
  gh.factory<_i18.UploadRepository>(() => _i18.UploadRepository());
  gh.factory<_i19.ApiClient>(() => _i19.ApiClient(gh<_i12.Logger>()));
  gh.factory<_i20.AppThemeDataService>(
      () => _i20.AppThemeDataService(gh<_i17.ThemePreferencesHelper>()));
  gh.factory<_i21.AuthRepository>(
      () => _i21.AuthRepository(gh<_i19.ApiClient>()));
  gh.factory<_i22.ChooseLocalScreen>(
      () => _i22.ChooseLocalScreen(gh<_i11.LocalizationService>()));
  gh.factory<_i23.UploadManager>(
      () => _i23.UploadManager(gh<_i18.UploadRepository>()));
  gh.factory<_i24.AuthManager>(
      () => _i24.AuthManager(gh<_i21.AuthRepository>()));
  gh.factory<_i25.AuthService>(() => _i25.AuthService(
        gh<_i4.AuthPrefsHelper>(),
        gh<_i24.AuthManager>(),
      ));
  gh.factory<_i26.BidOrderRepository>(() => _i26.BidOrderRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i27.BranchesRepository>(() => _i27.BranchesRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i28.CaptainsRepository>(() => _i28.CaptainsRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i29.CarsRepository>(() => _i29.CarsRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i30.CategoriesRepository>(() => _i30.CategoriesRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i31.ChatRepository>(() => _i31.ChatRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i32.CompanyRepository>(() => _i32.CompanyRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i33.DeepLinkRepository>(() => _i33.DeepLinkRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i34.DevRepository>(() => _i34.DevRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i35.ExternalDeliveryCompaniesRepository>(
      () => _i35.ExternalDeliveryCompaniesRepository(
            gh<_i19.ApiClient>(),
            gh<_i25.AuthService>(),
          ));
  gh.factory<_i36.ForgotPassStateManager>(
      () => _i36.ForgotPassStateManager(gh<_i25.AuthService>()));
  gh.factory<_i37.HomeRepository>(() => _i37.HomeRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i38.ImageUploadService>(
      () => _i38.ImageUploadService(gh<_i23.UploadManager>()));
  gh.factory<_i39.LoginStateManager>(
      () => _i39.LoginStateManager(gh<_i25.AuthService>()));
  gh.factory<_i40.MyNotificationsRepository>(
      () => _i40.MyNotificationsRepository(
            gh<_i19.ApiClient>(),
            gh<_i25.AuthService>(),
          ));
  gh.factory<_i41.NoticeRepository>(() => _i41.NoticeRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i42.NotificationRepo>(() => _i42.NotificationRepo(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i43.OrderRepository>(() => _i43.OrderRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i44.OrdersManager>(
      () => _i44.OrdersManager(gh<_i43.OrderRepository>()));
  gh.factory<_i45.OrdersService>(
      () => _i45.OrdersService(gh<_i44.OrdersManager>()));
  gh.factory<_i46.PaymentsRepository>(() => _i46.PaymentsRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i47.RecycleOrderStateManager>(
      () => _i47.RecycleOrderStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i48.RegisterStateManager>(
      () => _i48.RegisterStateManager(gh<_i25.AuthService>()));
  gh.factory<_i49.SearchForOrderStateManager>(
      () => _i49.SearchForOrderStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i50.SettingsScreen>(() => _i50.SettingsScreen(
        gh<_i25.AuthService>(),
        gh<_i11.LocalizationService>(),
        gh<_i20.AppThemeDataService>(),
      ));
  gh.factory<_i51.SplashScreen>(
      () => _i51.SplashScreen(gh<_i25.AuthService>()));
  gh.factory<_i52.StatisticsRepository>(() => _i52.StatisticsRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i53.StoresRepository>(() => _i53.StoresRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i54.SubOrdersStateManager>(
      () => _i54.SubOrdersStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i55.SubscriptionsRepository>(() => _i55.SubscriptionsRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i56.SupplierCategoriesRepository>(
      () => _i56.SupplierCategoriesRepository(
            gh<_i19.ApiClient>(),
            gh<_i25.AuthService>(),
          ));
  gh.factory<_i57.SupplierRepository>(() => _i57.SupplierRepository(
        gh<_i19.ApiClient>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i58.SuppliersManager>(
      () => _i58.SuppliersManager(gh<_i57.SupplierRepository>()));
  gh.factory<_i59.UpdateOrderStateManager>(
      () => _i59.UpdateOrderStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i60.BidOrderManager>(
      () => _i60.BidOrderManager(gh<_i26.BidOrderRepository>()));
  gh.factory<_i61.BidOrderService>(
      () => _i61.BidOrderService(gh<_i60.BidOrderManager>()));
  gh.factory<_i62.BidOrderStateManager>(
      () => _i62.BidOrderStateManager(gh<_i61.BidOrderService>()));
  gh.factory<_i63.BidOrdersScreen>(
      () => _i63.BidOrdersScreen(gh<_i62.BidOrderStateManager>()));
  gh.factory<_i64.BranchesManager>(
      () => _i64.BranchesManager(gh<_i27.BranchesRepository>()));
  gh.factory<_i65.CaptainsManager>(
      () => _i65.CaptainsManager(gh<_i28.CaptainsRepository>()));
  gh.factory<_i66.CaptainsService>(
      () => _i66.CaptainsService(gh<_i65.CaptainsManager>()));
  gh.factory<_i67.CaptainsStateManager>(
      () => _i67.CaptainsStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i68.CaptinRatingDetailsStateManager>(
      () => _i68.CaptinRatingDetailsStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i69.CarsManager>(
      () => _i69.CarsManager(gh<_i29.CarsRepository>()));
  gh.factory<_i70.CarsService>(() => _i70.CarsService(gh<_i69.CarsManager>()));
  gh.factory<_i71.CarsStateManager>(
      () => _i71.CarsStateManager(gh<_i70.CarsService>()));
  gh.factory<_i72.CategoriesManager>(
      () => _i72.CategoriesManager(gh<_i30.CategoriesRepository>()));
  gh.factory<_i73.CategoriesService>(
      () => _i73.CategoriesService(gh<_i72.CategoriesManager>()));
  gh.factory<_i74.ChatManager>(
      () => _i74.ChatManager(gh<_i31.ChatRepository>()));
  gh.factory<_i75.ChatService>(() => _i75.ChatService(gh<_i74.ChatManager>()));
  gh.factory<_i76.ChatStateManager>(
      () => _i76.ChatStateManager(gh<_i75.ChatService>()));
  gh.factory<_i77.CompanyManager>(
      () => _i77.CompanyManager(gh<_i32.CompanyRepository>()));
  gh.factory<_i78.CompanyService>(
      () => _i78.CompanyService(gh<_i77.CompanyManager>()));
  gh.factory<_i79.DevManager>(() => _i79.DevManager(gh<_i34.DevRepository>()));
  gh.factory<_i80.DevService>(() => _i80.DevService(gh<_i79.DevManager>()));
  gh.factory<_i81.ExternalDeliveryCompaniesManager>(() =>
      _i81.ExternalDeliveryCompaniesManager(
          gh<_i35.ExternalDeliveryCompaniesRepository>()));
  gh.factory<_i82.ExternalDeliveryCompaniesService>(() =>
      _i82.ExternalDeliveryCompaniesService(
          gh<_i81.ExternalDeliveryCompaniesManager>()));
  gh.factory<_i83.ExternalDeliveryCompaniesStateManager>(() =>
      _i83.ExternalDeliveryCompaniesStateManager(
          gh<_i82.ExternalDeliveryCompaniesService>()));
  gh.factory<_i84.FireNotificationService>(
      () => _i84.FireNotificationService(gh<_i42.NotificationRepo>()));
  gh.factory<_i85.ForgotPassScreen>(
      () => _i85.ForgotPassScreen(gh<_i36.ForgotPassStateManager>()));
  gh.factory<_i86.HomeManager>(
      () => _i86.HomeManager(gh<_i37.HomeRepository>()));
  gh.factory<_i87.HomeService>(() => _i87.HomeService(gh<_i86.HomeManager>()));
  gh.factory<_i88.HomeStateManager>(
      () => _i88.HomeStateManager(gh<_i87.HomeService>()));
  gh.factory<_i89.InActiveCaptainsStateManager>(
      () => _i89.InActiveCaptainsStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i90.LoginScreen>(
      () => _i90.LoginScreen(gh<_i39.LoginStateManager>()));
  gh.factory<_i91.MyNotificationsManager>(
      () => _i91.MyNotificationsManager(gh<_i40.MyNotificationsRepository>()));
  gh.factory<_i92.MyNotificationsService>(
      () => _i92.MyNotificationsService(gh<_i91.MyNotificationsManager>()));
  gh.factory<_i93.MyNotificationsStateManager>(
      () => _i93.MyNotificationsStateManager(
            gh<_i92.MyNotificationsService>(),
            gh<_i25.AuthService>(),
          ));
  gh.factory<_i94.NewOrderLinkStateManager>(
      () => _i94.NewOrderLinkStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i95.NewOrderStateManager>(
      () => _i95.NewOrderStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i96.NewTestOrderStateManager>(
      () => _i96.NewTestOrderStateManager(gh<_i80.DevService>()));
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
  gh.factory<_i104.OrderLogsStateManager>(
      () => _i104.OrderLogsStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i105.OrderPendingStateManager>(
      () => _i105.OrderPendingStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i106.OrderWithoutDistanceStateManager>(
      () => _i106.OrderWithoutDistanceStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i107.OrdersCashCaptainScreen>(() =>
      _i107.OrdersCashCaptainScreen(gh<_i102.OrderCashCaptainStateManager>()));
  gh.factory<_i108.OrdersCashStoreStateManager>(
      () => _i108.OrdersCashStoreStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i109.OrdersReceiveCashStateManager>(
      () => _i109.OrdersReceiveCashStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i110.OrdersWithoutDistanceScreen>(() =>
      _i110.OrdersWithoutDistanceScreen(
          gh<_i106.OrderWithoutDistanceStateManager>()));
  gh.factory<_i111.PackageCategoriesStateManager>(
      () => _i111.PackageCategoriesStateManager(gh<_i73.CategoriesService>()));
  gh.factory<_i112.PackagesStateManager>(
      () => _i112.PackagesStateManager(gh<_i73.CategoriesService>()));
  gh.factory<_i113.PaymentsManager>(
      () => _i113.PaymentsManager(gh<_i46.PaymentsRepository>()));
  gh.factory<_i114.PaymentsService>(
      () => _i114.PaymentsService(gh<_i113.PaymentsManager>()));
  gh.factory<_i115.PaymentsToCaptainStateManager>(
      () => _i115.PaymentsToCaptainStateManager(gh<_i114.PaymentsService>()));
  gh.factory<_i116.PlanScreenStateManager>(
      () => _i116.PlanScreenStateManager(gh<_i114.PaymentsService>()));
  gh.factory<_i117.RecycleOrderScreen>(
      () => _i117.RecycleOrderScreen(gh<_i47.RecycleOrderStateManager>()));
  gh.factory<_i118.RegisterScreen>(
      () => _i118.RegisterScreen(gh<_i48.RegisterStateManager>()));
  gh.factory<_i119.SearchForOrderScreen>(
      () => _i119.SearchForOrderScreen(gh<_i49.SearchForOrderStateManager>()));
  gh.factory<_i120.SettingsModule>(() => _i120.SettingsModule(
        gh<_i50.SettingsScreen>(),
        gh<_i22.ChooseLocalScreen>(),
      ));
  gh.factory<_i121.SplashModule>(
      () => _i121.SplashModule(gh<_i51.SplashScreen>()));
  gh.factory<_i122.StatisticManager>(
      () => _i122.StatisticManager(gh<_i52.StatisticsRepository>()));
  gh.factory<_i123.StatisticsService>(
      () => _i123.StatisticsService(gh<_i122.StatisticManager>()));
  gh.factory<_i124.StatisticsStateManager>(
      () => _i124.StatisticsStateManager(gh<_i123.StatisticsService>()));
  gh.factory<_i125.StoreBalanceStateManager>(
      () => _i125.StoreBalanceStateManager(gh<_i114.PaymentsService>()));
  gh.factory<_i126.StoreManager>(
      () => _i126.StoreManager(gh<_i53.StoresRepository>()));
  gh.factory<_i127.StoresService>(
      () => _i127.StoresService(gh<_i126.StoreManager>()));
  gh.factory<_i128.StoresStateManager>(() => _i128.StoresStateManager(
        gh<_i127.StoresService>(),
        gh<_i38.ImageUploadService>(),
      ));
  gh.factory<_i129.SubOrdersScreen>(
      () => _i129.SubOrdersScreen(gh<_i54.SubOrdersStateManager>()));
  gh.factory<_i130.SubscriptionsManager>(
      () => _i130.SubscriptionsManager(gh<_i55.SubscriptionsRepository>()));
  gh.factory<_i131.SubscriptionsService>(
      () => _i131.SubscriptionsService(gh<_i130.SubscriptionsManager>()));
  gh.factory<_i132.SupplierCategoriesManager>(() =>
      _i132.SupplierCategoriesManager(gh<_i56.SupplierCategoriesRepository>()));
  gh.factory<_i133.SupplierCategoriesService>(() =>
      _i133.SupplierCategoriesService(gh<_i132.SupplierCategoriesManager>()));
  gh.factory<_i134.SupplierCategoriesStateManager>(
      () => _i134.SupplierCategoriesStateManager(
            gh<_i133.SupplierCategoriesService>(),
            gh<_i38.ImageUploadService>(),
          ));
  gh.factory<_i135.SupplierService>(
      () => _i135.SupplierService(gh<_i58.SuppliersManager>()));
  gh.factory<_i136.SuppliersStateManager>(
      () => _i136.SuppliersStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i137.TopActiveStateManagment>(
      () => _i137.TopActiveStateManagment(gh<_i127.StoresService>()));
  gh.factory<_i138.TopActiveStoreScreen>(
      () => _i138.TopActiveStoreScreen(gh<_i137.TopActiveStateManagment>()));
  gh.factory<_i139.UpdateOrderScreen>(
      () => _i139.UpdateOrderScreen(gh<_i59.UpdateOrderStateManager>()));
  gh.factory<_i140.UpdatesStateManager>(() => _i140.UpdatesStateManager(
        gh<_i92.MyNotificationsService>(),
        gh<_i25.AuthService>(),
      ));
  gh.factory<_i141.AccountBalanceStateManager>(
      () => _i141.AccountBalanceStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i142.AuthorizationModule>(() => _i142.AuthorizationModule(
        gh<_i90.LoginScreen>(),
        gh<_i118.RegisterScreen>(),
        gh<_i85.ForgotPassScreen>(),
      ));
  gh.factory<_i143.BidOrderDetailsScreen>(
      () => _i143.BidOrderDetailsScreen(gh<_i62.BidOrderStateManager>()));
  gh.factory<_i144.BidOrderModule>(
      () => _i144.BidOrderModule(gh<_i63.BidOrdersScreen>()));
  gh.factory<_i145.BranchesListService>(
      () => _i145.BranchesListService(gh<_i64.BranchesManager>()));
  gh.factory<_i146.BranchesListStateManager>(
      () => _i146.BranchesListStateManager(gh<_i145.BranchesListService>()));
  gh.factory<_i147.CaptainAccountBalanceScreen>(() =>
      _i147.CaptainAccountBalanceScreen(
          gh<_i141.AccountBalanceStateManager>()));
  gh.factory<_i148.CaptainActivityDetailsStateManager>(() =>
      _i148.CaptainActivityDetailsStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i149.CaptainAssignOrderStateManager>(
      () => _i149.CaptainAssignOrderStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i150.CaptainFinanceByHoursStateManager>(() =>
      _i150.CaptainFinanceByHoursStateManager(gh<_i114.PaymentsService>()));
  gh.factory<_i151.CaptainFinanceByOrderCountStateManager>(() =>
      _i151.CaptainFinanceByOrderCountStateManager(
          gh<_i114.PaymentsService>()));
  gh.factory<_i152.CaptainFinanceByOrderStateManager>(() =>
      _i152.CaptainFinanceByOrderStateManager(gh<_i114.PaymentsService>()));
  gh.factory<_i153.CaptainFinanceDailyStateManager>(
      () => _i153.CaptainFinanceDailyStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i154.CaptainFinancialDuesDetailsStateManager>(
      () => _i154.CaptainFinancialDuesDetailsStateManager(
            gh<_i114.PaymentsService>(),
            gh<_i66.CaptainsService>(),
          ));
  gh.factory<_i155.CaptainFinancialDuesStateManager>(
      () => _i155.CaptainFinancialDuesStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i156.CaptainOfferStateManager>(
      () => _i156.CaptainOfferStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i157.CaptainOffersScreen>(
      () => _i157.CaptainOffersScreen(gh<_i156.CaptainOfferStateManager>()));
  gh.factory<_i158.CaptainProfileStateManager>(
      () => _i158.CaptainProfileStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i159.CaptainsActivityStateManager>(
      () => _i159.CaptainsActivityStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i160.CaptainsNeedsSupportStateManager>(
      () => _i160.CaptainsNeedsSupportStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i161.CaptainsRatingStateManager>(
      () => _i161.CaptainsRatingStateManager(gh<_i66.CaptainsService>()));
  gh.factory<_i162.CaptainsScreen>(
      () => _i162.CaptainsScreen(gh<_i67.CaptainsStateManager>()));
  gh.factory<_i163.CaptinRatingDetailsScreen>(() =>
      _i163.CaptinRatingDetailsScreen(
          gh<_i68.CaptinRatingDetailsStateManager>()));
  gh.factory<_i164.CarsScreen>(
      () => _i164.CarsScreen(gh<_i71.CarsStateManager>()));
  gh.factory<_i165.CategoriesScreen>(
      () => _i165.CategoriesScreen(gh<_i111.PackageCategoriesStateManager>()));
  gh.factory<_i166.ChatPage>(() => _i166.ChatPage(
        gh<_i76.ChatStateManager>(),
        gh<_i38.ImageUploadService>(),
        gh<_i25.AuthService>(),
        gh<_i6.ChatHiveHelper>(),
      ));
  gh.factory<_i167.CompanyFinanceStateManager>(
      () => _i167.CompanyFinanceStateManager(gh<_i78.CompanyService>()));
  gh.factory<_i168.CompanyProfileStateManager>(
      () => _i168.CompanyProfileStateManager(gh<_i78.CompanyService>()));
  gh.factory<_i169.DailyBalanceStateManager>(
      () => _i169.DailyBalanceStateManager(gh<_i114.PaymentsService>()));
  gh.factory<_i170.DailyPaymentsScreen>(
      () => _i170.DailyPaymentsScreen(gh<_i169.DailyBalanceStateManager>()));
  gh.factory<_i171.DeliveryCompanyAllSettingsStateManager>(() =>
      _i171.DeliveryCompanyAllSettingsStateManager(
          gh<_i82.ExternalDeliveryCompaniesService>()));
  gh.factory<_i172.EditSubscriptionStateManager>(() =>
      _i172.EditSubscriptionStateManager(gh<_i131.SubscriptionsService>()));
  gh.factory<_i173.ExternalDeliveryCompaniesScreen>(() =>
      _i173.ExternalDeliveryCompaniesScreen(
          gh<_i83.ExternalDeliveryCompaniesStateManager>()));
  gh.factory<_i174.FilterOrderTopStateManager>(
      () => _i174.FilterOrderTopStateManager(gh<_i127.StoresService>()));
  gh.factory<_i175.HomeScreen>(
      () => _i175.HomeScreen(gh<_i88.HomeStateManager>()));
  gh.factory<_i176.InActiveCaptainsScreen>(() =>
      _i176.InActiveCaptainsScreen(gh<_i89.InActiveCaptainsStateManager>()));
  gh.factory<_i177.InActiveSupplierStateManager>(
      () => _i177.InActiveSupplierStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i178.InitBranchesStateManager>(
      () => _i178.InitBranchesStateManager(gh<_i145.BranchesListService>()));
  gh.factory<_i179.InitSubscriptionStateManager>(() =>
      _i179.InitSubscriptionStateManager(gh<_i131.SubscriptionsService>()));
  gh.factory<_i180.MyNotificationsScreen>(() =>
      _i180.MyNotificationsScreen(gh<_i93.MyNotificationsStateManager>()));
  gh.factory<_i181.NewOrderLinkScreen>(
      () => _i181.NewOrderLinkScreen(gh<_i94.NewOrderLinkStateManager>()));
  gh.factory<_i182.NewOrderScreen>(
      () => _i182.NewOrderScreen(gh<_i95.NewOrderStateManager>()));
  gh.factory<_i183.NewTestOrderScreen>(
      () => _i183.NewTestOrderScreen(gh<_i96.NewTestOrderStateManager>()));
  gh.factory<_i184.NoticeScreen>(
      () => _i184.NoticeScreen(gh<_i99.NoticeStateManager>()));
  gh.factory<_i185.OrderActionLogsScreen>(() =>
      _i185.OrderActionLogsScreen(gh<_i100.OrderActionLogsStateManager>()));
  gh.factory<_i186.OrderCaptainLogsScreen>(() =>
      _i186.OrderCaptainLogsScreen(gh<_i101.OrderCaptainLogsStateManager>()));
  gh.factory<_i187.OrderCaptainNotArrivedStateManager>(() =>
      _i187.OrderCaptainNotArrivedStateManager(gh<_i127.StoresService>()));
  gh.factory<_i188.OrderDistanceConflictScreen>(() =>
      _i188.OrderDistanceConflictScreen(
          gh<_i103.OrderDistanceConflictStateManager>()));
  gh.factory<_i189.OrderLogsScreen>(
      () => _i189.OrderLogsScreen(gh<_i104.OrderLogsStateManager>()));
  gh.factory<_i190.OrderLogsStateManager>(
      () => _i190.OrderLogsStateManager(gh<_i127.StoresService>()));
  gh.factory<_i191.OrderPendingScreen>(
      () => _i191.OrderPendingScreen(gh<_i105.OrderPendingStateManager>()));
  gh.factory<_i192.OrderStatusStateManager>(
      () => _i192.OrderStatusStateManager(gh<_i127.StoresService>()));
  gh.factory<_i193.OrderTimeLineStateManager>(
      () => _i193.OrderTimeLineStateManager(gh<_i127.StoresService>()));
  gh.factory<_i194.OrdersCashStoreScreen>(() =>
      _i194.OrdersCashStoreScreen(gh<_i108.OrdersCashStoreStateManager>()));
  gh.factory<_i195.OrdersReceiveCashScreen>(() =>
      _i195.OrdersReceiveCashScreen(gh<_i109.OrdersReceiveCashStateManager>()));
  gh.factory<_i196.OrdersTopActiveStoreScreen>(() =>
      _i196.OrdersTopActiveStoreScreen(gh<_i174.FilterOrderTopStateManager>()));
  gh.factory<_i197.PackagesScreen>(
      () => _i197.PackagesScreen(gh<_i112.PackagesStateManager>()));
  gh.factory<_i198.PaymentsToCaptainScreen>(() =>
      _i198.PaymentsToCaptainScreen(gh<_i115.PaymentsToCaptainStateManager>()));
  gh.factory<_i199.PlanScreen>(
      () => _i199.PlanScreen(gh<_i116.PlanScreenStateManager>()));
  gh.factory<_i200.StatisticsScreen>(
      () => _i200.StatisticsScreen(gh<_i124.StatisticsStateManager>()));
  gh.factory<_i201.StoreBalanceScreen>(
      () => _i201.StoreBalanceScreen(gh<_i125.StoreBalanceStateManager>()));
  gh.factory<_i202.StoreDuesStateManager>(() => _i202.StoreDuesStateManager(
        gh<_i127.StoresService>(),
        gh<_i114.PaymentsService>(),
      ));
  gh.factory<_i203.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i203.StoreFinancialSubscriptionsDuesDetailsStateManager(
            gh<_i114.PaymentsService>(),
            gh<_i131.SubscriptionsService>(),
          ));
  gh.factory<_i204.StoreProfileStateManager>(
      () => _i204.StoreProfileStateManager(
            gh<_i127.StoresService>(),
            gh<_i38.ImageUploadService>(),
          ));
  gh.factory<_i205.StoreSubscriptionManagementStateManager>(() =>
      _i205.StoreSubscriptionManagementStateManager(
          gh<_i131.SubscriptionsService>()));
  gh.factory<_i206.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i206.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i131.SubscriptionsService>()));
  gh.factory<_i207.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i207.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i203.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i208.StoreSubscriptionsFinanceStateManager>(() =>
      _i208.StoreSubscriptionsFinanceStateManager(
          gh<_i131.SubscriptionsService>()));
  gh.factory<_i209.StoresDuesStateManager>(
      () => _i209.StoresDuesStateManager(gh<_i127.StoresService>()));
  gh.factory<_i210.StoresInActiveStateManager>(
      () => _i210.StoresInActiveStateManager(
            gh<_i127.StoresService>(),
            gh<_i38.ImageUploadService>(),
          ));
  gh.factory<_i211.StoresNeedsSupportStateManager>(
      () => _i211.StoresNeedsSupportStateManager(gh<_i127.StoresService>()));
  gh.factory<_i212.StoresScreen>(
      () => _i212.StoresScreen(gh<_i128.StoresStateManager>()));
  gh.factory<_i213.SubscriptionManagementScreen>(() =>
      _i213.SubscriptionManagementScreen(
          gh<_i205.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i214.SubscriptionToCaptainOfferStateManager>(() =>
      _i214.SubscriptionToCaptainOfferStateManager(
          gh<_i131.SubscriptionsService>()));
  gh.factory<_i215.SupplierAdsStateManager>(
      () => _i215.SupplierAdsStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i216.SupplierCategoriesScreen>(() =>
      _i216.SupplierCategoriesScreen(
          gh<_i134.SupplierCategoriesStateManager>()));
  gh.factory<_i217.SupplierNeedsSupportStateManager>(() =>
      _i217.SupplierNeedsSupportStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i218.SupplierProfileStateManager>(
      () => _i218.SupplierProfileStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i219.SuppliersScreen>(
      () => _i219.SuppliersScreen(gh<_i136.SuppliersStateManager>()));
  gh.factory<_i220.UpdateBranchStateManager>(
      () => _i220.UpdateBranchStateManager(gh<_i145.BranchesListService>()));
  gh.factory<_i221.UpdateScreen>(
      () => _i221.UpdateScreen(gh<_i140.UpdatesStateManager>()));
  gh.factory<_i222.AllAmountCaptainsScreen>(() =>
      _i222.AllAmountCaptainsScreen(gh<_i169.DailyBalanceStateManager>()));
  gh.factory<_i223.BranchesListScreen>(
      () => _i223.BranchesListScreen(gh<_i146.BranchesListStateManager>()));
  gh.factory<_i224.CaptainActivityDetailsScreen>(() =>
      _i224.CaptainActivityDetailsScreen(
          gh<_i148.CaptainActivityDetailsStateManager>()));
  gh.factory<_i225.CaptainAssignOrderScreen>(() =>
      _i225.CaptainAssignOrderScreen(
          gh<_i149.CaptainAssignOrderStateManager>()));
  gh.factory<_i226.CaptainFinanceByCountOrderScreen>(() =>
      _i226.CaptainFinanceByCountOrderScreen(
          gh<_i151.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i227.CaptainFinanceByHoursScreen>(() =>
      _i227.CaptainFinanceByHoursScreen(
          gh<_i150.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i228.CaptainFinanceByOrderScreen>(() =>
      _i228.CaptainFinanceByOrderScreen(
          gh<_i152.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i229.CaptainFinanceDailyScreen>(() =>
      _i229.CaptainFinanceDailyScreen(
          gh<_i153.CaptainFinanceDailyStateManager>()));
  gh.factory<_i230.CaptainFinancialDuesDetailsScreen>(() =>
      _i230.CaptainFinancialDuesDetailsScreen(
          gh<_i154.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i231.CaptainFinancialDuesScreen>(() =>
      _i231.CaptainFinancialDuesScreen(
          gh<_i155.CaptainFinancialDuesStateManager>()));
  gh.factory<_i232.CaptainProfileScreen>(
      () => _i232.CaptainProfileScreen(gh<_i158.CaptainProfileStateManager>()));
  gh.factory<_i233.CaptainsActivityScreen>(() =>
      _i233.CaptainsActivityScreen(gh<_i159.CaptainsActivityStateManager>()));
  gh.factory<_i234.CaptainsNeedsSupportScreen>(() =>
      _i234.CaptainsNeedsSupportScreen(
          gh<_i160.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i235.CaptainsRatingScreen>(
      () => _i235.CaptainsRatingScreen(gh<_i161.CaptainsRatingStateManager>()));
  gh.factory<_i236.CarsModule>(() => _i236.CarsModule(gh<_i164.CarsScreen>()));
  gh.factory<_i237.CategoriesModule>(() => _i237.CategoriesModule(
        gh<_i165.CategoriesScreen>(),
        gh<_i197.PackagesScreen>(),
      ));
  gh.factory<_i238.ChatModule>(() => _i238.ChatModule(gh<_i166.ChatPage>()));
  gh.factory<_i239.CompanyFinanceScreen>(
      () => _i239.CompanyFinanceScreen(gh<_i167.CompanyFinanceStateManager>()));
  gh.factory<_i240.CompanyProfileScreen>(
      () => _i240.CompanyProfileScreen(gh<_i168.CompanyProfileStateManager>()));
  gh.factory<_i241.CreateSubscriptionScreen>(() =>
      _i241.CreateSubscriptionScreen(gh<_i179.InitSubscriptionStateManager>()));
  gh.factory<_i242.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i242.CreateSubscriptionToCaptainOfferScreen(
          gh<_i214.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i243.DeliveryCompanyAllSettingsScreen>(() =>
      _i243.DeliveryCompanyAllSettingsScreen(
          gh<_i171.DeliveryCompanyAllSettingsStateManager>()));
  gh.factory<_i244.DevModule>(
      () => _i244.DevModule(gh<_i183.NewTestOrderScreen>()));
  gh.factory<_i245.EditSubscriptionScreen>(() =>
      _i245.EditSubscriptionScreen(gh<_i172.EditSubscriptionStateManager>()));
  gh.factory<_i246.ExternalDeliveryCompaniesModule>(
      () => _i246.ExternalDeliveryCompaniesModule(
            gh<_i173.ExternalDeliveryCompaniesScreen>(),
            gh<_i243.DeliveryCompanyAllSettingsScreen>(),
          ));
  gh.factory<_i247.InActiveSupplierScreen>(() =>
      _i247.InActiveSupplierScreen(gh<_i177.InActiveSupplierStateManager>()));
  gh.factory<_i248.InitBranchesScreen>(
      () => _i248.InitBranchesScreen(gh<_i178.InitBranchesStateManager>()));
  gh.factory<_i249.MainScreen>(
      () => _i249.MainScreen(gh<_i200.StatisticsScreen>()));
  gh.factory<_i250.MyNotificationsModule>(() => _i250.MyNotificationsModule(
        gh<_i180.MyNotificationsScreen>(),
        gh<_i221.UpdateScreen>(),
      ));
  gh.factory<_i251.NoticeModule>(
      () => _i251.NoticeModule(gh<_i184.NoticeScreen>()));
  gh.factory<_i252.OrderCaptainNotArrivedScreen>(() =>
      _i252.OrderCaptainNotArrivedScreen(
          gh<_i187.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i253.OrderDetailsScreen>(
      () => _i253.OrderDetailsScreen(gh<_i192.OrderStatusStateManager>()));
  gh.factory<_i254.OrderLogsScreen>(
      () => _i254.OrderLogsScreen(gh<_i190.OrderLogsStateManager>()));
  gh.factory<_i255.OrderTimeLineScreen>(
      () => _i255.OrderTimeLineScreen(gh<_i193.OrderTimeLineStateManager>()));
  gh.factory<_i256.OrdersModule>(() => _i256.OrdersModule(
        gh<_i189.OrderLogsScreen>(),
        gh<_i107.OrdersCashCaptainScreen>(),
        gh<_i194.OrdersCashStoreScreen>(),
        gh<_i139.UpdateOrderScreen>(),
        gh<_i191.OrderPendingScreen>(),
        gh<_i182.NewOrderScreen>(),
        gh<_i186.OrderCaptainLogsScreen>(),
        gh<_i185.OrderActionLogsScreen>(),
        gh<_i110.OrdersWithoutDistanceScreen>(),
        gh<_i195.OrdersReceiveCashScreen>(),
        gh<_i129.SubOrdersScreen>(),
        gh<_i181.NewOrderLinkScreen>(),
        gh<_i119.SearchForOrderScreen>(),
        gh<_i117.RecycleOrderScreen>(),
        gh<_i188.OrderDistanceConflictScreen>(),
      ));
  gh.factory<_i257.PaymentsModule>(() => _i257.PaymentsModule(
        gh<_i226.CaptainFinanceByCountOrderScreen>(),
        gh<_i227.CaptainFinanceByHoursScreen>(),
        gh<_i228.CaptainFinanceByOrderScreen>(),
        gh<_i198.PaymentsToCaptainScreen>(),
        gh<_i201.StoreBalanceScreen>(),
        gh<_i170.DailyPaymentsScreen>(),
        gh<_i222.AllAmountCaptainsScreen>(),
      ));
  gh.factory<_i258.StatisticsModule>(
      () => _i258.StatisticsModule(gh<_i200.StatisticsScreen>()));
  gh.factory<_i259.StoreDuesScreen>(
      () => _i259.StoreDuesScreen(gh<_i202.StoreDuesStateManager>()));
  gh.factory<_i260.StoreInfoScreen>(
      () => _i260.StoreInfoScreen(gh<_i204.StoreProfileStateManager>()));
  gh.factory<_i261.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i261.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i206.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i262.StoreSubscriptionsFinanceScreen>(() =>
      _i262.StoreSubscriptionsFinanceScreen(
          gh<_i208.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i263.StoresDuesScreen>(
      () => _i263.StoresDuesScreen(gh<_i209.StoresDuesStateManager>()));
  gh.factory<_i264.StoresInActiveScreen>(
      () => _i264.StoresInActiveScreen(gh<_i210.StoresInActiveStateManager>()));
  gh.factory<_i265.StoresNeedsSupportScreen>(() =>
      _i265.StoresNeedsSupportScreen(
          gh<_i211.StoresNeedsSupportStateManager>()));
  gh.factory<_i266.SubscriptionsModule>(() => _i266.SubscriptionsModule(
        gh<_i207.StoreSubscriptionsFinanceDetailsScreen>(),
        gh<_i262.StoreSubscriptionsFinanceScreen>(),
        gh<_i213.SubscriptionManagementScreen>(),
        gh<_i261.StoreSubscriptionsExpiredFinanceScreen>(),
        gh<_i241.CreateSubscriptionScreen>(),
        gh<_i242.CreateSubscriptionToCaptainOfferScreen>(),
        gh<_i245.EditSubscriptionScreen>(),
      ));
  gh.factory<_i267.SupplierAdsScreen>(
      () => _i267.SupplierAdsScreen(gh<_i215.SupplierAdsStateManager>()));
  gh.factory<_i268.SupplierCategoriesModule>(() =>
      _i268.SupplierCategoriesModule(gh<_i216.SupplierCategoriesScreen>()));
  gh.factory<_i269.SupplierNeedsSupportScreen>(() =>
      _i269.SupplierNeedsSupportScreen(
          gh<_i217.SupplierNeedsSupportStateManager>()));
  gh.factory<_i270.SupplierProfileScreen>(() =>
      _i270.SupplierProfileScreen(gh<_i218.SupplierProfileStateManager>()));
  gh.factory<_i271.UpdateBranchScreen>(
      () => _i271.UpdateBranchScreen(gh<_i220.UpdateBranchStateManager>()));
  gh.factory<_i272.BranchesModule>(() => _i272.BranchesModule(
        gh<_i223.BranchesListScreen>(),
        gh<_i271.UpdateBranchScreen>(),
        gh<_i248.InitBranchesScreen>(),
      ));
  gh.factory<_i273.CaptainsModule>(() => _i273.CaptainsModule(
        gh<_i157.CaptainOffersScreen>(),
        gh<_i176.InActiveCaptainsScreen>(),
        gh<_i162.CaptainsScreen>(),
        gh<_i232.CaptainProfileScreen>(),
        gh<_i234.CaptainsNeedsSupportScreen>(),
        gh<_i147.CaptainAccountBalanceScreen>(),
        gh<_i230.CaptainFinancialDuesDetailsScreen>(),
        gh<_i231.CaptainFinancialDuesScreen>(),
        gh<_i199.PlanScreen>(),
        gh<_i225.CaptainAssignOrderScreen>(),
        gh<_i235.CaptainsRatingScreen>(),
        gh<_i163.CaptinRatingDetailsScreen>(),
        gh<_i233.CaptainsActivityScreen>(),
        gh<_i224.CaptainActivityDetailsScreen>(),
        gh<_i229.CaptainFinanceDailyScreen>(),
      ));
  gh.factory<_i274.CompanyModule>(() => _i274.CompanyModule(
        gh<_i240.CompanyProfileScreen>(),
        gh<_i239.CompanyFinanceScreen>(),
      ));
  gh.factory<_i275.MainModule>(() => _i275.MainModule(
        gh<_i249.MainScreen>(),
        gh<_i175.HomeScreen>(),
      ));
  gh.factory<_i276.StoresModule>(() => _i276.StoresModule(
        gh<_i212.StoresScreen>(),
        gh<_i260.StoreInfoScreen>(),
        gh<_i264.StoresInActiveScreen>(),
        gh<_i201.StoreBalanceScreen>(),
        gh<_i265.StoresNeedsSupportScreen>(),
        gh<_i253.OrderDetailsScreen>(),
        gh<_i254.OrderLogsScreen>(),
        gh<_i252.OrderCaptainNotArrivedScreen>(),
        gh<_i255.OrderTimeLineScreen>(),
        gh<_i138.TopActiveStoreScreen>(),
        gh<_i196.OrdersTopActiveStoreScreen>(),
        gh<_i263.StoresDuesScreen>(),
        gh<_i259.StoreDuesScreen>(),
      ));
  gh.factory<_i277.SupplierModule>(() => _i277.SupplierModule(
        gh<_i247.InActiveSupplierScreen>(),
        gh<_i219.SuppliersScreen>(),
        gh<_i270.SupplierProfileScreen>(),
        gh<_i269.SupplierNeedsSupportScreen>(),
        gh<_i267.SupplierAdsScreen>(),
      ));
  gh.factory<_i278.MyApp>(() => _i278.MyApp(
        gh<_i20.AppThemeDataService>(),
        gh<_i11.LocalizationService>(),
        gh<_i84.FireNotificationService>(),
        gh<_i9.LocalNotificationService>(),
        gh<_i121.SplashModule>(),
        gh<_i142.AuthorizationModule>(),
        gh<_i238.ChatModule>(),
        gh<_i120.SettingsModule>(),
        gh<_i275.MainModule>(),
        gh<_i276.StoresModule>(),
        gh<_i237.CategoriesModule>(),
        gh<_i274.CompanyModule>(),
        gh<_i272.BranchesModule>(),
        gh<_i251.NoticeModule>(),
        gh<_i273.CaptainsModule>(),
        gh<_i257.PaymentsModule>(),
        gh<_i268.SupplierCategoriesModule>(),
        gh<_i277.SupplierModule>(),
        gh<_i236.CarsModule>(),
        gh<_i144.BidOrderModule>(),
        gh<_i256.OrdersModule>(),
        gh<_i266.SubscriptionsModule>(),
        gh<_i250.MyNotificationsModule>(),
        gh<_i258.StatisticsModule>(),
        gh<_i244.DevModule>(),
        gh<_i246.ExternalDeliveryCompaniesModule>(),
      ));
  return getIt;
}

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
import '../main.dart' as _i219;
import '../module_auth/authoriazation_module.dart' as _i145;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i37;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i6;
import '../module_auth/service/auth_service/auth_service.dart' as _i38;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i49;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i51;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i60;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i95;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i101;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i125;
import '../module_bid_order/bid_order_module.dart' as _i147;
import '../module_bid_order/manager/bid_order_manager.dart' as _i73;
import '../module_bid_order/repository/bid_order_repository.dart' as _i39;
import '../module_bid_order/service/bid_order_service.dart' as _i74;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i75;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i76;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i146;
import '../module_branches/branches_module.dart' as _i7;
import '../module_branches/manager/branches_manager.dart' as _i77;
import '../module_branches/repository/branches_repository.dart' as _i40;
import '../module_branches/service/branches_list_service.dart' as _i148;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i149;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i174;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i201;
import '../module_captain/captains_module.dart' as _i11;
import '../module_captain/hive/captain_hive_helper.dart' as _i10;
import '../module_captain/manager/captains_manager.dart' as _i78;
import '../module_captain/repository/captains_repository.dart' as _i41;
import '../module_captain/service/captains_service.dart' as _i79;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i150;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i161;
import '../module_captain/state_manager/captain_dues_state_manager.dart'
    as _i152;
import '../module_captain/state_manager/captain_list.dart' as _i80;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i162;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i156;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i151;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i159;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i163;
import '../module_captain/state_manager/caption_rating_details_state_manager.dart'
    as _i160;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i100;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i124;
import '../module_captain/ui/screen/captain_dues_screen.dart' as _i9;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i12;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i8;
import '../module_categories/categories_module.dart' as _i14;
import '../module_categories/manager/categories_manager.dart' as _i81;
import '../module_categories/repository/categories_repository.dart' as _i42;
import '../module_categories/service/store_categories_service.dart' as _i82;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i119;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i120;
import '../module_chat/chat_module.dart' as _i203;
import '../module_chat/manager/chat/chat_manager.dart' as _i83;
import '../module_chat/presistance/chat_hive_helper.dart' as _i15;
import '../module_chat/repository/chat/chat_repository.dart' as _i43;
import '../module_chat/service/chat/char_service.dart' as _i84;
import '../module_chat/state_manager/chat_state_manager.dart' as _i85;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i164;
import '../module_company/company_module.dart' as _i16;
import '../module_company/manager/company_manager.dart' as _i86;
import '../module_company/repository/company_repository.dart' as _i45;
import '../module_company/service/company_service.dart' as _i87;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i165;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i166;
import '../module_deep_links/repository/deep_link_repository.dart' as _i46;
import '../module_delivary_car/cars_module.dart' as _i13;
import '../module_dev/dev_module.dart' as _i206;
import '../module_dev/hive/order_hive_helper.dart' as _i28;
import '../module_dev/manager/dev_manager.dart' as _i88;
import '../module_dev/repository/dev_repository.dart' as _i47;
import '../module_dev/service/orders/dev.service.dart' as _i89;
import '../module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i107;
import '../module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i178;
import '../module_external_delivery_companies/external_delivery_companies_module.dart'
    as _i17;
import '../module_external_delivery_companies/manager/external_delivery_companies_manager.dart'
    as _i90;
import '../module_external_delivery_companies/repository/external_delivery_companies_repository.dart'
    as _i48;
import '../module_external_delivery_companies/service/external_delivery_companies_service.dart'
    as _i91;
import '../module_external_delivery_companies/state_manager/assign_order_to_external_company_state_manager.dart'
    as _i144;
import '../module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart'
    as _i167;
import '../module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart'
    as _i168;
import '../module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart'
    as _i92;
import '../module_external_delivery_companies/state_manager/external_orders_state_manager.dart'
    as _i93;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i21;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i22;
import '../module_main/main_module.dart' as _i176;
import '../module_main/manager/home_manager.dart' as _i96;
import '../module_main/repository/home_repository.dart' as _i50;
import '../module_main/sceen/home_screen.dart' as _i172;
import '../module_main/sceen/main_screen.dart' as _i24;
import '../module_main/service/home_service.dart' as _i97;
import '../module_main/state_manager/home_state_manager.dart' as _i98;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i102;
import '../module_my_notifications/my_notifications_module.dart' as _i209;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i52;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i103;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i104;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i143;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i177;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i202;
import '../module_network/http_client/http_client.dart' as _i3;
import '../module_notice/manager/notice_manager.dart' as _i108;
import '../module_notice/notice_module.dart' as _i25;
import '../module_notice/repository/notice_repository.dart' as _i53;
import '../module_notice/service/notice_service.dart' as _i109;
import '../module_notice/state_manager/notice_state_manager.dart' as _i110;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i26;
import '../module_notifications/repository/notification_repo.dart' as _i54;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i94;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i20;
import '../module_orders/hive/order_hive_helper.dart' as _i27;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i56;
import '../module_orders/orders_module.dart' as _i29;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i55;
import '../module_orders/service/orders/orders.service.dart' as _i57;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i106;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i105;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i71;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i111;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i112;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i113;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i117;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i114;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i115;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i118;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i116;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i59;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i61;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i66;
import '../module_payments/manager/payments_manager.dart' as _i121;
import '../module_payments/payments_module.dart' as _i30;
import '../module_payments/repository/payments_repository.dart' as _i58;
import '../module_payments/service/payments_service.dart' as _i122;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i153;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i154;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i155;
import '../module_payments/state_manager/captain_payment_state_manager.dart'
    as _i157;
import '../module_payments/state_manager/captain_previous_payments.dart'
    as _i158;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i123;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i131;
import '../module_settings/settings_module.dart' as _i126;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i44;
import '../module_settings/ui/settings_page/settings_page.dart' as _i62;
import '../module_splash/splash_module.dart' as _i127;
import '../module_splash/ui/screen/splash_screen.dart' as _i63;
import '../module_statistics/manager/statistic_manager.dart' as _i128;
import '../module_statistics/repository/statistics_repository.dart' as _i64;
import '../module_statistics/service/statistics_service.dart' as _i129;
import '../module_statistics/state_manager/statistics_state_manager.dart'
    as _i130;
import '../module_statistics/ui/statistics_module.dart' as _i31;
import '../module_stores/hive/store_hive_helper.dart' as _i32;
import '../module_stores/manager/stores_manager.dart' as _i132;
import '../module_stores/repository/stores_repository.dart' as _i65;
import '../module_stores/service/store_service.dart' as _i133;
import '../module_stores/state_manager/edit_store_setting_state_manager.dart'
    as _i169;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i171;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i179;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i180;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i181;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i182;
import '../module_stores/state_manager/store_dues_state_manager.dart' as _i184;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i186;
import '../module_stores/state_manager/stores_dues_state_manager.dart' as _i191;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i192;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i193;
import '../module_stores/state_manager/stores_state_manager.dart' as _i134;
import '../module_stores/state_manager/top_active_store.dart' as _i142;
import '../module_stores/stores_module.dart' as _i33;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i135;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i67;
import '../module_subscriptions/service/subscriptions_service.dart' as _i136;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i170;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i175;
import '../module_subscriptions/state_manager/receipts_state_manager.dart'
    as _i183;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i185;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i187;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i188;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i190;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i195;
import '../module_subscriptions/subscriptions_module.dart' as _i213;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i207;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i204;
import '../module_subscriptions/ui/screen/receipts_screen.dart' as _i210;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i189;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i211;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i212;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i205;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i194;
import '../module_supplier/manager/supplier_manager.dart' as _i70;
import '../module_supplier/repository/supplier_repository.dart' as _i69;
import '../module_supplier/service/supplier_service.dart' as _i140;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i173;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i196;
import '../module_supplier/state_manager/supplier_list.dart' as _i141;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i198;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i199;
import '../module_supplier/supplier_module.dart' as _i218;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i208;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i214;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i200;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i216;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i217;
import '../module_supplier_categories/categories_supplier_module.dart' as _i215;
import '../module_supplier_categories/manager/categories_manager.dart' as _i137;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i68;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i138;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i139;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i197;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i34;
import '../module_theme/service/theme_service/theme_service.dart' as _i36;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i72;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i35;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i99;
import '../utils/global/global_state_manager.dart' as _i19;
import '../utils/helpers/firestore_helper.dart' as _i18;
import '../utils/logger/logger.dart' as _i23;

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
  gh.factory<_i7.BranchesModule>(() => _i7.BranchesModule());
  gh.factory<_i8.CaptainAssignOrderScreen>(
      () => _i8.CaptainAssignOrderScreen());
  gh.factory<_i9.CaptainDuesScreen>(() => _i9.CaptainDuesScreen());
  gh.factory<_i10.CaptainsHiveHelper>(() => _i10.CaptainsHiveHelper());
  gh.factory<_i11.CaptainsModule>(() => _i11.CaptainsModule());
  gh.factory<_i12.CaptainsNeedsSupportScreen>(
      () => _i12.CaptainsNeedsSupportScreen());
  gh.factory<_i13.CarsModule>(() => _i13.CarsModule());
  gh.factory<_i14.CategoriesModule>(() => _i14.CategoriesModule());
  gh.factory<_i15.ChatHiveHelper>(() => _i15.ChatHiveHelper());
  gh.factory<_i16.CompanyModule>(() => _i16.CompanyModule());
  gh.factory<_i17.ExternalDeliveryCompaniesModule>(
      () => _i17.ExternalDeliveryCompaniesModule());
  gh.factory<_i18.FireStoreHelper>(() => _i18.FireStoreHelper());
  gh.singleton<_i19.GlobalStateManager>(_i19.GlobalStateManager());
  gh.factory<_i20.LocalNotificationService>(
      () => _i20.LocalNotificationService());
  gh.factory<_i21.LocalizationPreferencesHelper>(
      () => _i21.LocalizationPreferencesHelper());
  gh.factory<_i22.LocalizationService>(
      () => _i22.LocalizationService(gh<_i21.LocalizationPreferencesHelper>()));
  gh.factory<_i23.Logger>(() => _i23.Logger());
  gh.factory<_i24.MainScreen>(() => _i24.MainScreen());
  gh.factory<_i25.NoticeModule>(() => _i25.NoticeModule());
  gh.factory<_i26.NotificationsPrefHelper>(
      () => _i26.NotificationsPrefHelper());
  gh.factory<_i27.OrderHiveHelper>(() => _i27.OrderHiveHelper());
  gh.factory<_i28.OrderHiveHelper>(() => _i28.OrderHiveHelper());
  gh.factory<_i29.OrdersModule>(() => _i29.OrdersModule());
  gh.factory<_i30.PaymentsModule>(() => _i30.PaymentsModule());
  gh.factory<_i31.StatisticsModule>(() => _i31.StatisticsModule());
  gh.factory<_i32.StoresHiveHelper>(() => _i32.StoresHiveHelper());
  gh.factory<_i33.StoresModule>(() => _i33.StoresModule());
  gh.factory<_i34.ThemePreferencesHelper>(() => _i34.ThemePreferencesHelper());
  gh.factory<_i35.UploadRepository>(() => _i35.UploadRepository());
  gh.factory<_i36.AppThemeDataService>(
      () => _i36.AppThemeDataService(gh<_i34.ThemePreferencesHelper>()));
  gh.factory<_i37.AuthManager>(
      () => _i37.AuthManager(gh<_i6.AuthRepository>()));
  gh.factory<_i38.AuthService>(() => _i38.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i37.AuthManager>(),
      ));
  gh.factory<_i39.BidOrderRepository>(() => _i39.BidOrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i40.BranchesRepository>(() => _i40.BranchesRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i41.CaptainsRepository>(() => _i41.CaptainsRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i42.CategoriesRepository>(() => _i42.CategoriesRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i43.ChatRepository>(() => _i43.ChatRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i44.ChooseLocalScreen>(
      () => _i44.ChooseLocalScreen(gh<_i22.LocalizationService>()));
  gh.factory<_i45.CompanyRepository>(() => _i45.CompanyRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i46.DeepLinkRepository>(() => _i46.DeepLinkRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i47.DevRepository>(() => _i47.DevRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i48.ExternalDeliveryCompaniesRepository>(
      () => _i48.ExternalDeliveryCompaniesRepository(
            gh<_i3.ApiClient>(),
            gh<_i38.AuthService>(),
          ));
  gh.factory<_i49.ForgotPassStateManager>(
      () => _i49.ForgotPassStateManager(gh<_i38.AuthService>()));
  gh.factory<_i50.HomeRepository>(() => _i50.HomeRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i51.LoginStateManager>(
      () => _i51.LoginStateManager(gh<_i38.AuthService>()));
  gh.factory<_i52.MyNotificationsRepository>(
      () => _i52.MyNotificationsRepository(
            gh<_i3.ApiClient>(),
            gh<_i38.AuthService>(),
          ));
  gh.factory<_i53.NoticeRepository>(() => _i53.NoticeRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i54.NotificationRepo>(() => _i54.NotificationRepo(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i55.OrderRepository>(() => _i55.OrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i56.OrdersManager>(
      () => _i56.OrdersManager(gh<_i55.OrderRepository>()));
  gh.factory<_i57.OrdersService>(
      () => _i57.OrdersService(gh<_i56.OrdersManager>()));
  gh.factory<_i58.PaymentsRepository>(() => _i58.PaymentsRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i59.RecycleOrderStateManager>(
      () => _i59.RecycleOrderStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i60.RegisterStateManager>(
      () => _i60.RegisterStateManager(gh<_i38.AuthService>()));
  gh.factory<_i61.SearchForOrderStateManager>(
      () => _i61.SearchForOrderStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i62.SettingsScreen>(() => _i62.SettingsScreen(
        gh<_i38.AuthService>(),
        gh<_i22.LocalizationService>(),
        gh<_i36.AppThemeDataService>(),
      ));
  gh.factory<_i63.SplashScreen>(
      () => _i63.SplashScreen(gh<_i38.AuthService>()));
  gh.factory<_i64.StatisticsRepository>(() => _i64.StatisticsRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i65.StoresRepository>(() => _i65.StoresRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i66.SubOrdersStateManager>(
      () => _i66.SubOrdersStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i67.SubscriptionsRepository>(() => _i67.SubscriptionsRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i68.SupplierCategoriesRepository>(
      () => _i68.SupplierCategoriesRepository(
            gh<_i3.ApiClient>(),
            gh<_i38.AuthService>(),
          ));
  gh.factory<_i69.SupplierRepository>(() => _i69.SupplierRepository(
        gh<_i3.ApiClient>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i70.SuppliersManager>(
      () => _i70.SuppliersManager(gh<_i69.SupplierRepository>()));
  gh.factory<_i71.UpdateOrderStateManager>(
      () => _i71.UpdateOrderStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i72.UploadManager>(
      () => _i72.UploadManager(gh<_i35.UploadRepository>()));
  gh.factory<_i73.BidOrderManager>(
      () => _i73.BidOrderManager(gh<_i39.BidOrderRepository>()));
  gh.factory<_i74.BidOrderService>(
      () => _i74.BidOrderService(gh<_i73.BidOrderManager>()));
  gh.factory<_i75.BidOrderStateManager>(
      () => _i75.BidOrderStateManager(gh<_i74.BidOrderService>()));
  gh.factory<_i76.BidOrdersScreen>(
      () => _i76.BidOrdersScreen(gh<_i75.BidOrderStateManager>()));
  gh.factory<_i77.BranchesManager>(
      () => _i77.BranchesManager(gh<_i40.BranchesRepository>()));
  gh.factory<_i78.CaptainsManager>(
      () => _i78.CaptainsManager(gh<_i41.CaptainsRepository>()));
  gh.factory<_i79.CaptainsService>(
      () => _i79.CaptainsService(gh<_i78.CaptainsManager>()));
  gh.factory<_i80.CaptainsStateManager>(
      () => _i80.CaptainsStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i81.CategoriesManager>(
      () => _i81.CategoriesManager(gh<_i42.CategoriesRepository>()));
  gh.factory<_i82.CategoriesService>(
      () => _i82.CategoriesService(gh<_i81.CategoriesManager>()));
  gh.factory<_i83.ChatManager>(
      () => _i83.ChatManager(gh<_i43.ChatRepository>()));
  gh.factory<_i84.ChatService>(() => _i84.ChatService(gh<_i83.ChatManager>()));
  gh.factory<_i85.ChatStateManager>(
      () => _i85.ChatStateManager(gh<_i84.ChatService>()));
  gh.factory<_i86.CompanyManager>(
      () => _i86.CompanyManager(gh<_i45.CompanyRepository>()));
  gh.factory<_i87.CompanyService>(
      () => _i87.CompanyService(gh<_i86.CompanyManager>()));
  gh.factory<_i88.DevManager>(() => _i88.DevManager(gh<_i47.DevRepository>()));
  gh.factory<_i89.DevService>(() => _i89.DevService(gh<_i88.DevManager>()));
  gh.factory<_i90.ExternalDeliveryCompaniesManager>(() =>
      _i90.ExternalDeliveryCompaniesManager(
          gh<_i48.ExternalDeliveryCompaniesRepository>()));
  gh.factory<_i91.ExternalDeliveryCompaniesService>(() =>
      _i91.ExternalDeliveryCompaniesService(
          gh<_i90.ExternalDeliveryCompaniesManager>()));
  gh.factory<_i92.ExternalDeliveryCompaniesStateManager>(() =>
      _i92.ExternalDeliveryCompaniesStateManager(
          gh<_i91.ExternalDeliveryCompaniesService>()));
  gh.factory<_i93.ExternalOrdersStateManager>(() =>
      _i93.ExternalOrdersStateManager(
          gh<_i91.ExternalDeliveryCompaniesService>()));
  gh.factory<_i94.FireNotificationService>(
      () => _i94.FireNotificationService(gh<_i54.NotificationRepo>()));
  gh.factory<_i95.ForgotPassScreen>(
      () => _i95.ForgotPassScreen(gh<_i49.ForgotPassStateManager>()));
  gh.factory<_i96.HomeManager>(
      () => _i96.HomeManager(gh<_i50.HomeRepository>()));
  gh.factory<_i97.HomeService>(() => _i97.HomeService(gh<_i96.HomeManager>()));
  gh.factory<_i98.HomeStateManager>(
      () => _i98.HomeStateManager(gh<_i97.HomeService>()));
  gh.factory<_i99.ImageUploadService>(
      () => _i99.ImageUploadService(gh<_i72.UploadManager>()));
  gh.factory<_i100.InActiveCaptainsStateManager>(
      () => _i100.InActiveCaptainsStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i101.LoginScreen>(
      () => _i101.LoginScreen(gh<_i51.LoginStateManager>()));
  gh.factory<_i102.MyNotificationsManager>(
      () => _i102.MyNotificationsManager(gh<_i52.MyNotificationsRepository>()));
  gh.factory<_i103.MyNotificationsService>(
      () => _i103.MyNotificationsService(gh<_i102.MyNotificationsManager>()));
  gh.factory<_i104.MyNotificationsStateManager>(
      () => _i104.MyNotificationsStateManager(
            gh<_i103.MyNotificationsService>(),
            gh<_i38.AuthService>(),
          ));
  gh.factory<_i105.NewOrderLinkStateManager>(
      () => _i105.NewOrderLinkStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i106.NewOrderStateManager>(
      () => _i106.NewOrderStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i107.NewTestOrderStateManager>(
      () => _i107.NewTestOrderStateManager(gh<_i89.DevService>()));
  gh.factory<_i108.NoticeManager>(
      () => _i108.NoticeManager(gh<_i53.NoticeRepository>()));
  gh.factory<_i109.NoticeService>(
      () => _i109.NoticeService(gh<_i108.NoticeManager>()));
  gh.factory<_i110.NoticeStateManager>(
      () => _i110.NoticeStateManager(gh<_i109.NoticeService>()));
  gh.factory<_i111.OrderActionLogsStateManager>(
      () => _i111.OrderActionLogsStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i112.OrderCaptainLogsStateManager>(
      () => _i112.OrderCaptainLogsStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i113.OrderCashCaptainStateManager>(
      () => _i113.OrderCashCaptainStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i114.OrderDistanceConflictStateManager>(
      () => _i114.OrderDistanceConflictStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i115.OrderPendingStateManager>(
      () => _i115.OrderPendingStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i116.OrderWithoutDistanceStateManager>(
      () => _i116.OrderWithoutDistanceStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i117.OrdersCashStoreStateManager>(
      () => _i117.OrdersCashStoreStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i118.OrdersReceiveCashStateManager>(
      () => _i118.OrdersReceiveCashStateManager(gh<_i57.OrdersService>()));
  gh.factory<_i119.PackageCategoriesStateManager>(
      () => _i119.PackageCategoriesStateManager(gh<_i82.CategoriesService>()));
  gh.factory<_i120.PackagesStateManager>(
      () => _i120.PackagesStateManager(gh<_i82.CategoriesService>()));
  gh.factory<_i121.PaymentsManager>(
      () => _i121.PaymentsManager(gh<_i58.PaymentsRepository>()));
  gh.factory<_i122.PaymentsService>(
      () => _i122.PaymentsService(gh<_i121.PaymentsManager>()));
  gh.factory<_i123.PaymentsToCaptainStateManager>(
      () => _i123.PaymentsToCaptainStateManager(gh<_i122.PaymentsService>()));
  gh.factory<_i124.PlanScreenStateManager>(
      () => _i124.PlanScreenStateManager(gh<_i122.PaymentsService>()));
  gh.factory<_i125.RegisterScreen>(
      () => _i125.RegisterScreen(gh<_i60.RegisterStateManager>()));
  gh.factory<_i126.SettingsModule>(() => _i126.SettingsModule(
        gh<_i62.SettingsScreen>(),
        gh<_i44.ChooseLocalScreen>(),
      ));
  gh.factory<_i127.SplashModule>(
      () => _i127.SplashModule(gh<_i63.SplashScreen>()));
  gh.factory<_i128.StatisticManager>(
      () => _i128.StatisticManager(gh<_i64.StatisticsRepository>()));
  gh.factory<_i129.StatisticsService>(
      () => _i129.StatisticsService(gh<_i128.StatisticManager>()));
  gh.factory<_i130.StatisticsStateManager>(
      () => _i130.StatisticsStateManager(gh<_i129.StatisticsService>()));
  gh.factory<_i131.StoreBalanceStateManager>(
      () => _i131.StoreBalanceStateManager(gh<_i122.PaymentsService>()));
  gh.factory<_i132.StoreManager>(
      () => _i132.StoreManager(gh<_i65.StoresRepository>()));
  gh.factory<_i133.StoresService>(
      () => _i133.StoresService(gh<_i132.StoreManager>()));
  gh.factory<_i134.StoresStateManager>(() => _i134.StoresStateManager(
        gh<_i133.StoresService>(),
        gh<_i99.ImageUploadService>(),
      ));
  gh.factory<_i135.SubscriptionsManager>(
      () => _i135.SubscriptionsManager(gh<_i67.SubscriptionsRepository>()));
  gh.factory<_i136.SubscriptionsService>(
      () => _i136.SubscriptionsService(gh<_i135.SubscriptionsManager>()));
  gh.factory<_i137.SupplierCategoriesManager>(() =>
      _i137.SupplierCategoriesManager(gh<_i68.SupplierCategoriesRepository>()));
  gh.factory<_i138.SupplierCategoriesService>(() =>
      _i138.SupplierCategoriesService(gh<_i137.SupplierCategoriesManager>()));
  gh.factory<_i139.SupplierCategoriesStateManager>(
      () => _i139.SupplierCategoriesStateManager(
            gh<_i138.SupplierCategoriesService>(),
            gh<_i99.ImageUploadService>(),
          ));
  gh.factory<_i140.SupplierService>(
      () => _i140.SupplierService(gh<_i70.SuppliersManager>()));
  gh.factory<_i141.SuppliersStateManager>(
      () => _i141.SuppliersStateManager(gh<_i140.SupplierService>()));
  gh.factory<_i142.TopActiveStateManagement>(
      () => _i142.TopActiveStateManagement(gh<_i133.StoresService>()));
  gh.factory<_i143.UpdatesStateManager>(() => _i143.UpdatesStateManager(
        gh<_i103.MyNotificationsService>(),
        gh<_i38.AuthService>(),
      ));
  gh.factory<_i144.AssignOrderToExternalCompanyStateManager>(() =>
      _i144.AssignOrderToExternalCompanyStateManager(
          gh<_i91.ExternalDeliveryCompaniesService>()));
  gh.factory<_i145.AuthorizationModule>(() => _i145.AuthorizationModule(
        gh<_i101.LoginScreen>(),
        gh<_i125.RegisterScreen>(),
        gh<_i95.ForgotPassScreen>(),
      ));
  gh.factory<_i146.BidOrderDetailsScreen>(
      () => _i146.BidOrderDetailsScreen(gh<_i75.BidOrderStateManager>()));
  gh.factory<_i147.BidOrderModule>(
      () => _i147.BidOrderModule(gh<_i76.BidOrdersScreen>()));
  gh.factory<_i148.BranchesListService>(
      () => _i148.BranchesListService(gh<_i77.BranchesManager>()));
  gh.factory<_i149.BranchesListStateManager>(
      () => _i149.BranchesListStateManager(gh<_i148.BranchesListService>()));
  gh.factory<_i150.CaptainActivityDetailsStateManager>(() =>
      _i150.CaptainActivityDetailsStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i151.CaptainAssignOrderStateManager>(
      () => _i151.CaptainAssignOrderStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i152.CaptainDuesStateManager>(
      () => _i152.CaptainDuesStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i153.CaptainFinanceByHoursStateManager>(() =>
      _i153.CaptainFinanceByHoursStateManager(gh<_i122.PaymentsService>()));
  gh.factory<_i154.CaptainFinanceByOrderCountStateManager>(() =>
      _i154.CaptainFinanceByOrderCountStateManager(
          gh<_i122.PaymentsService>()));
  gh.factory<_i155.CaptainFinanceByOrderStateManager>(() =>
      _i155.CaptainFinanceByOrderStateManager(gh<_i122.PaymentsService>()));
  gh.factory<_i156.CaptainOfferStateManager>(
      () => _i156.CaptainOfferStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i157.CaptainPaymentStateManager>(
      () => _i157.CaptainPaymentStateManager(gh<_i122.PaymentsService>()));
  gh.factory<_i158.CaptainPreviousPaymentsStateManager>(() =>
      _i158.CaptainPreviousPaymentsStateManager(gh<_i122.PaymentsService>()));
  gh.factory<_i159.CaptainProfileStateManager>(
      () => _i159.CaptainProfileStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i160.CaptainRatingDetailsStateManager>(
      () => _i160.CaptainRatingDetailsStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i161.CaptainsActivityStateManager>(
      () => _i161.CaptainsActivityStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i162.CaptainsNeedsSupportStateManager>(
      () => _i162.CaptainsNeedsSupportStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i163.CaptainsRatingStateManager>(
      () => _i163.CaptainsRatingStateManager(gh<_i79.CaptainsService>()));
  gh.factory<_i164.ChatPage>(() => _i164.ChatPage(
        gh<_i85.ChatStateManager>(),
        gh<_i99.ImageUploadService>(),
        gh<_i38.AuthService>(),
        gh<_i15.ChatHiveHelper>(),
      ));
  gh.factory<_i165.CompanyFinanceStateManager>(
      () => _i165.CompanyFinanceStateManager(gh<_i87.CompanyService>()));
  gh.factory<_i166.CompanyProfileStateManager>(
      () => _i166.CompanyProfileStateManager(gh<_i87.CompanyService>()));
  gh.factory<_i167.DeliveryCompanyAllSettingsStateManager>(() =>
      _i167.DeliveryCompanyAllSettingsStateManager(
          gh<_i91.ExternalDeliveryCompaniesService>()));
  gh.factory<_i168.EditDeliveryCompanySettingScreenStateManager>(() =>
      _i168.EditDeliveryCompanySettingScreenStateManager(
          gh<_i91.ExternalDeliveryCompaniesService>()));
  gh.factory<_i169.EditStoreSettingStateManager>(
      () => _i169.EditStoreSettingStateManager(
            gh<_i133.StoresService>(),
            gh<_i99.ImageUploadService>(),
          ));
  gh.factory<_i170.EditSubscriptionStateManager>(() =>
      _i170.EditSubscriptionStateManager(gh<_i136.SubscriptionsService>()));
  gh.factory<_i171.FilterOrderTopStateManager>(
      () => _i171.FilterOrderTopStateManager(gh<_i133.StoresService>()));
  gh.factory<_i172.HomeScreen>(
      () => _i172.HomeScreen(gh<_i98.HomeStateManager>()));
  gh.factory<_i173.InActiveSupplierStateManager>(
      () => _i173.InActiveSupplierStateManager(gh<_i140.SupplierService>()));
  gh.factory<_i174.InitBranchesStateManager>(
      () => _i174.InitBranchesStateManager(gh<_i148.BranchesListService>()));
  gh.factory<_i175.InitSubscriptionStateManager>(() =>
      _i175.InitSubscriptionStateManager(gh<_i136.SubscriptionsService>()));
  gh.factory<_i176.MainModule>(() => _i176.MainModule(
        gh<_i24.MainScreen>(),
        gh<_i172.HomeScreen>(),
      ));
  gh.factory<_i177.MyNotificationsScreen>(() =>
      _i177.MyNotificationsScreen(gh<_i104.MyNotificationsStateManager>()));
  gh.factory<_i178.NewTestOrderScreen>(
      () => _i178.NewTestOrderScreen(gh<_i107.NewTestOrderStateManager>()));
  gh.factory<_i179.OrderCaptainNotArrivedStateManager>(() =>
      _i179.OrderCaptainNotArrivedStateManager(gh<_i133.StoresService>()));
  gh.factory<_i180.OrderLogsStateManager>(
      () => _i180.OrderLogsStateManager(gh<_i133.StoresService>()));
  gh.factory<_i181.OrderStatusStateManager>(
      () => _i181.OrderStatusStateManager(gh<_i133.StoresService>()));
  gh.factory<_i182.OrderTimeLineStateManager>(
      () => _i182.OrderTimeLineStateManager(gh<_i133.StoresService>()));
  gh.factory<_i183.ReceiptsStateManager>(
      () => _i183.ReceiptsStateManager(gh<_i136.SubscriptionsService>()));
  gh.factory<_i184.StoreDuesStateManager>(() => _i184.StoreDuesStateManager(
        gh<_i133.StoresService>(),
        gh<_i122.PaymentsService>(),
      ));
  gh.factory<_i185.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i185.StoreFinancialSubscriptionsDuesDetailsStateManager(
            gh<_i122.PaymentsService>(),
            gh<_i136.SubscriptionsService>(),
          ));
  gh.factory<_i186.StoreProfileStateManager>(
      () => _i186.StoreProfileStateManager(
            gh<_i133.StoresService>(),
            gh<_i99.ImageUploadService>(),
          ));
  gh.factory<_i187.StoreSubscriptionManagementStateManager>(() =>
      _i187.StoreSubscriptionManagementStateManager(
          gh<_i136.SubscriptionsService>()));
  gh.factory<_i188.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i188.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i136.SubscriptionsService>()));
  gh.factory<_i189.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i189.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i185.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i190.StoreSubscriptionsFinanceStateManager>(() =>
      _i190.StoreSubscriptionsFinanceStateManager(
          gh<_i136.SubscriptionsService>()));
  gh.factory<_i191.StoresDuesStateManager>(
      () => _i191.StoresDuesStateManager(gh<_i133.StoresService>()));
  gh.factory<_i192.StoresInActiveStateManager>(
      () => _i192.StoresInActiveStateManager(
            gh<_i133.StoresService>(),
            gh<_i99.ImageUploadService>(),
          ));
  gh.factory<_i193.StoresNeedsSupportStateManager>(
      () => _i193.StoresNeedsSupportStateManager(gh<_i133.StoresService>()));
  gh.factory<_i194.SubscriptionManagementScreen>(() =>
      _i194.SubscriptionManagementScreen(
          gh<_i187.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i195.SubscriptionToCaptainOfferStateManager>(() =>
      _i195.SubscriptionToCaptainOfferStateManager(
          gh<_i136.SubscriptionsService>()));
  gh.factory<_i196.SupplierAdsStateManager>(
      () => _i196.SupplierAdsStateManager(gh<_i140.SupplierService>()));
  gh.factory<_i197.SupplierCategoriesScreen>(() =>
      _i197.SupplierCategoriesScreen(
          gh<_i139.SupplierCategoriesStateManager>()));
  gh.factory<_i198.SupplierNeedsSupportStateManager>(() =>
      _i198.SupplierNeedsSupportStateManager(gh<_i140.SupplierService>()));
  gh.factory<_i199.SupplierProfileStateManager>(
      () => _i199.SupplierProfileStateManager(gh<_i140.SupplierService>()));
  gh.factory<_i200.SuppliersScreen>(
      () => _i200.SuppliersScreen(gh<_i141.SuppliersStateManager>()));
  gh.factory<_i201.UpdateBranchStateManager>(
      () => _i201.UpdateBranchStateManager(gh<_i148.BranchesListService>()));
  gh.factory<_i202.UpdateScreen>(
      () => _i202.UpdateScreen(gh<_i143.UpdatesStateManager>()));
  gh.factory<_i203.ChatModule>(() => _i203.ChatModule(gh<_i164.ChatPage>()));
  gh.factory<_i204.CreateSubscriptionScreen>(() =>
      _i204.CreateSubscriptionScreen(gh<_i175.InitSubscriptionStateManager>()));
  gh.factory<_i205.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i205.CreateSubscriptionToCaptainOfferScreen(
          gh<_i195.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i206.DevModule>(
      () => _i206.DevModule(gh<_i178.NewTestOrderScreen>()));
  gh.factory<_i207.EditSubscriptionScreen>(() =>
      _i207.EditSubscriptionScreen(gh<_i170.EditSubscriptionStateManager>()));
  gh.factory<_i208.InActiveSupplierScreen>(() =>
      _i208.InActiveSupplierScreen(gh<_i173.InActiveSupplierStateManager>()));
  gh.factory<_i209.MyNotificationsModule>(() => _i209.MyNotificationsModule(
        gh<_i177.MyNotificationsScreen>(),
        gh<_i202.UpdateScreen>(),
      ));
  gh.factory<_i210.ReceiptsScreen>(
      () => _i210.ReceiptsScreen(gh<_i183.ReceiptsStateManager>()));
  gh.factory<_i211.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i211.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i188.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i212.StoreSubscriptionsFinanceScreen>(() =>
      _i212.StoreSubscriptionsFinanceScreen(
          gh<_i190.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i213.SubscriptionsModule>(() => _i213.SubscriptionsModule(
        gh<_i189.StoreSubscriptionsFinanceDetailsScreen>(),
        gh<_i212.StoreSubscriptionsFinanceScreen>(),
        gh<_i194.SubscriptionManagementScreen>(),
        gh<_i211.StoreSubscriptionsExpiredFinanceScreen>(),
        gh<_i204.CreateSubscriptionScreen>(),
        gh<_i205.CreateSubscriptionToCaptainOfferScreen>(),
        gh<_i207.EditSubscriptionScreen>(),
        gh<_i210.ReceiptsScreen>(),
      ));
  gh.factory<_i214.SupplierAdsScreen>(
      () => _i214.SupplierAdsScreen(gh<_i196.SupplierAdsStateManager>()));
  gh.factory<_i215.SupplierCategoriesModule>(() =>
      _i215.SupplierCategoriesModule(gh<_i197.SupplierCategoriesScreen>()));
  gh.factory<_i216.SupplierNeedsSupportScreen>(() =>
      _i216.SupplierNeedsSupportScreen(
          gh<_i198.SupplierNeedsSupportStateManager>()));
  gh.factory<_i217.SupplierProfileScreen>(() =>
      _i217.SupplierProfileScreen(gh<_i199.SupplierProfileStateManager>()));
  gh.factory<_i218.SupplierModule>(() => _i218.SupplierModule(
        gh<_i208.InActiveSupplierScreen>(),
        gh<_i200.SuppliersScreen>(),
        gh<_i217.SupplierProfileScreen>(),
        gh<_i216.SupplierNeedsSupportScreen>(),
        gh<_i214.SupplierAdsScreen>(),
      ));
  gh.factory<_i219.MyApp>(() => _i219.MyApp(
        gh<_i36.AppThemeDataService>(),
        gh<_i22.LocalizationService>(),
        gh<_i94.FireNotificationService>(),
        gh<_i20.LocalNotificationService>(),
        gh<_i127.SplashModule>(),
        gh<_i145.AuthorizationModule>(),
        gh<_i203.ChatModule>(),
        gh<_i126.SettingsModule>(),
        gh<_i176.MainModule>(),
        gh<_i33.StoresModule>(),
        gh<_i14.CategoriesModule>(),
        gh<_i16.CompanyModule>(),
        gh<_i7.BranchesModule>(),
        gh<_i25.NoticeModule>(),
        gh<_i11.CaptainsModule>(),
        gh<_i30.PaymentsModule>(),
        gh<_i215.SupplierCategoriesModule>(),
        gh<_i218.SupplierModule>(),
        gh<_i13.CarsModule>(),
        gh<_i147.BidOrderModule>(),
        gh<_i29.OrdersModule>(),
        gh<_i213.SubscriptionsModule>(),
        gh<_i209.MyNotificationsModule>(),
        gh<_i31.StatisticsModule>(),
        gh<_i206.DevModule>(),
        gh<_i17.ExternalDeliveryCompaniesModule>(),
      ));
  return getIt;
}

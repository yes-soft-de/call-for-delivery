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
import '../main.dart' as _i217;
import '../module_auth/authoriazation_module.dart' as _i146;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i38;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i6;
import '../module_auth/service/auth_service/auth_service.dart' as _i39;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i50;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i52;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i61;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i96;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i102;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i126;
import '../module_bid_order/bid_order_module.dart' as _i148;
import '../module_bid_order/manager/bid_order_manager.dart' as _i74;
import '../module_bid_order/repository/bid_order_repository.dart' as _i40;
import '../module_bid_order/service/bid_order_service.dart' as _i75;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i76;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i77;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i147;
import '../module_branches/branches_module.dart' as _i7;
import '../module_branches/manager/branches_manager.dart' as _i78;
import '../module_branches/repository/branches_repository.dart' as _i41;
import '../module_branches/service/branches_list_service.dart' as _i149;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i150;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i175;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i201;
import '../module_captain/captains_module.dart' as _i11;
import '../module_captain/hive/captain_hive_helper.dart' as _i10;
import '../module_captain/manager/captains_manager.dart' as _i79;
import '../module_captain/repository/captains_repository.dart' as _i42;
import '../module_captain/service/captains_service.dart' as _i80;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i151;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i162;
import '../module_captain/state_manager/captain_dues_state_manager.dart'
    as _i153;
import '../module_captain/state_manager/captain_list.dart' as _i81;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i163;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i157;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i152;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i160;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i164;
import '../module_captain/state_manager/caption_rating_details_state_manager.dart'
    as _i161;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i101;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i125;
import '../module_captain/ui/screen/captain_dues_screen.dart' as _i9;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i12;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i8;
import '../module_categories/categories_module.dart' as _i14;
import '../module_categories/manager/categories_manager.dart' as _i82;
import '../module_categories/repository/categories_repository.dart' as _i43;
import '../module_categories/service/store_categories_service.dart' as _i83;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i120;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i121;
import '../module_chat/chat_module.dart' as _i202;
import '../module_chat/manager/chat/chat_manager.dart' as _i84;
import '../module_chat/presistance/chat_hive_helper.dart' as _i15;
import '../module_chat/repository/chat/chat_repository.dart' as _i44;
import '../module_chat/service/chat/char_service.dart' as _i85;
import '../module_chat/state_manager/chat_state_manager.dart' as _i86;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i165;
import '../module_company/company_module.dart' as _i16;
import '../module_company/manager/company_manager.dart' as _i87;
import '../module_company/repository/company_repository.dart' as _i46;
import '../module_company/service/company_service.dart' as _i88;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i166;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i167;
import '../module_deep_links/repository/deep_link_repository.dart' as _i47;
import '../module_delivary_car/cars_module.dart' as _i13;
import '../module_dev/dev_module.dart' as _i205;
import '../module_dev/hive/order_hive_helper.dart' as _i29;
import '../module_dev/manager/dev_manager.dart' as _i89;
import '../module_dev/repository/dev_repository.dart' as _i48;
import '../module_dev/service/orders/dev.service.dart' as _i90;
import '../module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i108;
import '../module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i178;
import '../module_external_delivery_companies/external_delivery_companies_module.dart'
    as _i17;
import '../module_external_delivery_companies/manager/external_delivery_companies_manager.dart'
    as _i91;
import '../module_external_delivery_companies/repository/external_delivery_companies_repository.dart'
    as _i49;
import '../module_external_delivery_companies/service/external_delivery_companies_service.dart'
    as _i92;
import '../module_external_delivery_companies/state_manager/assign_order_to_external_company_state_manager.dart'
    as _i145;
import '../module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart'
    as _i168;
import '../module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart'
    as _i169;
import '../module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart'
    as _i93;
import '../module_external_delivery_companies/state_manager/external_orders_state_manager.dart'
    as _i94;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i21;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i22;
import '../module_main/main_module.dart' as _i177;
import '../module_main/manager/home_manager.dart' as _i97;
import '../module_main/repository/home_repository.dart' as _i51;
import '../module_main/sceen/home_screen.dart' as _i173;
import '../module_main/sceen/main_screen.dart' as _i24;
import '../module_main/service/home_service.dart' as _i98;
import '../module_main/state_manager/home_state_manager.dart' as _i99;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i103;
import '../module_my_notifications/my_notifications_module.dart' as _i25;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i53;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i104;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i105;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i144;
import '../module_network/http_client/http_client.dart' as _i3;
import '../module_notice/manager/notice_manager.dart' as _i109;
import '../module_notice/notice_module.dart' as _i26;
import '../module_notice/repository/notice_repository.dart' as _i54;
import '../module_notice/service/notice_service.dart' as _i110;
import '../module_notice/state_manager/notice_state_manager.dart' as _i111;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i27;
import '../module_notifications/repository/notification_repo.dart' as _i55;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i95;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i20;
import '../module_orders/hive/order_hive_helper.dart' as _i28;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i57;
import '../module_orders/orders_module.dart' as _i30;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i56;
import '../module_orders/service/orders/orders.service.dart' as _i58;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i107;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i106;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i72;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i112;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i113;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i114;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i118;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i115;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i116;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i119;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i117;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i60;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i62;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i67;
import '../module_payments/manager/payments_manager.dart' as _i122;
import '../module_payments/payments_module.dart' as _i31;
import '../module_payments/repository/payments_repository.dart' as _i59;
import '../module_payments/service/payments_service.dart' as _i123;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i154;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i155;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i156;
import '../module_payments/state_manager/captain_payment_state_manager.dart'
    as _i158;
import '../module_payments/state_manager/captain_previous_payments.dart'
    as _i159;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i124;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i132;
import '../module_settings/settings_module.dart' as _i127;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i45;
import '../module_settings/ui/settings_page/settings_page.dart' as _i63;
import '../module_splash/splash_module.dart' as _i128;
import '../module_splash/ui/screen/splash_screen.dart' as _i64;
import '../module_statistics/manager/statistic_manager.dart' as _i129;
import '../module_statistics/repository/statistics_repository.dart' as _i65;
import '../module_statistics/service/statistics_service.dart' as _i130;
import '../module_statistics/state_manager/statistics_state_manager.dart'
    as _i131;
import '../module_statistics/ui/statistics_module.dart' as _i32;
import '../module_stores/hive/store_hive_helper.dart' as _i33;
import '../module_stores/manager/stores_manager.dart' as _i133;
import '../module_stores/repository/stores_repository.dart' as _i66;
import '../module_stores/service/store_service.dart' as _i134;
import '../module_stores/state_manager/edit_store_setting_state_manager.dart'
    as _i170;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i172;
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
import '../module_stores/state_manager/stores_state_manager.dart' as _i135;
import '../module_stores/state_manager/top_active_store.dart' as _i143;
import '../module_stores/stores_module.dart' as _i34;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i136;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i68;
import '../module_subscriptions/service/subscriptions_service.dart' as _i137;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i171;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i176;
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
import '../module_subscriptions/subscriptions_module.dart' as _i211;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i206;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i203;
import '../module_subscriptions/ui/screen/receipts_screen.dart' as _i208;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i189;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i209;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i210;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i204;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i194;
import '../module_supplier/manager/supplier_manager.dart' as _i71;
import '../module_supplier/repository/supplier_repository.dart' as _i70;
import '../module_supplier/service/supplier_service.dart' as _i141;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i174;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i196;
import '../module_supplier/state_manager/supplier_list.dart' as _i142;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i198;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i199;
import '../module_supplier/supplier_module.dart' as _i216;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i207;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i212;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i200;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i214;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i215;
import '../module_supplier_categories/categories_supplier_module.dart' as _i213;
import '../module_supplier_categories/manager/categories_manager.dart' as _i138;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i69;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i139;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i140;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i197;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i35;
import '../module_theme/service/theme_service/theme_service.dart' as _i37;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i73;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i36;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i100;
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
  gh.factory<_i25.MyNotificationsModule>(() => _i25.MyNotificationsModule());
  gh.factory<_i26.NoticeModule>(() => _i26.NoticeModule());
  gh.factory<_i27.NotificationsPrefHelper>(
      () => _i27.NotificationsPrefHelper());
  gh.factory<_i28.OrderHiveHelper>(() => _i28.OrderHiveHelper());
  gh.factory<_i29.OrderHiveHelper>(() => _i29.OrderHiveHelper());
  gh.factory<_i30.OrdersModule>(() => _i30.OrdersModule());
  gh.factory<_i31.PaymentsModule>(() => _i31.PaymentsModule());
  gh.factory<_i32.StatisticsModule>(() => _i32.StatisticsModule());
  gh.factory<_i33.StoresHiveHelper>(() => _i33.StoresHiveHelper());
  gh.factory<_i34.StoresModule>(() => _i34.StoresModule());
  gh.factory<_i35.ThemePreferencesHelper>(() => _i35.ThemePreferencesHelper());
  gh.factory<_i36.UploadRepository>(() => _i36.UploadRepository());
  gh.factory<_i37.AppThemeDataService>(
      () => _i37.AppThemeDataService(gh<_i35.ThemePreferencesHelper>()));
  gh.factory<_i38.AuthManager>(
      () => _i38.AuthManager(gh<_i6.AuthRepository>()));
  gh.factory<_i39.AuthService>(() => _i39.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i38.AuthManager>(),
      ));
  gh.factory<_i40.BidOrderRepository>(() => _i40.BidOrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i41.BranchesRepository>(() => _i41.BranchesRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i42.CaptainsRepository>(() => _i42.CaptainsRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i43.CategoriesRepository>(() => _i43.CategoriesRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i44.ChatRepository>(() => _i44.ChatRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i45.ChooseLocalScreen>(
      () => _i45.ChooseLocalScreen(gh<_i22.LocalizationService>()));
  gh.factory<_i46.CompanyRepository>(() => _i46.CompanyRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i47.DeepLinkRepository>(() => _i47.DeepLinkRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i48.DevRepository>(() => _i48.DevRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i49.ExternalDeliveryCompaniesRepository>(
      () => _i49.ExternalDeliveryCompaniesRepository(
            gh<_i3.ApiClient>(),
            gh<_i39.AuthService>(),
          ));
  gh.factory<_i50.ForgotPassStateManager>(
      () => _i50.ForgotPassStateManager(gh<_i39.AuthService>()));
  gh.factory<_i51.HomeRepository>(() => _i51.HomeRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i52.LoginStateManager>(
      () => _i52.LoginStateManager(gh<_i39.AuthService>()));
  gh.factory<_i53.MyNotificationsRepository>(
      () => _i53.MyNotificationsRepository(
            gh<_i3.ApiClient>(),
            gh<_i39.AuthService>(),
          ));
  gh.factory<_i54.NoticeRepository>(() => _i54.NoticeRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i55.NotificationRepo>(() => _i55.NotificationRepo(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i56.OrderRepository>(() => _i56.OrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i57.OrdersManager>(
      () => _i57.OrdersManager(gh<_i56.OrderRepository>()));
  gh.factory<_i58.OrdersService>(
      () => _i58.OrdersService(gh<_i57.OrdersManager>()));
  gh.factory<_i59.PaymentsRepository>(() => _i59.PaymentsRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i60.RecycleOrderStateManager>(
      () => _i60.RecycleOrderStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i61.RegisterStateManager>(
      () => _i61.RegisterStateManager(gh<_i39.AuthService>()));
  gh.factory<_i62.SearchForOrderStateManager>(
      () => _i62.SearchForOrderStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i63.SettingsScreen>(() => _i63.SettingsScreen(
        gh<_i39.AuthService>(),
        gh<_i22.LocalizationService>(),
        gh<_i37.AppThemeDataService>(),
      ));
  gh.factory<_i64.SplashScreen>(
      () => _i64.SplashScreen(gh<_i39.AuthService>()));
  gh.factory<_i65.StatisticsRepository>(() => _i65.StatisticsRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i66.StoresRepository>(() => _i66.StoresRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i67.SubOrdersStateManager>(
      () => _i67.SubOrdersStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i68.SubscriptionsRepository>(() => _i68.SubscriptionsRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i69.SupplierCategoriesRepository>(
      () => _i69.SupplierCategoriesRepository(
            gh<_i3.ApiClient>(),
            gh<_i39.AuthService>(),
          ));
  gh.factory<_i70.SupplierRepository>(() => _i70.SupplierRepository(
        gh<_i3.ApiClient>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i71.SuppliersManager>(
      () => _i71.SuppliersManager(gh<_i70.SupplierRepository>()));
  gh.factory<_i72.UpdateOrderStateManager>(
      () => _i72.UpdateOrderStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i73.UploadManager>(
      () => _i73.UploadManager(gh<_i36.UploadRepository>()));
  gh.factory<_i74.BidOrderManager>(
      () => _i74.BidOrderManager(gh<_i40.BidOrderRepository>()));
  gh.factory<_i75.BidOrderService>(
      () => _i75.BidOrderService(gh<_i74.BidOrderManager>()));
  gh.factory<_i76.BidOrderStateManager>(
      () => _i76.BidOrderStateManager(gh<_i75.BidOrderService>()));
  gh.factory<_i77.BidOrdersScreen>(
      () => _i77.BidOrdersScreen(gh<_i76.BidOrderStateManager>()));
  gh.factory<_i78.BranchesManager>(
      () => _i78.BranchesManager(gh<_i41.BranchesRepository>()));
  gh.factory<_i79.CaptainsManager>(
      () => _i79.CaptainsManager(gh<_i42.CaptainsRepository>()));
  gh.factory<_i80.CaptainsService>(
      () => _i80.CaptainsService(gh<_i79.CaptainsManager>()));
  gh.factory<_i81.CaptainsStateManager>(
      () => _i81.CaptainsStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i82.CategoriesManager>(
      () => _i82.CategoriesManager(gh<_i43.CategoriesRepository>()));
  gh.factory<_i83.CategoriesService>(
      () => _i83.CategoriesService(gh<_i82.CategoriesManager>()));
  gh.factory<_i84.ChatManager>(
      () => _i84.ChatManager(gh<_i44.ChatRepository>()));
  gh.factory<_i85.ChatService>(() => _i85.ChatService(gh<_i84.ChatManager>()));
  gh.factory<_i86.ChatStateManager>(
      () => _i86.ChatStateManager(gh<_i85.ChatService>()));
  gh.factory<_i87.CompanyManager>(
      () => _i87.CompanyManager(gh<_i46.CompanyRepository>()));
  gh.factory<_i88.CompanyService>(
      () => _i88.CompanyService(gh<_i87.CompanyManager>()));
  gh.factory<_i89.DevManager>(() => _i89.DevManager(gh<_i48.DevRepository>()));
  gh.factory<_i90.DevService>(() => _i90.DevService(gh<_i89.DevManager>()));
  gh.factory<_i91.ExternalDeliveryCompaniesManager>(() =>
      _i91.ExternalDeliveryCompaniesManager(
          gh<_i49.ExternalDeliveryCompaniesRepository>()));
  gh.factory<_i92.ExternalDeliveryCompaniesService>(() =>
      _i92.ExternalDeliveryCompaniesService(
          gh<_i91.ExternalDeliveryCompaniesManager>()));
  gh.factory<_i93.ExternalDeliveryCompaniesStateManager>(() =>
      _i93.ExternalDeliveryCompaniesStateManager(
          gh<_i92.ExternalDeliveryCompaniesService>()));
  gh.factory<_i94.ExternalOrdersStateManager>(() =>
      _i94.ExternalOrdersStateManager(
          gh<_i92.ExternalDeliveryCompaniesService>()));
  gh.factory<_i95.FireNotificationService>(
      () => _i95.FireNotificationService(gh<_i55.NotificationRepo>()));
  gh.factory<_i96.ForgotPassScreen>(
      () => _i96.ForgotPassScreen(gh<_i50.ForgotPassStateManager>()));
  gh.factory<_i97.HomeManager>(
      () => _i97.HomeManager(gh<_i51.HomeRepository>()));
  gh.factory<_i98.HomeService>(() => _i98.HomeService(gh<_i97.HomeManager>()));
  gh.factory<_i99.HomeStateManager>(
      () => _i99.HomeStateManager(gh<_i98.HomeService>()));
  gh.factory<_i100.ImageUploadService>(
      () => _i100.ImageUploadService(gh<_i73.UploadManager>()));
  gh.factory<_i101.InActiveCaptainsStateManager>(
      () => _i101.InActiveCaptainsStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i102.LoginScreen>(
      () => _i102.LoginScreen(gh<_i52.LoginStateManager>()));
  gh.factory<_i103.MyNotificationsManager>(
      () => _i103.MyNotificationsManager(gh<_i53.MyNotificationsRepository>()));
  gh.factory<_i104.MyNotificationsService>(
      () => _i104.MyNotificationsService(gh<_i103.MyNotificationsManager>()));
  gh.factory<_i105.MyNotificationsStateManager>(
      () => _i105.MyNotificationsStateManager(
            gh<_i104.MyNotificationsService>(),
            gh<_i39.AuthService>(),
          ));
  gh.factory<_i106.NewOrderLinkStateManager>(
      () => _i106.NewOrderLinkStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i107.NewOrderStateManager>(
      () => _i107.NewOrderStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i108.NewTestOrderStateManager>(
      () => _i108.NewTestOrderStateManager(gh<_i90.DevService>()));
  gh.factory<_i109.NoticeManager>(
      () => _i109.NoticeManager(gh<_i54.NoticeRepository>()));
  gh.factory<_i110.NoticeService>(
      () => _i110.NoticeService(gh<_i109.NoticeManager>()));
  gh.factory<_i111.NoticeStateManager>(
      () => _i111.NoticeStateManager(gh<_i110.NoticeService>()));
  gh.factory<_i112.OrderActionLogsStateManager>(
      () => _i112.OrderActionLogsStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i113.OrderCaptainLogsStateManager>(
      () => _i113.OrderCaptainLogsStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i114.OrderCashCaptainStateManager>(
      () => _i114.OrderCashCaptainStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i115.OrderDistanceConflictStateManager>(
      () => _i115.OrderDistanceConflictStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i116.OrderPendingStateManager>(
      () => _i116.OrderPendingStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i117.OrderWithoutDistanceStateManager>(
      () => _i117.OrderWithoutDistanceStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i118.OrdersCashStoreStateManager>(
      () => _i118.OrdersCashStoreStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i119.OrdersReceiveCashStateManager>(
      () => _i119.OrdersReceiveCashStateManager(gh<_i58.OrdersService>()));
  gh.factory<_i120.PackageCategoriesStateManager>(
      () => _i120.PackageCategoriesStateManager(gh<_i83.CategoriesService>()));
  gh.factory<_i121.PackagesStateManager>(
      () => _i121.PackagesStateManager(gh<_i83.CategoriesService>()));
  gh.factory<_i122.PaymentsManager>(
      () => _i122.PaymentsManager(gh<_i59.PaymentsRepository>()));
  gh.factory<_i123.PaymentsService>(
      () => _i123.PaymentsService(gh<_i122.PaymentsManager>()));
  gh.factory<_i124.PaymentsToCaptainStateManager>(
      () => _i124.PaymentsToCaptainStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i125.PlanScreenStateManager>(
      () => _i125.PlanScreenStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i126.RegisterScreen>(
      () => _i126.RegisterScreen(gh<_i61.RegisterStateManager>()));
  gh.factory<_i127.SettingsModule>(() => _i127.SettingsModule(
        gh<_i63.SettingsScreen>(),
        gh<_i45.ChooseLocalScreen>(),
      ));
  gh.factory<_i128.SplashModule>(
      () => _i128.SplashModule(gh<_i64.SplashScreen>()));
  gh.factory<_i129.StatisticManager>(
      () => _i129.StatisticManager(gh<_i65.StatisticsRepository>()));
  gh.factory<_i130.StatisticsService>(
      () => _i130.StatisticsService(gh<_i129.StatisticManager>()));
  gh.factory<_i131.StatisticsStateManager>(
      () => _i131.StatisticsStateManager(gh<_i130.StatisticsService>()));
  gh.factory<_i132.StoreBalanceStateManager>(
      () => _i132.StoreBalanceStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i133.StoreManager>(
      () => _i133.StoreManager(gh<_i66.StoresRepository>()));
  gh.factory<_i134.StoresService>(
      () => _i134.StoresService(gh<_i133.StoreManager>()));
  gh.factory<_i135.StoresStateManager>(() => _i135.StoresStateManager(
        gh<_i134.StoresService>(),
        gh<_i100.ImageUploadService>(),
      ));
  gh.factory<_i136.SubscriptionsManager>(
      () => _i136.SubscriptionsManager(gh<_i68.SubscriptionsRepository>()));
  gh.factory<_i137.SubscriptionsService>(
      () => _i137.SubscriptionsService(gh<_i136.SubscriptionsManager>()));
  gh.factory<_i138.SupplierCategoriesManager>(() =>
      _i138.SupplierCategoriesManager(gh<_i69.SupplierCategoriesRepository>()));
  gh.factory<_i139.SupplierCategoriesService>(() =>
      _i139.SupplierCategoriesService(gh<_i138.SupplierCategoriesManager>()));
  gh.factory<_i140.SupplierCategoriesStateManager>(
      () => _i140.SupplierCategoriesStateManager(
            gh<_i139.SupplierCategoriesService>(),
            gh<_i100.ImageUploadService>(),
          ));
  gh.factory<_i141.SupplierService>(
      () => _i141.SupplierService(gh<_i71.SuppliersManager>()));
  gh.factory<_i142.SuppliersStateManager>(
      () => _i142.SuppliersStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i143.TopActiveStateManagement>(
      () => _i143.TopActiveStateManagement(gh<_i134.StoresService>()));
  gh.factory<_i144.UpdatesStateManager>(() => _i144.UpdatesStateManager(
        gh<_i104.MyNotificationsService>(),
        gh<_i39.AuthService>(),
      ));
  gh.factory<_i145.AssignOrderToExternalCompanyStateManager>(() =>
      _i145.AssignOrderToExternalCompanyStateManager(
          gh<_i92.ExternalDeliveryCompaniesService>()));
  gh.factory<_i146.AuthorizationModule>(() => _i146.AuthorizationModule(
        gh<_i102.LoginScreen>(),
        gh<_i126.RegisterScreen>(),
        gh<_i96.ForgotPassScreen>(),
      ));
  gh.factory<_i147.BidOrderDetailsScreen>(
      () => _i147.BidOrderDetailsScreen(gh<_i76.BidOrderStateManager>()));
  gh.factory<_i148.BidOrderModule>(
      () => _i148.BidOrderModule(gh<_i77.BidOrdersScreen>()));
  gh.factory<_i149.BranchesListService>(
      () => _i149.BranchesListService(gh<_i78.BranchesManager>()));
  gh.factory<_i150.BranchesListStateManager>(
      () => _i150.BranchesListStateManager(gh<_i149.BranchesListService>()));
  gh.factory<_i151.CaptainActivityDetailsStateManager>(() =>
      _i151.CaptainActivityDetailsStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i152.CaptainAssignOrderStateManager>(
      () => _i152.CaptainAssignOrderStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i153.CaptainDuesStateManager>(
      () => _i153.CaptainDuesStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i154.CaptainFinanceByHoursStateManager>(() =>
      _i154.CaptainFinanceByHoursStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i155.CaptainFinanceByOrderCountStateManager>(() =>
      _i155.CaptainFinanceByOrderCountStateManager(
          gh<_i123.PaymentsService>()));
  gh.factory<_i156.CaptainFinanceByOrderStateManager>(() =>
      _i156.CaptainFinanceByOrderStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i157.CaptainOfferStateManager>(
      () => _i157.CaptainOfferStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i158.CaptainPaymentStateManager>(
      () => _i158.CaptainPaymentStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i159.CaptainPreviousPaymentsStateManager>(() =>
      _i159.CaptainPreviousPaymentsStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i160.CaptainProfileStateManager>(
      () => _i160.CaptainProfileStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i161.CaptainRatingDetailsStateManager>(
      () => _i161.CaptainRatingDetailsStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i162.CaptainsActivityStateManager>(
      () => _i162.CaptainsActivityStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i163.CaptainsNeedsSupportStateManager>(
      () => _i163.CaptainsNeedsSupportStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i164.CaptainsRatingStateManager>(
      () => _i164.CaptainsRatingStateManager(gh<_i80.CaptainsService>()));
  gh.factory<_i165.ChatPage>(() => _i165.ChatPage(
        gh<_i86.ChatStateManager>(),
        gh<_i100.ImageUploadService>(),
        gh<_i39.AuthService>(),
        gh<_i15.ChatHiveHelper>(),
      ));
  gh.factory<_i166.CompanyFinanceStateManager>(
      () => _i166.CompanyFinanceStateManager(gh<_i88.CompanyService>()));
  gh.factory<_i167.CompanyProfileStateManager>(
      () => _i167.CompanyProfileStateManager(gh<_i88.CompanyService>()));
  gh.factory<_i168.DeliveryCompanyAllSettingsStateManager>(() =>
      _i168.DeliveryCompanyAllSettingsStateManager(
          gh<_i92.ExternalDeliveryCompaniesService>()));
  gh.factory<_i169.EditDeliveryCompanySettingScreenStateManager>(() =>
      _i169.EditDeliveryCompanySettingScreenStateManager(
          gh<_i92.ExternalDeliveryCompaniesService>()));
  gh.factory<_i170.EditStoreSettingStateManager>(
      () => _i170.EditStoreSettingStateManager(
            gh<_i134.StoresService>(),
            gh<_i100.ImageUploadService>(),
          ));
  gh.factory<_i171.EditSubscriptionStateManager>(() =>
      _i171.EditSubscriptionStateManager(gh<_i137.SubscriptionsService>()));
  gh.factory<_i172.FilterOrderTopStateManager>(
      () => _i172.FilterOrderTopStateManager(gh<_i134.StoresService>()));
  gh.factory<_i173.HomeScreen>(
      () => _i173.HomeScreen(gh<_i99.HomeStateManager>()));
  gh.factory<_i174.InActiveSupplierStateManager>(
      () => _i174.InActiveSupplierStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i175.InitBranchesStateManager>(
      () => _i175.InitBranchesStateManager(gh<_i149.BranchesListService>()));
  gh.factory<_i176.InitSubscriptionStateManager>(() =>
      _i176.InitSubscriptionStateManager(gh<_i137.SubscriptionsService>()));
  gh.factory<_i177.MainModule>(() => _i177.MainModule(
        gh<_i24.MainScreen>(),
        gh<_i173.HomeScreen>(),
      ));
  gh.factory<_i178.NewTestOrderScreen>(
      () => _i178.NewTestOrderScreen(gh<_i108.NewTestOrderStateManager>()));
  gh.factory<_i179.OrderCaptainNotArrivedStateManager>(() =>
      _i179.OrderCaptainNotArrivedStateManager(gh<_i134.StoresService>()));
  gh.factory<_i180.OrderLogsStateManager>(
      () => _i180.OrderLogsStateManager(gh<_i134.StoresService>()));
  gh.factory<_i181.OrderStatusStateManager>(
      () => _i181.OrderStatusStateManager(gh<_i134.StoresService>()));
  gh.factory<_i182.OrderTimeLineStateManager>(
      () => _i182.OrderTimeLineStateManager(gh<_i134.StoresService>()));
  gh.factory<_i183.ReceiptsStateManager>(
      () => _i183.ReceiptsStateManager(gh<_i137.SubscriptionsService>()));
  gh.factory<_i184.StoreDuesStateManager>(() => _i184.StoreDuesStateManager(
        gh<_i134.StoresService>(),
        gh<_i123.PaymentsService>(),
      ));
  gh.factory<_i185.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i185.StoreFinancialSubscriptionsDuesDetailsStateManager(
            gh<_i123.PaymentsService>(),
            gh<_i137.SubscriptionsService>(),
          ));
  gh.factory<_i186.StoreProfileStateManager>(
      () => _i186.StoreProfileStateManager(
            gh<_i134.StoresService>(),
            gh<_i100.ImageUploadService>(),
          ));
  gh.factory<_i187.StoreSubscriptionManagementStateManager>(() =>
      _i187.StoreSubscriptionManagementStateManager(
          gh<_i137.SubscriptionsService>()));
  gh.factory<_i188.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i188.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i137.SubscriptionsService>()));
  gh.factory<_i189.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i189.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i185.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i190.StoreSubscriptionsFinanceStateManager>(() =>
      _i190.StoreSubscriptionsFinanceStateManager(
          gh<_i137.SubscriptionsService>()));
  gh.factory<_i191.StoresDuesStateManager>(
      () => _i191.StoresDuesStateManager(gh<_i134.StoresService>()));
  gh.factory<_i192.StoresInActiveStateManager>(
      () => _i192.StoresInActiveStateManager(
            gh<_i134.StoresService>(),
            gh<_i100.ImageUploadService>(),
          ));
  gh.factory<_i193.StoresNeedsSupportStateManager>(
      () => _i193.StoresNeedsSupportStateManager(gh<_i134.StoresService>()));
  gh.factory<_i194.SubscriptionManagementScreen>(() =>
      _i194.SubscriptionManagementScreen(
          gh<_i187.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i195.SubscriptionToCaptainOfferStateManager>(() =>
      _i195.SubscriptionToCaptainOfferStateManager(
          gh<_i137.SubscriptionsService>()));
  gh.factory<_i196.SupplierAdsStateManager>(
      () => _i196.SupplierAdsStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i197.SupplierCategoriesScreen>(() =>
      _i197.SupplierCategoriesScreen(
          gh<_i140.SupplierCategoriesStateManager>()));
  gh.factory<_i198.SupplierNeedsSupportStateManager>(() =>
      _i198.SupplierNeedsSupportStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i199.SupplierProfileStateManager>(
      () => _i199.SupplierProfileStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i200.SuppliersScreen>(
      () => _i200.SuppliersScreen(gh<_i142.SuppliersStateManager>()));
  gh.factory<_i201.UpdateBranchStateManager>(
      () => _i201.UpdateBranchStateManager(gh<_i149.BranchesListService>()));
  gh.factory<_i202.ChatModule>(() => _i202.ChatModule(gh<_i165.ChatPage>()));
  gh.factory<_i203.CreateSubscriptionScreen>(() =>
      _i203.CreateSubscriptionScreen(gh<_i176.InitSubscriptionStateManager>()));
  gh.factory<_i204.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i204.CreateSubscriptionToCaptainOfferScreen(
          gh<_i195.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i205.DevModule>(
      () => _i205.DevModule(gh<_i178.NewTestOrderScreen>()));
  gh.factory<_i206.EditSubscriptionScreen>(() =>
      _i206.EditSubscriptionScreen(gh<_i171.EditSubscriptionStateManager>()));
  gh.factory<_i207.InActiveSupplierScreen>(() =>
      _i207.InActiveSupplierScreen(gh<_i174.InActiveSupplierStateManager>()));
  gh.factory<_i208.ReceiptsScreen>(
      () => _i208.ReceiptsScreen(gh<_i183.ReceiptsStateManager>()));
  gh.factory<_i209.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i209.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i188.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i210.StoreSubscriptionsFinanceScreen>(() =>
      _i210.StoreSubscriptionsFinanceScreen(
          gh<_i190.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i211.SubscriptionsModule>(() => _i211.SubscriptionsModule(
        gh<_i189.StoreSubscriptionsFinanceDetailsScreen>(),
        gh<_i210.StoreSubscriptionsFinanceScreen>(),
        gh<_i194.SubscriptionManagementScreen>(),
        gh<_i209.StoreSubscriptionsExpiredFinanceScreen>(),
        gh<_i203.CreateSubscriptionScreen>(),
        gh<_i204.CreateSubscriptionToCaptainOfferScreen>(),
        gh<_i206.EditSubscriptionScreen>(),
        gh<_i208.ReceiptsScreen>(),
      ));
  gh.factory<_i212.SupplierAdsScreen>(
      () => _i212.SupplierAdsScreen(gh<_i196.SupplierAdsStateManager>()));
  gh.factory<_i213.SupplierCategoriesModule>(() =>
      _i213.SupplierCategoriesModule(gh<_i197.SupplierCategoriesScreen>()));
  gh.factory<_i214.SupplierNeedsSupportScreen>(() =>
      _i214.SupplierNeedsSupportScreen(
          gh<_i198.SupplierNeedsSupportStateManager>()));
  gh.factory<_i215.SupplierProfileScreen>(() =>
      _i215.SupplierProfileScreen(gh<_i199.SupplierProfileStateManager>()));
  gh.factory<_i216.SupplierModule>(() => _i216.SupplierModule(
        gh<_i207.InActiveSupplierScreen>(),
        gh<_i200.SuppliersScreen>(),
        gh<_i215.SupplierProfileScreen>(),
        gh<_i214.SupplierNeedsSupportScreen>(),
        gh<_i212.SupplierAdsScreen>(),
      ));
  gh.factory<_i217.MyApp>(() => _i217.MyApp(
        gh<_i37.AppThemeDataService>(),
        gh<_i22.LocalizationService>(),
        gh<_i95.FireNotificationService>(),
        gh<_i20.LocalNotificationService>(),
        gh<_i128.SplashModule>(),
        gh<_i146.AuthorizationModule>(),
        gh<_i202.ChatModule>(),
        gh<_i127.SettingsModule>(),
        gh<_i177.MainModule>(),
        gh<_i34.StoresModule>(),
        gh<_i14.CategoriesModule>(),
        gh<_i16.CompanyModule>(),
        gh<_i7.BranchesModule>(),
        gh<_i26.NoticeModule>(),
        gh<_i11.CaptainsModule>(),
        gh<_i31.PaymentsModule>(),
        gh<_i213.SupplierCategoriesModule>(),
        gh<_i216.SupplierModule>(),
        gh<_i13.CarsModule>(),
        gh<_i148.BidOrderModule>(),
        gh<_i30.OrdersModule>(),
        gh<_i211.SubscriptionsModule>(),
        gh<_i25.MyNotificationsModule>(),
        gh<_i32.StatisticsModule>(),
        gh<_i205.DevModule>(),
        gh<_i17.ExternalDeliveryCompaniesModule>(),
      ));
  return getIt;
}

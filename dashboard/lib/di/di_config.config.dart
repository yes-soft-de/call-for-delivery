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
import '../main.dart' as _i216;
import '../module_auth/authoriazation_module.dart' as _i153;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i42;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i6;
import '../module_auth/service/auth_service/auth_service.dart' as _i43;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i55;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i57;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i66;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i103;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i109;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i133;
import '../module_bid_order/bid_order_module.dart' as _i7;
import '../module_bid_order/manager/bid_order_manager.dart' as _i79;
import '../module_bid_order/repository/bid_order_repository.dart' as _i44;
import '../module_bid_order/service/bid_order_service.dart' as _i80;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i81;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i8;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i154;
import '../module_branches/branches_module.dart' as _i9;
import '../module_branches/manager/branches_manager.dart' as _i82;
import '../module_branches/repository/branches_repository.dart' as _i45;
import '../module_branches/service/branches_list_service.dart' as _i155;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i156;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i182;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i206;
import '../module_captain/captains_module.dart' as _i13;
import '../module_captain/hive/captain_hive_helper.dart' as _i12;
import '../module_captain/manager/captains_manager.dart' as _i83;
import '../module_captain/repository/captains_repository.dart' as _i46;
import '../module_captain/service/captains_service.dart' as _i84;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i157;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i168;
import '../module_captain/state_manager/captain_dues_state_manager.dart'
    as _i159;
import '../module_captain/state_manager/captain_list.dart' as _i85;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i169;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i163;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i158;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i166;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i170;
import '../module_captain/state_manager/caption_rating_details_state_manager.dart'
    as _i167;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i108;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i132;
import '../module_captain/ui/screen/captain_dues_screen.dart' as _i11;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i14;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i10;
import '../module_categories/categories_module.dart' as _i16;
import '../module_categories/manager/categories_manager.dart' as _i86;
import '../module_categories/repository/categories_repository.dart' as _i47;
import '../module_categories/service/store_categories_service.dart' as _i87;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i127;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i128;
import '../module_chat/chat_module.dart' as _i208;
import '../module_chat/manager/chat/chat_manager.dart' as _i91;
import '../module_chat/presistance/chat_hive_helper.dart' as _i17;
import '../module_chat/repository/chat/chat_repository.dart' as _i49;
import '../module_chat/service/chat/char_service.dart' as _i92;
import '../module_chat/state_manager/chat_state_manager.dart' as _i93;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i172;
import '../module_chat_v2/chat_module.dart' as _i207;
import '../module_chat_v2/manager/chat/chat_manager.dart' as _i88;
import '../module_chat_v2/presistance/chat_hive_helper.dart' as _i18;
import '../module_chat_v2/repository/chat/chat_repository.dart' as _i48;
import '../module_chat_v2/service/chat/char_service.dart' as _i89;
import '../module_chat_v2/state_manager/chat_state_manager.dart' as _i90;
import '../module_chat_v2/ui/screens/chat_page/chat_page.dart' as _i171;
import '../module_company/company_module.dart' as _i19;
import '../module_company/manager/company_manager.dart' as _i94;
import '../module_company/repository/company_repository.dart' as _i51;
import '../module_company/service/company_service.dart' as _i95;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i173;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i174;
import '../module_deep_links/repository/deep_link_repository.dart' as _i52;
import '../module_delivary_car/cars_module.dart' as _i15;
import '../module_dev/dev_module.dart' as _i209;
import '../module_dev/hive/order_hive_helper.dart' as _i31;
import '../module_dev/manager/dev_manager.dart' as _i96;
import '../module_dev/repository/dev_repository.dart' as _i53;
import '../module_dev/service/orders/dev.service.dart' as _i97;
import '../module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i115;
import '../module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i185;
import '../module_external_delivery_companies/external_delivery_companies_module.dart'
    as _i20;
import '../module_external_delivery_companies/manager/external_delivery_companies_manager.dart'
    as _i98;
import '../module_external_delivery_companies/repository/external_delivery_companies_repository.dart'
    as _i54;
import '../module_external_delivery_companies/service/external_delivery_companies_service.dart'
    as _i99;
import '../module_external_delivery_companies/state_manager/assign_order_to_external_company_state_manager.dart'
    as _i152;
import '../module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart'
    as _i175;
import '../module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart'
    as _i176;
import '../module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart'
    as _i100;
import '../module_external_delivery_companies/state_manager/external_orders_state_manager.dart'
    as _i101;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i24;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i25;
import '../module_main/main_module.dart' as _i184;
import '../module_main/manager/home_manager.dart' as _i104;
import '../module_main/repository/home_repository.dart' as _i56;
import '../module_main/sceen/home_screen.dart' as _i180;
import '../module_main/sceen/main_screen.dart' as _i27;
import '../module_main/service/home_service.dart' as _i105;
import '../module_main/state_manager/home_state_manager.dart' as _i106;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i110;
import '../module_my_notifications/my_notifications_module.dart' as _i28;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i58;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i111;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i112;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i151;
import '../module_network/http_client/http_client.dart' as _i3;
import '../module_notice/manager/notice_manager.dart' as _i116;
import '../module_notice/notice_module.dart' as _i29;
import '../module_notice/repository/notice_repository.dart' as _i59;
import '../module_notice/service/notice_service.dart' as _i117;
import '../module_notice/state_manager/notice_state_manager.dart' as _i118;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i30;
import '../module_notifications/repository/notification_repo.dart' as _i60;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i102;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i23;
import '../module_orders/hive/order_hive_helper.dart' as _i32;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i62;
import '../module_orders/orders_module.dart' as _i33;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i61;
import '../module_orders/service/orders/orders.service.dart' as _i63;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i114;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i113;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i77;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i119;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i120;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i121;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i125;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i122;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i123;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i126;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i124;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i65;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i67;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i72;
import '../module_payments/manager/payments_manager.dart' as _i129;
import '../module_payments/payments_module.dart' as _i34;
import '../module_payments/repository/payments_repository.dart' as _i64;
import '../module_payments/service/payments_service.dart' as _i130;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i160;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i161;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i162;
import '../module_payments/state_manager/captain_payment_state_manager.dart'
    as _i164;
import '../module_payments/state_manager/captain_previous_payments.dart'
    as _i165;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i131;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i139;
import '../module_settings/settings_module.dart' as _i134;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i50;
import '../module_settings/ui/settings_page/settings_page.dart' as _i68;
import '../module_splash/splash_module.dart' as _i135;
import '../module_splash/ui/screen/splash_screen.dart' as _i69;
import '../module_statistics/manager/statistic_manager.dart' as _i136;
import '../module_statistics/repository/statistics_repository.dart' as _i70;
import '../module_statistics/service/statistics_service.dart' as _i137;
import '../module_statistics/state_manager/statistics_state_manager.dart'
    as _i138;
import '../module_statistics/ui/statistics_module.dart' as _i35;
import '../module_stores/hive/store_hive_helper.dart' as _i36;
import '../module_stores/manager/stores_manager.dart' as _i140;
import '../module_stores/repository/stores_repository.dart' as _i71;
import '../module_stores/service/store_service.dart' as _i141;
import '../module_stores/state_manager/edit_store_setting_state_manager.dart'
    as _i177;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i179;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i186;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i187;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i188;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i189;
import '../module_stores/state_manager/store_dues_state_manager.dart' as _i191;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i193;
import '../module_stores/state_manager/stores_dues_state_manager.dart' as _i197;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i198;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i199;
import '../module_stores/state_manager/stores_state_manager.dart' as _i142;
import '../module_stores/state_manager/top_active_store.dart' as _i150;
import '../module_stores/stores_module.dart' as _i37;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i143;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i73;
import '../module_subscriptions/service/subscriptions_service.dart' as _i144;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i178;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i183;
import '../module_subscriptions/state_manager/receipts_state_manager.dart'
    as _i190;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i192;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i194;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i195;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i196;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i200;
import '../module_subscriptions/subscriptions_module.dart' as _i38;
import '../module_supplier/manager/supplier_manager.dart' as _i76;
import '../module_supplier/repository/supplier_repository.dart' as _i75;
import '../module_supplier/service/supplier_service.dart' as _i148;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i181;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i201;
import '../module_supplier/state_manager/supplier_list.dart' as _i149;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i203;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i204;
import '../module_supplier/supplier_module.dart' as _i215;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i210;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i211;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i205;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i213;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i214;
import '../module_supplier_categories/categories_supplier_module.dart' as _i212;
import '../module_supplier_categories/manager/categories_manager.dart' as _i145;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i74;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i146;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i147;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i202;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i39;
import '../module_theme/service/theme_service/theme_service.dart' as _i41;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i78;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i40;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i107;
import '../utils/global/global_state_manager.dart' as _i22;
import '../utils/helpers/firestore_helper.dart' as _i21;
import '../utils/logger/logger.dart' as _i26;

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
  gh.factory<_i7.BidOrderModule>(() => _i7.BidOrderModule());
  gh.factory<_i8.BidOrdersScreen>(() => _i8.BidOrdersScreen());
  gh.factory<_i9.BranchesModule>(() => _i9.BranchesModule());
  gh.factory<_i10.CaptainAssignOrderScreen>(
      () => _i10.CaptainAssignOrderScreen());
  gh.factory<_i11.CaptainDuesScreen>(() => _i11.CaptainDuesScreen());
  gh.factory<_i12.CaptainsHiveHelper>(() => _i12.CaptainsHiveHelper());
  gh.factory<_i13.CaptainsModule>(() => _i13.CaptainsModule());
  gh.factory<_i14.CaptainsNeedsSupportScreen>(
      () => _i14.CaptainsNeedsSupportScreen());
  gh.factory<_i15.CarsModule>(() => _i15.CarsModule());
  gh.factory<_i16.CategoriesModule>(() => _i16.CategoriesModule());
  gh.factory<_i17.ChatHiveHelper>(() => _i17.ChatHiveHelper());
  gh.factory<_i18.ChatHiveHelper>(() => _i18.ChatHiveHelper());
  gh.factory<_i19.CompanyModule>(() => _i19.CompanyModule());
  gh.factory<_i20.ExternalDeliveryCompaniesModule>(
      () => _i20.ExternalDeliveryCompaniesModule());
  gh.factory<_i21.FireStoreHelper>(() => _i21.FireStoreHelper());
  gh.singleton<_i22.GlobalStateManager>(_i22.GlobalStateManager());
  gh.factory<_i23.LocalNotificationService>(
      () => _i23.LocalNotificationService());
  gh.factory<_i24.LocalizationPreferencesHelper>(
      () => _i24.LocalizationPreferencesHelper());
  gh.factory<_i25.LocalizationService>(
      () => _i25.LocalizationService(gh<_i24.LocalizationPreferencesHelper>()));
  gh.factory<_i26.Logger>(() => _i26.Logger());
  gh.factory<_i27.MainScreen>(() => _i27.MainScreen());
  gh.factory<_i28.MyNotificationsModule>(() => _i28.MyNotificationsModule());
  gh.factory<_i29.NoticeModule>(() => _i29.NoticeModule());
  gh.factory<_i30.NotificationsPrefHelper>(
      () => _i30.NotificationsPrefHelper());
  gh.factory<_i31.OrderHiveHelper>(() => _i31.OrderHiveHelper());
  gh.factory<_i32.OrderHiveHelper>(() => _i32.OrderHiveHelper());
  gh.factory<_i33.OrdersModule>(() => _i33.OrdersModule());
  gh.factory<_i34.PaymentsModule>(() => _i34.PaymentsModule());
  gh.factory<_i35.StatisticsModule>(() => _i35.StatisticsModule());
  gh.factory<_i36.StoresHiveHelper>(() => _i36.StoresHiveHelper());
  gh.factory<_i37.StoresModule>(() => _i37.StoresModule());
  gh.factory<_i38.SubscriptionsModule>(() => _i38.SubscriptionsModule());
  gh.factory<_i39.ThemePreferencesHelper>(() => _i39.ThemePreferencesHelper());
  gh.factory<_i40.UploadRepository>(() => _i40.UploadRepository());
  gh.factory<_i41.AppThemeDataService>(
      () => _i41.AppThemeDataService(gh<_i39.ThemePreferencesHelper>()));
  gh.factory<_i42.AuthManager>(
      () => _i42.AuthManager(gh<_i6.AuthRepository>()));
  gh.factory<_i43.AuthService>(() => _i43.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i42.AuthManager>(),
      ));
  gh.factory<_i44.BidOrderRepository>(() => _i44.BidOrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i45.BranchesRepository>(() => _i45.BranchesRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i46.CaptainsRepository>(() => _i46.CaptainsRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i47.CategoriesRepository>(() => _i47.CategoriesRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i48.Chat2Repository>(() => _i48.Chat2Repository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i49.ChatRepository>(() => _i49.ChatRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i50.ChooseLocalScreen>(
      () => _i50.ChooseLocalScreen(gh<_i25.LocalizationService>()));
  gh.factory<_i51.CompanyRepository>(() => _i51.CompanyRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i52.DeepLinkRepository>(() => _i52.DeepLinkRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i53.DevRepository>(() => _i53.DevRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i54.ExternalDeliveryCompaniesRepository>(
      () => _i54.ExternalDeliveryCompaniesRepository(
            gh<_i3.ApiClient>(),
            gh<_i43.AuthService>(),
          ));
  gh.factory<_i55.ForgotPassStateManager>(
      () => _i55.ForgotPassStateManager(gh<_i43.AuthService>()));
  gh.factory<_i56.HomeRepository>(() => _i56.HomeRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i57.LoginStateManager>(
      () => _i57.LoginStateManager(gh<_i43.AuthService>()));
  gh.factory<_i58.MyNotificationsRepository>(
      () => _i58.MyNotificationsRepository(
            gh<_i3.ApiClient>(),
            gh<_i43.AuthService>(),
          ));
  gh.factory<_i59.NoticeRepository>(() => _i59.NoticeRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i60.NotificationRepo>(() => _i60.NotificationRepo(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i61.OrderRepository>(() => _i61.OrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i62.OrdersManager>(
      () => _i62.OrdersManager(gh<_i61.OrderRepository>()));
  gh.factory<_i63.OrdersService>(
      () => _i63.OrdersService(gh<_i62.OrdersManager>()));
  gh.factory<_i64.PaymentsRepository>(() => _i64.PaymentsRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i65.RecycleOrderStateManager>(
      () => _i65.RecycleOrderStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i66.RegisterStateManager>(
      () => _i66.RegisterStateManager(gh<_i43.AuthService>()));
  gh.factory<_i67.SearchForOrderStateManager>(
      () => _i67.SearchForOrderStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i68.SettingsScreen>(() => _i68.SettingsScreen(
        gh<_i43.AuthService>(),
        gh<_i25.LocalizationService>(),
        gh<_i41.AppThemeDataService>(),
      ));
  gh.factory<_i69.SplashScreen>(
      () => _i69.SplashScreen(gh<_i43.AuthService>()));
  gh.factory<_i70.StatisticsRepository>(() => _i70.StatisticsRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i71.StoresRepository>(() => _i71.StoresRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i72.SubOrdersStateManager>(
      () => _i72.SubOrdersStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i73.SubscriptionsRepository>(() => _i73.SubscriptionsRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i74.SupplierCategoriesRepository>(
      () => _i74.SupplierCategoriesRepository(
            gh<_i3.ApiClient>(),
            gh<_i43.AuthService>(),
          ));
  gh.factory<_i75.SupplierRepository>(() => _i75.SupplierRepository(
        gh<_i3.ApiClient>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i76.SuppliersManager>(
      () => _i76.SuppliersManager(gh<_i75.SupplierRepository>()));
  gh.factory<_i77.UpdateOrderStateManager>(
      () => _i77.UpdateOrderStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i78.UploadManager>(
      () => _i78.UploadManager(gh<_i40.UploadRepository>()));
  gh.factory<_i79.BidOrderManager>(
      () => _i79.BidOrderManager(gh<_i44.BidOrderRepository>()));
  gh.factory<_i80.BidOrderService>(
      () => _i80.BidOrderService(gh<_i79.BidOrderManager>()));
  gh.factory<_i81.BidOrderStateManager>(
      () => _i81.BidOrderStateManager(gh<_i80.BidOrderService>()));
  gh.factory<_i82.BranchesManager>(
      () => _i82.BranchesManager(gh<_i45.BranchesRepository>()));
  gh.factory<_i83.CaptainsManager>(
      () => _i83.CaptainsManager(gh<_i46.CaptainsRepository>()));
  gh.factory<_i84.CaptainsService>(
      () => _i84.CaptainsService(gh<_i83.CaptainsManager>()));
  gh.factory<_i85.CaptainsStateManager>(
      () => _i85.CaptainsStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i86.CategoriesManager>(
      () => _i86.CategoriesManager(gh<_i47.CategoriesRepository>()));
  gh.factory<_i87.CategoriesService>(
      () => _i87.CategoriesService(gh<_i86.CategoriesManager>()));
  gh.factory<_i88.Chat2Manager>(
      () => _i88.Chat2Manager(gh<_i48.Chat2Repository>()));
  gh.factory<_i89.Chat2Service>(
      () => _i89.Chat2Service(gh<_i88.Chat2Manager>()));
  gh.factory<_i90.Chat2StateManager>(
      () => _i90.Chat2StateManager(gh<_i89.Chat2Service>()));
  gh.factory<_i91.ChatManager>(
      () => _i91.ChatManager(gh<_i49.ChatRepository>()));
  gh.factory<_i92.ChatService>(() => _i92.ChatService(gh<_i91.ChatManager>()));
  gh.factory<_i93.ChatStateManager>(
      () => _i93.ChatStateManager(gh<_i92.ChatService>()));
  gh.factory<_i94.CompanyManager>(
      () => _i94.CompanyManager(gh<_i51.CompanyRepository>()));
  gh.factory<_i95.CompanyService>(
      () => _i95.CompanyService(gh<_i94.CompanyManager>()));
  gh.factory<_i96.DevManager>(() => _i96.DevManager(gh<_i53.DevRepository>()));
  gh.factory<_i97.DevService>(() => _i97.DevService(gh<_i96.DevManager>()));
  gh.factory<_i98.ExternalDeliveryCompaniesManager>(() =>
      _i98.ExternalDeliveryCompaniesManager(
          gh<_i54.ExternalDeliveryCompaniesRepository>()));
  gh.factory<_i99.ExternalDeliveryCompaniesService>(() =>
      _i99.ExternalDeliveryCompaniesService(
          gh<_i98.ExternalDeliveryCompaniesManager>()));
  gh.factory<_i100.ExternalDeliveryCompaniesStateManager>(() =>
      _i100.ExternalDeliveryCompaniesStateManager(
          gh<_i99.ExternalDeliveryCompaniesService>()));
  gh.factory<_i101.ExternalOrdersStateManager>(() =>
      _i101.ExternalOrdersStateManager(
          gh<_i99.ExternalDeliveryCompaniesService>()));
  gh.factory<_i102.FireNotificationService>(
      () => _i102.FireNotificationService(gh<_i60.NotificationRepo>()));
  gh.factory<_i103.ForgotPassScreen>(
      () => _i103.ForgotPassScreen(gh<_i55.ForgotPassStateManager>()));
  gh.factory<_i104.HomeManager>(
      () => _i104.HomeManager(gh<_i56.HomeRepository>()));
  gh.factory<_i105.HomeService>(
      () => _i105.HomeService(gh<_i104.HomeManager>()));
  gh.factory<_i106.HomeStateManager>(
      () => _i106.HomeStateManager(gh<_i105.HomeService>()));
  gh.factory<_i107.ImageUploadService>(
      () => _i107.ImageUploadService(gh<_i78.UploadManager>()));
  gh.factory<_i108.InActiveCaptainsStateManager>(
      () => _i108.InActiveCaptainsStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i109.LoginScreen>(
      () => _i109.LoginScreen(gh<_i57.LoginStateManager>()));
  gh.factory<_i110.MyNotificationsManager>(
      () => _i110.MyNotificationsManager(gh<_i58.MyNotificationsRepository>()));
  gh.factory<_i111.MyNotificationsService>(
      () => _i111.MyNotificationsService(gh<_i110.MyNotificationsManager>()));
  gh.factory<_i112.MyNotificationsStateManager>(
      () => _i112.MyNotificationsStateManager(
            gh<_i111.MyNotificationsService>(),
            gh<_i43.AuthService>(),
          ));
  gh.factory<_i113.NewOrderLinkStateManager>(
      () => _i113.NewOrderLinkStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i114.NewOrderStateManager>(
      () => _i114.NewOrderStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i115.NewTestOrderStateManager>(
      () => _i115.NewTestOrderStateManager(gh<_i97.DevService>()));
  gh.factory<_i116.NoticeManager>(
      () => _i116.NoticeManager(gh<_i59.NoticeRepository>()));
  gh.factory<_i117.NoticeService>(
      () => _i117.NoticeService(gh<_i116.NoticeManager>()));
  gh.factory<_i118.NoticeStateManager>(
      () => _i118.NoticeStateManager(gh<_i117.NoticeService>()));
  gh.factory<_i119.OrderActionLogsStateManager>(
      () => _i119.OrderActionLogsStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i120.OrderCaptainLogsStateManager>(
      () => _i120.OrderCaptainLogsStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i121.OrderCashCaptainStateManager>(
      () => _i121.OrderCashCaptainStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i122.OrderDistanceConflictStateManager>(
      () => _i122.OrderDistanceConflictStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i123.OrderPendingStateManager>(
      () => _i123.OrderPendingStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i124.OrderWithoutDistanceStateManager>(
      () => _i124.OrderWithoutDistanceStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i125.OrdersCashStoreStateManager>(
      () => _i125.OrdersCashStoreStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i126.OrdersReceiveCashStateManager>(
      () => _i126.OrdersReceiveCashStateManager(gh<_i63.OrdersService>()));
  gh.factory<_i127.PackageCategoriesStateManager>(
      () => _i127.PackageCategoriesStateManager(gh<_i87.CategoriesService>()));
  gh.factory<_i128.PackagesStateManager>(
      () => _i128.PackagesStateManager(gh<_i87.CategoriesService>()));
  gh.factory<_i129.PaymentsManager>(
      () => _i129.PaymentsManager(gh<_i64.PaymentsRepository>()));
  gh.factory<_i130.PaymentsService>(
      () => _i130.PaymentsService(gh<_i129.PaymentsManager>()));
  gh.factory<_i131.PaymentsToCaptainStateManager>(
      () => _i131.PaymentsToCaptainStateManager(gh<_i130.PaymentsService>()));
  gh.factory<_i132.PlanScreenStateManager>(
      () => _i132.PlanScreenStateManager(gh<_i130.PaymentsService>()));
  gh.factory<_i133.RegisterScreen>(
      () => _i133.RegisterScreen(gh<_i66.RegisterStateManager>()));
  gh.factory<_i134.SettingsModule>(() => _i134.SettingsModule(
        gh<_i68.SettingsScreen>(),
        gh<_i50.ChooseLocalScreen>(),
      ));
  gh.factory<_i135.SplashModule>(
      () => _i135.SplashModule(gh<_i69.SplashScreen>()));
  gh.factory<_i136.StatisticManager>(
      () => _i136.StatisticManager(gh<_i70.StatisticsRepository>()));
  gh.factory<_i137.StatisticsService>(
      () => _i137.StatisticsService(gh<_i136.StatisticManager>()));
  gh.factory<_i138.StatisticsStateManager>(
      () => _i138.StatisticsStateManager(gh<_i137.StatisticsService>()));
  gh.factory<_i139.StoreBalanceStateManager>(
      () => _i139.StoreBalanceStateManager(gh<_i130.PaymentsService>()));
  gh.factory<_i140.StoreManager>(
      () => _i140.StoreManager(gh<_i71.StoresRepository>()));
  gh.factory<_i141.StoresService>(
      () => _i141.StoresService(gh<_i140.StoreManager>()));
  gh.factory<_i142.StoresStateManager>(() => _i142.StoresStateManager(
        gh<_i141.StoresService>(),
        gh<_i107.ImageUploadService>(),
      ));
  gh.factory<_i143.SubscriptionsManager>(
      () => _i143.SubscriptionsManager(gh<_i73.SubscriptionsRepository>()));
  gh.factory<_i144.SubscriptionsService>(
      () => _i144.SubscriptionsService(gh<_i143.SubscriptionsManager>()));
  gh.factory<_i145.SupplierCategoriesManager>(() =>
      _i145.SupplierCategoriesManager(gh<_i74.SupplierCategoriesRepository>()));
  gh.factory<_i146.SupplierCategoriesService>(() =>
      _i146.SupplierCategoriesService(gh<_i145.SupplierCategoriesManager>()));
  gh.factory<_i147.SupplierCategoriesStateManager>(
      () => _i147.SupplierCategoriesStateManager(
            gh<_i146.SupplierCategoriesService>(),
            gh<_i107.ImageUploadService>(),
          ));
  gh.factory<_i148.SupplierService>(
      () => _i148.SupplierService(gh<_i76.SuppliersManager>()));
  gh.factory<_i149.SuppliersStateManager>(
      () => _i149.SuppliersStateManager(gh<_i148.SupplierService>()));
  gh.factory<_i150.TopActiveStateManagement>(
      () => _i150.TopActiveStateManagement(gh<_i141.StoresService>()));
  gh.factory<_i151.UpdatesStateManager>(() => _i151.UpdatesStateManager(
        gh<_i111.MyNotificationsService>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i152.AssignOrderToExternalCompanyStateManager>(() =>
      _i152.AssignOrderToExternalCompanyStateManager(
          gh<_i99.ExternalDeliveryCompaniesService>()));
  gh.factory<_i153.AuthorizationModule>(() => _i153.AuthorizationModule(
        gh<_i109.LoginScreen>(),
        gh<_i133.RegisterScreen>(),
        gh<_i103.ForgotPassScreen>(),
      ));
  gh.factory<_i154.BidOrderDetailsScreen>(
      () => _i154.BidOrderDetailsScreen(gh<_i81.BidOrderStateManager>()));
  gh.factory<_i155.BranchesListService>(
      () => _i155.BranchesListService(gh<_i82.BranchesManager>()));
  gh.factory<_i156.BranchesListStateManager>(
      () => _i156.BranchesListStateManager(gh<_i155.BranchesListService>()));
  gh.factory<_i157.CaptainActivityDetailsStateManager>(() =>
      _i157.CaptainActivityDetailsStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i158.CaptainAssignOrderStateManager>(
      () => _i158.CaptainAssignOrderStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i159.CaptainDuesStateManager>(
      () => _i159.CaptainDuesStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i160.CaptainFinanceByHoursStateManager>(() =>
      _i160.CaptainFinanceByHoursStateManager(gh<_i130.PaymentsService>()));
  gh.factory<_i161.CaptainFinanceByOrderCountStateManager>(() =>
      _i161.CaptainFinanceByOrderCountStateManager(
          gh<_i130.PaymentsService>()));
  gh.factory<_i162.CaptainFinanceByOrderStateManager>(() =>
      _i162.CaptainFinanceByOrderStateManager(gh<_i130.PaymentsService>()));
  gh.factory<_i163.CaptainOfferStateManager>(
      () => _i163.CaptainOfferStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i164.CaptainPaymentStateManager>(
      () => _i164.CaptainPaymentStateManager(gh<_i130.PaymentsService>()));
  gh.factory<_i165.CaptainPreviousPaymentsStateManager>(() =>
      _i165.CaptainPreviousPaymentsStateManager(gh<_i130.PaymentsService>()));
  gh.factory<_i166.CaptainProfileStateManager>(
      () => _i166.CaptainProfileStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i167.CaptainRatingDetailsStateManager>(
      () => _i167.CaptainRatingDetailsStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i168.CaptainsActivityStateManager>(
      () => _i168.CaptainsActivityStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i169.CaptainsNeedsSupportStateManager>(
      () => _i169.CaptainsNeedsSupportStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i170.CaptainsRatingStateManager>(
      () => _i170.CaptainsRatingStateManager(gh<_i84.CaptainsService>()));
  gh.factory<_i171.Chat2Page>(() => _i171.Chat2Page(
        gh<_i90.Chat2StateManager>(),
        gh<_i107.ImageUploadService>(),
        gh<_i43.AuthService>(),
        gh<_i18.ChatHiveHelper>(),
      ));
  gh.factory<_i172.ChatPage>(() => _i172.ChatPage(
        gh<_i93.ChatStateManager>(),
        gh<_i107.ImageUploadService>(),
        gh<_i43.AuthService>(),
        gh<_i17.ChatHiveHelper>(),
      ));
  gh.factory<_i173.CompanyFinanceStateManager>(
      () => _i173.CompanyFinanceStateManager(gh<_i95.CompanyService>()));
  gh.factory<_i174.CompanyProfileStateManager>(
      () => _i174.CompanyProfileStateManager(gh<_i95.CompanyService>()));
  gh.factory<_i175.DeliveryCompanyAllSettingsStateManager>(() =>
      _i175.DeliveryCompanyAllSettingsStateManager(
          gh<_i99.ExternalDeliveryCompaniesService>()));
  gh.factory<_i176.EditDeliveryCompanySettingScreenStateManager>(() =>
      _i176.EditDeliveryCompanySettingScreenStateManager(
          gh<_i99.ExternalDeliveryCompaniesService>()));
  gh.factory<_i177.EditStoreSettingStateManager>(
      () => _i177.EditStoreSettingStateManager(
            gh<_i141.StoresService>(),
            gh<_i107.ImageUploadService>(),
          ));
  gh.factory<_i178.EditSubscriptionStateManager>(() =>
      _i178.EditSubscriptionStateManager(gh<_i144.SubscriptionsService>()));
  gh.factory<_i179.FilterOrderTopStateManager>(
      () => _i179.FilterOrderTopStateManager(gh<_i141.StoresService>()));
  gh.factory<_i180.HomeScreen>(
      () => _i180.HomeScreen(gh<_i106.HomeStateManager>()));
  gh.factory<_i181.InActiveSupplierStateManager>(
      () => _i181.InActiveSupplierStateManager(gh<_i148.SupplierService>()));
  gh.factory<_i182.InitBranchesStateManager>(
      () => _i182.InitBranchesStateManager(gh<_i155.BranchesListService>()));
  gh.factory<_i183.InitSubscriptionStateManager>(() =>
      _i183.InitSubscriptionStateManager(gh<_i144.SubscriptionsService>()));
  gh.factory<_i184.MainModule>(() => _i184.MainModule(
        gh<_i27.MainScreen>(),
        gh<_i180.HomeScreen>(),
      ));
  gh.factory<_i185.NewTestOrderScreen>(
      () => _i185.NewTestOrderScreen(gh<_i115.NewTestOrderStateManager>()));
  gh.factory<_i186.OrderCaptainNotArrivedStateManager>(() =>
      _i186.OrderCaptainNotArrivedStateManager(gh<_i141.StoresService>()));
  gh.factory<_i187.OrderLogsStateManager>(
      () => _i187.OrderLogsStateManager(gh<_i141.StoresService>()));
  gh.factory<_i188.OrderStatusStateManager>(
      () => _i188.OrderStatusStateManager(gh<_i141.StoresService>()));
  gh.factory<_i189.OrderTimeLineStateManager>(
      () => _i189.OrderTimeLineStateManager(gh<_i141.StoresService>()));
  gh.factory<_i190.ReceiptsStateManager>(
      () => _i190.ReceiptsStateManager(gh<_i144.SubscriptionsService>()));
  gh.factory<_i191.StoreDuesStateManager>(() => _i191.StoreDuesStateManager(
        gh<_i141.StoresService>(),
        gh<_i130.PaymentsService>(),
      ));
  gh.factory<_i192.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i192.StoreFinancialSubscriptionsDuesDetailsStateManager(
            gh<_i130.PaymentsService>(),
            gh<_i144.SubscriptionsService>(),
          ));
  gh.factory<_i193.StoreProfileStateManager>(
      () => _i193.StoreProfileStateManager(
            gh<_i141.StoresService>(),
            gh<_i107.ImageUploadService>(),
          ));
  gh.factory<_i194.StoreSubscriptionManagementStateManager>(() =>
      _i194.StoreSubscriptionManagementStateManager(
          gh<_i144.SubscriptionsService>()));
  gh.factory<_i195.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i195.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i144.SubscriptionsService>()));
  gh.factory<_i196.StoreSubscriptionsFinanceStateManager>(() =>
      _i196.StoreSubscriptionsFinanceStateManager(
          gh<_i144.SubscriptionsService>()));
  gh.factory<_i197.StoresDuesStateManager>(
      () => _i197.StoresDuesStateManager(gh<_i141.StoresService>()));
  gh.factory<_i198.StoresInActiveStateManager>(
      () => _i198.StoresInActiveStateManager(
            gh<_i141.StoresService>(),
            gh<_i107.ImageUploadService>(),
          ));
  gh.factory<_i199.StoresNeedsSupportStateManager>(
      () => _i199.StoresNeedsSupportStateManager(gh<_i141.StoresService>()));
  gh.factory<_i200.SubscriptionToCaptainOfferStateManager>(() =>
      _i200.SubscriptionToCaptainOfferStateManager(
          gh<_i144.SubscriptionsService>()));
  gh.factory<_i201.SupplierAdsStateManager>(
      () => _i201.SupplierAdsStateManager(gh<_i148.SupplierService>()));
  gh.factory<_i202.SupplierCategoriesScreen>(() =>
      _i202.SupplierCategoriesScreen(
          gh<_i147.SupplierCategoriesStateManager>()));
  gh.factory<_i203.SupplierNeedsSupportStateManager>(() =>
      _i203.SupplierNeedsSupportStateManager(gh<_i148.SupplierService>()));
  gh.factory<_i204.SupplierProfileStateManager>(
      () => _i204.SupplierProfileStateManager(gh<_i148.SupplierService>()));
  gh.factory<_i205.SuppliersScreen>(
      () => _i205.SuppliersScreen(gh<_i149.SuppliersStateManager>()));
  gh.factory<_i206.UpdateBranchStateManager>(
      () => _i206.UpdateBranchStateManager(gh<_i155.BranchesListService>()));
  gh.factory<_i207.Chat2Module>(() => _i207.Chat2Module(
        gh<_i171.Chat2Page>(),
        gh<_i43.AuthService>(),
      ));
  gh.factory<_i208.ChatModule>(() => _i208.ChatModule(
        gh<_i172.ChatPage>(),
        gh<_i171.Chat2Page>(),
      ));
  gh.factory<_i209.DevModule>(
      () => _i209.DevModule(gh<_i185.NewTestOrderScreen>()));
  gh.factory<_i210.InActiveSupplierScreen>(() =>
      _i210.InActiveSupplierScreen(gh<_i181.InActiveSupplierStateManager>()));
  gh.factory<_i211.SupplierAdsScreen>(
      () => _i211.SupplierAdsScreen(gh<_i201.SupplierAdsStateManager>()));
  gh.factory<_i212.SupplierCategoriesModule>(() =>
      _i212.SupplierCategoriesModule(gh<_i202.SupplierCategoriesScreen>()));
  gh.factory<_i213.SupplierNeedsSupportScreen>(() =>
      _i213.SupplierNeedsSupportScreen(
          gh<_i203.SupplierNeedsSupportStateManager>()));
  gh.factory<_i214.SupplierProfileScreen>(() =>
      _i214.SupplierProfileScreen(gh<_i204.SupplierProfileStateManager>()));
  gh.factory<_i215.SupplierModule>(() => _i215.SupplierModule(
        gh<_i210.InActiveSupplierScreen>(),
        gh<_i205.SuppliersScreen>(),
        gh<_i214.SupplierProfileScreen>(),
        gh<_i213.SupplierNeedsSupportScreen>(),
        gh<_i211.SupplierAdsScreen>(),
      ));
  gh.factory<_i216.MyApp>(() => _i216.MyApp(
        gh<_i41.AppThemeDataService>(),
        gh<_i25.LocalizationService>(),
        gh<_i102.FireNotificationService>(),
        gh<_i23.LocalNotificationService>(),
        gh<_i135.SplashModule>(),
        gh<_i153.AuthorizationModule>(),
        gh<_i208.ChatModule>(),
        gh<_i134.SettingsModule>(),
        gh<_i184.MainModule>(),
        gh<_i37.StoresModule>(),
        gh<_i16.CategoriesModule>(),
        gh<_i19.CompanyModule>(),
        gh<_i9.BranchesModule>(),
        gh<_i29.NoticeModule>(),
        gh<_i13.CaptainsModule>(),
        gh<_i34.PaymentsModule>(),
        gh<_i212.SupplierCategoriesModule>(),
        gh<_i215.SupplierModule>(),
        gh<_i15.CarsModule>(),
        gh<_i7.BidOrderModule>(),
        gh<_i33.OrdersModule>(),
        gh<_i38.SubscriptionsModule>(),
        gh<_i28.MyNotificationsModule>(),
        gh<_i35.StatisticsModule>(),
        gh<_i209.DevModule>(),
        gh<_i20.ExternalDeliveryCompaniesModule>(),
      ));
  return getIt;
}

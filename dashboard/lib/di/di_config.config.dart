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
import '../main.dart' as _i226;
import '../module_auth/authoriazation_module.dart' as _i142;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i34;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i6;
import '../module_auth/service/auth_service/auth_service.dart' as _i35;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i46;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i48;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i57;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i92;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i98;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i122;
import '../module_bid_order/bid_order_module.dart' as _i144;
import '../module_bid_order/manager/bid_order_manager.dart' as _i70;
import '../module_bid_order/repository/bid_order_repository.dart' as _i36;
import '../module_bid_order/service/bid_order_service.dart' as _i71;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i72;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i73;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i143;
import '../module_branches/branches_module.dart' as _i223;
import '../module_branches/manager/branches_manager.dart' as _i74;
import '../module_branches/repository/branches_repository.dart' as _i37;
import '../module_branches/service/branches_list_service.dart' as _i145;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i146;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i172;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i200;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i202;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i212;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i222;
import '../module_captain/captains_module.dart' as _i10;
import '../module_captain/hive/captain_hive_helper.dart' as _i9;
import '../module_captain/manager/captains_manager.dart' as _i75;
import '../module_captain/repository/captains_repository.dart' as _i38;
import '../module_captain/service/captains_service.dart' as _i76;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i147;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i158;
import '../module_captain/state_manager/captain_dues_state_manager.dart'
    as _i149;
import '../module_captain/state_manager/captain_list.dart' as _i77;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i159;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i153;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i148;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i156;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i160;
import '../module_captain/state_manager/caption_rating_details_state_manager.dart'
    as _i157;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i97;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i121;
import '../module_captain/ui/screen/captain_dues_screen.dart' as _i8;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i11;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i7;
import '../module_categories/categories_module.dart' as _i203;
import '../module_categories/manager/categories_manager.dart' as _i78;
import '../module_categories/repository/categories_repository.dart' as _i39;
import '../module_categories/service/store_categories_service.dart' as _i79;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i116;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i117;
import '../module_categories/ui/screen/categories_screen.dart' as _i161;
import '../module_categories/ui/screen/packages_screen.dart' as _i181;
import '../module_chat/chat_module.dart' as _i204;
import '../module_chat/manager/chat/chat_manager.dart' as _i80;
import '../module_chat/presistance/chat_hive_helper.dart' as _i13;
import '../module_chat/repository/chat/chat_repository.dart' as _i40;
import '../module_chat/service/chat/char_service.dart' as _i81;
import '../module_chat/state_manager/chat_state_manager.dart' as _i82;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i162;
import '../module_company/company_module.dart' as _i224;
import '../module_company/manager/company_manager.dart' as _i83;
import '../module_company/repository/company_repository.dart' as _i42;
import '../module_company/service/company_service.dart' as _i84;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i163;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i164;
import '../module_company/ui/screen/company_finance_screen.dart' as _i205;
import '../module_company/ui/screen/company_profile_screen.dart' as _i206;
import '../module_deep_links/repository/deep_link_repository.dart' as _i43;
import '../module_delivary_car/cars_module.dart' as _i12;
import '../module_dev/dev_module.dart' as _i209;
import '../module_dev/hive/order_hive_helper.dart' as _i25;
import '../module_dev/manager/dev_manager.dart' as _i85;
import '../module_dev/repository/dev_repository.dart' as _i44;
import '../module_dev/service/orders/dev.service.dart' as _i86;
import '../module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i104;
import '../module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i176;
import '../module_external_delivery_companies/external_delivery_companies_module.dart'
    as _i14;
import '../module_external_delivery_companies/manager/external_delivery_companies_manager.dart'
    as _i87;
import '../module_external_delivery_companies/repository/external_delivery_companies_repository.dart'
    as _i45;
import '../module_external_delivery_companies/service/external_delivery_companies_service.dart'
    as _i88;
import '../module_external_delivery_companies/state_manager/assign_order_to_external_company_state_manager.dart'
    as _i141;
import '../module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart'
    as _i165;
import '../module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart'
    as _i166;
import '../module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart'
    as _i89;
import '../module_external_delivery_companies/state_manager/external_orders_state_manager.dart'
    as _i90;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i18;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i19;
import '../module_main/main_module.dart' as _i174;
import '../module_main/manager/home_manager.dart' as _i93;
import '../module_main/repository/home_repository.dart' as _i47;
import '../module_main/sceen/home_screen.dart' as _i170;
import '../module_main/sceen/main_screen.dart' as _i21;
import '../module_main/service/home_service.dart' as _i94;
import '../module_main/state_manager/home_state_manager.dart' as _i95;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i99;
import '../module_my_notifications/my_notifications_module.dart' as _i213;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i49;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i100;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i101;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i140;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i175;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i201;
import '../module_network/http_client/http_client.dart' as _i3;
import '../module_notice/manager/notice_manager.dart' as _i105;
import '../module_notice/notice_module.dart' as _i22;
import '../module_notice/repository/notice_repository.dart' as _i50;
import '../module_notice/service/notice_service.dart' as _i106;
import '../module_notice/state_manager/notice_state_manager.dart' as _i107;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i23;
import '../module_notifications/repository/notification_repo.dart' as _i51;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i91;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i17;
import '../module_orders/hive/order_hive_helper.dart' as _i24;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i53;
import '../module_orders/orders_module.dart' as _i26;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i52;
import '../module_orders/service/orders/orders.service.dart' as _i54;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i103;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i102;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i68;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i108;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i109;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i110;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i114;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i111;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i112;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i115;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i113;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i56;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i58;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i63;
import '../module_payments/manager/payments_manager.dart' as _i118;
import '../module_payments/payments_module.dart' as _i27;
import '../module_payments/repository/payments_repository.dart' as _i55;
import '../module_payments/service/payments_service.dart' as _i119;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i150;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i151;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i152;
import '../module_payments/state_manager/captain_payment_state_manager.dart'
    as _i154;
import '../module_payments/state_manager/captain_previous_payments.dart'
    as _i155;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i120;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i128;
import '../module_settings/settings_module.dart' as _i123;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i41;
import '../module_settings/ui/settings_page/settings_page.dart' as _i59;
import '../module_splash/splash_module.dart' as _i124;
import '../module_splash/ui/screen/splash_screen.dart' as _i60;
import '../module_statistics/manager/statistic_manager.dart' as _i125;
import '../module_statistics/repository/statistics_repository.dart' as _i61;
import '../module_statistics/service/statistics_service.dart' as _i126;
import '../module_statistics/state_manager/statistics_state_manager.dart'
    as _i127;
import '../module_statistics/ui/statistics_module.dart' as _i28;
import '../module_stores/hive/store_hive_helper.dart' as _i29;
import '../module_stores/manager/stores_manager.dart' as _i129;
import '../module_stores/repository/stores_repository.dart' as _i62;
import '../module_stores/service/store_service.dart' as _i130;
import '../module_stores/state_manager/edit_store_setting_state_manager.dart'
    as _i167;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i169;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i177;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i178;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i179;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i180;
import '../module_stores/state_manager/store_dues_state_manager.dart' as _i183;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i185;
import '../module_stores/state_manager/stores_dues_state_manager.dart' as _i190;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i191;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i192;
import '../module_stores/state_manager/stores_state_manager.dart' as _i131;
import '../module_stores/state_manager/top_active_store.dart' as _i139;
import '../module_stores/stores_module.dart' as _i30;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i132;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i64;
import '../module_subscriptions/service/subscriptions_service.dart' as _i133;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i168;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i173;
import '../module_subscriptions/state_manager/receipts_state_manager.dart'
    as _i182;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i184;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i186;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i187;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i189;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i194;
import '../module_subscriptions/subscriptions_module.dart' as _i217;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i210;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i207;
import '../module_subscriptions/ui/screen/receipts_screen.dart' as _i214;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i188;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i215;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i216;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i208;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i193;
import '../module_supplier/manager/supplier_manager.dart' as _i67;
import '../module_supplier/repository/supplier_repository.dart' as _i66;
import '../module_supplier/service/supplier_service.dart' as _i137;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i171;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i195;
import '../module_supplier/state_manager/supplier_list.dart' as _i138;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i197;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i198;
import '../module_supplier/supplier_module.dart' as _i225;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i211;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i218;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i199;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i220;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i221;
import '../module_supplier_categories/categories_supplier_module.dart' as _i219;
import '../module_supplier_categories/manager/categories_manager.dart' as _i134;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i65;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i135;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i136;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i196;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i31;
import '../module_theme/service/theme_service/theme_service.dart' as _i33;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i69;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i32;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i96;
import '../utils/global/global_state_manager.dart' as _i16;
import '../utils/helpers/firestore_helper.dart' as _i15;
import '../utils/logger/logger.dart' as _i20;

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
  gh.factory<_i10.CaptainsModule>(() => _i10.CaptainsModule());
  gh.factory<_i11.CaptainsNeedsSupportScreen>(
      () => _i11.CaptainsNeedsSupportScreen());
  gh.factory<_i12.CarsModule>(() => _i12.CarsModule());
  gh.factory<_i13.ChatHiveHelper>(() => _i13.ChatHiveHelper());
  gh.factory<_i14.ExternalDeliveryCompaniesModule>(
      () => _i14.ExternalDeliveryCompaniesModule());
  gh.factory<_i15.FireStoreHelper>(() => _i15.FireStoreHelper());
  gh.singleton<_i16.GlobalStateManager>(_i16.GlobalStateManager());
  gh.factory<_i17.LocalNotificationService>(
      () => _i17.LocalNotificationService());
  gh.factory<_i18.LocalizationPreferencesHelper>(
      () => _i18.LocalizationPreferencesHelper());
  gh.factory<_i19.LocalizationService>(
      () => _i19.LocalizationService(gh<_i18.LocalizationPreferencesHelper>()));
  gh.factory<_i20.Logger>(() => _i20.Logger());
  gh.factory<_i21.MainScreen>(() => _i21.MainScreen());
  gh.factory<_i22.NoticeModule>(() => _i22.NoticeModule());
  gh.factory<_i23.NotificationsPrefHelper>(
      () => _i23.NotificationsPrefHelper());
  gh.factory<_i24.OrderHiveHelper>(() => _i24.OrderHiveHelper());
  gh.factory<_i25.OrderHiveHelper>(() => _i25.OrderHiveHelper());
  gh.factory<_i26.OrdersModule>(() => _i26.OrdersModule());
  gh.factory<_i27.PaymentsModule>(() => _i27.PaymentsModule());
  gh.factory<_i28.StatisticsModule>(() => _i28.StatisticsModule());
  gh.factory<_i29.StoresHiveHelper>(() => _i29.StoresHiveHelper());
  gh.factory<_i30.StoresModule>(() => _i30.StoresModule());
  gh.factory<_i31.ThemePreferencesHelper>(() => _i31.ThemePreferencesHelper());
  gh.factory<_i32.UploadRepository>(() => _i32.UploadRepository());
  gh.factory<_i33.AppThemeDataService>(
      () => _i33.AppThemeDataService(gh<_i31.ThemePreferencesHelper>()));
  gh.factory<_i34.AuthManager>(
      () => _i34.AuthManager(gh<_i6.AuthRepository>()));
  gh.factory<_i35.AuthService>(() => _i35.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i34.AuthManager>(),
      ));
  gh.factory<_i36.BidOrderRepository>(() => _i36.BidOrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i37.BranchesRepository>(() => _i37.BranchesRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i38.CaptainsRepository>(() => _i38.CaptainsRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i39.CategoriesRepository>(() => _i39.CategoriesRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i40.ChatRepository>(() => _i40.ChatRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i41.ChooseLocalScreen>(
      () => _i41.ChooseLocalScreen(gh<_i19.LocalizationService>()));
  gh.factory<_i42.CompanyRepository>(() => _i42.CompanyRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i43.DeepLinkRepository>(() => _i43.DeepLinkRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i44.DevRepository>(() => _i44.DevRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i45.ExternalDeliveryCompaniesRepository>(
      () => _i45.ExternalDeliveryCompaniesRepository(
            gh<_i3.ApiClient>(),
            gh<_i35.AuthService>(),
          ));
  gh.factory<_i46.ForgotPassStateManager>(
      () => _i46.ForgotPassStateManager(gh<_i35.AuthService>()));
  gh.factory<_i47.HomeRepository>(() => _i47.HomeRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i48.LoginStateManager>(
      () => _i48.LoginStateManager(gh<_i35.AuthService>()));
  gh.factory<_i49.MyNotificationsRepository>(
      () => _i49.MyNotificationsRepository(
            gh<_i3.ApiClient>(),
            gh<_i35.AuthService>(),
          ));
  gh.factory<_i50.NoticeRepository>(() => _i50.NoticeRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i51.NotificationRepo>(() => _i51.NotificationRepo(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i52.OrderRepository>(() => _i52.OrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i53.OrdersManager>(
      () => _i53.OrdersManager(gh<_i52.OrderRepository>()));
  gh.factory<_i54.OrdersService>(
      () => _i54.OrdersService(gh<_i53.OrdersManager>()));
  gh.factory<_i55.PaymentsRepository>(() => _i55.PaymentsRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i56.RecycleOrderStateManager>(
      () => _i56.RecycleOrderStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i57.RegisterStateManager>(
      () => _i57.RegisterStateManager(gh<_i35.AuthService>()));
  gh.factory<_i58.SearchForOrderStateManager>(
      () => _i58.SearchForOrderStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i59.SettingsScreen>(() => _i59.SettingsScreen(
        gh<_i35.AuthService>(),
        gh<_i19.LocalizationService>(),
        gh<_i33.AppThemeDataService>(),
      ));
  gh.factory<_i60.SplashScreen>(
      () => _i60.SplashScreen(gh<_i35.AuthService>()));
  gh.factory<_i61.StatisticsRepository>(() => _i61.StatisticsRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i62.StoresRepository>(() => _i62.StoresRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i63.SubOrdersStateManager>(
      () => _i63.SubOrdersStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i64.SubscriptionsRepository>(() => _i64.SubscriptionsRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i65.SupplierCategoriesRepository>(
      () => _i65.SupplierCategoriesRepository(
            gh<_i3.ApiClient>(),
            gh<_i35.AuthService>(),
          ));
  gh.factory<_i66.SupplierRepository>(() => _i66.SupplierRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i67.SuppliersManager>(
      () => _i67.SuppliersManager(gh<_i66.SupplierRepository>()));
  gh.factory<_i68.UpdateOrderStateManager>(
      () => _i68.UpdateOrderStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i69.UploadManager>(
      () => _i69.UploadManager(gh<_i32.UploadRepository>()));
  gh.factory<_i70.BidOrderManager>(
      () => _i70.BidOrderManager(gh<_i36.BidOrderRepository>()));
  gh.factory<_i71.BidOrderService>(
      () => _i71.BidOrderService(gh<_i70.BidOrderManager>()));
  gh.factory<_i72.BidOrderStateManager>(
      () => _i72.BidOrderStateManager(gh<_i71.BidOrderService>()));
  gh.factory<_i73.BidOrdersScreen>(
      () => _i73.BidOrdersScreen(gh<_i72.BidOrderStateManager>()));
  gh.factory<_i74.BranchesManager>(
      () => _i74.BranchesManager(gh<_i37.BranchesRepository>()));
  gh.factory<_i75.CaptainsManager>(
      () => _i75.CaptainsManager(gh<_i38.CaptainsRepository>()));
  gh.factory<_i76.CaptainsService>(
      () => _i76.CaptainsService(gh<_i75.CaptainsManager>()));
  gh.factory<_i77.CaptainsStateManager>(
      () => _i77.CaptainsStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i78.CategoriesManager>(
      () => _i78.CategoriesManager(gh<_i39.CategoriesRepository>()));
  gh.factory<_i79.CategoriesService>(
      () => _i79.CategoriesService(gh<_i78.CategoriesManager>()));
  gh.factory<_i80.ChatManager>(
      () => _i80.ChatManager(gh<_i40.ChatRepository>()));
  gh.factory<_i81.ChatService>(() => _i81.ChatService(gh<_i80.ChatManager>()));
  gh.factory<_i82.ChatStateManager>(
      () => _i82.ChatStateManager(gh<_i81.ChatService>()));
  gh.factory<_i83.CompanyManager>(
      () => _i83.CompanyManager(gh<_i42.CompanyRepository>()));
  gh.factory<_i84.CompanyService>(
      () => _i84.CompanyService(gh<_i83.CompanyManager>()));
  gh.factory<_i85.DevManager>(() => _i85.DevManager(gh<_i44.DevRepository>()));
  gh.factory<_i86.DevService>(() => _i86.DevService(gh<_i85.DevManager>()));
  gh.factory<_i87.ExternalDeliveryCompaniesManager>(() =>
      _i87.ExternalDeliveryCompaniesManager(
          gh<_i45.ExternalDeliveryCompaniesRepository>()));
  gh.factory<_i88.ExternalDeliveryCompaniesService>(() =>
      _i88.ExternalDeliveryCompaniesService(
          gh<_i87.ExternalDeliveryCompaniesManager>()));
  gh.factory<_i89.ExternalDeliveryCompaniesStateManager>(() =>
      _i89.ExternalDeliveryCompaniesStateManager(
          gh<_i88.ExternalDeliveryCompaniesService>()));
  gh.factory<_i90.ExternalOrdersStateManager>(() =>
      _i90.ExternalOrdersStateManager(
          gh<_i88.ExternalDeliveryCompaniesService>()));
  gh.factory<_i91.FireNotificationService>(
      () => _i91.FireNotificationService(gh<_i51.NotificationRepo>()));
  gh.factory<_i92.ForgotPassScreen>(
      () => _i92.ForgotPassScreen(gh<_i46.ForgotPassStateManager>()));
  gh.factory<_i93.HomeManager>(
      () => _i93.HomeManager(gh<_i47.HomeRepository>()));
  gh.factory<_i94.HomeService>(() => _i94.HomeService(gh<_i93.HomeManager>()));
  gh.factory<_i95.HomeStateManager>(
      () => _i95.HomeStateManager(gh<_i94.HomeService>()));
  gh.factory<_i96.ImageUploadService>(
      () => _i96.ImageUploadService(gh<_i69.UploadManager>()));
  gh.factory<_i97.InActiveCaptainsStateManager>(
      () => _i97.InActiveCaptainsStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i98.LoginScreen>(
      () => _i98.LoginScreen(gh<_i48.LoginStateManager>()));
  gh.factory<_i99.MyNotificationsManager>(
      () => _i99.MyNotificationsManager(gh<_i49.MyNotificationsRepository>()));
  gh.factory<_i100.MyNotificationsService>(
      () => _i100.MyNotificationsService(gh<_i99.MyNotificationsManager>()));
  gh.factory<_i101.MyNotificationsStateManager>(
      () => _i101.MyNotificationsStateManager(
            gh<_i100.MyNotificationsService>(),
            gh<_i35.AuthService>(),
          ));
  gh.factory<_i102.NewOrderLinkStateManager>(
      () => _i102.NewOrderLinkStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i103.NewOrderStateManager>(
      () => _i103.NewOrderStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i104.NewTestOrderStateManager>(
      () => _i104.NewTestOrderStateManager(gh<_i86.DevService>()));
  gh.factory<_i105.NoticeManager>(
      () => _i105.NoticeManager(gh<_i50.NoticeRepository>()));
  gh.factory<_i106.NoticeService>(
      () => _i106.NoticeService(gh<_i105.NoticeManager>()));
  gh.factory<_i107.NoticeStateManager>(
      () => _i107.NoticeStateManager(gh<_i106.NoticeService>()));
  gh.factory<_i108.OrderActionLogsStateManager>(
      () => _i108.OrderActionLogsStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i109.OrderCaptainLogsStateManager>(
      () => _i109.OrderCaptainLogsStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i110.OrderCashCaptainStateManager>(
      () => _i110.OrderCashCaptainStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i111.OrderDistanceConflictStateManager>(
      () => _i111.OrderDistanceConflictStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i112.OrderPendingStateManager>(
      () => _i112.OrderPendingStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i113.OrderWithoutDistanceStateManager>(
      () => _i113.OrderWithoutDistanceStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i114.OrdersCashStoreStateManager>(
      () => _i114.OrdersCashStoreStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i115.OrdersReceiveCashStateManager>(
      () => _i115.OrdersReceiveCashStateManager(gh<_i54.OrdersService>()));
  gh.factory<_i116.PackageCategoriesStateManager>(
      () => _i116.PackageCategoriesStateManager(gh<_i79.CategoriesService>()));
  gh.factory<_i117.PackagesStateManager>(
      () => _i117.PackagesStateManager(gh<_i79.CategoriesService>()));
  gh.factory<_i118.PaymentsManager>(
      () => _i118.PaymentsManager(gh<_i55.PaymentsRepository>()));
  gh.factory<_i119.PaymentsService>(
      () => _i119.PaymentsService(gh<_i118.PaymentsManager>()));
  gh.factory<_i120.PaymentsToCaptainStateManager>(
      () => _i120.PaymentsToCaptainStateManager(gh<_i119.PaymentsService>()));
  gh.factory<_i121.PlanScreenStateManager>(
      () => _i121.PlanScreenStateManager(gh<_i119.PaymentsService>()));
  gh.factory<_i122.RegisterScreen>(
      () => _i122.RegisterScreen(gh<_i57.RegisterStateManager>()));
  gh.factory<_i123.SettingsModule>(() => _i123.SettingsModule(
        gh<_i59.SettingsScreen>(),
        gh<_i41.ChooseLocalScreen>(),
      ));
  gh.factory<_i124.SplashModule>(
      () => _i124.SplashModule(gh<_i60.SplashScreen>()));
  gh.factory<_i125.StatisticManager>(
      () => _i125.StatisticManager(gh<_i61.StatisticsRepository>()));
  gh.factory<_i126.StatisticsService>(
      () => _i126.StatisticsService(gh<_i125.StatisticManager>()));
  gh.factory<_i127.StatisticsStateManager>(
      () => _i127.StatisticsStateManager(gh<_i126.StatisticsService>()));
  gh.factory<_i128.StoreBalanceStateManager>(
      () => _i128.StoreBalanceStateManager(gh<_i119.PaymentsService>()));
  gh.factory<_i129.StoreManager>(
      () => _i129.StoreManager(gh<_i62.StoresRepository>()));
  gh.factory<_i130.StoresService>(
      () => _i130.StoresService(gh<_i129.StoreManager>()));
  gh.factory<_i131.StoresStateManager>(() => _i131.StoresStateManager(
        gh<_i130.StoresService>(),
        gh<_i96.ImageUploadService>(),
      ));
  gh.factory<_i132.SubscriptionsManager>(
      () => _i132.SubscriptionsManager(gh<_i64.SubscriptionsRepository>()));
  gh.factory<_i133.SubscriptionsService>(
      () => _i133.SubscriptionsService(gh<_i132.SubscriptionsManager>()));
  gh.factory<_i134.SupplierCategoriesManager>(() =>
      _i134.SupplierCategoriesManager(gh<_i65.SupplierCategoriesRepository>()));
  gh.factory<_i135.SupplierCategoriesService>(() =>
      _i135.SupplierCategoriesService(gh<_i134.SupplierCategoriesManager>()));
  gh.factory<_i136.SupplierCategoriesStateManager>(
      () => _i136.SupplierCategoriesStateManager(
            gh<_i135.SupplierCategoriesService>(),
            gh<_i96.ImageUploadService>(),
          ));
  gh.factory<_i137.SupplierService>(
      () => _i137.SupplierService(gh<_i67.SuppliersManager>()));
  gh.factory<_i138.SuppliersStateManager>(
      () => _i138.SuppliersStateManager(gh<_i137.SupplierService>()));
  gh.factory<_i139.TopActiveStateManagement>(
      () => _i139.TopActiveStateManagement(gh<_i130.StoresService>()));
  gh.factory<_i140.UpdatesStateManager>(() => _i140.UpdatesStateManager(
        gh<_i100.MyNotificationsService>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i141.AssignOrderToExternalCompanyStateManager>(() =>
      _i141.AssignOrderToExternalCompanyStateManager(
          gh<_i88.ExternalDeliveryCompaniesService>()));
  gh.factory<_i142.AuthorizationModule>(() => _i142.AuthorizationModule(
        gh<_i98.LoginScreen>(),
        gh<_i122.RegisterScreen>(),
        gh<_i92.ForgotPassScreen>(),
      ));
  gh.factory<_i143.BidOrderDetailsScreen>(
      () => _i143.BidOrderDetailsScreen(gh<_i72.BidOrderStateManager>()));
  gh.factory<_i144.BidOrderModule>(
      () => _i144.BidOrderModule(gh<_i73.BidOrdersScreen>()));
  gh.factory<_i145.BranchesListService>(
      () => _i145.BranchesListService(gh<_i74.BranchesManager>()));
  gh.factory<_i146.BranchesListStateManager>(
      () => _i146.BranchesListStateManager(gh<_i145.BranchesListService>()));
  gh.factory<_i147.CaptainActivityDetailsStateManager>(() =>
      _i147.CaptainActivityDetailsStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i148.CaptainAssignOrderStateManager>(
      () => _i148.CaptainAssignOrderStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i149.CaptainDuesStateManager>(
      () => _i149.CaptainDuesStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i150.CaptainFinanceByHoursStateManager>(() =>
      _i150.CaptainFinanceByHoursStateManager(gh<_i119.PaymentsService>()));
  gh.factory<_i151.CaptainFinanceByOrderCountStateManager>(() =>
      _i151.CaptainFinanceByOrderCountStateManager(
          gh<_i119.PaymentsService>()));
  gh.factory<_i152.CaptainFinanceByOrderStateManager>(() =>
      _i152.CaptainFinanceByOrderStateManager(gh<_i119.PaymentsService>()));
  gh.factory<_i153.CaptainOfferStateManager>(
      () => _i153.CaptainOfferStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i154.CaptainPaymentStateManager>(
      () => _i154.CaptainPaymentStateManager(gh<_i119.PaymentsService>()));
  gh.factory<_i155.CaptainPreviousPaymentsStateManager>(() =>
      _i155.CaptainPreviousPaymentsStateManager(gh<_i119.PaymentsService>()));
  gh.factory<_i156.CaptainProfileStateManager>(
      () => _i156.CaptainProfileStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i157.CaptainRatingDetailsStateManager>(
      () => _i157.CaptainRatingDetailsStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i158.CaptainsActivityStateManager>(
      () => _i158.CaptainsActivityStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i159.CaptainsNeedsSupportStateManager>(
      () => _i159.CaptainsNeedsSupportStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i160.CaptainsRatingStateManager>(
      () => _i160.CaptainsRatingStateManager(gh<_i76.CaptainsService>()));
  gh.factory<_i161.CategoriesScreen>(
      () => _i161.CategoriesScreen(gh<_i116.PackageCategoriesStateManager>()));
  gh.factory<_i162.ChatPage>(() => _i162.ChatPage(
        gh<_i82.ChatStateManager>(),
        gh<_i96.ImageUploadService>(),
        gh<_i35.AuthService>(),
        gh<_i13.ChatHiveHelper>(),
      ));
  gh.factory<_i163.CompanyFinanceStateManager>(
      () => _i163.CompanyFinanceStateManager(gh<_i84.CompanyService>()));
  gh.factory<_i164.CompanyProfileStateManager>(
      () => _i164.CompanyProfileStateManager(gh<_i84.CompanyService>()));
  gh.factory<_i165.DeliveryCompanyAllSettingsStateManager>(() =>
      _i165.DeliveryCompanyAllSettingsStateManager(
          gh<_i88.ExternalDeliveryCompaniesService>()));
  gh.factory<_i166.EditDeliveryCompanySettingScreenStateManager>(() =>
      _i166.EditDeliveryCompanySettingScreenStateManager(
          gh<_i88.ExternalDeliveryCompaniesService>()));
  gh.factory<_i167.EditStoreSettingStateManager>(
      () => _i167.EditStoreSettingStateManager(
            gh<_i130.StoresService>(),
            gh<_i96.ImageUploadService>(),
          ));
  gh.factory<_i168.EditSubscriptionStateManager>(() =>
      _i168.EditSubscriptionStateManager(gh<_i133.SubscriptionsService>()));
  gh.factory<_i169.FilterOrderTopStateManager>(
      () => _i169.FilterOrderTopStateManager(gh<_i130.StoresService>()));
  gh.factory<_i170.HomeScreen>(
      () => _i170.HomeScreen(gh<_i95.HomeStateManager>()));
  gh.factory<_i171.InActiveSupplierStateManager>(
      () => _i171.InActiveSupplierStateManager(gh<_i137.SupplierService>()));
  gh.factory<_i172.InitBranchesStateManager>(
      () => _i172.InitBranchesStateManager(gh<_i145.BranchesListService>()));
  gh.factory<_i173.InitSubscriptionStateManager>(() =>
      _i173.InitSubscriptionStateManager(gh<_i133.SubscriptionsService>()));
  gh.factory<_i174.MainModule>(() => _i174.MainModule(
        gh<_i21.MainScreen>(),
        gh<_i170.HomeScreen>(),
      ));
  gh.factory<_i175.MyNotificationsScreen>(() =>
      _i175.MyNotificationsScreen(gh<_i101.MyNotificationsStateManager>()));
  gh.factory<_i176.NewTestOrderScreen>(
      () => _i176.NewTestOrderScreen(gh<_i104.NewTestOrderStateManager>()));
  gh.factory<_i177.OrderCaptainNotArrivedStateManager>(() =>
      _i177.OrderCaptainNotArrivedStateManager(gh<_i130.StoresService>()));
  gh.factory<_i178.OrderLogsStateManager>(
      () => _i178.OrderLogsStateManager(gh<_i130.StoresService>()));
  gh.factory<_i179.OrderStatusStateManager>(
      () => _i179.OrderStatusStateManager(gh<_i130.StoresService>()));
  gh.factory<_i180.OrderTimeLineStateManager>(
      () => _i180.OrderTimeLineStateManager(gh<_i130.StoresService>()));
  gh.factory<_i181.PackagesScreen>(
      () => _i181.PackagesScreen(gh<_i117.PackagesStateManager>()));
  gh.factory<_i182.ReceiptsStateManager>(
      () => _i182.ReceiptsStateManager(gh<_i133.SubscriptionsService>()));
  gh.factory<_i183.StoreDuesStateManager>(() => _i183.StoreDuesStateManager(
        gh<_i130.StoresService>(),
        gh<_i119.PaymentsService>(),
      ));
  gh.factory<_i184.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i184.StoreFinancialSubscriptionsDuesDetailsStateManager(
            gh<_i119.PaymentsService>(),
            gh<_i133.SubscriptionsService>(),
          ));
  gh.factory<_i185.StoreProfileStateManager>(
      () => _i185.StoreProfileStateManager(
            gh<_i130.StoresService>(),
            gh<_i96.ImageUploadService>(),
          ));
  gh.factory<_i186.StoreSubscriptionManagementStateManager>(() =>
      _i186.StoreSubscriptionManagementStateManager(
          gh<_i133.SubscriptionsService>()));
  gh.factory<_i187.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i187.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i133.SubscriptionsService>()));
  gh.factory<_i188.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i188.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i184.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i189.StoreSubscriptionsFinanceStateManager>(() =>
      _i189.StoreSubscriptionsFinanceStateManager(
          gh<_i133.SubscriptionsService>()));
  gh.factory<_i190.StoresDuesStateManager>(
      () => _i190.StoresDuesStateManager(gh<_i130.StoresService>()));
  gh.factory<_i191.StoresInActiveStateManager>(
      () => _i191.StoresInActiveStateManager(
            gh<_i130.StoresService>(),
            gh<_i96.ImageUploadService>(),
          ));
  gh.factory<_i192.StoresNeedsSupportStateManager>(
      () => _i192.StoresNeedsSupportStateManager(gh<_i130.StoresService>()));
  gh.factory<_i193.SubscriptionManagementScreen>(() =>
      _i193.SubscriptionManagementScreen(
          gh<_i186.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i194.SubscriptionToCaptainOfferStateManager>(() =>
      _i194.SubscriptionToCaptainOfferStateManager(
          gh<_i133.SubscriptionsService>()));
  gh.factory<_i195.SupplierAdsStateManager>(
      () => _i195.SupplierAdsStateManager(gh<_i137.SupplierService>()));
  gh.factory<_i196.SupplierCategoriesScreen>(() =>
      _i196.SupplierCategoriesScreen(
          gh<_i136.SupplierCategoriesStateManager>()));
  gh.factory<_i197.SupplierNeedsSupportStateManager>(() =>
      _i197.SupplierNeedsSupportStateManager(gh<_i137.SupplierService>()));
  gh.factory<_i198.SupplierProfileStateManager>(
      () => _i198.SupplierProfileStateManager(gh<_i137.SupplierService>()));
  gh.factory<_i199.SuppliersScreen>(
      () => _i199.SuppliersScreen(gh<_i138.SuppliersStateManager>()));
  gh.factory<_i200.UpdateBranchStateManager>(
      () => _i200.UpdateBranchStateManager(gh<_i145.BranchesListService>()));
  gh.factory<_i201.UpdateScreen>(
      () => _i201.UpdateScreen(gh<_i140.UpdatesStateManager>()));
  gh.factory<_i202.BranchesListScreen>(
      () => _i202.BranchesListScreen(gh<_i146.BranchesListStateManager>()));
  gh.factory<_i203.CategoriesModule>(() => _i203.CategoriesModule(
        gh<_i161.CategoriesScreen>(),
        gh<_i181.PackagesScreen>(),
      ));
  gh.factory<_i204.ChatModule>(() => _i204.ChatModule(gh<_i162.ChatPage>()));
  gh.factory<_i205.CompanyFinanceScreen>(
      () => _i205.CompanyFinanceScreen(gh<_i163.CompanyFinanceStateManager>()));
  gh.factory<_i206.CompanyProfileScreen>(
      () => _i206.CompanyProfileScreen(gh<_i164.CompanyProfileStateManager>()));
  gh.factory<_i207.CreateSubscriptionScreen>(() =>
      _i207.CreateSubscriptionScreen(gh<_i173.InitSubscriptionStateManager>()));
  gh.factory<_i208.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i208.CreateSubscriptionToCaptainOfferScreen(
          gh<_i194.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i209.DevModule>(
      () => _i209.DevModule(gh<_i176.NewTestOrderScreen>()));
  gh.factory<_i210.EditSubscriptionScreen>(() =>
      _i210.EditSubscriptionScreen(gh<_i168.EditSubscriptionStateManager>()));
  gh.factory<_i211.InActiveSupplierScreen>(() =>
      _i211.InActiveSupplierScreen(gh<_i171.InActiveSupplierStateManager>()));
  gh.factory<_i212.InitBranchesScreen>(
      () => _i212.InitBranchesScreen(gh<_i172.InitBranchesStateManager>()));
  gh.factory<_i213.MyNotificationsModule>(() => _i213.MyNotificationsModule(
        gh<_i175.MyNotificationsScreen>(),
        gh<_i201.UpdateScreen>(),
      ));
  gh.factory<_i214.ReceiptsScreen>(
      () => _i214.ReceiptsScreen(gh<_i182.ReceiptsStateManager>()));
  gh.factory<_i215.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i215.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i187.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i216.StoreSubscriptionsFinanceScreen>(() =>
      _i216.StoreSubscriptionsFinanceScreen(
          gh<_i189.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i217.SubscriptionsModule>(() => _i217.SubscriptionsModule(
        gh<_i188.StoreSubscriptionsFinanceDetailsScreen>(),
        gh<_i216.StoreSubscriptionsFinanceScreen>(),
        gh<_i193.SubscriptionManagementScreen>(),
        gh<_i215.StoreSubscriptionsExpiredFinanceScreen>(),
        gh<_i207.CreateSubscriptionScreen>(),
        gh<_i208.CreateSubscriptionToCaptainOfferScreen>(),
        gh<_i210.EditSubscriptionScreen>(),
        gh<_i214.ReceiptsScreen>(),
      ));
  gh.factory<_i218.SupplierAdsScreen>(
      () => _i218.SupplierAdsScreen(gh<_i195.SupplierAdsStateManager>()));
  gh.factory<_i219.SupplierCategoriesModule>(() =>
      _i219.SupplierCategoriesModule(gh<_i196.SupplierCategoriesScreen>()));
  gh.factory<_i220.SupplierNeedsSupportScreen>(() =>
      _i220.SupplierNeedsSupportScreen(
          gh<_i197.SupplierNeedsSupportStateManager>()));
  gh.factory<_i221.SupplierProfileScreen>(() =>
      _i221.SupplierProfileScreen(gh<_i198.SupplierProfileStateManager>()));
  gh.factory<_i222.UpdateBranchScreen>(
      () => _i222.UpdateBranchScreen(gh<_i200.UpdateBranchStateManager>()));
  gh.factory<_i223.BranchesModule>(() => _i223.BranchesModule(
        gh<_i202.BranchesListScreen>(),
        gh<_i222.UpdateBranchScreen>(),
        gh<_i212.InitBranchesScreen>(),
      ));
  gh.factory<_i224.CompanyModule>(() => _i224.CompanyModule(
        gh<_i206.CompanyProfileScreen>(),
        gh<_i205.CompanyFinanceScreen>(),
      ));
  gh.factory<_i225.SupplierModule>(() => _i225.SupplierModule(
        gh<_i211.InActiveSupplierScreen>(),
        gh<_i199.SuppliersScreen>(),
        gh<_i221.SupplierProfileScreen>(),
        gh<_i220.SupplierNeedsSupportScreen>(),
        gh<_i218.SupplierAdsScreen>(),
      ));
  gh.factory<_i226.MyApp>(() => _i226.MyApp(
        gh<_i33.AppThemeDataService>(),
        gh<_i19.LocalizationService>(),
        gh<_i91.FireNotificationService>(),
        gh<_i17.LocalNotificationService>(),
        gh<_i124.SplashModule>(),
        gh<_i142.AuthorizationModule>(),
        gh<_i204.ChatModule>(),
        gh<_i123.SettingsModule>(),
        gh<_i174.MainModule>(),
        gh<_i30.StoresModule>(),
        gh<_i203.CategoriesModule>(),
        gh<_i224.CompanyModule>(),
        gh<_i223.BranchesModule>(),
        gh<_i22.NoticeModule>(),
        gh<_i10.CaptainsModule>(),
        gh<_i27.PaymentsModule>(),
        gh<_i219.SupplierCategoriesModule>(),
        gh<_i225.SupplierModule>(),
        gh<_i12.CarsModule>(),
        gh<_i144.BidOrderModule>(),
        gh<_i26.OrdersModule>(),
        gh<_i217.SubscriptionsModule>(),
        gh<_i213.MyNotificationsModule>(),
        gh<_i28.StatisticsModule>(),
        gh<_i209.DevModule>(),
        gh<_i14.ExternalDeliveryCompaniesModule>(),
      ));
  return getIt;
}

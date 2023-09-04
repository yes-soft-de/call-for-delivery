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
import '../main.dart' as _i234;
import '../module_auth/authoriazation_module.dart' as _i146;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i34;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i6;
import '../module_auth/service/auth_service/auth_service.dart' as _i35;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i47;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i49;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i58;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i96;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i102;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i126;
import '../module_bid_order/bid_order_module.dart' as _i148;
import '../module_bid_order/manager/bid_order_manager.dart' as _i71;
import '../module_bid_order/repository/bid_order_repository.dart' as _i36;
import '../module_bid_order/service/bid_order_service.dart' as _i72;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i73;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i74;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i147;
import '../module_branches/branches_module.dart' as _i231;
import '../module_branches/manager/branches_manager.dart' as _i75;
import '../module_branches/repository/branches_repository.dart' as _i37;
import '../module_branches/service/branches_list_service.dart' as _i149;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i150;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i177;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i206;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i208;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i219;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i230;
import '../module_captain/captains_module.dart' as _i10;
import '../module_captain/hive/captain_hive_helper.dart' as _i9;
import '../module_captain/manager/captains_manager.dart' as _i76;
import '../module_captain/repository/captains_repository.dart' as _i38;
import '../module_captain/service/captains_service.dart' as _i77;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i151;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i162;
import '../module_captain/state_manager/captain_dues_state_manager.dart'
    as _i153;
import '../module_captain/state_manager/captain_list.dart' as _i78;
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
import '../module_captain/ui/screen/captain_dues_screen.dart' as _i8;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i11;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i7;
import '../module_categories/categories_module.dart' as _i209;
import '../module_categories/manager/categories_manager.dart' as _i79;
import '../module_categories/repository/categories_repository.dart' as _i39;
import '../module_categories/service/store_categories_service.dart' as _i80;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i120;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i121;
import '../module_categories/ui/screen/categories_screen.dart' as _i165;
import '../module_categories/ui/screen/packages_screen.dart' as _i187;
import '../module_chat/chat_module.dart' as _i211;
import '../module_chat/manager/chat/chat_manager.dart' as _i84;
import '../module_chat/presistance/chat_hive_helper.dart' as _i13;
import '../module_chat/repository/chat/chat_repository.dart' as _i41;
import '../module_chat/service/chat/char_service.dart' as _i85;
import '../module_chat/state_manager/chat_state_manager.dart' as _i86;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i167;
import '../module_chat_v2/chat_module.dart' as _i210;
import '../module_chat_v2/manager/chat/chat_manager.dart' as _i81;
import '../module_chat_v2/presistance/chat_hive_helper.dart' as _i14;
import '../module_chat_v2/repository/chat/chat_repository.dart' as _i40;
import '../module_chat_v2/service/chat/char_service.dart' as _i82;
import '../module_chat_v2/state_manager/chat_state_manager.dart' as _i83;
import '../module_chat_v2/ui/screens/chat_page/chat_page.dart' as _i166;
import '../module_company/company_module.dart' as _i232;
import '../module_company/manager/company_manager.dart' as _i87;
import '../module_company/repository/company_repository.dart' as _i43;
import '../module_company/service/company_service.dart' as _i88;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i168;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i169;
import '../module_company/ui/screen/company_finance_screen.dart' as _i212;
import '../module_company/ui/screen/company_profile_screen.dart' as _i213;
import '../module_deep_links/repository/deep_link_repository.dart' as _i44;
import '../module_delivary_car/cars_module.dart' as _i12;
import '../module_dev/dev_module.dart' as _i216;
import '../module_dev/hive/order_hive_helper.dart' as _i24;
import '../module_dev/manager/dev_manager.dart' as _i89;
import '../module_dev/repository/dev_repository.dart' as _i45;
import '../module_dev/service/orders/dev.service.dart' as _i90;
import '../module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i108;
import '../module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i181;
import '../module_external_delivery_companies/external_delivery_companies_module.dart'
    as _i15;
import '../module_external_delivery_companies/manager/external_delivery_companies_manager.dart'
    as _i91;
import '../module_external_delivery_companies/repository/external_delivery_companies_repository.dart'
    as _i46;
import '../module_external_delivery_companies/service/external_delivery_companies_service.dart'
    as _i92;
import '../module_external_delivery_companies/state_manager/assign_order_to_external_company_state_manager.dart'
    as _i145;
import '../module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart'
    as _i170;
import '../module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart'
    as _i171;
import '../module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart'
    as _i93;
import '../module_external_delivery_companies/state_manager/external_orders_state_manager.dart'
    as _i94;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i19;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i20;
import '../module_main/main_module.dart' as _i179;
import '../module_main/manager/home_manager.dart' as _i97;
import '../module_main/repository/home_repository.dart' as _i48;
import '../module_main/sceen/home_screen.dart' as _i175;
import '../module_main/sceen/main_screen.dart' as _i22;
import '../module_main/service/home_service.dart' as _i98;
import '../module_main/state_manager/home_state_manager.dart' as _i99;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i103;
import '../module_my_notifications/my_notifications_module.dart' as _i220;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i50;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i104;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i105;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i144;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i180;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i207;
import '../module_network/http_client/http_client.dart' as _i3;
import '../module_notice/manager/notice_manager.dart' as _i109;
import '../module_notice/notice_module.dart' as _i221;
import '../module_notice/repository/notice_repository.dart' as _i51;
import '../module_notice/service/notice_service.dart' as _i110;
import '../module_notice/state_manager/notice_state_manager.dart' as _i111;
import '../module_notice/ui/screen/notice_screen.dart' as _i182;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i23;
import '../module_notifications/repository/notification_repo.dart' as _i52;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i95;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i18;
import '../module_orders/hive/order_hive_helper.dart' as _i25;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i54;
import '../module_orders/orders_module.dart' as _i26;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i53;
import '../module_orders/service/orders/orders.service.dart' as _i55;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i107;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i106;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i69;
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
    as _i57;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i59;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i64;
import '../module_payments/manager/payments_manager.dart' as _i122;
import '../module_payments/payments_module.dart' as _i27;
import '../module_payments/repository/payments_repository.dart' as _i56;
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
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i42;
import '../module_settings/ui/settings_page/settings_page.dart' as _i60;
import '../module_splash/splash_module.dart' as _i128;
import '../module_splash/ui/screen/splash_screen.dart' as _i61;
import '../module_statistics/manager/statistic_manager.dart' as _i129;
import '../module_statistics/repository/statistics_repository.dart' as _i62;
import '../module_statistics/service/statistics_service.dart' as _i130;
import '../module_statistics/state_manager/statistics_state_manager.dart'
    as _i131;
import '../module_statistics/ui/statistics_module.dart' as _i28;
import '../module_stores/hive/store_hive_helper.dart' as _i29;
import '../module_stores/manager/stores_manager.dart' as _i133;
import '../module_stores/repository/stores_repository.dart' as _i63;
import '../module_stores/service/store_service.dart' as _i134;
import '../module_stores/state_manager/edit_store_setting_state_manager.dart'
    as _i172;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i174;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i183;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i184;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i185;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i186;
import '../module_stores/state_manager/store_dues_state_manager.dart' as _i189;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i191;
import '../module_stores/state_manager/stores_dues_state_manager.dart' as _i196;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i197;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i198;
import '../module_stores/state_manager/stores_state_manager.dart' as _i135;
import '../module_stores/state_manager/top_active_store.dart' as _i143;
import '../module_stores/stores_module.dart' as _i30;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i136;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i65;
import '../module_subscriptions/service/subscriptions_service.dart' as _i137;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i173;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i178;
import '../module_subscriptions/state_manager/receipts_state_manager.dart'
    as _i188;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i190;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i192;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i193;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i195;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i200;
import '../module_subscriptions/subscriptions_module.dart' as _i225;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i217;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i214;
import '../module_subscriptions/ui/screen/receipts_screen.dart' as _i222;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i194;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i223;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i224;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i215;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i199;
import '../module_supplier/manager/supplier_manager.dart' as _i68;
import '../module_supplier/repository/supplier_repository.dart' as _i67;
import '../module_supplier/service/supplier_service.dart' as _i141;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i176;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i201;
import '../module_supplier/state_manager/supplier_list.dart' as _i142;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i203;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i204;
import '../module_supplier/supplier_module.dart' as _i233;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i218;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i226;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i205;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i228;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i229;
import '../module_supplier_categories/categories_supplier_module.dart' as _i227;
import '../module_supplier_categories/manager/categories_manager.dart' as _i138;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i66;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i139;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i140;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i202;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i31;
import '../module_theme/service/theme_service/theme_service.dart' as _i33;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i70;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i32;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i100;
import '../utils/global/global_state_manager.dart' as _i17;
import '../utils/helpers/firestore_helper.dart' as _i16;
import '../utils/logger/logger.dart' as _i21;

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
  gh.factory<_i14.ChatHiveHelper>(() => _i14.ChatHiveHelper());
  gh.factory<_i15.ExternalDeliveryCompaniesModule>(
      () => _i15.ExternalDeliveryCompaniesModule());
  gh.factory<_i16.FireStoreHelper>(() => _i16.FireStoreHelper());
  gh.singleton<_i17.GlobalStateManager>(_i17.GlobalStateManager());
  gh.factory<_i18.LocalNotificationService>(
      () => _i18.LocalNotificationService());
  gh.factory<_i19.LocalizationPreferencesHelper>(
      () => _i19.LocalizationPreferencesHelper());
  gh.factory<_i20.LocalizationService>(
      () => _i20.LocalizationService(gh<_i19.LocalizationPreferencesHelper>()));
  gh.factory<_i21.Logger>(() => _i21.Logger());
  gh.factory<_i22.MainScreen>(() => _i22.MainScreen());
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
  gh.factory<_i40.Chat2Repository>(() => _i40.Chat2Repository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i41.ChatRepository>(() => _i41.ChatRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i42.ChooseLocalScreen>(
      () => _i42.ChooseLocalScreen(gh<_i20.LocalizationService>()));
  gh.factory<_i43.CompanyRepository>(() => _i43.CompanyRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i44.DeepLinkRepository>(() => _i44.DeepLinkRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i45.DevRepository>(() => _i45.DevRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i46.ExternalDeliveryCompaniesRepository>(
      () => _i46.ExternalDeliveryCompaniesRepository(
            gh<_i3.ApiClient>(),
            gh<_i35.AuthService>(),
          ));
  gh.factory<_i47.ForgotPassStateManager>(
      () => _i47.ForgotPassStateManager(gh<_i35.AuthService>()));
  gh.factory<_i48.HomeRepository>(() => _i48.HomeRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i49.LoginStateManager>(
      () => _i49.LoginStateManager(gh<_i35.AuthService>()));
  gh.factory<_i50.MyNotificationsRepository>(
      () => _i50.MyNotificationsRepository(
            gh<_i3.ApiClient>(),
            gh<_i35.AuthService>(),
          ));
  gh.factory<_i51.NoticeRepository>(() => _i51.NoticeRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i52.NotificationRepo>(() => _i52.NotificationRepo(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i53.OrderRepository>(() => _i53.OrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i54.OrdersManager>(
      () => _i54.OrdersManager(gh<_i53.OrderRepository>()));
  gh.factory<_i55.OrdersService>(
      () => _i55.OrdersService(gh<_i54.OrdersManager>()));
  gh.factory<_i56.PaymentsRepository>(() => _i56.PaymentsRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i57.RecycleOrderStateManager>(
      () => _i57.RecycleOrderStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i58.RegisterStateManager>(
      () => _i58.RegisterStateManager(gh<_i35.AuthService>()));
  gh.factory<_i59.SearchForOrderStateManager>(
      () => _i59.SearchForOrderStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i60.SettingsScreen>(() => _i60.SettingsScreen(
        gh<_i35.AuthService>(),
        gh<_i20.LocalizationService>(),
        gh<_i33.AppThemeDataService>(),
      ));
  gh.factory<_i61.SplashScreen>(
      () => _i61.SplashScreen(gh<_i35.AuthService>()));
  gh.factory<_i62.StatisticsRepository>(() => _i62.StatisticsRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i63.StoresRepository>(() => _i63.StoresRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i64.SubOrdersStateManager>(
      () => _i64.SubOrdersStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i65.SubscriptionsRepository>(() => _i65.SubscriptionsRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i66.SupplierCategoriesRepository>(
      () => _i66.SupplierCategoriesRepository(
            gh<_i3.ApiClient>(),
            gh<_i35.AuthService>(),
          ));
  gh.factory<_i67.SupplierRepository>(() => _i67.SupplierRepository(
        gh<_i3.ApiClient>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i68.SuppliersManager>(
      () => _i68.SuppliersManager(gh<_i67.SupplierRepository>()));
  gh.factory<_i69.UpdateOrderStateManager>(
      () => _i69.UpdateOrderStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i70.UploadManager>(
      () => _i70.UploadManager(gh<_i32.UploadRepository>()));
  gh.factory<_i71.BidOrderManager>(
      () => _i71.BidOrderManager(gh<_i36.BidOrderRepository>()));
  gh.factory<_i72.BidOrderService>(
      () => _i72.BidOrderService(gh<_i71.BidOrderManager>()));
  gh.factory<_i73.BidOrderStateManager>(
      () => _i73.BidOrderStateManager(gh<_i72.BidOrderService>()));
  gh.factory<_i74.BidOrdersScreen>(
      () => _i74.BidOrdersScreen(gh<_i73.BidOrderStateManager>()));
  gh.factory<_i75.BranchesManager>(
      () => _i75.BranchesManager(gh<_i37.BranchesRepository>()));
  gh.factory<_i76.CaptainsManager>(
      () => _i76.CaptainsManager(gh<_i38.CaptainsRepository>()));
  gh.factory<_i77.CaptainsService>(
      () => _i77.CaptainsService(gh<_i76.CaptainsManager>()));
  gh.factory<_i78.CaptainsStateManager>(
      () => _i78.CaptainsStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i79.CategoriesManager>(
      () => _i79.CategoriesManager(gh<_i39.CategoriesRepository>()));
  gh.factory<_i80.CategoriesService>(
      () => _i80.CategoriesService(gh<_i79.CategoriesManager>()));
  gh.factory<_i81.Chat2Manager>(
      () => _i81.Chat2Manager(gh<_i40.Chat2Repository>()));
  gh.factory<_i82.Chat2Service>(
      () => _i82.Chat2Service(gh<_i81.Chat2Manager>()));
  gh.factory<_i83.Chat2StateManager>(
      () => _i83.Chat2StateManager(gh<_i82.Chat2Service>()));
  gh.factory<_i84.ChatManager>(
      () => _i84.ChatManager(gh<_i41.ChatRepository>()));
  gh.factory<_i85.ChatService>(() => _i85.ChatService(gh<_i84.ChatManager>()));
  gh.factory<_i86.ChatStateManager>(
      () => _i86.ChatStateManager(gh<_i85.ChatService>()));
  gh.factory<_i87.CompanyManager>(
      () => _i87.CompanyManager(gh<_i43.CompanyRepository>()));
  gh.factory<_i88.CompanyService>(
      () => _i88.CompanyService(gh<_i87.CompanyManager>()));
  gh.factory<_i89.DevManager>(() => _i89.DevManager(gh<_i45.DevRepository>()));
  gh.factory<_i90.DevService>(() => _i90.DevService(gh<_i89.DevManager>()));
  gh.factory<_i91.ExternalDeliveryCompaniesManager>(() =>
      _i91.ExternalDeliveryCompaniesManager(
          gh<_i46.ExternalDeliveryCompaniesRepository>()));
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
      () => _i95.FireNotificationService(gh<_i52.NotificationRepo>()));
  gh.factory<_i96.ForgotPassScreen>(
      () => _i96.ForgotPassScreen(gh<_i47.ForgotPassStateManager>()));
  gh.factory<_i97.HomeManager>(
      () => _i97.HomeManager(gh<_i48.HomeRepository>()));
  gh.factory<_i98.HomeService>(() => _i98.HomeService(gh<_i97.HomeManager>()));
  gh.factory<_i99.HomeStateManager>(
      () => _i99.HomeStateManager(gh<_i98.HomeService>()));
  gh.factory<_i100.ImageUploadService>(
      () => _i100.ImageUploadService(gh<_i70.UploadManager>()));
  gh.factory<_i101.InActiveCaptainsStateManager>(
      () => _i101.InActiveCaptainsStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i102.LoginScreen>(
      () => _i102.LoginScreen(gh<_i49.LoginStateManager>()));
  gh.factory<_i103.MyNotificationsManager>(
      () => _i103.MyNotificationsManager(gh<_i50.MyNotificationsRepository>()));
  gh.factory<_i104.MyNotificationsService>(
      () => _i104.MyNotificationsService(gh<_i103.MyNotificationsManager>()));
  gh.factory<_i105.MyNotificationsStateManager>(
      () => _i105.MyNotificationsStateManager(
            gh<_i104.MyNotificationsService>(),
            gh<_i35.AuthService>(),
          ));
  gh.factory<_i106.NewOrderLinkStateManager>(
      () => _i106.NewOrderLinkStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i107.NewOrderStateManager>(
      () => _i107.NewOrderStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i108.NewTestOrderStateManager>(
      () => _i108.NewTestOrderStateManager(gh<_i90.DevService>()));
  gh.factory<_i109.NoticeManager>(
      () => _i109.NoticeManager(gh<_i51.NoticeRepository>()));
  gh.factory<_i110.NoticeService>(
      () => _i110.NoticeService(gh<_i109.NoticeManager>()));
  gh.factory<_i111.NoticeStateManager>(
      () => _i111.NoticeStateManager(gh<_i110.NoticeService>()));
  gh.factory<_i112.OrderActionLogsStateManager>(
      () => _i112.OrderActionLogsStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i113.OrderCaptainLogsStateManager>(
      () => _i113.OrderCaptainLogsStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i114.OrderCashCaptainStateManager>(
      () => _i114.OrderCashCaptainStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i115.OrderDistanceConflictStateManager>(
      () => _i115.OrderDistanceConflictStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i116.OrderPendingStateManager>(
      () => _i116.OrderPendingStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i117.OrderWithoutDistanceStateManager>(
      () => _i117.OrderWithoutDistanceStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i118.OrdersCashStoreStateManager>(
      () => _i118.OrdersCashStoreStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i119.OrdersReceiveCashStateManager>(
      () => _i119.OrdersReceiveCashStateManager(gh<_i55.OrdersService>()));
  gh.factory<_i120.PackageCategoriesStateManager>(
      () => _i120.PackageCategoriesStateManager(gh<_i80.CategoriesService>()));
  gh.factory<_i121.PackagesStateManager>(
      () => _i121.PackagesStateManager(gh<_i80.CategoriesService>()));
  gh.factory<_i122.PaymentsManager>(
      () => _i122.PaymentsManager(gh<_i56.PaymentsRepository>()));
  gh.factory<_i123.PaymentsService>(
      () => _i123.PaymentsService(gh<_i122.PaymentsManager>()));
  gh.factory<_i124.PaymentsToCaptainStateManager>(
      () => _i124.PaymentsToCaptainStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i125.PlanScreenStateManager>(
      () => _i125.PlanScreenStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i126.RegisterScreen>(
      () => _i126.RegisterScreen(gh<_i58.RegisterStateManager>()));
  gh.factory<_i127.SettingsModule>(() => _i127.SettingsModule(
        gh<_i60.SettingsScreen>(),
        gh<_i42.ChooseLocalScreen>(),
      ));
  gh.factory<_i128.SplashModule>(
      () => _i128.SplashModule(gh<_i61.SplashScreen>()));
  gh.factory<_i129.StatisticManager>(
      () => _i129.StatisticManager(gh<_i62.StatisticsRepository>()));
  gh.factory<_i130.StatisticsService>(
      () => _i130.StatisticsService(gh<_i129.StatisticManager>()));
  gh.factory<_i131.StatisticsStateManager>(
      () => _i131.StatisticsStateManager(gh<_i130.StatisticsService>()));
  gh.factory<_i132.StoreBalanceStateManager>(
      () => _i132.StoreBalanceStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i133.StoreManager>(
      () => _i133.StoreManager(gh<_i63.StoresRepository>()));
  gh.factory<_i134.StoresService>(
      () => _i134.StoresService(gh<_i133.StoreManager>()));
  gh.factory<_i135.StoresStateManager>(() => _i135.StoresStateManager(
        gh<_i134.StoresService>(),
        gh<_i100.ImageUploadService>(),
      ));
  gh.factory<_i136.SubscriptionsManager>(
      () => _i136.SubscriptionsManager(gh<_i65.SubscriptionsRepository>()));
  gh.factory<_i137.SubscriptionsService>(
      () => _i137.SubscriptionsService(gh<_i136.SubscriptionsManager>()));
  gh.factory<_i138.SupplierCategoriesManager>(() =>
      _i138.SupplierCategoriesManager(gh<_i66.SupplierCategoriesRepository>()));
  gh.factory<_i139.SupplierCategoriesService>(() =>
      _i139.SupplierCategoriesService(gh<_i138.SupplierCategoriesManager>()));
  gh.factory<_i140.SupplierCategoriesStateManager>(
      () => _i140.SupplierCategoriesStateManager(
            gh<_i139.SupplierCategoriesService>(),
            gh<_i100.ImageUploadService>(),
          ));
  gh.factory<_i141.SupplierService>(
      () => _i141.SupplierService(gh<_i68.SuppliersManager>()));
  gh.factory<_i142.SuppliersStateManager>(
      () => _i142.SuppliersStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i143.TopActiveStateManagement>(
      () => _i143.TopActiveStateManagement(gh<_i134.StoresService>()));
  gh.factory<_i144.UpdatesStateManager>(() => _i144.UpdatesStateManager(
        gh<_i104.MyNotificationsService>(),
        gh<_i35.AuthService>(),
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
      () => _i147.BidOrderDetailsScreen(gh<_i73.BidOrderStateManager>()));
  gh.factory<_i148.BidOrderModule>(
      () => _i148.BidOrderModule(gh<_i74.BidOrdersScreen>()));
  gh.factory<_i149.BranchesListService>(
      () => _i149.BranchesListService(gh<_i75.BranchesManager>()));
  gh.factory<_i150.BranchesListStateManager>(
      () => _i150.BranchesListStateManager(gh<_i149.BranchesListService>()));
  gh.factory<_i151.CaptainActivityDetailsStateManager>(() =>
      _i151.CaptainActivityDetailsStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i152.CaptainAssignOrderStateManager>(
      () => _i152.CaptainAssignOrderStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i153.CaptainDuesStateManager>(
      () => _i153.CaptainDuesStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i154.CaptainFinanceByHoursStateManager>(() =>
      _i154.CaptainFinanceByHoursStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i155.CaptainFinanceByOrderCountStateManager>(() =>
      _i155.CaptainFinanceByOrderCountStateManager(
          gh<_i123.PaymentsService>()));
  gh.factory<_i156.CaptainFinanceByOrderStateManager>(() =>
      _i156.CaptainFinanceByOrderStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i157.CaptainOfferStateManager>(
      () => _i157.CaptainOfferStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i158.CaptainPaymentStateManager>(
      () => _i158.CaptainPaymentStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i159.CaptainPreviousPaymentsStateManager>(() =>
      _i159.CaptainPreviousPaymentsStateManager(gh<_i123.PaymentsService>()));
  gh.factory<_i160.CaptainProfileStateManager>(
      () => _i160.CaptainProfileStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i161.CaptainRatingDetailsStateManager>(
      () => _i161.CaptainRatingDetailsStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i162.CaptainsActivityStateManager>(
      () => _i162.CaptainsActivityStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i163.CaptainsNeedsSupportStateManager>(
      () => _i163.CaptainsNeedsSupportStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i164.CaptainsRatingStateManager>(
      () => _i164.CaptainsRatingStateManager(gh<_i77.CaptainsService>()));
  gh.factory<_i165.CategoriesScreen>(
      () => _i165.CategoriesScreen(gh<_i120.PackageCategoriesStateManager>()));
  gh.factory<_i166.Chat2Page>(() => _i166.Chat2Page(
        gh<_i83.Chat2StateManager>(),
        gh<_i100.ImageUploadService>(),
        gh<_i35.AuthService>(),
        gh<_i14.ChatHiveHelper>(),
      ));
  gh.factory<_i167.ChatPage>(() => _i167.ChatPage(
        gh<_i86.ChatStateManager>(),
        gh<_i100.ImageUploadService>(),
        gh<_i35.AuthService>(),
        gh<_i13.ChatHiveHelper>(),
      ));
  gh.factory<_i168.CompanyFinanceStateManager>(
      () => _i168.CompanyFinanceStateManager(gh<_i88.CompanyService>()));
  gh.factory<_i169.CompanyProfileStateManager>(
      () => _i169.CompanyProfileStateManager(gh<_i88.CompanyService>()));
  gh.factory<_i170.DeliveryCompanyAllSettingsStateManager>(() =>
      _i170.DeliveryCompanyAllSettingsStateManager(
          gh<_i92.ExternalDeliveryCompaniesService>()));
  gh.factory<_i171.EditDeliveryCompanySettingScreenStateManager>(() =>
      _i171.EditDeliveryCompanySettingScreenStateManager(
          gh<_i92.ExternalDeliveryCompaniesService>()));
  gh.factory<_i172.EditStoreSettingStateManager>(
      () => _i172.EditStoreSettingStateManager(
            gh<_i134.StoresService>(),
            gh<_i100.ImageUploadService>(),
          ));
  gh.factory<_i173.EditSubscriptionStateManager>(() =>
      _i173.EditSubscriptionStateManager(gh<_i137.SubscriptionsService>()));
  gh.factory<_i174.FilterOrderTopStateManager>(
      () => _i174.FilterOrderTopStateManager(gh<_i134.StoresService>()));
  gh.factory<_i175.HomeScreen>(
      () => _i175.HomeScreen(gh<_i99.HomeStateManager>()));
  gh.factory<_i176.InActiveSupplierStateManager>(
      () => _i176.InActiveSupplierStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i177.InitBranchesStateManager>(
      () => _i177.InitBranchesStateManager(gh<_i149.BranchesListService>()));
  gh.factory<_i178.InitSubscriptionStateManager>(() =>
      _i178.InitSubscriptionStateManager(gh<_i137.SubscriptionsService>()));
  gh.factory<_i179.MainModule>(() => _i179.MainModule(
        gh<_i22.MainScreen>(),
        gh<_i175.HomeScreen>(),
      ));
  gh.factory<_i180.MyNotificationsScreen>(() =>
      _i180.MyNotificationsScreen(gh<_i105.MyNotificationsStateManager>()));
  gh.factory<_i181.NewTestOrderScreen>(
      () => _i181.NewTestOrderScreen(gh<_i108.NewTestOrderStateManager>()));
  gh.factory<_i182.NoticeScreen>(
      () => _i182.NoticeScreen(gh<_i111.NoticeStateManager>()));
  gh.factory<_i183.OrderCaptainNotArrivedStateManager>(() =>
      _i183.OrderCaptainNotArrivedStateManager(gh<_i134.StoresService>()));
  gh.factory<_i184.OrderLogsStateManager>(
      () => _i184.OrderLogsStateManager(gh<_i134.StoresService>()));
  gh.factory<_i185.OrderStatusStateManager>(
      () => _i185.OrderStatusStateManager(gh<_i134.StoresService>()));
  gh.factory<_i186.OrderTimeLineStateManager>(
      () => _i186.OrderTimeLineStateManager(gh<_i134.StoresService>()));
  gh.factory<_i187.PackagesScreen>(
      () => _i187.PackagesScreen(gh<_i121.PackagesStateManager>()));
  gh.factory<_i188.ReceiptsStateManager>(
      () => _i188.ReceiptsStateManager(gh<_i137.SubscriptionsService>()));
  gh.factory<_i189.StoreDuesStateManager>(() => _i189.StoreDuesStateManager(
        gh<_i134.StoresService>(),
        gh<_i123.PaymentsService>(),
      ));
  gh.factory<_i190.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i190.StoreFinancialSubscriptionsDuesDetailsStateManager(
            gh<_i123.PaymentsService>(),
            gh<_i137.SubscriptionsService>(),
          ));
  gh.factory<_i191.StoreProfileStateManager>(
      () => _i191.StoreProfileStateManager(
            gh<_i134.StoresService>(),
            gh<_i100.ImageUploadService>(),
          ));
  gh.factory<_i192.StoreSubscriptionManagementStateManager>(() =>
      _i192.StoreSubscriptionManagementStateManager(
          gh<_i137.SubscriptionsService>()));
  gh.factory<_i193.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i193.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i137.SubscriptionsService>()));
  gh.factory<_i194.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i194.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i190.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i195.StoreSubscriptionsFinanceStateManager>(() =>
      _i195.StoreSubscriptionsFinanceStateManager(
          gh<_i137.SubscriptionsService>()));
  gh.factory<_i196.StoresDuesStateManager>(
      () => _i196.StoresDuesStateManager(gh<_i134.StoresService>()));
  gh.factory<_i197.StoresInActiveStateManager>(
      () => _i197.StoresInActiveStateManager(
            gh<_i134.StoresService>(),
            gh<_i100.ImageUploadService>(),
          ));
  gh.factory<_i198.StoresNeedsSupportStateManager>(
      () => _i198.StoresNeedsSupportStateManager(gh<_i134.StoresService>()));
  gh.factory<_i199.SubscriptionManagementScreen>(() =>
      _i199.SubscriptionManagementScreen(
          gh<_i192.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i200.SubscriptionToCaptainOfferStateManager>(() =>
      _i200.SubscriptionToCaptainOfferStateManager(
          gh<_i137.SubscriptionsService>()));
  gh.factory<_i201.SupplierAdsStateManager>(
      () => _i201.SupplierAdsStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i202.SupplierCategoriesScreen>(() =>
      _i202.SupplierCategoriesScreen(
          gh<_i140.SupplierCategoriesStateManager>()));
  gh.factory<_i203.SupplierNeedsSupportStateManager>(() =>
      _i203.SupplierNeedsSupportStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i204.SupplierProfileStateManager>(
      () => _i204.SupplierProfileStateManager(gh<_i141.SupplierService>()));
  gh.factory<_i205.SuppliersScreen>(
      () => _i205.SuppliersScreen(gh<_i142.SuppliersStateManager>()));
  gh.factory<_i206.UpdateBranchStateManager>(
      () => _i206.UpdateBranchStateManager(gh<_i149.BranchesListService>()));
  gh.factory<_i207.UpdateScreen>(
      () => _i207.UpdateScreen(gh<_i144.UpdatesStateManager>()));
  gh.factory<_i208.BranchesListScreen>(
      () => _i208.BranchesListScreen(gh<_i150.BranchesListStateManager>()));
  gh.factory<_i209.CategoriesModule>(() => _i209.CategoriesModule(
        gh<_i165.CategoriesScreen>(),
        gh<_i187.PackagesScreen>(),
      ));
  gh.factory<_i210.Chat2Module>(() => _i210.Chat2Module(
        gh<_i166.Chat2Page>(),
        gh<_i35.AuthService>(),
      ));
  gh.factory<_i211.ChatModule>(() => _i211.ChatModule(
        gh<_i167.ChatPage>(),
        gh<_i166.Chat2Page>(),
      ));
  gh.factory<_i212.CompanyFinanceScreen>(
      () => _i212.CompanyFinanceScreen(gh<_i168.CompanyFinanceStateManager>()));
  gh.factory<_i213.CompanyProfileScreen>(
      () => _i213.CompanyProfileScreen(gh<_i169.CompanyProfileStateManager>()));
  gh.factory<_i214.CreateSubscriptionScreen>(() =>
      _i214.CreateSubscriptionScreen(gh<_i178.InitSubscriptionStateManager>()));
  gh.factory<_i215.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i215.CreateSubscriptionToCaptainOfferScreen(
          gh<_i200.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i216.DevModule>(
      () => _i216.DevModule(gh<_i181.NewTestOrderScreen>()));
  gh.factory<_i217.EditSubscriptionScreen>(() =>
      _i217.EditSubscriptionScreen(gh<_i173.EditSubscriptionStateManager>()));
  gh.factory<_i218.InActiveSupplierScreen>(() =>
      _i218.InActiveSupplierScreen(gh<_i176.InActiveSupplierStateManager>()));
  gh.factory<_i219.InitBranchesScreen>(
      () => _i219.InitBranchesScreen(gh<_i177.InitBranchesStateManager>()));
  gh.factory<_i220.MyNotificationsModule>(() => _i220.MyNotificationsModule(
        gh<_i180.MyNotificationsScreen>(),
        gh<_i207.UpdateScreen>(),
      ));
  gh.factory<_i221.NoticeModule>(
      () => _i221.NoticeModule(gh<_i182.NoticeScreen>()));
  gh.factory<_i222.ReceiptsScreen>(
      () => _i222.ReceiptsScreen(gh<_i188.ReceiptsStateManager>()));
  gh.factory<_i223.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i223.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i193.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i224.StoreSubscriptionsFinanceScreen>(() =>
      _i224.StoreSubscriptionsFinanceScreen(
          gh<_i195.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i225.SubscriptionsModule>(() => _i225.SubscriptionsModule(
        gh<_i194.StoreSubscriptionsFinanceDetailsScreen>(),
        gh<_i224.StoreSubscriptionsFinanceScreen>(),
        gh<_i199.SubscriptionManagementScreen>(),
        gh<_i223.StoreSubscriptionsExpiredFinanceScreen>(),
        gh<_i214.CreateSubscriptionScreen>(),
        gh<_i215.CreateSubscriptionToCaptainOfferScreen>(),
        gh<_i217.EditSubscriptionScreen>(),
        gh<_i222.ReceiptsScreen>(),
      ));
  gh.factory<_i226.SupplierAdsScreen>(
      () => _i226.SupplierAdsScreen(gh<_i201.SupplierAdsStateManager>()));
  gh.factory<_i227.SupplierCategoriesModule>(() =>
      _i227.SupplierCategoriesModule(gh<_i202.SupplierCategoriesScreen>()));
  gh.factory<_i228.SupplierNeedsSupportScreen>(() =>
      _i228.SupplierNeedsSupportScreen(
          gh<_i203.SupplierNeedsSupportStateManager>()));
  gh.factory<_i229.SupplierProfileScreen>(() =>
      _i229.SupplierProfileScreen(gh<_i204.SupplierProfileStateManager>()));
  gh.factory<_i230.UpdateBranchScreen>(
      () => _i230.UpdateBranchScreen(gh<_i206.UpdateBranchStateManager>()));
  gh.factory<_i231.BranchesModule>(() => _i231.BranchesModule(
        gh<_i208.BranchesListScreen>(),
        gh<_i230.UpdateBranchScreen>(),
        gh<_i219.InitBranchesScreen>(),
      ));
  gh.factory<_i232.CompanyModule>(() => _i232.CompanyModule(
        gh<_i213.CompanyProfileScreen>(),
        gh<_i212.CompanyFinanceScreen>(),
      ));
  gh.factory<_i233.SupplierModule>(() => _i233.SupplierModule(
        gh<_i218.InActiveSupplierScreen>(),
        gh<_i205.SuppliersScreen>(),
        gh<_i229.SupplierProfileScreen>(),
        gh<_i228.SupplierNeedsSupportScreen>(),
        gh<_i226.SupplierAdsScreen>(),
      ));
  gh.factory<_i234.MyApp>(() => _i234.MyApp(
        gh<_i33.AppThemeDataService>(),
        gh<_i20.LocalizationService>(),
        gh<_i95.FireNotificationService>(),
        gh<_i18.LocalNotificationService>(),
        gh<_i128.SplashModule>(),
        gh<_i146.AuthorizationModule>(),
        gh<_i211.ChatModule>(),
        gh<_i127.SettingsModule>(),
        gh<_i179.MainModule>(),
        gh<_i30.StoresModule>(),
        gh<_i209.CategoriesModule>(),
        gh<_i232.CompanyModule>(),
        gh<_i231.BranchesModule>(),
        gh<_i221.NoticeModule>(),
        gh<_i10.CaptainsModule>(),
        gh<_i27.PaymentsModule>(),
        gh<_i227.SupplierCategoriesModule>(),
        gh<_i233.SupplierModule>(),
        gh<_i12.CarsModule>(),
        gh<_i148.BidOrderModule>(),
        gh<_i26.OrdersModule>(),
        gh<_i225.SubscriptionsModule>(),
        gh<_i220.MyNotificationsModule>(),
        gh<_i28.StatisticsModule>(),
        gh<_i216.DevModule>(),
        gh<_i15.ExternalDeliveryCompaniesModule>(),
      ));
  return getIt;
}

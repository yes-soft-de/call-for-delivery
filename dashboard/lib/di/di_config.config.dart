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
import '../main.dart' as _i232;
import '../module_auth/authoriazation_module.dart' as _i140;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i32;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i6;
import '../module_auth/service/auth_service/auth_service.dart' as _i33;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i44;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i46;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i55;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i90;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i96;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i120;
import '../module_bid_order/bid_order_module.dart' as _i142;
import '../module_bid_order/manager/bid_order_manager.dart' as _i68;
import '../module_bid_order/repository/bid_order_repository.dart' as _i34;
import '../module_bid_order/service/bid_order_service.dart' as _i69;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i70;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i71;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i141;
import '../module_branches/branches_module.dart' as _i229;
import '../module_branches/manager/branches_manager.dart' as _i72;
import '../module_branches/repository/branches_repository.dart' as _i35;
import '../module_branches/service/branches_list_service.dart' as _i143;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i144;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i172;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i201;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i204;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i217;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i228;
import '../module_captain/captains_module.dart' as _i10;
import '../module_captain/hive/captain_hive_helper.dart' as _i9;
import '../module_captain/manager/captains_manager.dart' as _i73;
import '../module_captain/repository/captains_repository.dart' as _i36;
import '../module_captain/service/captains_service.dart' as _i74;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i145;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i156;
import '../module_captain/state_manager/captain_dues_state_manager.dart'
    as _i147;
import '../module_captain/state_manager/captain_list.dart' as _i75;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i157;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i151;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i146;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i154;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i158;
import '../module_captain/state_manager/caption_rating_details_state_manager.dart'
    as _i155;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i95;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i119;
import '../module_captain/ui/screen/captain_dues_screen.dart' as _i8;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i11;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i7;
import '../module_categories/categories_module.dart' as _i205;
import '../module_categories/manager/categories_manager.dart' as _i76;
import '../module_categories/repository/categories_repository.dart' as _i37;
import '../module_categories/service/store_categories_service.dart' as _i77;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i114;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i115;
import '../module_categories/ui/screen/categories_screen.dart' as _i159;
import '../module_categories/ui/screen/packages_screen.dart' as _i182;
import '../module_chat/chat_module.dart' as _i206;
import '../module_chat/manager/chat/chat_manager.dart' as _i78;
import '../module_chat/presistance/chat_hive_helper.dart' as _i13;
import '../module_chat/repository/chat/chat_repository.dart' as _i38;
import '../module_chat/service/chat/char_service.dart' as _i79;
import '../module_chat/state_manager/chat_state_manager.dart' as _i80;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i160;
import '../module_company/company_module.dart' as _i230;
import '../module_company/manager/company_manager.dart' as _i81;
import '../module_company/repository/company_repository.dart' as _i40;
import '../module_company/service/company_service.dart' as _i82;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i161;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i162;
import '../module_company/ui/screen/company_finance_screen.dart' as _i207;
import '../module_company/ui/screen/company_profile_screen.dart' as _i208;
import '../module_deep_links/repository/deep_link_repository.dart' as _i41;
import '../module_delivary_car/cars_module.dart' as _i12;
import '../module_dev/dev_module.dart' as _i212;
import '../module_dev/hive/order_hive_helper.dart' as _i22;
import '../module_dev/manager/dev_manager.dart' as _i83;
import '../module_dev/repository/dev_repository.dart' as _i42;
import '../module_dev/service/orders/dev.service.dart' as _i84;
import '../module_dev/state_manager/new_order/new_test_order_state_manager.dart'
    as _i102;
import '../module_dev/ui/screens/new_test_order/new_test_order_screen.dart'
    as _i176;
import '../module_external_delivery_companies/external_delivery_companies_module.dart'
    as _i215;
import '../module_external_delivery_companies/manager/external_delivery_companies_manager.dart'
    as _i85;
import '../module_external_delivery_companies/repository/external_delivery_companies_repository.dart'
    as _i43;
import '../module_external_delivery_companies/service/external_delivery_companies_service.dart'
    as _i86;
import '../module_external_delivery_companies/state_manager/assign_order_to_external_company_state_manager.dart'
    as _i139;
import '../module_external_delivery_companies/state_manager/delivery_copmany_all_settings_state_manager.dart'
    as _i163;
import '../module_external_delivery_companies/state_manager/edit_delivery_company_setting_state_manager.dart'
    as _i164;
import '../module_external_delivery_companies/state_manager/external_delivery_companies_state_manager.dart'
    as _i87;
import '../module_external_delivery_companies/state_manager/external_orders_state_manager.dart'
    as _i88;
import '../module_external_delivery_companies/ui/screen/assign_order_to_external_company_screen.dart'
    as _i203;
import '../module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart'
    as _i211;
import '../module_external_delivery_companies/ui/screen/edit_delivery_company_setting_screen.dart'
    as _i213;
import '../module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart'
    as _i167;
import '../module_external_delivery_companies/ui/screen/external_orders_screen.dart'
    as _i168;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i17;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i18;
import '../module_main/main_module.dart' as _i174;
import '../module_main/manager/home_manager.dart' as _i91;
import '../module_main/repository/home_repository.dart' as _i45;
import '../module_main/sceen/home_screen.dart' as _i170;
import '../module_main/sceen/main_screen.dart' as _i20;
import '../module_main/service/home_service.dart' as _i92;
import '../module_main/state_manager/home_state_manager.dart' as _i93;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i97;
import '../module_my_notifications/my_notifications_module.dart' as _i218;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i47;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i98;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i99;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i138;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i175;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i202;
import '../module_network/http_client/http_client.dart' as _i3;
import '../module_notice/manager/notice_manager.dart' as _i103;
import '../module_notice/notice_module.dart' as _i219;
import '../module_notice/repository/notice_repository.dart' as _i48;
import '../module_notice/service/notice_service.dart' as _i104;
import '../module_notice/state_manager/notice_state_manager.dart' as _i105;
import '../module_notice/ui/screen/notice_screen.dart' as _i177;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i21;
import '../module_notifications/repository/notification_repo.dart' as _i49;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i89;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i16;
import '../module_orders/hive/order_hive_helper.dart' as _i23;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i51;
import '../module_orders/orders_module.dart' as _i24;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i50;
import '../module_orders/service/orders/orders.service.dart' as _i52;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i101;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i100;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i66;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i106;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i107;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i108;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i112;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i109;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i110;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i113;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i111;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i54;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i56;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i61;
import '../module_payments/manager/payments_manager.dart' as _i116;
import '../module_payments/payments_module.dart' as _i25;
import '../module_payments/repository/payments_repository.dart' as _i53;
import '../module_payments/service/payments_service.dart' as _i117;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i148;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i149;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i150;
import '../module_payments/state_manager/captain_payment_state_manager.dart'
    as _i152;
import '../module_payments/state_manager/captain_previous_payments.dart'
    as _i153;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i118;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i126;
import '../module_settings/settings_module.dart' as _i121;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i39;
import '../module_settings/ui/settings_page/settings_page.dart' as _i57;
import '../module_splash/splash_module.dart' as _i122;
import '../module_splash/ui/screen/splash_screen.dart' as _i58;
import '../module_statistics/manager/statistic_manager.dart' as _i123;
import '../module_statistics/repository/statistics_repository.dart' as _i59;
import '../module_statistics/service/statistics_service.dart' as _i124;
import '../module_statistics/state_manager/statistics_state_manager.dart'
    as _i125;
import '../module_statistics/ui/statistics_module.dart' as _i26;
import '../module_stores/hive/store_hive_helper.dart' as _i27;
import '../module_stores/manager/stores_manager.dart' as _i127;
import '../module_stores/repository/stores_repository.dart' as _i60;
import '../module_stores/service/store_service.dart' as _i128;
import '../module_stores/state_manager/edit_store_setting_state_manager.dart'
    as _i165;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i169;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i178;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i179;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i180;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i181;
import '../module_stores/state_manager/store_dues_state_manager.dart' as _i184;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i186;
import '../module_stores/state_manager/stores_dues_state_manager.dart' as _i191;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i192;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i193;
import '../module_stores/state_manager/stores_state_manager.dart' as _i129;
import '../module_stores/state_manager/top_active_store.dart' as _i137;
import '../module_stores/stores_module.dart' as _i28;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i130;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i62;
import '../module_subscriptions/service/subscriptions_service.dart' as _i131;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i166;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i173;
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
import '../module_subscriptions/subscriptions_module.dart' as _i223;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i214;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i209;
import '../module_subscriptions/ui/screen/receipts_screen.dart' as _i220;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i189;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i221;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i222;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i210;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i194;
import '../module_supplier/manager/supplier_manager.dart' as _i65;
import '../module_supplier/repository/supplier_repository.dart' as _i64;
import '../module_supplier/service/supplier_service.dart' as _i135;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i171;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i196;
import '../module_supplier/state_manager/supplier_list.dart' as _i136;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i198;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i199;
import '../module_supplier/supplier_module.dart' as _i231;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i216;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i224;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i200;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i226;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i227;
import '../module_supplier_categories/categories_supplier_module.dart' as _i225;
import '../module_supplier_categories/manager/categories_manager.dart' as _i132;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i63;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i133;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i134;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i197;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i29;
import '../module_theme/service/theme_service/theme_service.dart' as _i31;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i67;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i30;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i94;
import '../utils/global/global_state_manager.dart' as _i15;
import '../utils/helpers/firestore_helper.dart' as _i14;
import '../utils/logger/logger.dart' as _i19;

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
  gh.factory<_i14.FireStoreHelper>(() => _i14.FireStoreHelper());
  gh.singleton<_i15.GlobalStateManager>(_i15.GlobalStateManager());
  gh.factory<_i16.LocalNotificationService>(
      () => _i16.LocalNotificationService());
  gh.factory<_i17.LocalizationPreferencesHelper>(
      () => _i17.LocalizationPreferencesHelper());
  gh.factory<_i18.LocalizationService>(
      () => _i18.LocalizationService(gh<_i17.LocalizationPreferencesHelper>()));
  gh.factory<_i19.Logger>(() => _i19.Logger());
  gh.factory<_i20.MainScreen>(() => _i20.MainScreen());
  gh.factory<_i21.NotificationsPrefHelper>(
      () => _i21.NotificationsPrefHelper());
  gh.factory<_i22.OrderHiveHelper>(() => _i22.OrderHiveHelper());
  gh.factory<_i23.OrderHiveHelper>(() => _i23.OrderHiveHelper());
  gh.factory<_i24.OrdersModule>(() => _i24.OrdersModule());
  gh.factory<_i25.PaymentsModule>(() => _i25.PaymentsModule());
  gh.factory<_i26.StatisticsModule>(() => _i26.StatisticsModule());
  gh.factory<_i27.StoresHiveHelper>(() => _i27.StoresHiveHelper());
  gh.factory<_i28.StoresModule>(() => _i28.StoresModule());
  gh.factory<_i29.ThemePreferencesHelper>(() => _i29.ThemePreferencesHelper());
  gh.factory<_i30.UploadRepository>(() => _i30.UploadRepository());
  gh.factory<_i31.AppThemeDataService>(
      () => _i31.AppThemeDataService(gh<_i29.ThemePreferencesHelper>()));
  gh.factory<_i32.AuthManager>(
      () => _i32.AuthManager(gh<_i6.AuthRepository>()));
  gh.factory<_i33.AuthService>(() => _i33.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i32.AuthManager>(),
      ));
  gh.factory<_i34.BidOrderRepository>(() => _i34.BidOrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i35.BranchesRepository>(() => _i35.BranchesRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i36.CaptainsRepository>(() => _i36.CaptainsRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i37.CategoriesRepository>(() => _i37.CategoriesRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i38.ChatRepository>(() => _i38.ChatRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i39.ChooseLocalScreen>(
      () => _i39.ChooseLocalScreen(gh<_i18.LocalizationService>()));
  gh.factory<_i40.CompanyRepository>(() => _i40.CompanyRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i41.DeepLinkRepository>(() => _i41.DeepLinkRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i42.DevRepository>(() => _i42.DevRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i43.ExternalDeliveryCompaniesRepository>(
      () => _i43.ExternalDeliveryCompaniesRepository(
            gh<_i3.ApiClient>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i44.ForgotPassStateManager>(
      () => _i44.ForgotPassStateManager(gh<_i33.AuthService>()));
  gh.factory<_i45.HomeRepository>(() => _i45.HomeRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i46.LoginStateManager>(
      () => _i46.LoginStateManager(gh<_i33.AuthService>()));
  gh.factory<_i47.MyNotificationsRepository>(
      () => _i47.MyNotificationsRepository(
            gh<_i3.ApiClient>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i48.NoticeRepository>(() => _i48.NoticeRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i49.NotificationRepo>(() => _i49.NotificationRepo(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i50.OrderRepository>(() => _i50.OrderRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i51.OrdersManager>(
      () => _i51.OrdersManager(gh<_i50.OrderRepository>()));
  gh.factory<_i52.OrdersService>(
      () => _i52.OrdersService(gh<_i51.OrdersManager>()));
  gh.factory<_i53.PaymentsRepository>(() => _i53.PaymentsRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i54.RecycleOrderStateManager>(
      () => _i54.RecycleOrderStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i55.RegisterStateManager>(
      () => _i55.RegisterStateManager(gh<_i33.AuthService>()));
  gh.factory<_i56.SearchForOrderStateManager>(
      () => _i56.SearchForOrderStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i57.SettingsScreen>(() => _i57.SettingsScreen(
        gh<_i33.AuthService>(),
        gh<_i18.LocalizationService>(),
        gh<_i31.AppThemeDataService>(),
      ));
  gh.factory<_i58.SplashScreen>(
      () => _i58.SplashScreen(gh<_i33.AuthService>()));
  gh.factory<_i59.StatisticsRepository>(() => _i59.StatisticsRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i60.StoresRepository>(() => _i60.StoresRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i61.SubOrdersStateManager>(
      () => _i61.SubOrdersStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i62.SubscriptionsRepository>(() => _i62.SubscriptionsRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i63.SupplierCategoriesRepository>(
      () => _i63.SupplierCategoriesRepository(
            gh<_i3.ApiClient>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i64.SupplierRepository>(() => _i64.SupplierRepository(
        gh<_i3.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i65.SuppliersManager>(
      () => _i65.SuppliersManager(gh<_i64.SupplierRepository>()));
  gh.factory<_i66.UpdateOrderStateManager>(
      () => _i66.UpdateOrderStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i67.UploadManager>(
      () => _i67.UploadManager(gh<_i30.UploadRepository>()));
  gh.factory<_i68.BidOrderManager>(
      () => _i68.BidOrderManager(gh<_i34.BidOrderRepository>()));
  gh.factory<_i69.BidOrderService>(
      () => _i69.BidOrderService(gh<_i68.BidOrderManager>()));
  gh.factory<_i70.BidOrderStateManager>(
      () => _i70.BidOrderStateManager(gh<_i69.BidOrderService>()));
  gh.factory<_i71.BidOrdersScreen>(
      () => _i71.BidOrdersScreen(gh<_i70.BidOrderStateManager>()));
  gh.factory<_i72.BranchesManager>(
      () => _i72.BranchesManager(gh<_i35.BranchesRepository>()));
  gh.factory<_i73.CaptainsManager>(
      () => _i73.CaptainsManager(gh<_i36.CaptainsRepository>()));
  gh.factory<_i74.CaptainsService>(
      () => _i74.CaptainsService(gh<_i73.CaptainsManager>()));
  gh.factory<_i75.CaptainsStateManager>(
      () => _i75.CaptainsStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i76.CategoriesManager>(
      () => _i76.CategoriesManager(gh<_i37.CategoriesRepository>()));
  gh.factory<_i77.CategoriesService>(
      () => _i77.CategoriesService(gh<_i76.CategoriesManager>()));
  gh.factory<_i78.ChatManager>(
      () => _i78.ChatManager(gh<_i38.ChatRepository>()));
  gh.factory<_i79.ChatService>(() => _i79.ChatService(gh<_i78.ChatManager>()));
  gh.factory<_i80.ChatStateManager>(
      () => _i80.ChatStateManager(gh<_i79.ChatService>()));
  gh.factory<_i81.CompanyManager>(
      () => _i81.CompanyManager(gh<_i40.CompanyRepository>()));
  gh.factory<_i82.CompanyService>(
      () => _i82.CompanyService(gh<_i81.CompanyManager>()));
  gh.factory<_i83.DevManager>(() => _i83.DevManager(gh<_i42.DevRepository>()));
  gh.factory<_i84.DevService>(() => _i84.DevService(gh<_i83.DevManager>()));
  gh.factory<_i85.ExternalDeliveryCompaniesManager>(() =>
      _i85.ExternalDeliveryCompaniesManager(
          gh<_i43.ExternalDeliveryCompaniesRepository>()));
  gh.factory<_i86.ExternalDeliveryCompaniesService>(() =>
      _i86.ExternalDeliveryCompaniesService(
          gh<_i85.ExternalDeliveryCompaniesManager>()));
  gh.factory<_i87.ExternalDeliveryCompaniesStateManager>(() =>
      _i87.ExternalDeliveryCompaniesStateManager(
          gh<_i86.ExternalDeliveryCompaniesService>()));
  gh.factory<_i88.ExternalOrdersStateManager>(() =>
      _i88.ExternalOrdersStateManager(
          gh<_i86.ExternalDeliveryCompaniesService>()));
  gh.factory<_i89.FireNotificationService>(
      () => _i89.FireNotificationService(gh<_i49.NotificationRepo>()));
  gh.factory<_i90.ForgotPassScreen>(
      () => _i90.ForgotPassScreen(gh<_i44.ForgotPassStateManager>()));
  gh.factory<_i91.HomeManager>(
      () => _i91.HomeManager(gh<_i45.HomeRepository>()));
  gh.factory<_i92.HomeService>(() => _i92.HomeService(gh<_i91.HomeManager>()));
  gh.factory<_i93.HomeStateManager>(
      () => _i93.HomeStateManager(gh<_i92.HomeService>()));
  gh.factory<_i94.ImageUploadService>(
      () => _i94.ImageUploadService(gh<_i67.UploadManager>()));
  gh.factory<_i95.InActiveCaptainsStateManager>(
      () => _i95.InActiveCaptainsStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i96.LoginScreen>(
      () => _i96.LoginScreen(gh<_i46.LoginStateManager>()));
  gh.factory<_i97.MyNotificationsManager>(
      () => _i97.MyNotificationsManager(gh<_i47.MyNotificationsRepository>()));
  gh.factory<_i98.MyNotificationsService>(
      () => _i98.MyNotificationsService(gh<_i97.MyNotificationsManager>()));
  gh.factory<_i99.MyNotificationsStateManager>(
      () => _i99.MyNotificationsStateManager(
            gh<_i98.MyNotificationsService>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i100.NewOrderLinkStateManager>(
      () => _i100.NewOrderLinkStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i101.NewOrderStateManager>(
      () => _i101.NewOrderStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i102.NewTestOrderStateManager>(
      () => _i102.NewTestOrderStateManager(gh<_i84.DevService>()));
  gh.factory<_i103.NoticeManager>(
      () => _i103.NoticeManager(gh<_i48.NoticeRepository>()));
  gh.factory<_i104.NoticeService>(
      () => _i104.NoticeService(gh<_i103.NoticeManager>()));
  gh.factory<_i105.NoticeStateManager>(
      () => _i105.NoticeStateManager(gh<_i104.NoticeService>()));
  gh.factory<_i106.OrderActionLogsStateManager>(
      () => _i106.OrderActionLogsStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i107.OrderCaptainLogsStateManager>(
      () => _i107.OrderCaptainLogsStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i108.OrderCashCaptainStateManager>(
      () => _i108.OrderCashCaptainStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i109.OrderDistanceConflictStateManager>(
      () => _i109.OrderDistanceConflictStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i110.OrderPendingStateManager>(
      () => _i110.OrderPendingStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i111.OrderWithoutDistanceStateManager>(
      () => _i111.OrderWithoutDistanceStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i112.OrdersCashStoreStateManager>(
      () => _i112.OrdersCashStoreStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i113.OrdersReceiveCashStateManager>(
      () => _i113.OrdersReceiveCashStateManager(gh<_i52.OrdersService>()));
  gh.factory<_i114.PackageCategoriesStateManager>(
      () => _i114.PackageCategoriesStateManager(gh<_i77.CategoriesService>()));
  gh.factory<_i115.PackagesStateManager>(
      () => _i115.PackagesStateManager(gh<_i77.CategoriesService>()));
  gh.factory<_i116.PaymentsManager>(
      () => _i116.PaymentsManager(gh<_i53.PaymentsRepository>()));
  gh.factory<_i117.PaymentsService>(
      () => _i117.PaymentsService(gh<_i116.PaymentsManager>()));
  gh.factory<_i118.PaymentsToCaptainStateManager>(
      () => _i118.PaymentsToCaptainStateManager(gh<_i117.PaymentsService>()));
  gh.factory<_i119.PlanScreenStateManager>(
      () => _i119.PlanScreenStateManager(gh<_i117.PaymentsService>()));
  gh.factory<_i120.RegisterScreen>(
      () => _i120.RegisterScreen(gh<_i55.RegisterStateManager>()));
  gh.factory<_i121.SettingsModule>(() => _i121.SettingsModule(
        gh<_i57.SettingsScreen>(),
        gh<_i39.ChooseLocalScreen>(),
      ));
  gh.factory<_i122.SplashModule>(
      () => _i122.SplashModule(gh<_i58.SplashScreen>()));
  gh.factory<_i123.StatisticManager>(
      () => _i123.StatisticManager(gh<_i59.StatisticsRepository>()));
  gh.factory<_i124.StatisticsService>(
      () => _i124.StatisticsService(gh<_i123.StatisticManager>()));
  gh.factory<_i125.StatisticsStateManager>(
      () => _i125.StatisticsStateManager(gh<_i124.StatisticsService>()));
  gh.factory<_i126.StoreBalanceStateManager>(
      () => _i126.StoreBalanceStateManager(gh<_i117.PaymentsService>()));
  gh.factory<_i127.StoreManager>(
      () => _i127.StoreManager(gh<_i60.StoresRepository>()));
  gh.factory<_i128.StoresService>(
      () => _i128.StoresService(gh<_i127.StoreManager>()));
  gh.factory<_i129.StoresStateManager>(() => _i129.StoresStateManager(
        gh<_i128.StoresService>(),
        gh<_i94.ImageUploadService>(),
      ));
  gh.factory<_i130.SubscriptionsManager>(
      () => _i130.SubscriptionsManager(gh<_i62.SubscriptionsRepository>()));
  gh.factory<_i131.SubscriptionsService>(
      () => _i131.SubscriptionsService(gh<_i130.SubscriptionsManager>()));
  gh.factory<_i132.SupplierCategoriesManager>(() =>
      _i132.SupplierCategoriesManager(gh<_i63.SupplierCategoriesRepository>()));
  gh.factory<_i133.SupplierCategoriesService>(() =>
      _i133.SupplierCategoriesService(gh<_i132.SupplierCategoriesManager>()));
  gh.factory<_i134.SupplierCategoriesStateManager>(
      () => _i134.SupplierCategoriesStateManager(
            gh<_i133.SupplierCategoriesService>(),
            gh<_i94.ImageUploadService>(),
          ));
  gh.factory<_i135.SupplierService>(
      () => _i135.SupplierService(gh<_i65.SuppliersManager>()));
  gh.factory<_i136.SuppliersStateManager>(
      () => _i136.SuppliersStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i137.TopActiveStateManagement>(
      () => _i137.TopActiveStateManagement(gh<_i128.StoresService>()));
  gh.factory<_i138.UpdatesStateManager>(() => _i138.UpdatesStateManager(
        gh<_i98.MyNotificationsService>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i139.AssignOrderToExternalCompanyStateManager>(() =>
      _i139.AssignOrderToExternalCompanyStateManager(
          gh<_i86.ExternalDeliveryCompaniesService>()));
  gh.factory<_i140.AuthorizationModule>(() => _i140.AuthorizationModule(
        gh<_i96.LoginScreen>(),
        gh<_i120.RegisterScreen>(),
        gh<_i90.ForgotPassScreen>(),
      ));
  gh.factory<_i141.BidOrderDetailsScreen>(
      () => _i141.BidOrderDetailsScreen(gh<_i70.BidOrderStateManager>()));
  gh.factory<_i142.BidOrderModule>(
      () => _i142.BidOrderModule(gh<_i71.BidOrdersScreen>()));
  gh.factory<_i143.BranchesListService>(
      () => _i143.BranchesListService(gh<_i72.BranchesManager>()));
  gh.factory<_i144.BranchesListStateManager>(
      () => _i144.BranchesListStateManager(gh<_i143.BranchesListService>()));
  gh.factory<_i145.CaptainActivityDetailsStateManager>(() =>
      _i145.CaptainActivityDetailsStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i146.CaptainAssignOrderStateManager>(
      () => _i146.CaptainAssignOrderStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i147.CaptainDuesStateManager>(
      () => _i147.CaptainDuesStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i148.CaptainFinanceByHoursStateManager>(() =>
      _i148.CaptainFinanceByHoursStateManager(gh<_i117.PaymentsService>()));
  gh.factory<_i149.CaptainFinanceByOrderCountStateManager>(() =>
      _i149.CaptainFinanceByOrderCountStateManager(
          gh<_i117.PaymentsService>()));
  gh.factory<_i150.CaptainFinanceByOrderStateManager>(() =>
      _i150.CaptainFinanceByOrderStateManager(gh<_i117.PaymentsService>()));
  gh.factory<_i151.CaptainOfferStateManager>(
      () => _i151.CaptainOfferStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i152.CaptainPaymentStateManager>(
      () => _i152.CaptainPaymentStateManager(gh<_i117.PaymentsService>()));
  gh.factory<_i153.CaptainPreviousPaymentsStateManager>(() =>
      _i153.CaptainPreviousPaymentsStateManager(gh<_i117.PaymentsService>()));
  gh.factory<_i154.CaptainProfileStateManager>(
      () => _i154.CaptainProfileStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i155.CaptainRatingDetailsStateManager>(
      () => _i155.CaptainRatingDetailsStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i156.CaptainsActivityStateManager>(
      () => _i156.CaptainsActivityStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i157.CaptainsNeedsSupportStateManager>(
      () => _i157.CaptainsNeedsSupportStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i158.CaptainsRatingStateManager>(
      () => _i158.CaptainsRatingStateManager(gh<_i74.CaptainsService>()));
  gh.factory<_i159.CategoriesScreen>(
      () => _i159.CategoriesScreen(gh<_i114.PackageCategoriesStateManager>()));
  gh.factory<_i160.ChatPage>(() => _i160.ChatPage(
        gh<_i80.ChatStateManager>(),
        gh<_i94.ImageUploadService>(),
        gh<_i33.AuthService>(),
        gh<_i13.ChatHiveHelper>(),
      ));
  gh.factory<_i161.CompanyFinanceStateManager>(
      () => _i161.CompanyFinanceStateManager(gh<_i82.CompanyService>()));
  gh.factory<_i162.CompanyProfileStateManager>(
      () => _i162.CompanyProfileStateManager(gh<_i82.CompanyService>()));
  gh.factory<_i163.DeliveryCompanyAllSettingsStateManager>(() =>
      _i163.DeliveryCompanyAllSettingsStateManager(
          gh<_i86.ExternalDeliveryCompaniesService>()));
  gh.factory<_i164.EditDeliveryCompanySettingScreenStateManager>(() =>
      _i164.EditDeliveryCompanySettingScreenStateManager(
          gh<_i86.ExternalDeliveryCompaniesService>()));
  gh.factory<_i165.EditStoreSettingStateManager>(
      () => _i165.EditStoreSettingStateManager(
            gh<_i128.StoresService>(),
            gh<_i94.ImageUploadService>(),
          ));
  gh.factory<_i166.EditSubscriptionStateManager>(() =>
      _i166.EditSubscriptionStateManager(gh<_i131.SubscriptionsService>()));
  gh.factory<_i167.ExternalDeliveryCompaniesScreen>(() =>
      _i167.ExternalDeliveryCompaniesScreen(
          gh<_i87.ExternalDeliveryCompaniesStateManager>()));
  gh.factory<_i168.ExternalOrderScreen>(
      () => _i168.ExternalOrderScreen(gh<_i88.ExternalOrdersStateManager>()));
  gh.factory<_i169.FilterOrderTopStateManager>(
      () => _i169.FilterOrderTopStateManager(gh<_i128.StoresService>()));
  gh.factory<_i170.HomeScreen>(
      () => _i170.HomeScreen(gh<_i93.HomeStateManager>()));
  gh.factory<_i171.InActiveSupplierStateManager>(
      () => _i171.InActiveSupplierStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i172.InitBranchesStateManager>(
      () => _i172.InitBranchesStateManager(gh<_i143.BranchesListService>()));
  gh.factory<_i173.InitSubscriptionStateManager>(() =>
      _i173.InitSubscriptionStateManager(gh<_i131.SubscriptionsService>()));
  gh.factory<_i174.MainModule>(() => _i174.MainModule(
        gh<_i20.MainScreen>(),
        gh<_i170.HomeScreen>(),
      ));
  gh.factory<_i175.MyNotificationsScreen>(() =>
      _i175.MyNotificationsScreen(gh<_i99.MyNotificationsStateManager>()));
  gh.factory<_i176.NewTestOrderScreen>(
      () => _i176.NewTestOrderScreen(gh<_i102.NewTestOrderStateManager>()));
  gh.factory<_i177.NoticeScreen>(
      () => _i177.NoticeScreen(gh<_i105.NoticeStateManager>()));
  gh.factory<_i178.OrderCaptainNotArrivedStateManager>(() =>
      _i178.OrderCaptainNotArrivedStateManager(gh<_i128.StoresService>()));
  gh.factory<_i179.OrderLogsStateManager>(
      () => _i179.OrderLogsStateManager(gh<_i128.StoresService>()));
  gh.factory<_i180.OrderStatusStateManager>(
      () => _i180.OrderStatusStateManager(gh<_i128.StoresService>()));
  gh.factory<_i181.OrderTimeLineStateManager>(
      () => _i181.OrderTimeLineStateManager(gh<_i128.StoresService>()));
  gh.factory<_i182.PackagesScreen>(
      () => _i182.PackagesScreen(gh<_i115.PackagesStateManager>()));
  gh.factory<_i183.ReceiptsStateManager>(
      () => _i183.ReceiptsStateManager(gh<_i131.SubscriptionsService>()));
  gh.factory<_i184.StoreDuesStateManager>(() => _i184.StoreDuesStateManager(
        gh<_i128.StoresService>(),
        gh<_i117.PaymentsService>(),
      ));
  gh.factory<_i185.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i185.StoreFinancialSubscriptionsDuesDetailsStateManager(
            gh<_i117.PaymentsService>(),
            gh<_i131.SubscriptionsService>(),
          ));
  gh.factory<_i186.StoreProfileStateManager>(
      () => _i186.StoreProfileStateManager(
            gh<_i128.StoresService>(),
            gh<_i94.ImageUploadService>(),
          ));
  gh.factory<_i187.StoreSubscriptionManagementStateManager>(() =>
      _i187.StoreSubscriptionManagementStateManager(
          gh<_i131.SubscriptionsService>()));
  gh.factory<_i188.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i188.StoreSubscriptionsExpiredFinanceStateManager(
          gh<_i131.SubscriptionsService>()));
  gh.factory<_i189.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i189.StoreSubscriptionsFinanceDetailsScreen(
          gh<_i185.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i190.StoreSubscriptionsFinanceStateManager>(() =>
      _i190.StoreSubscriptionsFinanceStateManager(
          gh<_i131.SubscriptionsService>()));
  gh.factory<_i191.StoresDuesStateManager>(
      () => _i191.StoresDuesStateManager(gh<_i128.StoresService>()));
  gh.factory<_i192.StoresInActiveStateManager>(
      () => _i192.StoresInActiveStateManager(
            gh<_i128.StoresService>(),
            gh<_i94.ImageUploadService>(),
          ));
  gh.factory<_i193.StoresNeedsSupportStateManager>(
      () => _i193.StoresNeedsSupportStateManager(gh<_i128.StoresService>()));
  gh.factory<_i194.SubscriptionManagementScreen>(() =>
      _i194.SubscriptionManagementScreen(
          gh<_i187.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i195.SubscriptionToCaptainOfferStateManager>(() =>
      _i195.SubscriptionToCaptainOfferStateManager(
          gh<_i131.SubscriptionsService>()));
  gh.factory<_i196.SupplierAdsStateManager>(
      () => _i196.SupplierAdsStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i197.SupplierCategoriesScreen>(() =>
      _i197.SupplierCategoriesScreen(
          gh<_i134.SupplierCategoriesStateManager>()));
  gh.factory<_i198.SupplierNeedsSupportStateManager>(() =>
      _i198.SupplierNeedsSupportStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i199.SupplierProfileStateManager>(
      () => _i199.SupplierProfileStateManager(gh<_i135.SupplierService>()));
  gh.factory<_i200.SuppliersScreen>(
      () => _i200.SuppliersScreen(gh<_i136.SuppliersStateManager>()));
  gh.factory<_i201.UpdateBranchStateManager>(
      () => _i201.UpdateBranchStateManager(gh<_i143.BranchesListService>()));
  gh.factory<_i202.UpdateScreen>(
      () => _i202.UpdateScreen(gh<_i138.UpdatesStateManager>()));
  gh.factory<_i203.AssignOrderToExternalCompanyScreen>(() =>
      _i203.AssignOrderToExternalCompanyScreen(
          gh<_i139.AssignOrderToExternalCompanyStateManager>()));
  gh.factory<_i204.BranchesListScreen>(
      () => _i204.BranchesListScreen(gh<_i144.BranchesListStateManager>()));
  gh.factory<_i205.CategoriesModule>(() => _i205.CategoriesModule(
        gh<_i159.CategoriesScreen>(),
        gh<_i182.PackagesScreen>(),
      ));
  gh.factory<_i206.ChatModule>(() => _i206.ChatModule(gh<_i160.ChatPage>()));
  gh.factory<_i207.CompanyFinanceScreen>(
      () => _i207.CompanyFinanceScreen(gh<_i161.CompanyFinanceStateManager>()));
  gh.factory<_i208.CompanyProfileScreen>(
      () => _i208.CompanyProfileScreen(gh<_i162.CompanyProfileStateManager>()));
  gh.factory<_i209.CreateSubscriptionScreen>(() =>
      _i209.CreateSubscriptionScreen(gh<_i173.InitSubscriptionStateManager>()));
  gh.factory<_i210.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i210.CreateSubscriptionToCaptainOfferScreen(
          gh<_i195.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i211.DeliveryCompanyAllSettingsScreen>(() =>
      _i211.DeliveryCompanyAllSettingsScreen(
          gh<_i163.DeliveryCompanyAllSettingsStateManager>()));
  gh.factory<_i212.DevModule>(
      () => _i212.DevModule(gh<_i176.NewTestOrderScreen>()));
  gh.factory<_i213.EditDeliveryCompanySettingScreen>(() =>
      _i213.EditDeliveryCompanySettingScreen(
          gh<_i164.EditDeliveryCompanySettingScreenStateManager>()));
  gh.factory<_i214.EditSubscriptionScreen>(() =>
      _i214.EditSubscriptionScreen(gh<_i166.EditSubscriptionStateManager>()));
  gh.factory<_i215.ExternalDeliveryCompaniesModule>(
      () => _i215.ExternalDeliveryCompaniesModule(
            gh<_i167.ExternalDeliveryCompaniesScreen>(),
            gh<_i211.DeliveryCompanyAllSettingsScreen>(),
            gh<_i213.EditDeliveryCompanySettingScreen>(),
            gh<_i203.AssignOrderToExternalCompanyScreen>(),
            gh<_i168.ExternalOrderScreen>(),
          ));
  gh.factory<_i216.InActiveSupplierScreen>(() =>
      _i216.InActiveSupplierScreen(gh<_i171.InActiveSupplierStateManager>()));
  gh.factory<_i217.InitBranchesScreen>(
      () => _i217.InitBranchesScreen(gh<_i172.InitBranchesStateManager>()));
  gh.factory<_i218.MyNotificationsModule>(() => _i218.MyNotificationsModule(
        gh<_i175.MyNotificationsScreen>(),
        gh<_i202.UpdateScreen>(),
      ));
  gh.factory<_i219.NoticeModule>(
      () => _i219.NoticeModule(gh<_i177.NoticeScreen>()));
  gh.factory<_i220.ReceiptsScreen>(
      () => _i220.ReceiptsScreen(gh<_i183.ReceiptsStateManager>()));
  gh.factory<_i221.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i221.StoreSubscriptionsExpiredFinanceScreen(
          gh<_i188.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i222.StoreSubscriptionsFinanceScreen>(() =>
      _i222.StoreSubscriptionsFinanceScreen(
          gh<_i190.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i223.SubscriptionsModule>(() => _i223.SubscriptionsModule(
        gh<_i189.StoreSubscriptionsFinanceDetailsScreen>(),
        gh<_i222.StoreSubscriptionsFinanceScreen>(),
        gh<_i194.SubscriptionManagementScreen>(),
        gh<_i221.StoreSubscriptionsExpiredFinanceScreen>(),
        gh<_i209.CreateSubscriptionScreen>(),
        gh<_i210.CreateSubscriptionToCaptainOfferScreen>(),
        gh<_i214.EditSubscriptionScreen>(),
        gh<_i220.ReceiptsScreen>(),
      ));
  gh.factory<_i224.SupplierAdsScreen>(
      () => _i224.SupplierAdsScreen(gh<_i196.SupplierAdsStateManager>()));
  gh.factory<_i225.SupplierCategoriesModule>(() =>
      _i225.SupplierCategoriesModule(gh<_i197.SupplierCategoriesScreen>()));
  gh.factory<_i226.SupplierNeedsSupportScreen>(() =>
      _i226.SupplierNeedsSupportScreen(
          gh<_i198.SupplierNeedsSupportStateManager>()));
  gh.factory<_i227.SupplierProfileScreen>(() =>
      _i227.SupplierProfileScreen(gh<_i199.SupplierProfileStateManager>()));
  gh.factory<_i228.UpdateBranchScreen>(
      () => _i228.UpdateBranchScreen(gh<_i201.UpdateBranchStateManager>()));
  gh.factory<_i229.BranchesModule>(() => _i229.BranchesModule(
        gh<_i204.BranchesListScreen>(),
        gh<_i228.UpdateBranchScreen>(),
        gh<_i217.InitBranchesScreen>(),
      ));
  gh.factory<_i230.CompanyModule>(() => _i230.CompanyModule(
        gh<_i208.CompanyProfileScreen>(),
        gh<_i207.CompanyFinanceScreen>(),
      ));
  gh.factory<_i231.SupplierModule>(() => _i231.SupplierModule(
        gh<_i216.InActiveSupplierScreen>(),
        gh<_i200.SuppliersScreen>(),
        gh<_i227.SupplierProfileScreen>(),
        gh<_i226.SupplierNeedsSupportScreen>(),
        gh<_i224.SupplierAdsScreen>(),
      ));
  gh.factory<_i232.MyApp>(() => _i232.MyApp(
        gh<_i31.AppThemeDataService>(),
        gh<_i18.LocalizationService>(),
        gh<_i89.FireNotificationService>(),
        gh<_i16.LocalNotificationService>(),
        gh<_i122.SplashModule>(),
        gh<_i140.AuthorizationModule>(),
        gh<_i206.ChatModule>(),
        gh<_i121.SettingsModule>(),
        gh<_i174.MainModule>(),
        gh<_i28.StoresModule>(),
        gh<_i205.CategoriesModule>(),
        gh<_i230.CompanyModule>(),
        gh<_i229.BranchesModule>(),
        gh<_i219.NoticeModule>(),
        gh<_i10.CaptainsModule>(),
        gh<_i25.PaymentsModule>(),
        gh<_i225.SupplierCategoriesModule>(),
        gh<_i231.SupplierModule>(),
        gh<_i12.CarsModule>(),
        gh<_i142.BidOrderModule>(),
        gh<_i24.OrdersModule>(),
        gh<_i223.SubscriptionsModule>(),
        gh<_i218.MyNotificationsModule>(),
        gh<_i26.StatisticsModule>(),
        gh<_i212.DevModule>(),
        gh<_i215.ExternalDeliveryCompaniesModule>(),
      ));
  return getIt;
}

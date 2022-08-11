// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hive/util/argument_hive_helper.dart' as _i3;
import '../main.dart' as _i201;
import '../module_auth/authoriazation_module.dart' as _i107;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i22;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../module_auth/service/auth_service/auth_service.dart' as _i23;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i32;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i35;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i42;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i68;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i73;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i93;
import '../module_bid_order/bid_order_module.dart' as _i109;
import '../module_bid_order/manager/bid_order_manager.dart' as _i49;
import '../module_bid_order/repository/bid_order_repository.dart' as _i24;
import '../module_bid_order/service/bid_order_service.dart' as _i50;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i51;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i52;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i108;
import '../module_branches/branches_module.dart' as _i196;
import '../module_branches/manager/branches_manager.dart' as _i53;
import '../module_branches/repository/branches_repository.dart' as _i25;
import '../module_branches/service/branches_list_service.dart' as _i110;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i111;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i132;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i163;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i164;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i179;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i195;
import '../module_captain/captains_module.dart' as _i197;
import '../module_captain/hive/captain_hive_helper.dart' as _i5;
import '../module_captain/manager/captains_manager.dart' as _i54;
import '../module_captain/repository/captains_repository.dart' as _i26;
import '../module_captain/service/captains_service.dart' as _i55;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i106;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i117;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i118;
import '../module_captain/state_manager/captain_list.dart' as _i56;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i122;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i119;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i113;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i121;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i72;
import '../module_captain/state_manager/plan_screen_state_manager.dart' as _i92;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i112;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i169;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i170;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i172;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i171;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i165;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i123;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i120;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i148;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i130;
import '../module_categories/categories_module.dart' as _i174;
import '../module_categories/manager/categories_manager.dart' as _i60;
import '../module_categories/repository/categories_repository.dart' as _i28;
import '../module_categories/service/store_categories_service.dart' as _i61;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i87;
import '../module_categories/state_manager/packages_state_manager.dart' as _i88;
import '../module_categories/ui/screen/categories_screen.dart' as _i125;
import '../module_categories/ui/screen/packages_screen.dart' as _i146;
import '../module_chat/chat_module.dart' as _i175;
import '../module_chat/manager/chat/chat_manager.dart' as _i62;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i29;
import '../module_chat/service/chat/char_service.dart' as _i63;
import '../module_chat/state_manager/chat_state_manager.dart' as _i64;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i126;
import '../module_company/company_module.dart' as _i198;
import '../module_company/manager/company_manager.dart' as _i65;
import '../module_company/repository/company_repository.dart' as _i30;
import '../module_company/service/company_service.dart' as _i66;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i127;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i128;
import '../module_company/ui/screen/company_finance_screen.dart' as _i176;
import '../module_company/ui/screen/company_profile_screen.dart' as _i177;
import '../module_deep_links/repository/deep_link_repository.dart' as _i31;
import '../module_delivary_car/cars_module.dart' as _i173;
import '../module_delivary_car/manager/cars_manager.dart' as _i57;
import '../module_delivary_car/repository/cars_repository.dart' as _i27;
import '../module_delivary_car/service/cars_service.dart' as _i58;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i59;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i124;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main/main_module.dart' as _i180;
import '../module_main/manager/home_manager.dart' as _i69;
import '../module_main/repository/home_repository.dart' as _i33;
import '../module_main/sceen/home_screen.dart' as _i129;
import '../module_main/sceen/main_screen.dart' as _i133;
import '../module_main/service/home_service.dart' as _i70;
import '../module_main/state_manager/home_state_manager.dart' as _i71;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notice/manager/notice_manager.dart' as _i75;
import '../module_notice/notice_module.dart' as _i181;
import '../module_notice/repository/notice_repository.dart' as _i36;
import '../module_notice/service/notice_service.dart' as _i76;
import '../module_notice/state_manager/notice_state_manager.dart' as _i77;
import '../module_notice/ui/screen/notice_screen.dart' as _i135;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i37;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i67;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/hive/order_hive_helper.dart' as _i13;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i39;
import '../module_orders/orders_module.dart' as _i145;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i38;
import '../module_orders/service/orders/orders.service.dart' as _i40;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i74;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i48;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i78;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i79;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i80;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i85;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i81;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i82;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i83;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i134;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i105;
import '../module_orders/ui/screens/order_actions_log_screen.dart' as _i136;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i84;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i144;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i139;
import '../module_orders/ui/screens/order_pending_screen.dart' as _i141;
import '../module_orders/ui/screens/orders_captain_screen.dart' as _i137;
import '../module_orders/ui/screens/orders_without_distance_screen.dart'
    as _i86;
import '../module_payments/manager/payments_manager.dart' as _i89;
import '../module_payments/payments_module.dart' as _i186;
import '../module_payments/repository/payments_repository.dart' as _i41;
import '../module_payments/service/payments_service.dart' as _i90;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i114;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i115;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i116;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i91;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i96;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i167;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i166;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i168;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i147;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i150;
import '../module_settings/settings_module.dart' as _i149;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/settings_page.dart' as _i94;
import '../module_splash/splash_module.dart' as _i95;
import '../module_splash/ui/screen/splash_screen.dart' as _i43;
import '../module_stores/hive/store_hive_helper.dart' as _i14;
import '../module_stores/manager/stores_manager.dart' as _i97;
import '../module_stores/repository/stores_repository.dart' as _i44;
import '../module_stores/service/store_service.dart' as _i98;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i138;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i140;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i142;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i143;
import '../module_stores/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i151;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i152;
import '../module_stores/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i154;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i155;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i156;
import '../module_stores/state_manager/stores_state_manager.dart' as _i99;
import '../module_stores/stores_module.dart' as _i199;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i182;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i183;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i184;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i185;
import '../module_stores/ui/screen/store_info_screen.dart' as _i187;
import '../module_stores/ui/screen/store_subscriptions_details_screen.dart'
    as _i153;
import '../module_stores/ui/screen/store_subscriptions_screen.dart' as _i188;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i189;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i190;
import '../module_stores/ui/screen/stores_screen.dart' as _i157;
import '../module_supplier/manager/supplier_manager.dart' as _i47;
import '../module_supplier/repository/supplier_repository.dart' as _i46;
import '../module_supplier/service/supplier_service.dart' as _i103;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i131;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i158;
import '../module_supplier/state_manager/supplier_list.dart' as _i104;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i160;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i161;
import '../module_supplier/supplier_module.dart' as _i200;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i178;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i191;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i162;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i193;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i194;
import '../module_supplier_categories/categories_supplier_module.dart' as _i192;
import '../module_supplier_categories/manager/categories_manager.dart' as _i100;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i45;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i101;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i102;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i159;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i34;
import '../utils/global/global_state_manager.dart' as _i202;
import '../utils/helpers/firestore_helper.dart' as _i7;
import '../utils/logger/logger.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ArgumentHiveHelper>(() => _i3.ArgumentHiveHelper());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.CaptainsHiveHelper>(() => _i5.CaptainsHiveHelper());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
  gh.factory<_i7.FireStoreHelper>(() => _i7.FireStoreHelper());
  gh.factory<_i8.LocalNotificationService>(
      () => _i8.LocalNotificationService());
  gh.factory<_i9.LocalizationPreferencesHelper>(
      () => _i9.LocalizationPreferencesHelper());
  gh.factory<_i10.LocalizationService>(
      () => _i10.LocalizationService(get<_i9.LocalizationPreferencesHelper>()));
  gh.factory<_i11.Logger>(() => _i11.Logger());
  gh.factory<_i12.NotificationsPrefHelper>(
      () => _i12.NotificationsPrefHelper());
  gh.factory<_i13.OrderHiveHelper>(() => _i13.OrderHiveHelper());
  gh.factory<_i14.StoresHiveHelper>(() => _i14.StoresHiveHelper());
  gh.factory<_i15.ThemePreferencesHelper>(() => _i15.ThemePreferencesHelper());
  gh.factory<_i16.UploadRepository>(() => _i16.UploadRepository());
  gh.factory<_i17.ApiClient>(() => _i17.ApiClient(get<_i11.Logger>()));
  gh.factory<_i18.AppThemeDataService>(
      () => _i18.AppThemeDataService(get<_i15.ThemePreferencesHelper>()));
  gh.factory<_i19.AuthRepository>(
      () => _i19.AuthRepository(get<_i17.ApiClient>(), get<_i11.Logger>()));
  gh.factory<_i20.ChooseLocalScreen>(
      () => _i20.ChooseLocalScreen(get<_i10.LocalizationService>()));
  gh.factory<_i21.UploadManager>(
      () => _i21.UploadManager(get<_i16.UploadRepository>()));
  gh.factory<_i22.AuthManager>(
      () => _i22.AuthManager(get<_i19.AuthRepository>()));
  gh.factory<_i23.AuthService>(() =>
      _i23.AuthService(get<_i4.AuthPrefsHelper>(), get<_i22.AuthManager>()));
  gh.factory<_i24.BidOrderRepository>(() =>
      _i24.BidOrderRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i25.BranchesRepository>(() =>
      _i25.BranchesRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i26.CaptainsRepository>(() =>
      _i26.CaptainsRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i27.CarsRepository>(() =>
      _i27.CarsRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i28.CategoriesRepository>(() => _i28.CategoriesRepository(
      get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i29.ChatRepository>(() =>
      _i29.ChatRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i30.CompanyRepository>(() =>
      _i30.CompanyRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i31.DeepLinkRepository>(() =>
      _i31.DeepLinkRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i32.ForgotPassStateManager>(
      () => _i32.ForgotPassStateManager(get<_i23.AuthService>()));
  gh.factory<_i33.HomeRepository>(() =>
      _i33.HomeRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i34.ImageUploadService>(
      () => _i34.ImageUploadService(get<_i21.UploadManager>()));
  gh.factory<_i35.LoginStateManager>(
      () => _i35.LoginStateManager(get<_i23.AuthService>()));
  gh.factory<_i36.NoticeRepository>(() =>
      _i36.NoticeRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i37.NotificationRepo>(() =>
      _i37.NotificationRepo(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i38.OrderRepository>(() =>
      _i38.OrderRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i39.OrdersManager>(
      () => _i39.OrdersManager(get<_i38.OrderRepository>()));
  gh.factory<_i40.OrdersService>(
      () => _i40.OrdersService(get<_i39.OrdersManager>()));
  gh.factory<_i41.PaymentsRepository>(() =>
      _i41.PaymentsRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i42.RegisterStateManager>(
      () => _i42.RegisterStateManager(get<_i23.AuthService>()));
  gh.factory<_i43.SplashScreen>(
      () => _i43.SplashScreen(get<_i23.AuthService>()));
  gh.factory<_i44.StoresRepository>(() =>
      _i44.StoresRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i45.SupplierCategoriesRepository>(() =>
      _i45.SupplierCategoriesRepository(
          get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i46.SupplierRepository>(() =>
      _i46.SupplierRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i47.SuppliersManager>(
      () => _i47.SuppliersManager(get<_i46.SupplierRepository>()));
  gh.factory<_i48.UpdateOrderStateManager>(
      () => _i48.UpdateOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i49.BidOrderManager>(
      () => _i49.BidOrderManager(get<_i24.BidOrderRepository>()));
  gh.factory<_i50.BidOrderService>(
      () => _i50.BidOrderService(get<_i49.BidOrderManager>()));
  gh.factory<_i51.BidOrderStateManager>(
      () => _i51.BidOrderStateManager(get<_i50.BidOrderService>()));
  gh.factory<_i52.BidOrdersScreen>(
      () => _i52.BidOrdersScreen(get<_i51.BidOrderStateManager>()));
  gh.factory<_i53.BranchesManager>(
      () => _i53.BranchesManager(get<_i25.BranchesRepository>()));
  gh.factory<_i54.CaptainsManager>(
      () => _i54.CaptainsManager(get<_i26.CaptainsRepository>()));
  gh.factory<_i55.CaptainsService>(
      () => _i55.CaptainsService(get<_i54.CaptainsManager>()));
  gh.factory<_i56.CaptainsStateManager>(
      () => _i56.CaptainsStateManager(get<_i55.CaptainsService>()));
  gh.factory<_i57.CarsManager>(
      () => _i57.CarsManager(get<_i27.CarsRepository>()));
  gh.factory<_i58.CarsService>(() => _i58.CarsService(get<_i57.CarsManager>()));
  gh.factory<_i59.CarsStateManager>(
      () => _i59.CarsStateManager(get<_i58.CarsService>()));
  gh.factory<_i60.CategoriesManager>(
      () => _i60.CategoriesManager(get<_i28.CategoriesRepository>()));
  gh.factory<_i61.CategoriesService>(
      () => _i61.CategoriesService(get<_i60.CategoriesManager>()));
  gh.factory<_i62.ChatManager>(
      () => _i62.ChatManager(get<_i29.ChatRepository>()));
  gh.factory<_i63.ChatService>(() => _i63.ChatService(get<_i62.ChatManager>()));
  gh.factory<_i64.ChatStateManager>(
      () => _i64.ChatStateManager(get<_i63.ChatService>()));
  gh.factory<_i65.CompanyManager>(
      () => _i65.CompanyManager(get<_i30.CompanyRepository>()));
  gh.factory<_i66.CompanyService>(
      () => _i66.CompanyService(get<_i65.CompanyManager>()));
  gh.factory<_i67.FireNotificationService>(() => _i67.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i37.NotificationRepo>()));
  gh.factory<_i68.ForgotPassScreen>(
      () => _i68.ForgotPassScreen(get<_i32.ForgotPassStateManager>()));
  gh.factory<_i69.HomeManager>(
      () => _i69.HomeManager(get<_i33.HomeRepository>()));
  gh.factory<_i70.HomeService>(() => _i70.HomeService(get<_i69.HomeManager>()));
  gh.factory<_i71.HomeStateManager>(
      () => _i71.HomeStateManager(get<_i70.HomeService>()));
  gh.factory<_i72.InActiveCaptainsStateManager>(
      () => _i72.InActiveCaptainsStateManager(get<_i55.CaptainsService>()));
  gh.factory<_i73.LoginScreen>(
      () => _i73.LoginScreen(get<_i35.LoginStateManager>()));
  gh.factory<_i74.NewOrderStateManager>(
      () => _i74.NewOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i75.NoticeManager>(
      () => _i75.NoticeManager(get<_i36.NoticeRepository>()));
  gh.factory<_i76.NoticeService>(
      () => _i76.NoticeService(get<_i75.NoticeManager>()));
  gh.factory<_i77.NoticeStateManager>(
      () => _i77.NoticeStateManager(get<_i76.NoticeService>()));
  gh.factory<_i78.OrderActionLogsStateManager>(
      () => _i78.OrderActionLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i79.OrderCaptainLogsStateManager>(
      () => _i79.OrderCaptainLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i80.OrderCashCaptainStateManager>(
      () => _i80.OrderCashCaptainStateManager(get<_i40.OrdersService>()));
  gh.factory<_i81.OrderLogsStateManager>(
      () => _i81.OrderLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i82.OrderPendingStateManager>(
      () => _i82.OrderPendingStateManager(get<_i40.OrdersService>()));
  gh.factory<_i83.OrderWithoutDistanceStateManager>(
      () => _i83.OrderWithoutDistanceStateManager(get<_i40.OrdersService>()));
  gh.factory<_i84.OrdersCashCaptainScreen>(() =>
      _i84.OrdersCashCaptainScreen(get<_i80.OrderCashCaptainStateManager>()));
  gh.factory<_i85.OrdersCashStoreStateManager>(
      () => _i85.OrdersCashStoreStateManager(get<_i40.OrdersService>()));
  gh.factory<_i86.OrdersWithoutDistanceScreen>(() =>
      _i86.OrdersWithoutDistanceScreen(
          get<_i83.OrderWithoutDistanceStateManager>()));
  gh.factory<_i87.PackageCategoriesStateManager>(() =>
      _i87.PackageCategoriesStateManager(
          get<_i61.CategoriesService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i88.PackagesStateManager>(() => _i88.PackagesStateManager(
      get<_i61.CategoriesService>(), get<_i23.AuthService>()));
  gh.factory<_i89.PaymentsManager>(
      () => _i89.PaymentsManager(get<_i41.PaymentsRepository>()));
  gh.factory<_i90.PaymentsService>(
      () => _i90.PaymentsService(get<_i89.PaymentsManager>()));
  gh.factory<_i91.PaymentsToCaptainStateManager>(
      () => _i91.PaymentsToCaptainStateManager(get<_i90.PaymentsService>()));
  gh.factory<_i92.PlanScreenStateManager>(
      () => _i92.PlanScreenStateManager(get<_i90.PaymentsService>()));
  gh.factory<_i93.RegisterScreen>(
      () => _i93.RegisterScreen(get<_i42.RegisterStateManager>()));
  gh.factory<_i94.SettingsScreen>(() => _i94.SettingsScreen(
      get<_i23.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i18.AppThemeDataService>(),
      get<_i67.FireNotificationService>()));
  gh.factory<_i95.SplashModule>(
      () => _i95.SplashModule(get<_i43.SplashScreen>()));
  gh.factory<_i96.StoreBalanceStateManager>(
      () => _i96.StoreBalanceStateManager(get<_i90.PaymentsService>()));
  gh.factory<_i97.StoreManager>(
      () => _i97.StoreManager(get<_i44.StoresRepository>()));
  gh.factory<_i98.StoresService>(
      () => _i98.StoresService(get<_i97.StoreManager>()));
  gh.factory<_i99.StoresStateManager>(() => _i99.StoresStateManager(
      get<_i98.StoresService>(),
      get<_i23.AuthService>(),
      get<_i34.ImageUploadService>()));
  gh.factory<_i100.SupplierCategoriesManager>(() =>
      _i100.SupplierCategoriesManager(
          get<_i45.SupplierCategoriesRepository>()));
  gh.factory<_i101.SupplierCategoriesService>(() =>
      _i101.SupplierCategoriesService(get<_i100.SupplierCategoriesManager>()));
  gh.factory<_i102.SupplierCategoriesStateManager>(() =>
      _i102.SupplierCategoriesStateManager(
          get<_i101.SupplierCategoriesService>(),
          get<_i34.ImageUploadService>()));
  gh.factory<_i103.SupplierService>(
      () => _i103.SupplierService(get<_i47.SuppliersManager>()));
  gh.factory<_i104.SuppliersStateManager>(
      () => _i104.SuppliersStateManager(get<_i103.SupplierService>()));
  gh.factory<_i105.UpdateOrderScreen>(
      () => _i105.UpdateOrderScreen(get<_i48.UpdateOrderStateManager>()));
  gh.factory<_i106.AccountBalanceStateManager>(
      () => _i106.AccountBalanceStateManager(get<_i55.CaptainsService>()));
  gh.factory<_i107.AuthorizationModule>(() => _i107.AuthorizationModule(
      get<_i73.LoginScreen>(),
      get<_i93.RegisterScreen>(),
      get<_i68.ForgotPassScreen>()));
  gh.factory<_i108.BidOrderDetailsScreen>(
      () => _i108.BidOrderDetailsScreen(get<_i51.BidOrderStateManager>()));
  gh.factory<_i109.BidOrderModule>(
      () => _i109.BidOrderModule(get<_i52.BidOrdersScreen>()));
  gh.factory<_i110.BranchesListService>(
      () => _i110.BranchesListService(get<_i53.BranchesManager>()));
  gh.factory<_i111.BranchesListStateManager>(
      () => _i111.BranchesListStateManager(get<_i110.BranchesListService>()));
  gh.factory<_i112.CaptainAccountBalanceScreen>(() =>
      _i112.CaptainAccountBalanceScreen(
          get<_i106.AccountBalanceStateManager>()));
  gh.factory<_i113.CaptainAssignOrderStateManager>(
      () => _i113.CaptainAssignOrderStateManager(get<_i55.CaptainsService>()));
  gh.factory<_i114.CaptainFinanceByHoursStateManager>(() =>
      _i114.CaptainFinanceByHoursStateManager(get<_i90.PaymentsService>()));
  gh.factory<_i115.CaptainFinanceByOrderCountStateManager>(() =>
      _i115.CaptainFinanceByOrderCountStateManager(
          get<_i90.PaymentsService>()));
  gh.factory<_i116.CaptainFinanceByOrderStateManager>(() =>
      _i116.CaptainFinanceByOrderStateManager(get<_i90.PaymentsService>()));
  gh.factory<_i117.CaptainFinancialDuesDetailsStateManager>(() =>
      _i117.CaptainFinancialDuesDetailsStateManager(
          get<_i90.PaymentsService>(), get<_i55.CaptainsService>()));
  gh.factory<_i118.CaptainFinancialDuesStateManager>(() =>
      _i118.CaptainFinancialDuesStateManager(get<_i55.CaptainsService>()));
  gh.factory<_i119.CaptainOfferStateManager>(() =>
      _i119.CaptainOfferStateManager(
          get<_i55.CaptainsService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i120.CaptainOffersScreen>(
      () => _i120.CaptainOffersScreen(get<_i119.CaptainOfferStateManager>()));
  gh.factory<_i121.CaptainProfileStateManager>(
      () => _i121.CaptainProfileStateManager(get<_i55.CaptainsService>()));
  gh.factory<_i122.CaptainsNeedsSupportStateManager>(() =>
      _i122.CaptainsNeedsSupportStateManager(get<_i55.CaptainsService>()));
  gh.factory<_i123.CaptainsScreen>(
      () => _i123.CaptainsScreen(get<_i56.CaptainsStateManager>()));
  gh.factory<_i124.CarsScreen>(
      () => _i124.CarsScreen(get<_i59.CarsStateManager>()));
  gh.factory<_i125.CategoriesScreen>(
      () => _i125.CategoriesScreen(get<_i87.PackageCategoriesStateManager>()));
  gh.factory<_i126.ChatPage>(() => _i126.ChatPage(
      get<_i64.ChatStateManager>(),
      get<_i34.ImageUploadService>(),
      get<_i23.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i127.CompanyFinanceStateManager>(() =>
      _i127.CompanyFinanceStateManager(
          get<_i23.AuthService>(), get<_i66.CompanyService>()));
  gh.factory<_i128.CompanyProfileStateManager>(() =>
      _i128.CompanyProfileStateManager(
          get<_i23.AuthService>(), get<_i66.CompanyService>()));
  gh.factory<_i129.HomeScreen>(
      () => _i129.HomeScreen(get<_i71.HomeStateManager>()));
  gh.factory<_i130.InActiveCaptainsScreen>(() =>
      _i130.InActiveCaptainsScreen(get<_i72.InActiveCaptainsStateManager>()));
  gh.factory<_i131.InActiveSupplierStateManager>(
      () => _i131.InActiveSupplierStateManager(get<_i103.SupplierService>()));
  gh.factory<_i132.InitBranchesStateManager>(
      () => _i132.InitBranchesStateManager(get<_i110.BranchesListService>()));
  gh.factory<_i133.MainScreen>(() => _i133.MainScreen(get<_i129.HomeScreen>()));
  gh.factory<_i134.NewOrderScreen>(
      () => _i134.NewOrderScreen(get<_i74.NewOrderStateManager>()));
  gh.factory<_i135.NoticeScreen>(
      () => _i135.NoticeScreen(get<_i77.NoticeStateManager>()));
  gh.factory<_i136.OrderActionLogsScreen>(() =>
      _i136.OrderActionLogsScreen(get<_i78.OrderActionLogsStateManager>()));
  gh.factory<_i137.OrderCaptainLogsScreen>(() =>
      _i137.OrderCaptainLogsScreen(get<_i79.OrderCaptainLogsStateManager>()));
  gh.factory<_i138.OrderCaptainNotArrivedStateManager>(() =>
      _i138.OrderCaptainNotArrivedStateManager(get<_i98.StoresService>()));
  gh.factory<_i139.OrderLogsScreen>(
      () => _i139.OrderLogsScreen(get<_i81.OrderLogsStateManager>()));
  gh.factory<_i140.OrderLogsStateManager>(
      () => _i140.OrderLogsStateManager(get<_i98.StoresService>()));
  gh.factory<_i141.OrderPendingScreen>(
      () => _i141.OrderPendingScreen(get<_i82.OrderPendingStateManager>()));
  gh.factory<_i142.OrderStatusStateManager>(() => _i142.OrderStatusStateManager(
      get<_i98.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i143.OrderTimeLineStateManager>(() =>
      _i143.OrderTimeLineStateManager(
          get<_i98.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i144.OrdersCashStoreScreen>(() =>
      _i144.OrdersCashStoreScreen(get<_i85.OrdersCashStoreStateManager>()));
  gh.factory<_i145.OrdersModule>(() => _i145.OrdersModule(
      get<_i139.OrderLogsScreen>(),
      get<_i84.OrdersCashCaptainScreen>(),
      get<_i144.OrdersCashStoreScreen>(),
      get<_i105.UpdateOrderScreen>(),
      get<_i141.OrderPendingScreen>(),
      get<_i134.NewOrderScreen>(),
      get<_i137.OrderCaptainLogsScreen>(),
      get<_i136.OrderActionLogsScreen>(),
      get<_i86.OrdersWithoutDistanceScreen>()));
  gh.factory<_i146.PackagesScreen>(
      () => _i146.PackagesScreen(get<_i88.PackagesStateManager>()));
  gh.factory<_i147.PaymentsToCaptainScreen>(() =>
      _i147.PaymentsToCaptainScreen(get<_i91.PaymentsToCaptainStateManager>()));
  gh.factory<_i148.PlanScreen>(
      () => _i148.PlanScreen(get<_i92.PlanScreenStateManager>()));
  gh.factory<_i149.SettingsModule>(() => _i149.SettingsModule(
      get<_i94.SettingsScreen>(), get<_i20.ChooseLocalScreen>()));
  gh.factory<_i150.StoreBalanceScreen>(
      () => _i150.StoreBalanceScreen(get<_i96.StoreBalanceStateManager>()));
  gh.factory<_i151.StoreFinancialSubscriptionsDuesDetailsStateManager>(() =>
      _i151.StoreFinancialSubscriptionsDuesDetailsStateManager(
          get<_i90.PaymentsService>(), get<_i98.StoresService>()));
  gh.factory<_i152.StoreProfileStateManager>(() =>
      _i152.StoreProfileStateManager(
          get<_i98.StoresService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i153.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i153.StoreSubscriptionsFinanceDetailsScreen(
          get<_i151.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i154.StoreSubscriptionsFinanceStateManager>(() =>
      _i154.StoreSubscriptionsFinanceStateManager(get<_i98.StoresService>()));
  gh.factory<_i155.StoresInActiveStateManager>(() =>
      _i155.StoresInActiveStateManager(get<_i98.StoresService>(),
          get<_i23.AuthService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i156.StoresNeedsSupportStateManager>(
      () => _i156.StoresNeedsSupportStateManager(get<_i98.StoresService>()));
  gh.factory<_i157.StoresScreen>(
      () => _i157.StoresScreen(get<_i99.StoresStateManager>()));
  gh.factory<_i158.SupplierAdsStateManager>(
      () => _i158.SupplierAdsStateManager(get<_i103.SupplierService>()));
  gh.factory<_i159.SupplierCategoriesScreen>(() =>
      _i159.SupplierCategoriesScreen(
          get<_i102.SupplierCategoriesStateManager>()));
  gh.factory<_i160.SupplierNeedsSupportStateManager>(() =>
      _i160.SupplierNeedsSupportStateManager(get<_i103.SupplierService>()));
  gh.factory<_i161.SupplierProfileStateManager>(
      () => _i161.SupplierProfileStateManager(get<_i103.SupplierService>()));
  gh.factory<_i162.SuppliersScreen>(
      () => _i162.SuppliersScreen(get<_i104.SuppliersStateManager>()));
  gh.factory<_i163.UpdateBranchStateManager>(
      () => _i163.UpdateBranchStateManager(get<_i110.BranchesListService>()));
  gh.factory<_i164.BranchesListScreen>(
      () => _i164.BranchesListScreen(get<_i111.BranchesListStateManager>()));
  gh.factory<_i165.CaptainAssignOrderScreen>(() =>
      _i165.CaptainAssignOrderScreen(
          get<_i113.CaptainAssignOrderStateManager>()));
  gh.factory<_i166.CaptainFinanceByCountOrderScreen>(() =>
      _i166.CaptainFinanceByCountOrderScreen(
          get<_i115.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i167.CaptainFinanceByHoursScreen>(() =>
      _i167.CaptainFinanceByHoursScreen(
          get<_i114.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i168.CaptainFinanceByOrderScreen>(() =>
      _i168.CaptainFinanceByOrderScreen(
          get<_i116.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i169.CaptainFinancialDuesDetailsScreen>(() =>
      _i169.CaptainFinancialDuesDetailsScreen(
          get<_i117.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i170.CaptainFinancialDuesScreen>(() =>
      _i170.CaptainFinancialDuesScreen(
          get<_i118.CaptainFinancialDuesStateManager>()));
  gh.factory<_i171.CaptainProfileScreen>(() =>
      _i171.CaptainProfileScreen(get<_i121.CaptainProfileStateManager>()));
  gh.factory<_i172.CaptainsNeedsSupportScreen>(() =>
      _i172.CaptainsNeedsSupportScreen(
          get<_i122.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i173.CarsModule>(() => _i173.CarsModule(get<_i124.CarsScreen>()));
  gh.factory<_i174.CategoriesModule>(() => _i174.CategoriesModule(
      get<_i125.CategoriesScreen>(), get<_i146.PackagesScreen>()));
  gh.factory<_i175.ChatModule>(
      () => _i175.ChatModule(get<_i126.ChatPage>(), get<_i23.AuthService>()));
  gh.factory<_i176.CompanyFinanceScreen>(() =>
      _i176.CompanyFinanceScreen(get<_i127.CompanyFinanceStateManager>()));
  gh.factory<_i177.CompanyProfileScreen>(() =>
      _i177.CompanyProfileScreen(get<_i128.CompanyProfileStateManager>()));
  gh.factory<_i178.InActiveSupplierScreen>(() =>
      _i178.InActiveSupplierScreen(get<_i131.InActiveSupplierStateManager>()));
  gh.factory<_i179.InitBranchesScreen>(
      () => _i179.InitBranchesScreen(get<_i132.InitBranchesStateManager>()));
  gh.factory<_i180.MainModule>(
      () => _i180.MainModule(get<_i133.MainScreen>(), get<_i129.HomeScreen>()));
  gh.factory<_i181.NoticeModule>(
      () => _i181.NoticeModule(get<_i135.NoticeScreen>()));
  gh.factory<_i182.OrderCaptainNotArrivedScreen>(() =>
      _i182.OrderCaptainNotArrivedScreen(
          get<_i138.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i183.OrderDetailsScreen>(
      () => _i183.OrderDetailsScreen(get<_i142.OrderStatusStateManager>()));
  gh.factory<_i184.OrderLogsScreen>(
      () => _i184.OrderLogsScreen(get<_i140.OrderLogsStateManager>()));
  gh.factory<_i185.OrderTimeLineScreen>(
      () => _i185.OrderTimeLineScreen(get<_i143.OrderTimeLineStateManager>()));
  gh.factory<_i186.PaymentsModule>(() => _i186.PaymentsModule(
      get<_i166.CaptainFinanceByCountOrderScreen>(),
      get<_i167.CaptainFinanceByHoursScreen>(),
      get<_i168.CaptainFinanceByOrderScreen>(),
      get<_i147.PaymentsToCaptainScreen>(),
      get<_i150.StoreBalanceScreen>()));
  gh.factory<_i187.StoreInfoScreen>(
      () => _i187.StoreInfoScreen(get<_i152.StoreProfileStateManager>()));
  gh.factory<_i188.StoreSubscriptionsFinanceScreen>(() =>
      _i188.StoreSubscriptionsFinanceScreen(
          get<_i154.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i189.StoresInActiveScreen>(() =>
      _i189.StoresInActiveScreen(get<_i155.StoresInActiveStateManager>()));
  gh.factory<_i190.StoresNeedsSupportScreen>(() =>
      _i190.StoresNeedsSupportScreen(
          get<_i156.StoresNeedsSupportStateManager>()));
  gh.factory<_i191.SupplierAdsScreen>(
      () => _i191.SupplierAdsScreen(get<_i158.SupplierAdsStateManager>()));
  gh.factory<_i192.SupplierCategoriesModule>(() =>
      _i192.SupplierCategoriesModule(get<_i159.SupplierCategoriesScreen>()));
  gh.factory<_i193.SupplierNeedsSupportScreen>(() =>
      _i193.SupplierNeedsSupportScreen(
          get<_i160.SupplierNeedsSupportStateManager>()));
  gh.factory<_i194.SupplierProfileScreen>(() =>
      _i194.SupplierProfileScreen(get<_i161.SupplierProfileStateManager>()));
  gh.factory<_i195.UpdateBranchScreen>(
      () => _i195.UpdateBranchScreen(get<_i163.UpdateBranchStateManager>()));
  gh.factory<_i196.BranchesModule>(() => _i196.BranchesModule(
      get<_i164.BranchesListScreen>(),
      get<_i195.UpdateBranchScreen>(),
      get<_i179.InitBranchesScreen>()));
  gh.factory<_i197.CaptainsModule>(() => _i197.CaptainsModule(
      get<_i120.CaptainOffersScreen>(),
      get<_i130.InActiveCaptainsScreen>(),
      get<_i123.CaptainsScreen>(),
      get<_i171.CaptainProfileScreen>(),
      get<_i172.CaptainsNeedsSupportScreen>(),
      get<_i112.CaptainAccountBalanceScreen>(),
      get<_i169.CaptainFinancialDuesDetailsScreen>(),
      get<_i170.CaptainFinancialDuesScreen>(),
      get<_i148.PlanScreen>(),
      get<_i165.CaptainAssignOrderScreen>()));
  gh.factory<_i198.CompanyModule>(() => _i198.CompanyModule(
      get<_i177.CompanyProfileScreen>(), get<_i176.CompanyFinanceScreen>()));
  gh.factory<_i199.StoresModule>(() => _i199.StoresModule(
      get<_i157.StoresScreen>(),
      get<_i187.StoreInfoScreen>(),
      get<_i189.StoresInActiveScreen>(),
      get<_i150.StoreBalanceScreen>(),
      get<_i190.StoresNeedsSupportScreen>(),
      get<_i183.OrderDetailsScreen>(),
      get<_i184.OrderLogsScreen>(),
      get<_i182.OrderCaptainNotArrivedScreen>(),
      get<_i185.OrderTimeLineScreen>(),
      get<_i153.StoreSubscriptionsFinanceDetailsScreen>(),
      get<_i188.StoreSubscriptionsFinanceScreen>()));
  gh.factory<_i200.SupplierModule>(() => _i200.SupplierModule(
      get<_i178.InActiveSupplierScreen>(),
      get<_i162.SuppliersScreen>(),
      get<_i194.SupplierProfileScreen>(),
      get<_i193.SupplierNeedsSupportScreen>(),
      get<_i191.SupplierAdsScreen>()));
  gh.factory<_i201.MyApp>(() => _i201.MyApp(
      get<_i18.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i67.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i95.SplashModule>(),
      get<_i107.AuthorizationModule>(),
      get<_i175.ChatModule>(),
      get<_i149.SettingsModule>(),
      get<_i180.MainModule>(),
      get<_i199.StoresModule>(),
      get<_i174.CategoriesModule>(),
      get<_i198.CompanyModule>(),
      get<_i196.BranchesModule>(),
      get<_i181.NoticeModule>(),
      get<_i197.CaptainsModule>(),
      get<_i186.PaymentsModule>(),
      get<_i192.SupplierCategoriesModule>(),
      get<_i200.SupplierModule>(),
      get<_i173.CarsModule>(),
      get<_i109.BidOrderModule>(),
      get<_i145.OrdersModule>()));
  gh.singleton<_i202.GlobalStateManager>(_i202.GlobalStateManager());
  return get;
}

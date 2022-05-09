// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hive/util/argument_hive_helper.dart' as _i3;
import '../main.dart' as _i184;
import '../module_auth/authoriazation_module.dart' as _i97;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i22;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../module_auth/service/auth_service/auth_service.dart' as _i23;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i31;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i34;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i41;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i66;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i71;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i84;
import '../module_bid_order/bid_order_module.dart' as _i99;
import '../module_bid_order/manager/bid_order_manager.dart' as _i47;
import '../module_bid_order/repository/bid_order_repository.dart' as _i24;
import '../module_bid_order/service/bid_order_service.dart' as _i48;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i49;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i50;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i98;
import '../module_branches/branches_module.dart' as _i179;
import '../module_branches/manager/branches_manager.dart' as _i51;
import '../module_branches/repository/branches_repository.dart' as _i25;
import '../module_branches/service/branches_list_service.dart' as _i100;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i101;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i121;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i147;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i148;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i162;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i178;
import '../module_captain/captains_module.dart' as _i180;
import '../module_captain/hive/captain_hive_helper.dart' as _i5;
import '../module_captain/manager/captains_manager.dart' as _i52;
import '../module_captain/repository/captains_repository.dart' as _i26;
import '../module_captain/service/captains_service.dart' as _i53;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i96;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i106;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i107;
import '../module_captain/state_manager/captain_list.dart' as _i54;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i111;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i108;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i110;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i70;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i102;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i152;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i153;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i155;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i154;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i112;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i109;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i119;
import '../module_categories/categories_module.dart' as _i157;
import '../module_categories/manager/categories_manager.dart' as _i58;
import '../module_categories/repository/categories_repository.dart' as _i28;
import '../module_categories/service/store_categories_service.dart' as _i59;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i79;
import '../module_categories/state_manager/packages_state_manager.dart' as _i80;
import '../module_categories/ui/screen/categories_screen.dart' as _i114;
import '../module_categories/ui/screen/packages_screen.dart' as _i131;
import '../module_chat/chat_module.dart' as _i158;
import '../module_chat/manager/chat/chat_manager.dart' as _i60;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i29;
import '../module_chat/service/chat/char_service.dart' as _i61;
import '../module_chat/state_manager/chat_state_manager.dart' as _i62;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i115;
import '../module_company/company_module.dart' as _i181;
import '../module_company/manager/company_manager.dart' as _i63;
import '../module_company/repository/company_repository.dart' as _i30;
import '../module_company/service/company_service.dart' as _i64;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i116;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i117;
import '../module_company/ui/screen/company_finance_screen.dart' as _i159;
import '../module_company/ui/screen/company_profile_screen.dart' as _i160;
import '../module_delivary_car/cars_module.dart' as _i156;
import '../module_delivary_car/manager/cars_manager.dart' as _i55;
import '../module_delivary_car/repository/cars_repository.dart' as _i27;
import '../module_delivary_car/service/cars_service.dart' as _i56;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i57;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i113;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main/main_module.dart' as _i163;
import '../module_main/manager/home_manager.dart' as _i67;
import '../module_main/repository/home_repository.dart' as _i32;
import '../module_main/sceen/home_screen.dart' as _i118;
import '../module_main/sceen/main_screen.dart' as _i122;
import '../module_main/service/home_service.dart' as _i68;
import '../module_main/state_manager/home_state_manager.dart' as _i69;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notice/manager/notice_manager.dart' as _i72;
import '../module_notice/notice_module.dart' as _i164;
import '../module_notice/repository/notice_repository.dart' as _i35;
import '../module_notice/service/notice_service.dart' as _i73;
import '../module_notice/state_manager/notice_state_manager.dart' as _i74;
import '../module_notice/ui/screen/notice_screen.dart' as _i123;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i36;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i65;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/hive/order_hive_helper.dart' as _i13;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i38;
import '../module_orders/orders_module.dart' as _i130;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i37;
import '../module_orders/service/orders/orders.service.dart' as _i39;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i75;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i78;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i76;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i77;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i129;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i125;
import '../module_payments/manager/payments_manager.dart' as _i81;
import '../module_payments/payments_module.dart' as _i169;
import '../module_payments/repository/payments_repository.dart' as _i40;
import '../module_payments/service/payments_service.dart' as _i82;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i103;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i104;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i105;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i83;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i87;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i150;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i149;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i151;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i132;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i134;
import '../module_settings/settings_module.dart' as _i133;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/settings_page.dart' as _i85;
import '../module_splash/splash_module.dart' as _i86;
import '../module_splash/ui/screen/splash_screen.dart' as _i42;
import '../module_stores/hive/store_hive_helper.dart' as _i14;
import '../module_stores/manager/stores_manager.dart' as _i88;
import '../module_stores/repository/stores_repository.dart' as _i43;
import '../module_stores/service/store_service.dart' as _i89;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i124;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i126;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i127;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i128;
import '../module_stores/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i135;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i136;
import '../module_stores/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i138;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i139;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i140;
import '../module_stores/state_manager/stores_state_manager.dart' as _i90;
import '../module_stores/stores_module.dart' as _i182;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i165;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i166;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i167;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i168;
import '../module_stores/ui/screen/store_info_screen.dart' as _i170;
import '../module_stores/ui/screen/store_subscriptions_details_screen.dart'
    as _i137;
import '../module_stores/ui/screen/store_subscriptions_screen.dart' as _i171;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i172;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i173;
import '../module_stores/ui/screen/stores_screen.dart' as _i141;
import '../module_supplier/manager/supplier_manager.dart' as _i46;
import '../module_supplier/repository/supplier_repository.dart' as _i45;
import '../module_supplier/service/supplier_service.dart' as _i94;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i120;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i142;
import '../module_supplier/state_manager/supplier_list.dart' as _i95;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i144;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i145;
import '../module_supplier/supplier_module.dart' as _i183;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i161;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i174;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i146;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i176;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i177;
import '../module_supplier_categories/categories_supplier_module.dart' as _i175;
import '../module_supplier_categories/manager/categories_manager.dart' as _i91;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i44;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i92;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i93;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i143;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i33;
import '../utils/global/global_state_manager.dart' as _i185;
import '../utils/helpers/firestore_helper.dart' as _i7;
import '../utils/logger/logger.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ArgumentHiveHelper>(() => _i3.ArgumentHiveHelper());
  gh.factory<_i13.OrderHiveHelper>(() => _i13.OrderHiveHelper());
   gh.factory<_i37.OrderRepository>(() =>
      _i37.OrderRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i38.OrdersManager>(
      () => _i38.OrdersManager(get<_i37.OrderRepository>()));
  gh.factory<_i39.OrdersService>(
      () => _i39.OrdersService(get<_i38.OrdersManager>()));
  gh.factory<_i75.OrderCashCaptainStateManager>(
      () => _i75.OrderCashCaptainStateManager(get<_i39.OrdersService>()));
  gh.factory<_i76.OrderLogsStateManager>(
      () => _i76.OrderLogsStateManager(get<_i39.OrdersService>()));
  gh.factory<_i77.OrdersCashCaptainScreen>(() =>
      _i77.OrdersCashCaptainScreen(get<_i75.OrderCashCaptainStateManager>()));
  gh.factory<_i78.OrdersCashStoreStateManager>(
      () => _i78.OrdersCashStoreStateManager(get<_i39.OrdersService>()));
      get<_i130.OrdersModule>()));
  
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.CaptainsHiveHelper>(() => _i4.CaptainsHiveHelper());
  gh.factory<_i5.ChatHiveHelper>(() => _i5.ChatHiveHelper());
  gh.factory<_i6.FireStoreHelper>(() => _i6.FireStoreHelper());
  gh.factory<_i7.LocalNotificationService>(
      () => _i7.LocalNotificationService());
  gh.factory<_i8.LocalizationPreferencesHelper>(
      () => _i8.LocalizationPreferencesHelper());
  gh.factory<_i9.LocalizationService>(
      () => _i9.LocalizationService(get<_i8.LocalizationPreferencesHelper>()));
  gh.factory<_i10.Logger>(() => _i10.Logger());
  gh.factory<_i11.NotificationsPrefHelper>(
      () => _i11.NotificationsPrefHelper());
  gh.factory<_i12.StoresHiveHelper>(() => _i12.StoresHiveHelper());
  gh.factory<_i13.ThemePreferencesHelper>(() => _i13.ThemePreferencesHelper());
  gh.factory<_i14.UploadRepository>(() => _i14.UploadRepository());
  gh.factory<_i15.ApiClient>(() => _i15.ApiClient(get<_i10.Logger>()));
  gh.factory<_i16.AppThemeDataService>(
      () => _i16.AppThemeDataService(get<_i13.ThemePreferencesHelper>()));
  gh.factory<_i17.AuthRepository>(
      () => _i17.AuthRepository(get<_i15.ApiClient>(), get<_i10.Logger>()));
  gh.factory<_i18.ChooseLocalScreen>(
      () => _i18.ChooseLocalScreen(get<_i9.LocalizationService>()));
  gh.factory<_i19.UploadManager>(
      () => _i19.UploadManager(get<_i14.UploadRepository>()));
  gh.factory<_i20.AuthManager>(
      () => _i20.AuthManager(get<_i17.AuthRepository>()));
  gh.factory<_i21.AuthService>(() =>
      _i21.AuthService(get<_i3.AuthPrefsHelper>(), get<_i20.AuthManager>()));
  gh.factory<_i22.BidOrderRepository>(() =>
      _i22.BidOrderRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i23.BranchesRepository>(() =>
      _i23.BranchesRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i24.CaptainsRepository>(() =>
      _i24.CaptainsRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i25.CarsRepository>(() =>
      _i25.CarsRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i26.CategoriesRepository>(() => _i26.CategoriesRepository(
      get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i27.ChatRepository>(() =>
      _i27.ChatRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i28.CompanyRepository>(() =>
      _i28.CompanyRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i29.ForgotPassStateManager>(
      () => _i29.ForgotPassStateManager(get<_i21.AuthService>()));
  gh.factory<_i30.HomeRepository>(() =>
      _i30.HomeRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i31.ImageUploadService>(
      () => _i31.ImageUploadService(get<_i19.UploadManager>()));
  gh.factory<_i32.LoginStateManager>(
      () => _i32.LoginStateManager(get<_i21.AuthService>()));
  gh.factory<_i33.NoticeRepository>(() =>
      _i33.NoticeRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i34.NotificationRepo>(() =>
      _i34.NotificationRepo(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i35.PaymentsRepository>(() =>
      _i35.PaymentsRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i36.RegisterStateManager>(
      () => _i36.RegisterStateManager(get<_i21.AuthService>()));
  gh.factory<_i37.SplashScreen>(
      () => _i37.SplashScreen(get<_i21.AuthService>()));
  gh.factory<_i38.StoresRepository>(() =>
      _i38.StoresRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i39.SupplierCategoriesRepository>(() =>
      _i39.SupplierCategoriesRepository(
          get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i40.SupplierRepository>(() =>
      _i40.SupplierRepository(get<_i15.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i41.SuppliersManager>(
      () => _i41.SuppliersManager(get<_i40.SupplierRepository>()));
  gh.factory<_i42.BidOrderManager>(
      () => _i42.BidOrderManager(get<_i22.BidOrderRepository>()));
  gh.factory<_i43.BidOrderService>(
      () => _i43.BidOrderService(get<_i42.BidOrderManager>()));
  gh.factory<_i44.BidOrderStateManager>(
      () => _i44.BidOrderStateManager(get<_i43.BidOrderService>()));
  gh.factory<_i45.BidOrdersScreen>(
      () => _i45.BidOrdersScreen(get<_i44.BidOrderStateManager>()));
  gh.factory<_i46.BranchesManager>(
      () => _i46.BranchesManager(get<_i23.BranchesRepository>()));
  gh.factory<_i47.CaptainsManager>(
      () => _i47.CaptainsManager(get<_i24.CaptainsRepository>()));
  gh.factory<_i48.CaptainsService>(
      () => _i48.CaptainsService(get<_i47.CaptainsManager>()));
  gh.factory<_i49.CaptainsStateManager>(
      () => _i49.CaptainsStateManager(get<_i48.CaptainsService>()));
  gh.factory<_i50.CarsManager>(
      () => _i50.CarsManager(get<_i25.CarsRepository>()));
  gh.factory<_i51.CarsService>(() => _i51.CarsService(get<_i50.CarsManager>()));
  gh.factory<_i52.CarsStateManager>(
      () => _i52.CarsStateManager(get<_i51.CarsService>()));
  gh.factory<_i53.CategoriesManager>(
      () => _i53.CategoriesManager(get<_i26.CategoriesRepository>()));
  gh.factory<_i54.CategoriesService>(
      () => _i54.CategoriesService(get<_i53.CategoriesManager>()));
  gh.factory<_i55.ChatManager>(
      () => _i55.ChatManager(get<_i27.ChatRepository>()));
  gh.factory<_i56.ChatService>(() => _i56.ChatService(get<_i55.ChatManager>()));
  gh.factory<_i57.ChatStateManager>(
      () => _i57.ChatStateManager(get<_i56.ChatService>()));
  gh.factory<_i58.CompanyManager>(
      () => _i58.CompanyManager(get<_i28.CompanyRepository>()));
  gh.factory<_i59.CompanyService>(
      () => _i59.CompanyService(get<_i58.CompanyManager>()));
  gh.factory<_i60.FireNotificationService>(() => _i60.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i34.NotificationRepo>()));
  gh.factory<_i61.ForgotPassScreen>(
      () => _i61.ForgotPassScreen(get<_i29.ForgotPassStateManager>()));
  gh.factory<_i62.HomeManager>(
      () => _i62.HomeManager(get<_i30.HomeRepository>()));
  gh.factory<_i63.HomeService>(() => _i63.HomeService(get<_i62.HomeManager>()));
  gh.factory<_i64.HomeStateManager>(
      () => _i64.HomeStateManager(get<_i63.HomeService>()));
  gh.factory<_i65.InActiveCaptainsStateManager>(
      () => _i65.InActiveCaptainsStateManager(get<_i48.CaptainsService>()));
  gh.factory<_i66.LoginScreen>(
      () => _i66.LoginScreen(get<_i32.LoginStateManager>()));
  gh.factory<_i67.NoticeManager>(
      () => _i67.NoticeManager(get<_i33.NoticeRepository>()));
  gh.factory<_i68.NoticeService>(
      () => _i68.NoticeService(get<_i67.NoticeManager>()));
  gh.factory<_i69.NoticeStateManager>(
      () => _i69.NoticeStateManager(get<_i68.NoticeService>()));
  gh.factory<_i70.PackageCategoriesStateManager>(() =>
      _i70.PackageCategoriesStateManager(
          get<_i54.CategoriesService>(), get<_i31.ImageUploadService>()));
  gh.factory<_i71.PackagesStateManager>(() => _i71.PackagesStateManager(
      get<_i54.CategoriesService>(), get<_i21.AuthService>()));
  gh.factory<_i72.PaymentsManager>(
      () => _i72.PaymentsManager(get<_i35.PaymentsRepository>()));
  gh.factory<_i73.PaymentsService>(
      () => _i73.PaymentsService(get<_i72.PaymentsManager>()));
  gh.factory<_i74.PaymentsToCaptainStateManager>(
      () => _i74.PaymentsToCaptainStateManager(get<_i73.PaymentsService>()));
  gh.factory<_i75.RegisterScreen>(
      () => _i75.RegisterScreen(get<_i36.RegisterStateManager>()));
  gh.factory<_i76.SettingsScreen>(() => _i76.SettingsScreen(
      get<_i21.AuthService>(),
      get<_i9.LocalizationService>(),
      get<_i16.AppThemeDataService>(),
      get<_i60.FireNotificationService>()));
  gh.factory<_i77.SplashModule>(
      () => _i77.SplashModule(get<_i37.SplashScreen>()));
  gh.factory<_i78.StoreBalanceStateManager>(
      () => _i78.StoreBalanceStateManager(get<_i73.PaymentsService>()));
  gh.factory<_i79.StoreManager>(
      () => _i79.StoreManager(get<_i38.StoresRepository>()));
  gh.factory<_i80.StoresService>(
      () => _i80.StoresService(get<_i79.StoreManager>()));
  gh.factory<_i81.StoresStateManager>(() => _i81.StoresStateManager(
      get<_i80.StoresService>(),
      get<_i21.AuthService>(),
      get<_i31.ImageUploadService>()));
  gh.factory<_i82.SupplierCategoriesManager>(() =>
      _i82.SupplierCategoriesManager(get<_i39.SupplierCategoriesRepository>()));
  gh.factory<_i83.SupplierCategoriesService>(() =>
      _i83.SupplierCategoriesService(get<_i82.SupplierCategoriesManager>()));
  gh.factory<_i84.SupplierCategoriesStateManager>(() =>
      _i84.SupplierCategoriesStateManager(get<_i83.SupplierCategoriesService>(),
          get<_i31.ImageUploadService>()));
  gh.factory<_i85.SupplierService>(
      () => _i85.SupplierService(get<_i41.SuppliersManager>()));
  gh.factory<_i86.SuppliersStateManager>(
      () => _i86.SuppliersStateManager(get<_i85.SupplierService>()));
  gh.factory<_i87.AccountBalanceStateManager>(
      () => _i87.AccountBalanceStateManager(get<_i48.CaptainsService>()));
  gh.factory<_i88.AuthorizationModule>(() => _i88.AuthorizationModule(
      get<_i66.LoginScreen>(),
      get<_i75.RegisterScreen>(),
      get<_i61.ForgotPassScreen>()));
  gh.factory<_i89.BidOrderDetailsScreen>(
      () => _i89.BidOrderDetailsScreen(get<_i44.BidOrderStateManager>()));
  gh.factory<_i90.BidOrderModule>(
      () => _i90.BidOrderModule(get<_i45.BidOrdersScreen>()));
  gh.factory<_i91.BranchesListService>(
      () => _i91.BranchesListService(get<_i46.BranchesManager>()));
  gh.factory<_i92.BranchesListStateManager>(
      () => _i92.BranchesListStateManager(get<_i91.BranchesListService>()));
  gh.factory<_i93.CaptainAccountBalanceScreen>(() =>
      _i93.CaptainAccountBalanceScreen(get<_i87.AccountBalanceStateManager>()));
  gh.factory<_i94.CaptainFinanceByHoursStateManager>(() =>
      _i94.CaptainFinanceByHoursStateManager(get<_i73.PaymentsService>()));
  gh.factory<_i95.CaptainFinanceByOrderCountStateManager>(() =>
      _i95.CaptainFinanceByOrderCountStateManager(get<_i73.PaymentsService>()));
  gh.factory<_i96.CaptainFinanceByOrderStateManager>(() =>
      _i96.CaptainFinanceByOrderStateManager(get<_i73.PaymentsService>()));
  gh.factory<_i97.CaptainFinancialDuesDetailsStateManager>(() =>
      _i97.CaptainFinancialDuesDetailsStateManager(
          get<_i73.PaymentsService>(), get<_i48.CaptainsService>()));
  gh.factory<_i98.CaptainFinancialDuesStateManager>(
      () => _i98.CaptainFinancialDuesStateManager(get<_i48.CaptainsService>()));
  gh.factory<_i99.CaptainOfferStateManager>(() => _i99.CaptainOfferStateManager(
      get<_i48.CaptainsService>(), get<_i31.ImageUploadService>()));
  gh.factory<_i100.CaptainOffersScreen>(
      () => _i100.CaptainOffersScreen(get<_i99.CaptainOfferStateManager>()));
  gh.factory<_i101.CaptainProfileStateManager>(
      () => _i101.CaptainProfileStateManager(get<_i48.CaptainsService>()));
  gh.factory<_i102.CaptainsNeedsSupportStateManager>(() =>
      _i102.CaptainsNeedsSupportStateManager(get<_i48.CaptainsService>()));
  gh.factory<_i103.CaptainsScreen>(
      () => _i103.CaptainsScreen(get<_i49.CaptainsStateManager>()));
  gh.factory<_i104.CarsScreen>(
      () => _i104.CarsScreen(get<_i52.CarsStateManager>()));
  gh.factory<_i105.CategoriesScreen>(
      () => _i105.CategoriesScreen(get<_i70.PackageCategoriesStateManager>()));
  gh.factory<_i106.ChatPage>(() => _i106.ChatPage(
      get<_i57.ChatStateManager>(),
      get<_i31.ImageUploadService>(),
      get<_i21.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i107.CompanyFinanceStateManager>(() =>
      _i107.CompanyFinanceStateManager(
          get<_i21.AuthService>(), get<_i59.CompanyService>()));
  gh.factory<_i108.CompanyProfileStateManager>(() =>
      _i108.CompanyProfileStateManager(
          get<_i21.AuthService>(), get<_i59.CompanyService>()));
  gh.factory<_i109.HomeScreen>(
      () => _i109.HomeScreen(get<_i64.HomeStateManager>()));
  gh.factory<_i110.InActiveCaptainsScreen>(() =>
      _i110.InActiveCaptainsScreen(get<_i65.InActiveCaptainsStateManager>()));
  gh.factory<_i111.InActiveSupplierStateManager>(
      () => _i111.InActiveSupplierStateManager(get<_i85.SupplierService>()));
  gh.factory<_i112.InitBranchesStateManager>(
      () => _i112.InitBranchesStateManager(get<_i91.BranchesListService>()));
  gh.factory<_i113.MainScreen>(() => _i113.MainScreen(get<_i109.HomeScreen>()));
  gh.factory<_i114.NoticeScreen>(
      () => _i114.NoticeScreen(get<_i69.NoticeStateManager>()));
  gh.factory<_i115.OrderCaptainNotArrivedStateManager>(() =>
      _i115.OrderCaptainNotArrivedStateManager(get<_i80.StoresService>()));
  gh.factory<_i116.OrderLogsStateManager>(
      () => _i116.OrderLogsStateManager(get<_i80.StoresService>()));
  gh.factory<_i117.OrderStatusStateManager>(() => _i117.OrderStatusStateManager(
      get<_i80.StoresService>(), get<_i21.AuthService>()));
  gh.factory<_i118.OrderTimeLineStateManager>(() =>
      _i118.OrderTimeLineStateManager(
          get<_i80.StoresService>(), get<_i21.AuthService>()));
  gh.factory<_i119.PackagesScreen>(
      () => _i119.PackagesScreen(get<_i71.PackagesStateManager>()));
  gh.factory<_i120.PaymentsToCaptainScreen>(() =>
      _i120.PaymentsToCaptainScreen(get<_i74.PaymentsToCaptainStateManager>()));
  gh.factory<_i121.SettingsModule>(() => _i121.SettingsModule(
      get<_i76.SettingsScreen>(), get<_i18.ChooseLocalScreen>()));
  gh.factory<_i122.StoreBalanceScreen>(
      () => _i122.StoreBalanceScreen(get<_i78.StoreBalanceStateManager>()));
  gh.factory<_i123.StoreFinancialSubscriptionsDuesDetailsStateManager>(() =>
      _i123.StoreFinancialSubscriptionsDuesDetailsStateManager(
          get<_i73.PaymentsService>(), get<_i80.StoresService>()));
  gh.factory<_i124.StoreProfileStateManager>(() =>
      _i124.StoreProfileStateManager(
          get<_i80.StoresService>(), get<_i31.ImageUploadService>()));
  gh.factory<_i125.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i125.StoreSubscriptionsFinanceDetailsScreen(
          get<_i123.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i126.StoreSubscriptionsFinanceStateManager>(() =>
      _i126.StoreSubscriptionsFinanceStateManager(get<_i80.StoresService>()));
  gh.factory<_i127.StoresInActiveStateManager>(() =>
      _i127.StoresInActiveStateManager(get<_i80.StoresService>(),
          get<_i21.AuthService>(), get<_i31.ImageUploadService>()));
  gh.factory<_i128.StoresNeedsSupportStateManager>(
      () => _i128.StoresNeedsSupportStateManager(get<_i80.StoresService>()));
  gh.factory<_i129.StoresScreen>(
      () => _i129.StoresScreen(get<_i81.StoresStateManager>()));
  gh.factory<_i130.SupplierAdsStateManager>(
      () => _i130.SupplierAdsStateManager(get<_i85.SupplierService>()));
  gh.factory<_i131.SupplierCategoriesScreen>(() =>
      _i131.SupplierCategoriesScreen(
          get<_i84.SupplierCategoriesStateManager>()));
  gh.factory<_i132.SupplierNeedsSupportStateManager>(() =>
      _i132.SupplierNeedsSupportStateManager(get<_i85.SupplierService>()));
  gh.factory<_i133.SupplierProfileStateManager>(
      () => _i133.SupplierProfileStateManager(get<_i85.SupplierService>()));
  gh.factory<_i134.SuppliersScreen>(
      () => _i134.SuppliersScreen(get<_i86.SuppliersStateManager>()));
  gh.factory<_i135.UpdateBranchStateManager>(
      () => _i135.UpdateBranchStateManager(get<_i91.BranchesListService>()));
  gh.factory<_i136.BranchesListScreen>(
      () => _i136.BranchesListScreen(get<_i92.BranchesListStateManager>()));
  gh.factory<_i137.CaptainFinanceByCountOrderScreen>(() =>
      _i137.CaptainFinanceByCountOrderScreen(
          get<_i95.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i138.CaptainFinanceByHoursScreen>(() =>
      _i138.CaptainFinanceByHoursScreen(
          get<_i94.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i139.CaptainFinanceByOrderScreen>(() =>
      _i139.CaptainFinanceByOrderScreen(
          get<_i96.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i140.CaptainFinancialDuesDetailsScreen>(() =>
      _i140.CaptainFinancialDuesDetailsScreen(
          get<_i97.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i141.CaptainFinancialDuesScreen>(() =>
      _i141.CaptainFinancialDuesScreen(
          get<_i98.CaptainFinancialDuesStateManager>()));
  gh.factory<_i142.CaptainProfileScreen>(() =>
      _i142.CaptainProfileScreen(get<_i101.CaptainProfileStateManager>()));
  gh.factory<_i143.CaptainsNeedsSupportScreen>(() =>
      _i143.CaptainsNeedsSupportScreen(
          get<_i102.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i144.CarsModule>(() => _i144.CarsModule(get<_i104.CarsScreen>()));
  gh.factory<_i145.CategoriesModule>(() => _i145.CategoriesModule(
      get<_i105.CategoriesScreen>(), get<_i119.PackagesScreen>()));
  gh.factory<_i146.ChatModule>(
      () => _i146.ChatModule(get<_i106.ChatPage>(), get<_i21.AuthService>()));
  gh.factory<_i147.CompanyFinanceScreen>(() =>
      _i147.CompanyFinanceScreen(get<_i107.CompanyFinanceStateManager>()));
  gh.factory<_i148.CompanyProfileScreen>(() =>
      _i148.CompanyProfileScreen(get<_i108.CompanyProfileStateManager>()));
  gh.factory<_i149.InActiveSupplierScreen>(() =>
      _i149.InActiveSupplierScreen(get<_i111.InActiveSupplierStateManager>()));
  gh.factory<_i150.InitBranchesScreen>(
      () => _i150.InitBranchesScreen(get<_i112.InitBranchesStateManager>()));
  gh.factory<_i151.MainModule>(
      () => _i151.MainModule(get<_i113.MainScreen>(), get<_i109.HomeScreen>()));
  gh.factory<_i152.NoticeModule>(
      () => _i152.NoticeModule(get<_i114.NoticeScreen>()));
  gh.factory<_i153.OrderCaptainNotArrivedScreen>(() =>
      _i153.OrderCaptainNotArrivedScreen(
          get<_i115.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i154.OrderDetailsScreen>(
      () => _i154.OrderDetailsScreen(get<_i117.OrderStatusStateManager>()));
  gh.factory<_i155.OrderLogsScreen>(
      () => _i155.OrderLogsScreen(get<_i116.OrderLogsStateManager>()));
  gh.factory<_i156.OrderTimeLineScreen>(
      () => _i156.OrderTimeLineScreen(get<_i118.OrderTimeLineStateManager>()));
  gh.factory<_i157.PaymentsModule>(() => _i157.PaymentsModule(
      get<_i137.CaptainFinanceByCountOrderScreen>(),
      get<_i138.CaptainFinanceByHoursScreen>(),
      get<_i139.CaptainFinanceByOrderScreen>(),
      get<_i120.PaymentsToCaptainScreen>()));
  gh.factory<_i158.StoreInfoScreen>(
      () => _i158.StoreInfoScreen(get<_i124.StoreProfileStateManager>()));
  gh.factory<_i159.StoreSubscriptionsFinanceScreen>(() =>
      _i159.StoreSubscriptionsFinanceScreen(
          get<_i126.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i160.StoresInActiveScreen>(() =>
      _i160.StoresInActiveScreen(get<_i127.StoresInActiveStateManager>()));
  gh.factory<_i161.StoresNeedsSupportScreen>(() =>
      _i161.StoresNeedsSupportScreen(
          get<_i128.StoresNeedsSupportStateManager>()));
  gh.factory<_i162.SupplierAdsScreen>(
      () => _i162.SupplierAdsScreen(get<_i130.SupplierAdsStateManager>()));
  gh.factory<_i163.SupplierCategoriesModule>(() =>
      _i163.SupplierCategoriesModule(get<_i131.SupplierCategoriesScreen>()));
  gh.factory<_i164.SupplierNeedsSupportScreen>(() =>
      _i164.SupplierNeedsSupportScreen(
          get<_i132.SupplierNeedsSupportStateManager>()));
  gh.factory<_i165.SupplierProfileScreen>(() =>
      _i165.SupplierProfileScreen(get<_i133.SupplierProfileStateManager>()));
  gh.factory<_i166.UpdateBranchScreen>(
      () => _i166.UpdateBranchScreen(get<_i135.UpdateBranchStateManager>()));
  gh.factory<_i167.BranchesModule>(() => _i167.BranchesModule(
      get<_i136.BranchesListScreen>(),
      get<_i166.UpdateBranchScreen>(),
      get<_i150.InitBranchesScreen>()));
  gh.factory<_i168.CaptainsModule>(() => _i168.CaptainsModule(
      get<_i100.CaptainOffersScreen>(),
      get<_i110.InActiveCaptainsScreen>(),
      get<_i103.CaptainsScreen>(),
      get<_i142.CaptainProfileScreen>(),
      get<_i143.CaptainsNeedsSupportScreen>(),
      get<_i93.CaptainAccountBalanceScreen>(),
      get<_i140.CaptainFinancialDuesDetailsScreen>(),
      get<_i141.CaptainFinancialDuesScreen>()));
  gh.factory<_i169.CompanyModule>(() => _i169.CompanyModule(
      get<_i148.CompanyProfileScreen>(), get<_i147.CompanyFinanceScreen>()));
  gh.factory<_i170.StoresModule>(() => _i170.StoresModule(
      get<_i129.StoresScreen>(),
      get<_i158.StoreInfoScreen>(),
      get<_i160.StoresInActiveScreen>(),
      get<_i122.StoreBalanceScreen>(),
      get<_i161.StoresNeedsSupportScreen>(),
      get<_i154.OrderDetailsScreen>(),
      get<_i155.OrderLogsScreen>(),
      get<_i153.OrderCaptainNotArrivedScreen>(),
      get<_i156.OrderTimeLineScreen>(),
      get<_i125.StoreSubscriptionsFinanceDetailsScreen>(),
      get<_i159.StoreSubscriptionsFinanceScreen>()));
  gh.factory<_i171.SupplierModule>(() => _i171.SupplierModule(
      get<_i149.InActiveSupplierScreen>(),
      get<_i134.SuppliersScreen>(),
      get<_i165.SupplierProfileScreen>(),
      get<_i164.SupplierNeedsSupportScreen>(),
      get<_i162.SupplierAdsScreen>()));
  gh.factory<_i172.MyApp>(() => _i172.MyApp(
      get<_i16.AppThemeDataService>(),
      get<_i9.LocalizationService>(),
      get<_i60.FireNotificationService>(),
      get<_i7.LocalNotificationService>(),
      get<_i77.SplashModule>(),
      get<_i88.AuthorizationModule>(),
      get<_i146.ChatModule>(),
      get<_i121.SettingsModule>(),
      get<_i151.MainModule>(),
      get<_i170.StoresModule>(),
      get<_i145.CategoriesModule>(),
      get<_i169.CompanyModule>(),
      get<_i167.BranchesModule>(),
      get<_i152.NoticeModule>(),
      get<_i168.CaptainsModule>(),
      get<_i157.PaymentsModule>(),
      get<_i163.SupplierCategoriesModule>(),
      get<_i171.SupplierModule>(),
      get<_i144.CarsModule>(),
      get<_i90.BidOrderModule>()));
  gh.singleton<_i173.GlobalStateManager>(_i173.GlobalStateManager());
  return get;
}

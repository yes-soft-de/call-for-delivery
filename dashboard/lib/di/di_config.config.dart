// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i179;
import '../module_auth/authoriazation_module.dart' as _i93;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i21;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i22;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i30;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i33;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i40;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i65;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i70;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i80;
import '../module_bid_order/bid_order_module.dart' as _i95;
import '../module_bid_order/manager/bid_order_manager.dart' as _i46;
import '../module_bid_order/repository/bid_order_repository.dart' as _i23;
import '../module_bid_order/service/bid_order_service.dart' as _i47;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i48;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i49;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i94;
import '../module_branches/branches_module.dart' as _i174;
import '../module_branches/manager/branches_manager.dart' as _i50;
import '../module_branches/repository/branches_repository.dart' as _i24;
import '../module_branches/service/branches_list_service.dart' as _i96;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i97;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i117;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i142;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i143;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i157;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i173;
import '../module_captain/captains_module.dart' as _i175;
import '../module_captain/hive/captain_hive_helper.dart' as _i4;
import '../module_captain/manager/captains_manager.dart' as _i51;
import '../module_captain/repository/captains_repository.dart' as _i25;
import '../module_captain/service/captains_service.dart' as _i52;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i92;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i102;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i103;
import '../module_captain/state_manager/captain_list.dart' as _i53;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i107;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i104;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i106;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i69;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i98;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i147;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i148;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i150;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i149;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i108;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i105;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i115;
import '../module_categories/categories_module.dart' as _i152;
import '../module_categories/manager/categories_manager.dart' as _i57;
import '../module_categories/repository/categories_repository.dart' as _i27;
import '../module_categories/service/store_categories_service.dart' as _i58;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i75;
import '../module_categories/state_manager/packages_state_manager.dart' as _i76;
import '../module_categories/ui/screen/categories_screen.dart' as _i110;
import '../module_categories/ui/screen/packages_screen.dart' as _i126;
import '../module_chat/chat_module.dart' as _i153;
import '../module_chat/manager/chat/chat_manager.dart' as _i59;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i28;
import '../module_chat/service/chat/char_service.dart' as _i60;
import '../module_chat/state_manager/chat_state_manager.dart' as _i61;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i111;
import '../module_company/company_module.dart' as _i176;
import '../module_company/manager/company_manager.dart' as _i62;
import '../module_company/repository/company_repository.dart' as _i29;
import '../module_company/service/company_service.dart' as _i63;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i112;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i113;
import '../module_company/ui/screen/company_finance_screen.dart' as _i154;
import '../module_company/ui/screen/company_profile_screen.dart' as _i155;
import '../module_delivary_car/cars_module.dart' as _i151;
import '../module_delivary_car/manager/cars_manager.dart' as _i54;
import '../module_delivary_car/repository/cars_repository.dart' as _i26;
import '../module_delivary_car/service/cars_service.dart' as _i55;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i56;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i109;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i8;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i9;
import '../module_main/main_module.dart' as _i158;
import '../module_main/manager/home_manager.dart' as _i66;
import '../module_main/repository/home_repository.dart' as _i31;
import '../module_main/sceen/home_screen.dart' as _i114;
import '../module_main/sceen/main_screen.dart' as _i118;
import '../module_main/service/home_service.dart' as _i67;
import '../module_main/state_manager/home_state_manager.dart' as _i68;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notice/manager/notice_manager.dart' as _i71;
import '../module_notice/notice_module.dart' as _i159;
import '../module_notice/repository/notice_repository.dart' as _i34;
import '../module_notice/service/notice_service.dart' as _i72;
import '../module_notice/state_manager/notice_state_manager.dart' as _i73;
import '../module_notice/ui/screen/notice_screen.dart' as _i119;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i35;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i64;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i7;
import '../module_orders/hive/order_hive_helper.dart' as _i12;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i37;
import '../module_orders/orders_module.dart' as _i125;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i36;
import '../module_orders/service/orders/orders.service.dart' as _i38;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i74;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i121;
import '../module_payments/manager/payments_manager.dart' as _i77;
import '../module_payments/payments_module.dart' as _i164;
import '../module_payments/repository/payments_repository.dart' as _i39;
import '../module_payments/service/payments_service.dart' as _i78;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i99;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i100;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i101;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i79;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i83;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i145;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i144;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i146;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i127;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i129;
import '../module_settings/settings_module.dart' as _i128;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i19;
import '../module_settings/ui/settings_page/settings_page.dart' as _i81;
import '../module_splash/splash_module.dart' as _i82;
import '../module_splash/ui/screen/splash_screen.dart' as _i41;
import '../module_stores/hive/store_hive_helper.dart' as _i13;
import '../module_stores/manager/stores_manager.dart' as _i84;
import '../module_stores/repository/stores_repository.dart' as _i42;
import '../module_stores/service/store_service.dart' as _i85;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i120;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i122;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i123;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i124;
import '../module_stores/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i130;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i131;
import '../module_stores/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i133;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i134;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i135;
import '../module_stores/state_manager/stores_state_manager.dart' as _i86;
import '../module_stores/stores_module.dart' as _i177;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i160;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i161;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i162;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i163;
import '../module_stores/ui/screen/store_info_screen.dart' as _i165;
import '../module_stores/ui/screen/store_subscriptions_details_screen.dart'
    as _i132;
import '../module_stores/ui/screen/store_subscriptions_screen.dart' as _i166;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i167;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i168;
import '../module_stores/ui/screen/stores_screen.dart' as _i136;
import '../module_supplier/manager/supplier_manager.dart' as _i45;
import '../module_supplier/repository/supplier_repository.dart' as _i44;
import '../module_supplier/service/supplier_service.dart' as _i90;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i116;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i137;
import '../module_supplier/state_manager/supplier_list.dart' as _i91;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i139;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i140;
import '../module_supplier/supplier_module.dart' as _i178;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i156;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i169;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i141;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i171;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i172;
import '../module_supplier_categories/categories_supplier_module.dart' as _i170;
import '../module_supplier_categories/manager/categories_manager.dart' as _i87;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i43;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i88;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i89;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i138;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i20;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i32;
import '../utils/global/global_state_manager.dart' as _i180;
import '../utils/helpers/firestore_helper.dart' as _i6;
import '../utils/logger/logger.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
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
  gh.factory<_i12.OrderHiveHelper>(() => _i12.OrderHiveHelper());
  gh.factory<_i13.StoresHiveHelper>(() => _i13.StoresHiveHelper());
  gh.factory<_i14.ThemePreferencesHelper>(() => _i14.ThemePreferencesHelper());
  gh.factory<_i15.UploadRepository>(() => _i15.UploadRepository());
  gh.factory<_i16.ApiClient>(() => _i16.ApiClient(get<_i10.Logger>()));
  gh.factory<_i17.AppThemeDataService>(
      () => _i17.AppThemeDataService(get<_i14.ThemePreferencesHelper>()));
  gh.factory<_i18.AuthRepository>(
      () => _i18.AuthRepository(get<_i16.ApiClient>(), get<_i10.Logger>()));
  gh.factory<_i19.ChooseLocalScreen>(
      () => _i19.ChooseLocalScreen(get<_i9.LocalizationService>()));
  gh.factory<_i20.UploadManager>(
      () => _i20.UploadManager(get<_i15.UploadRepository>()));
  gh.factory<_i21.AuthManager>(
      () => _i21.AuthManager(get<_i18.AuthRepository>()));
  gh.factory<_i22.AuthService>(() =>
      _i22.AuthService(get<_i3.AuthPrefsHelper>(), get<_i21.AuthManager>()));
  gh.factory<_i23.BidOrderRepository>(() =>
      _i23.BidOrderRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i24.BranchesRepository>(() =>
      _i24.BranchesRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i25.CaptainsRepository>(() =>
      _i25.CaptainsRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i26.CarsRepository>(() =>
      _i26.CarsRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i27.CategoriesRepository>(() => _i27.CategoriesRepository(
      get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i28.ChatRepository>(() =>
      _i28.ChatRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i29.CompanyRepository>(() =>
      _i29.CompanyRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i30.ForgotPassStateManager>(
      () => _i30.ForgotPassStateManager(get<_i22.AuthService>()));
  gh.factory<_i31.HomeRepository>(() =>
      _i31.HomeRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i32.ImageUploadService>(
      () => _i32.ImageUploadService(get<_i20.UploadManager>()));
  gh.factory<_i33.LoginStateManager>(
      () => _i33.LoginStateManager(get<_i22.AuthService>()));
  gh.factory<_i34.NoticeRepository>(() =>
      _i34.NoticeRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i35.NotificationRepo>(() =>
      _i35.NotificationRepo(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i36.OrderRepository>(() =>
      _i36.OrderRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i37.OrdersManager>(
      () => _i37.OrdersManager(get<_i36.OrderRepository>()));
  gh.factory<_i38.OrdersService>(
      () => _i38.OrdersService(get<_i37.OrdersManager>()));
  gh.factory<_i39.PaymentsRepository>(() =>
      _i39.PaymentsRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i40.RegisterStateManager>(
      () => _i40.RegisterStateManager(get<_i22.AuthService>()));
  gh.factory<_i41.SplashScreen>(
      () => _i41.SplashScreen(get<_i22.AuthService>()));
  gh.factory<_i42.StoresRepository>(() =>
      _i42.StoresRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i43.SupplierCategoriesRepository>(() =>
      _i43.SupplierCategoriesRepository(
          get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i44.SupplierRepository>(() =>
      _i44.SupplierRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i45.SuppliersManager>(
      () => _i45.SuppliersManager(get<_i44.SupplierRepository>()));
  gh.factory<_i46.BidOrderManager>(
      () => _i46.BidOrderManager(get<_i23.BidOrderRepository>()));
  gh.factory<_i47.BidOrderService>(
      () => _i47.BidOrderService(get<_i46.BidOrderManager>()));
  gh.factory<_i48.BidOrderStateManager>(
      () => _i48.BidOrderStateManager(get<_i47.BidOrderService>()));
  gh.factory<_i49.BidOrdersScreen>(
      () => _i49.BidOrdersScreen(get<_i48.BidOrderStateManager>()));
  gh.factory<_i50.BranchesManager>(
      () => _i50.BranchesManager(get<_i24.BranchesRepository>()));
  gh.factory<_i51.CaptainsManager>(
      () => _i51.CaptainsManager(get<_i25.CaptainsRepository>()));
  gh.factory<_i52.CaptainsService>(
      () => _i52.CaptainsService(get<_i51.CaptainsManager>()));
  gh.factory<_i53.CaptainsStateManager>(
      () => _i53.CaptainsStateManager(get<_i52.CaptainsService>()));
  gh.factory<_i54.CarsManager>(
      () => _i54.CarsManager(get<_i26.CarsRepository>()));
  gh.factory<_i55.CarsService>(() => _i55.CarsService(get<_i54.CarsManager>()));
  gh.factory<_i56.CarsStateManager>(
      () => _i56.CarsStateManager(get<_i55.CarsService>()));
  gh.factory<_i57.CategoriesManager>(
      () => _i57.CategoriesManager(get<_i27.CategoriesRepository>()));
  gh.factory<_i58.CategoriesService>(
      () => _i58.CategoriesService(get<_i57.CategoriesManager>()));
  gh.factory<_i59.ChatManager>(
      () => _i59.ChatManager(get<_i28.ChatRepository>()));
  gh.factory<_i60.ChatService>(() => _i60.ChatService(get<_i59.ChatManager>()));
  gh.factory<_i61.ChatStateManager>(
      () => _i61.ChatStateManager(get<_i60.ChatService>()));
  gh.factory<_i62.CompanyManager>(
      () => _i62.CompanyManager(get<_i29.CompanyRepository>()));
  gh.factory<_i63.CompanyService>(
      () => _i63.CompanyService(get<_i62.CompanyManager>()));
  gh.factory<_i64.FireNotificationService>(() => _i64.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i35.NotificationRepo>()));
  gh.factory<_i65.ForgotPassScreen>(
      () => _i65.ForgotPassScreen(get<_i30.ForgotPassStateManager>()));
  gh.factory<_i66.HomeManager>(
      () => _i66.HomeManager(get<_i31.HomeRepository>()));
  gh.factory<_i67.HomeService>(() => _i67.HomeService(get<_i66.HomeManager>()));
  gh.factory<_i68.HomeStateManager>(
      () => _i68.HomeStateManager(get<_i67.HomeService>()));
  gh.factory<_i69.InActiveCaptainsStateManager>(
      () => _i69.InActiveCaptainsStateManager(get<_i52.CaptainsService>()));
  gh.factory<_i70.LoginScreen>(
      () => _i70.LoginScreen(get<_i33.LoginStateManager>()));
  gh.factory<_i71.NoticeManager>(
      () => _i71.NoticeManager(get<_i34.NoticeRepository>()));
  gh.factory<_i72.NoticeService>(
      () => _i72.NoticeService(get<_i71.NoticeManager>()));
  gh.factory<_i73.NoticeStateManager>(
      () => _i73.NoticeStateManager(get<_i72.NoticeService>()));
  gh.factory<_i74.OrderLogsStateManager>(
      () => _i74.OrderLogsStateManager(get<_i38.OrdersService>()));
  gh.factory<_i75.PackageCategoriesStateManager>(() =>
      _i75.PackageCategoriesStateManager(
          get<_i58.CategoriesService>(), get<_i32.ImageUploadService>()));
  gh.factory<_i76.PackagesStateManager>(() => _i76.PackagesStateManager(
      get<_i58.CategoriesService>(), get<_i22.AuthService>()));
  gh.factory<_i77.PaymentsManager>(
      () => _i77.PaymentsManager(get<_i39.PaymentsRepository>()));
  gh.factory<_i78.PaymentsService>(
      () => _i78.PaymentsService(get<_i77.PaymentsManager>()));
  gh.factory<_i79.PaymentsToCaptainStateManager>(
      () => _i79.PaymentsToCaptainStateManager(get<_i78.PaymentsService>()));
  gh.factory<_i80.RegisterScreen>(
      () => _i80.RegisterScreen(get<_i40.RegisterStateManager>()));
  gh.factory<_i81.SettingsScreen>(() => _i81.SettingsScreen(
      get<_i22.AuthService>(),
      get<_i9.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i64.FireNotificationService>()));
  gh.factory<_i82.SplashModule>(
      () => _i82.SplashModule(get<_i41.SplashScreen>()));
  gh.factory<_i83.StoreBalanceStateManager>(
      () => _i83.StoreBalanceStateManager(get<_i78.PaymentsService>()));
  gh.factory<_i84.StoreManager>(
      () => _i84.StoreManager(get<_i42.StoresRepository>()));
  gh.factory<_i85.StoresService>(
      () => _i85.StoresService(get<_i84.StoreManager>()));
  gh.factory<_i86.StoresStateManager>(() => _i86.StoresStateManager(
      get<_i85.StoresService>(),
      get<_i22.AuthService>(),
      get<_i32.ImageUploadService>()));
  gh.factory<_i87.SupplierCategoriesManager>(() =>
      _i87.SupplierCategoriesManager(get<_i43.SupplierCategoriesRepository>()));
  gh.factory<_i88.SupplierCategoriesService>(() =>
      _i88.SupplierCategoriesService(get<_i87.SupplierCategoriesManager>()));
  gh.factory<_i89.SupplierCategoriesStateManager>(() =>
      _i89.SupplierCategoriesStateManager(get<_i88.SupplierCategoriesService>(),
          get<_i32.ImageUploadService>()));
  gh.factory<_i90.SupplierService>(
      () => _i90.SupplierService(get<_i45.SuppliersManager>()));
  gh.factory<_i91.SuppliersStateManager>(
      () => _i91.SuppliersStateManager(get<_i90.SupplierService>()));
  gh.factory<_i92.AccountBalanceStateManager>(
      () => _i92.AccountBalanceStateManager(get<_i52.CaptainsService>()));
  gh.factory<_i93.AuthorizationModule>(() => _i93.AuthorizationModule(
      get<_i70.LoginScreen>(),
      get<_i80.RegisterScreen>(),
      get<_i65.ForgotPassScreen>()));
  gh.factory<_i94.BidOrderDetailsScreen>(
      () => _i94.BidOrderDetailsScreen(get<_i48.BidOrderStateManager>()));
  gh.factory<_i95.BidOrderModule>(
      () => _i95.BidOrderModule(get<_i49.BidOrdersScreen>()));
  gh.factory<_i96.BranchesListService>(
      () => _i96.BranchesListService(get<_i50.BranchesManager>()));
  gh.factory<_i97.BranchesListStateManager>(
      () => _i97.BranchesListStateManager(get<_i96.BranchesListService>()));
  gh.factory<_i98.CaptainAccountBalanceScreen>(() =>
      _i98.CaptainAccountBalanceScreen(get<_i92.AccountBalanceStateManager>()));
  gh.factory<_i99.CaptainFinanceByHoursStateManager>(() =>
      _i99.CaptainFinanceByHoursStateManager(get<_i78.PaymentsService>()));
  gh.factory<_i100.CaptainFinanceByOrderCountStateManager>(() =>
      _i100.CaptainFinanceByOrderCountStateManager(
          get<_i78.PaymentsService>()));
  gh.factory<_i101.CaptainFinanceByOrderStateManager>(() =>
      _i101.CaptainFinanceByOrderStateManager(get<_i78.PaymentsService>()));
  gh.factory<_i102.CaptainFinancialDuesDetailsStateManager>(() =>
      _i102.CaptainFinancialDuesDetailsStateManager(
          get<_i78.PaymentsService>(), get<_i52.CaptainsService>()));
  gh.factory<_i103.CaptainFinancialDuesStateManager>(() =>
      _i103.CaptainFinancialDuesStateManager(get<_i52.CaptainsService>()));
  gh.factory<_i104.CaptainOfferStateManager>(() =>
      _i104.CaptainOfferStateManager(
          get<_i52.CaptainsService>(), get<_i32.ImageUploadService>()));
  gh.factory<_i105.CaptainOffersScreen>(
      () => _i105.CaptainOffersScreen(get<_i104.CaptainOfferStateManager>()));
  gh.factory<_i106.CaptainProfileStateManager>(
      () => _i106.CaptainProfileStateManager(get<_i52.CaptainsService>()));
  gh.factory<_i107.CaptainsNeedsSupportStateManager>(() =>
      _i107.CaptainsNeedsSupportStateManager(get<_i52.CaptainsService>()));
  gh.factory<_i108.CaptainsScreen>(
      () => _i108.CaptainsScreen(get<_i53.CaptainsStateManager>()));
  gh.factory<_i109.CarsScreen>(
      () => _i109.CarsScreen(get<_i56.CarsStateManager>()));
  gh.factory<_i110.CategoriesScreen>(
      () => _i110.CategoriesScreen(get<_i75.PackageCategoriesStateManager>()));
  gh.factory<_i111.ChatPage>(() => _i111.ChatPage(
      get<_i61.ChatStateManager>(),
      get<_i32.ImageUploadService>(),
      get<_i22.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i112.CompanyFinanceStateManager>(() =>
      _i112.CompanyFinanceStateManager(
          get<_i22.AuthService>(), get<_i63.CompanyService>()));
  gh.factory<_i113.CompanyProfileStateManager>(() =>
      _i113.CompanyProfileStateManager(
          get<_i22.AuthService>(), get<_i63.CompanyService>()));
  gh.factory<_i114.HomeScreen>(
      () => _i114.HomeScreen(get<_i68.HomeStateManager>()));
  gh.factory<_i115.InActiveCaptainsScreen>(() =>
      _i115.InActiveCaptainsScreen(get<_i69.InActiveCaptainsStateManager>()));
  gh.factory<_i116.InActiveSupplierStateManager>(
      () => _i116.InActiveSupplierStateManager(get<_i90.SupplierService>()));
  gh.factory<_i117.InitBranchesStateManager>(
      () => _i117.InitBranchesStateManager(get<_i96.BranchesListService>()));
  gh.factory<_i118.MainScreen>(() => _i118.MainScreen(get<_i114.HomeScreen>()));
  gh.factory<_i119.NoticeScreen>(
      () => _i119.NoticeScreen(get<_i73.NoticeStateManager>()));
  gh.factory<_i120.OrderCaptainNotArrivedStateManager>(() =>
      _i120.OrderCaptainNotArrivedStateManager(get<_i85.StoresService>()));
  gh.factory<_i121.OrderLogsScreen>(
      () => _i121.OrderLogsScreen(get<_i74.OrderLogsStateManager>()));
  gh.factory<_i122.OrderLogsStateManager>(
      () => _i122.OrderLogsStateManager(get<_i85.StoresService>()));
  gh.factory<_i123.OrderStatusStateManager>(() => _i123.OrderStatusStateManager(
      get<_i85.StoresService>(), get<_i22.AuthService>()));
  gh.factory<_i124.OrderTimeLineStateManager>(() =>
      _i124.OrderTimeLineStateManager(
          get<_i85.StoresService>(), get<_i22.AuthService>()));
  gh.factory<_i125.OrdersModule>(
      () => _i125.OrdersModule(get<_i121.OrderLogsScreen>()));
  gh.factory<_i126.PackagesScreen>(
      () => _i126.PackagesScreen(get<_i76.PackagesStateManager>()));
  gh.factory<_i127.PaymentsToCaptainScreen>(() =>
      _i127.PaymentsToCaptainScreen(get<_i79.PaymentsToCaptainStateManager>()));
  gh.factory<_i128.SettingsModule>(() => _i128.SettingsModule(
      get<_i81.SettingsScreen>(), get<_i19.ChooseLocalScreen>()));
  gh.factory<_i129.StoreBalanceScreen>(
      () => _i129.StoreBalanceScreen(get<_i83.StoreBalanceStateManager>()));
  gh.factory<_i130.StoreFinancialSubscriptionsDuesDetailsStateManager>(() =>
      _i130.StoreFinancialSubscriptionsDuesDetailsStateManager(
          get<_i78.PaymentsService>(), get<_i85.StoresService>()));
  gh.factory<_i131.StoreProfileStateManager>(
      () => _i131.StoreProfileStateManager(get<_i85.StoresService>()));
  gh.factory<_i132.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i132.StoreSubscriptionsFinanceDetailsScreen(
          get<_i130.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i133.StoreSubscriptionsFinanceStateManager>(() =>
      _i133.StoreSubscriptionsFinanceStateManager(get<_i85.StoresService>()));
  gh.factory<_i134.StoresInActiveStateManager>(() =>
      _i134.StoresInActiveStateManager(get<_i85.StoresService>(),
          get<_i22.AuthService>(), get<_i32.ImageUploadService>()));
  gh.factory<_i135.StoresNeedsSupportStateManager>(
      () => _i135.StoresNeedsSupportStateManager(get<_i85.StoresService>()));
  gh.factory<_i136.StoresScreen>(
      () => _i136.StoresScreen(get<_i86.StoresStateManager>()));
  gh.factory<_i137.SupplierAdsStateManager>(
      () => _i137.SupplierAdsStateManager(get<_i90.SupplierService>()));
  gh.factory<_i138.SupplierCategoriesScreen>(() =>
      _i138.SupplierCategoriesScreen(
          get<_i89.SupplierCategoriesStateManager>()));
  gh.factory<_i139.SupplierNeedsSupportStateManager>(() =>
      _i139.SupplierNeedsSupportStateManager(get<_i90.SupplierService>()));
  gh.factory<_i140.SupplierProfileStateManager>(
      () => _i140.SupplierProfileStateManager(get<_i90.SupplierService>()));
  gh.factory<_i141.SuppliersScreen>(
      () => _i141.SuppliersScreen(get<_i91.SuppliersStateManager>()));
  gh.factory<_i142.UpdateBranchStateManager>(
      () => _i142.UpdateBranchStateManager(get<_i96.BranchesListService>()));
  gh.factory<_i143.BranchesListScreen>(
      () => _i143.BranchesListScreen(get<_i97.BranchesListStateManager>()));
  gh.factory<_i144.CaptainFinanceByCountOrderScreen>(() =>
      _i144.CaptainFinanceByCountOrderScreen(
          get<_i100.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i145.CaptainFinanceByHoursScreen>(() =>
      _i145.CaptainFinanceByHoursScreen(
          get<_i99.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i146.CaptainFinanceByOrderScreen>(() =>
      _i146.CaptainFinanceByOrderScreen(
          get<_i101.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i147.CaptainFinancialDuesDetailsScreen>(() =>
      _i147.CaptainFinancialDuesDetailsScreen(
          get<_i102.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i148.CaptainFinancialDuesScreen>(() =>
      _i148.CaptainFinancialDuesScreen(
          get<_i103.CaptainFinancialDuesStateManager>()));
  gh.factory<_i149.CaptainProfileScreen>(() =>
      _i149.CaptainProfileScreen(get<_i106.CaptainProfileStateManager>()));
  gh.factory<_i150.CaptainsNeedsSupportScreen>(() =>
      _i150.CaptainsNeedsSupportScreen(
          get<_i107.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i151.CarsModule>(() => _i151.CarsModule(get<_i109.CarsScreen>()));
  gh.factory<_i152.CategoriesModule>(() => _i152.CategoriesModule(
      get<_i110.CategoriesScreen>(), get<_i126.PackagesScreen>()));
  gh.factory<_i153.ChatModule>(
      () => _i153.ChatModule(get<_i111.ChatPage>(), get<_i22.AuthService>()));
  gh.factory<_i154.CompanyFinanceScreen>(() =>
      _i154.CompanyFinanceScreen(get<_i112.CompanyFinanceStateManager>()));
  gh.factory<_i155.CompanyProfileScreen>(() =>
      _i155.CompanyProfileScreen(get<_i113.CompanyProfileStateManager>()));
  gh.factory<_i156.InActiveSupplierScreen>(() =>
      _i156.InActiveSupplierScreen(get<_i116.InActiveSupplierStateManager>()));
  gh.factory<_i157.InitBranchesScreen>(
      () => _i157.InitBranchesScreen(get<_i117.InitBranchesStateManager>()));
  gh.factory<_i158.MainModule>(
      () => _i158.MainModule(get<_i118.MainScreen>(), get<_i114.HomeScreen>()));
  gh.factory<_i159.NoticeModule>(
      () => _i159.NoticeModule(get<_i119.NoticeScreen>()));
  gh.factory<_i160.OrderCaptainNotArrivedScreen>(() =>
      _i160.OrderCaptainNotArrivedScreen(
          get<_i120.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i161.OrderDetailsScreen>(
      () => _i161.OrderDetailsScreen(get<_i123.OrderStatusStateManager>()));
  gh.factory<_i162.OrderLogsScreen>(
      () => _i162.OrderLogsScreen(get<_i122.OrderLogsStateManager>()));
  gh.factory<_i163.OrderTimeLineScreen>(
      () => _i163.OrderTimeLineScreen(get<_i124.OrderTimeLineStateManager>()));
  gh.factory<_i164.PaymentsModule>(() => _i164.PaymentsModule(
      get<_i144.CaptainFinanceByCountOrderScreen>(),
      get<_i145.CaptainFinanceByHoursScreen>(),
      get<_i146.CaptainFinanceByOrderScreen>(),
      get<_i127.PaymentsToCaptainScreen>()));
  gh.factory<_i165.StoreInfoScreen>(
      () => _i165.StoreInfoScreen(get<_i131.StoreProfileStateManager>()));
  gh.factory<_i166.StoreSubscriptionsFinanceScreen>(() =>
      _i166.StoreSubscriptionsFinanceScreen(
          get<_i133.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i167.StoresInActiveScreen>(() =>
      _i167.StoresInActiveScreen(get<_i134.StoresInActiveStateManager>()));
  gh.factory<_i168.StoresNeedsSupportScreen>(() =>
      _i168.StoresNeedsSupportScreen(
          get<_i135.StoresNeedsSupportStateManager>()));
  gh.factory<_i169.SupplierAdsScreen>(
      () => _i169.SupplierAdsScreen(get<_i137.SupplierAdsStateManager>()));
  gh.factory<_i170.SupplierCategoriesModule>(() =>
      _i170.SupplierCategoriesModule(get<_i138.SupplierCategoriesScreen>()));
  gh.factory<_i171.SupplierNeedsSupportScreen>(() =>
      _i171.SupplierNeedsSupportScreen(
          get<_i139.SupplierNeedsSupportStateManager>()));
  gh.factory<_i172.SupplierProfileScreen>(() =>
      _i172.SupplierProfileScreen(get<_i140.SupplierProfileStateManager>()));
  gh.factory<_i173.UpdateBranchScreen>(
      () => _i173.UpdateBranchScreen(get<_i142.UpdateBranchStateManager>()));
  gh.factory<_i174.BranchesModule>(() => _i174.BranchesModule(
      get<_i143.BranchesListScreen>(),
      get<_i173.UpdateBranchScreen>(),
      get<_i157.InitBranchesScreen>()));
  gh.factory<_i175.CaptainsModule>(() => _i175.CaptainsModule(
      get<_i105.CaptainOffersScreen>(),
      get<_i115.InActiveCaptainsScreen>(),
      get<_i108.CaptainsScreen>(),
      get<_i149.CaptainProfileScreen>(),
      get<_i150.CaptainsNeedsSupportScreen>(),
      get<_i98.CaptainAccountBalanceScreen>(),
      get<_i147.CaptainFinancialDuesDetailsScreen>(),
      get<_i148.CaptainFinancialDuesScreen>()));
  gh.factory<_i176.CompanyModule>(() => _i176.CompanyModule(
      get<_i155.CompanyProfileScreen>(), get<_i154.CompanyFinanceScreen>()));
  gh.factory<_i177.StoresModule>(() => _i177.StoresModule(
      get<_i136.StoresScreen>(),
      get<_i165.StoreInfoScreen>(),
      get<_i167.StoresInActiveScreen>(),
      get<_i129.StoreBalanceScreen>(),
      get<_i168.StoresNeedsSupportScreen>(),
      get<_i161.OrderDetailsScreen>(),
      get<_i162.OrderLogsScreen>(),
      get<_i160.OrderCaptainNotArrivedScreen>(),
      get<_i163.OrderTimeLineScreen>(),
      get<_i132.StoreSubscriptionsFinanceDetailsScreen>(),
      get<_i166.StoreSubscriptionsFinanceScreen>()));
  gh.factory<_i178.SupplierModule>(() => _i178.SupplierModule(
      get<_i156.InActiveSupplierScreen>(),
      get<_i141.SuppliersScreen>(),
      get<_i172.SupplierProfileScreen>(),
      get<_i171.SupplierNeedsSupportScreen>(),
      get<_i169.SupplierAdsScreen>()));
  gh.factory<_i179.MyApp>(() => _i179.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i9.LocalizationService>(),
      get<_i64.FireNotificationService>(),
      get<_i7.LocalNotificationService>(),
      get<_i82.SplashModule>(),
      get<_i93.AuthorizationModule>(),
      get<_i153.ChatModule>(),
      get<_i128.SettingsModule>(),
      get<_i158.MainModule>(),
      get<_i177.StoresModule>(),
      get<_i152.CategoriesModule>(),
      get<_i176.CompanyModule>(),
      get<_i174.BranchesModule>(),
      get<_i159.NoticeModule>(),
      get<_i175.CaptainsModule>(),
      get<_i164.PaymentsModule>(),
      get<_i170.SupplierCategoriesModule>(),
      get<_i178.SupplierModule>(),
      get<_i151.CarsModule>(),
      get<_i95.BidOrderModule>(),
      get<_i125.OrdersModule>()));
  gh.singleton<_i180.GlobalStateManager>(_i180.GlobalStateManager());
  return get;
}

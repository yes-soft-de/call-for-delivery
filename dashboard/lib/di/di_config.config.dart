// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i160;
import '../module_auth/authoriazation_module.dart' as _i82;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i19;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i16;
import '../module_auth/service/auth_service/auth_service.dart' as _i20;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i30;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i34;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i55;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i60;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i69;
import '../module_branches/branches_module.dart' as _i155;
import '../module_branches/manager/branches_manager.dart' as _i40;
import '../module_branches/repository/branches_repository.dart' as _i21;
import '../module_branches/service/branches_list_service.dart' as _i83;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i84;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i104;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i124;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i125;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i139;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i154;
import '../module_captain/captains_module.dart' as _i156;
import '../module_captain/hive/captain_hive_helper.dart' as _i4;
import '../module_captain/manager/captains_manager.dart' as _i41;
import '../module_captain/repository/captains_repository.dart' as _i22;
import '../module_captain/service/captains_service.dart' as _i42;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i81;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i89;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i90;
import '../module_captain/state_manager/captain_list.dart' as _i43;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i94;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i91;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i93;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i59;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i85;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i129;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i130;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i132;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i131;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i95;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i92;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i102;
import '../module_categories/categories_module.dart' as _i134;
import '../module_categories/manager/categories_manager.dart' as _i47;
import '../module_categories/repository/categories_repository.dart' as _i24;
import '../module_categories/service/store_categories_service.dart' as _i48;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i64;
import '../module_categories/state_manager/packages_state_manager.dart' as _i65;
import '../module_categories/ui/screen/categories_screen.dart' as _i97;
import '../module_categories/ui/screen/packages_screen.dart' as _i111;
import '../module_chat/chat_module.dart' as _i135;
import '../module_chat/manager/chat/chat_manager.dart' as _i49;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i25;
import '../module_chat/service/chat/char_service.dart' as _i50;
import '../module_chat/state_manager/chat_state_manager.dart' as _i51;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i98;
import '../module_company/company_module.dart' as _i157;
import '../module_company/manager/company_manager.dart' as _i52;
import '../module_company/repository/company_repository.dart' as _i26;
import '../module_company/service/company_service.dart' as _i53;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i99;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i100;
import '../module_company/ui/screen/company_finance_screen.dart' as _i136;
import '../module_company/ui/screen/company_profile_screen.dart' as _i137;
import '../module_delivary_car/cars_module.dart' as _i133;
import '../module_delivary_car/manager/cars_manager.dart' as _i44;
import '../module_delivary_car/repository/cars_repository.dart' as _i23;
import '../module_delivary_car/service/cars_service.dart' as _i45;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i46;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i96;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i8;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i9;
import '../module_main/main_module.dart' as _i140;
import '../module_main/manager/home_manager.dart' as _i56;
import '../module_main/repository/home_repository.dart' as _i28;
import '../module_main/sceen/home_screen.dart' as _i101;
import '../module_main/sceen/main_screen.dart' as _i105;
import '../module_main/service/home_service.dart' as _i57;
import '../module_main/state_manager/home_state_manager.dart' as _i58;
import '../module_network/http_client/http_client.dart' as _i14;
import '../module_notice/manager/notice_manager.dart' as _i61;
import '../module_notice/notice_module.dart' as _i141;
import '../module_notice/repository/notice_repository.dart' as _i31;
import '../module_notice/service/notice_service.dart' as _i62;
import '../module_notice/state_manager/notice_state_manager.dart' as _i63;
import '../module_notice/ui/screen/notice_screen.dart' as _i106;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i32;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i54;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i7;
import '../module_payments/manager/payments_manager.dart' as _i66;
import '../module_payments/payments_module.dart' as _i146;
import '../module_payments/repository/payments_repository.dart' as _i33;
import '../module_payments/service/payments_service.dart' as _i67;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i86;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i87;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i88;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i68;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i72;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i127;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i126;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i128;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i112;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i114;
import '../module_settings/settings_module.dart' as _i113;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i17;
import '../module_settings/ui/settings_page/settings_page.dart' as _i70;
import '../module_splash/splash_module.dart' as _i71;
import '../module_splash/ui/screen/splash_screen.dart' as _i35;
import '../module_stores/manager/stores_manager.dart' as _i73;
import '../module_stores/repository/stores_repository.dart' as _i36;
import '../module_stores/service/store_service.dart' as _i74;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i107;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i108;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i109;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i110;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i115;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i116;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i117;
import '../module_stores/state_manager/stores_state_manager.dart' as _i75;
import '../module_stores/stores_module.dart' as _i158;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i142;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i143;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i144;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i145;
import '../module_stores/ui/screen/store_info_screen.dart' as _i147;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i148;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i149;
import '../module_stores/ui/screen/stores_screen.dart' as _i118;
import '../module_supplier/manager/supplier_manager.dart' as _i39;
import '../module_supplier/repository/supplier_repository.dart' as _i38;
import '../module_supplier/service/supplier_service.dart' as _i79;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i103;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i119;
import '../module_supplier/state_manager/supplier_list.dart' as _i80;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i121;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i122;
import '../module_supplier/supplier_module.dart' as _i159;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i138;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i150;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i123;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i152;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i153;
import '../module_supplier_categories/categories_supplier_module.dart' as _i151;
import '../module_supplier_categories/manager/categories_manager.dart' as _i76;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i37;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i77;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i78;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i120;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i12;
import '../module_theme/service/theme_service/theme_service.dart' as _i15;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i18;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i13;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i29;
import '../utils/global/global_state_manager.dart' as _i161;
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
  gh.factory<_i12.ThemePreferencesHelper>(() => _i12.ThemePreferencesHelper());
  gh.factory<_i13.UploadRepository>(() => _i13.UploadRepository());
  gh.factory<_i14.ApiClient>(() => _i14.ApiClient(get<_i10.Logger>()));
  gh.factory<_i15.AppThemeDataService>(
      () => _i15.AppThemeDataService(get<_i12.ThemePreferencesHelper>()));
  gh.factory<_i16.AuthRepository>(
      () => _i16.AuthRepository(get<_i14.ApiClient>(), get<_i10.Logger>()));
  gh.factory<_i17.ChooseLocalScreen>(
      () => _i17.ChooseLocalScreen(get<_i9.LocalizationService>()));
  gh.factory<_i18.UploadManager>(
      () => _i18.UploadManager(get<_i13.UploadRepository>()));
  gh.factory<_i19.AuthManager>(
      () => _i19.AuthManager(get<_i16.AuthRepository>()));
  gh.factory<_i20.AuthService>(() =>
      _i20.AuthService(get<_i3.AuthPrefsHelper>(), get<_i19.AuthManager>()));
  gh.factory<_i21.BranchesRepository>(() =>
      _i21.BranchesRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i22.CaptainsRepository>(() =>
      _i22.CaptainsRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i23.CarsRepository>(() =>
      _i23.CarsRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i24.CategoriesRepository>(() => _i24.CategoriesRepository(
      get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i25.ChatRepository>(() =>
      _i25.ChatRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i26.CompanyRepository>(() =>
      _i26.CompanyRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i27.ForgotPassStateManager>(
      () => _i27.ForgotPassStateManager(get<_i20.AuthService>()));
  gh.factory<_i28.HomeRepository>(() =>
      _i28.HomeRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i29.ImageUploadService>(
      () => _i29.ImageUploadService(get<_i18.UploadManager>()));
  gh.factory<_i30.LoginStateManager>(
      () => _i30.LoginStateManager(get<_i20.AuthService>()));
  gh.factory<_i31.NoticeRepository>(() =>
      _i31.NoticeRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i32.NotificationRepo>(() =>
      _i32.NotificationRepo(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i33.PaymentsRepository>(() =>
      _i33.PaymentsRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i34.RegisterStateManager>(
      () => _i34.RegisterStateManager(get<_i20.AuthService>()));
  gh.factory<_i35.SplashScreen>(
      () => _i35.SplashScreen(get<_i20.AuthService>()));
  gh.factory<_i36.StoresRepository>(() =>
      _i36.StoresRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i37.SupplierCategoriesRepository>(() =>
      _i37.SupplierCategoriesRepository(
          get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i38.SupplierRepository>(() =>
      _i38.SupplierRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i39.SuppliersManager>(
      () => _i39.SuppliersManager(get<_i38.SupplierRepository>()));
  gh.factory<_i40.BranchesManager>(
      () => _i40.BranchesManager(get<_i21.BranchesRepository>()));
  gh.factory<_i41.CaptainsManager>(
      () => _i41.CaptainsManager(get<_i22.CaptainsRepository>()));
  gh.factory<_i42.CaptainsService>(
      () => _i42.CaptainsService(get<_i41.CaptainsManager>()));
  gh.factory<_i43.CaptainsStateManager>(
      () => _i43.CaptainsStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i44.CarsManager>(
      () => _i44.CarsManager(get<_i23.CarsRepository>()));
  gh.factory<_i45.CarsService>(() => _i45.CarsService(get<_i44.CarsManager>()));
  gh.factory<_i46.CarsStateManager>(
      () => _i46.CarsStateManager(get<_i45.CarsService>()));
  gh.factory<_i47.CategoriesManager>(
      () => _i47.CategoriesManager(get<_i24.CategoriesRepository>()));
  gh.factory<_i48.CategoriesService>(
      () => _i48.CategoriesService(get<_i47.CategoriesManager>()));
  gh.factory<_i49.ChatManager>(
      () => _i49.ChatManager(get<_i25.ChatRepository>()));
  gh.factory<_i50.ChatService>(() => _i50.ChatService(get<_i49.ChatManager>()));
  gh.factory<_i51.ChatStateManager>(
      () => _i51.ChatStateManager(get<_i50.ChatService>()));
  gh.factory<_i52.CompanyManager>(
      () => _i52.CompanyManager(get<_i26.CompanyRepository>()));
  gh.factory<_i53.CompanyService>(
      () => _i53.CompanyService(get<_i52.CompanyManager>()));
  gh.factory<_i54.FireNotificationService>(() => _i54.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i32.NotificationRepo>()));
  gh.factory<_i55.ForgotPassScreen>(
      () => _i55.ForgotPassScreen(get<_i27.ForgotPassStateManager>()));
  gh.factory<_i56.HomeManager>(
      () => _i56.HomeManager(get<_i28.HomeRepository>()));
  gh.factory<_i57.HomeService>(() => _i57.HomeService(get<_i56.HomeManager>()));
  gh.factory<_i58.HomeStateManager>(
      () => _i58.HomeStateManager(get<_i57.HomeService>()));
  gh.factory<_i59.InActiveCaptainsStateManager>(
      () => _i59.InActiveCaptainsStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i60.LoginScreen>(
      () => _i60.LoginScreen(get<_i30.LoginStateManager>()));
  gh.factory<_i61.NoticeManager>(
      () => _i61.NoticeManager(get<_i31.NoticeRepository>()));
  gh.factory<_i62.NoticeService>(
      () => _i62.NoticeService(get<_i61.NoticeManager>()));
  gh.factory<_i63.NoticeStateManager>(
      () => _i63.NoticeStateManager(get<_i62.NoticeService>()));
  gh.factory<_i64.PackageCategoriesStateManager>(() =>
      _i64.PackageCategoriesStateManager(
          get<_i48.CategoriesService>(), get<_i29.ImageUploadService>()));
  gh.factory<_i65.PackagesStateManager>(() => _i65.PackagesStateManager(
      get<_i48.CategoriesService>(), get<_i20.AuthService>()));
  gh.factory<_i66.PaymentsManager>(
      () => _i66.PaymentsManager(get<_i33.PaymentsRepository>()));
  gh.factory<_i67.PaymentsService>(
      () => _i67.PaymentsService(get<_i66.PaymentsManager>()));
  gh.factory<_i68.PaymentsToCaptainStateManager>(
      () => _i68.PaymentsToCaptainStateManager(get<_i67.PaymentsService>()));
  gh.factory<_i69.RegisterScreen>(
      () => _i69.RegisterScreen(get<_i34.RegisterStateManager>()));
  gh.factory<_i70.SettingsScreen>(() => _i70.SettingsScreen(
      get<_i20.AuthService>(),
      get<_i9.LocalizationService>(),
      get<_i15.AppThemeDataService>(),
      get<_i54.FireNotificationService>()));
  gh.factory<_i71.SplashModule>(
      () => _i71.SplashModule(get<_i35.SplashScreen>()));
  gh.factory<_i72.StoreBalanceStateManager>(
      () => _i72.StoreBalanceStateManager(get<_i67.PaymentsService>()));
  gh.factory<_i73.StoreManager>(
      () => _i73.StoreManager(get<_i36.StoresRepository>()));
  gh.factory<_i74.StoresService>(
      () => _i74.StoresService(get<_i73.StoreManager>()));
  gh.factory<_i75.StoresStateManager>(() => _i75.StoresStateManager(
      get<_i74.StoresService>(),
      get<_i20.AuthService>(),
      get<_i29.ImageUploadService>()));
  gh.factory<_i76.SupplierCategoriesManager>(() =>
      _i76.SupplierCategoriesManager(get<_i37.SupplierCategoriesRepository>()));
  gh.factory<_i77.SupplierCategoriesService>(() =>
      _i77.SupplierCategoriesService(get<_i76.SupplierCategoriesManager>()));
  gh.factory<_i78.SupplierCategoriesStateManager>(() =>
      _i78.SupplierCategoriesStateManager(get<_i77.SupplierCategoriesService>(),
          get<_i29.ImageUploadService>()));
  gh.factory<_i79.SupplierService>(
      () => _i79.SupplierService(get<_i39.SuppliersManager>()));
  gh.factory<_i80.SuppliersStateManager>(
      () => _i80.SuppliersStateManager(get<_i79.SupplierService>()));
  gh.factory<_i81.AccountBalanceStateManager>(
      () => _i81.AccountBalanceStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i82.AuthorizationModule>(() => _i82.AuthorizationModule(
      get<_i60.LoginScreen>(),
      get<_i69.RegisterScreen>(),
      get<_i55.ForgotPassScreen>()));
  gh.factory<_i83.BranchesListService>(
      () => _i83.BranchesListService(get<_i40.BranchesManager>()));
  gh.factory<_i84.BranchesListStateManager>(
      () => _i84.BranchesListStateManager(get<_i83.BranchesListService>()));
  gh.factory<_i85.CaptainAccountBalanceScreen>(() =>
      _i85.CaptainAccountBalanceScreen(get<_i81.AccountBalanceStateManager>()));
  gh.factory<_i86.CaptainFinanceByHoursStateManager>(() =>
      _i86.CaptainFinanceByHoursStateManager(get<_i67.PaymentsService>()));
  gh.factory<_i87.CaptainFinanceByOrderCountStateManager>(() =>
      _i87.CaptainFinanceByOrderCountStateManager(get<_i67.PaymentsService>()));
  gh.factory<_i88.CaptainFinanceByOrderStateManager>(() =>
      _i88.CaptainFinanceByOrderStateManager(get<_i67.PaymentsService>()));
  gh.factory<_i89.CaptainFinancialDuesDetailsStateManager>(() =>
      _i89.CaptainFinancialDuesDetailsStateManager(
          get<_i67.PaymentsService>(), get<_i42.CaptainsService>()));
  gh.factory<_i90.CaptainFinancialDuesStateManager>(
      () => _i90.CaptainFinancialDuesStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i91.CaptainOfferStateManager>(() => _i91.CaptainOfferStateManager(
      get<_i42.CaptainsService>(), get<_i29.ImageUploadService>()));
  gh.factory<_i92.CaptainOffersScreen>(
      () => _i92.CaptainOffersScreen(get<_i91.CaptainOfferStateManager>()));
  gh.factory<_i93.CaptainProfileStateManager>(
      () => _i93.CaptainProfileStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i94.CaptainsNeedsSupportStateManager>(
      () => _i94.CaptainsNeedsSupportStateManager(get<_i42.CaptainsService>()));
  gh.factory<_i95.CaptainsScreen>(
      () => _i95.CaptainsScreen(get<_i43.CaptainsStateManager>()));
  gh.factory<_i96.CarsScreen>(
      () => _i96.CarsScreen(get<_i46.CarsStateManager>()));
  gh.factory<_i97.CategoriesScreen>(
      () => _i97.CategoriesScreen(get<_i64.PackageCategoriesStateManager>()));
  gh.factory<_i98.ChatPage>(() => _i98.ChatPage(
      get<_i51.ChatStateManager>(),
      get<_i29.ImageUploadService>(),
      get<_i20.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i99.CompanyFinanceStateManager>(() =>
      _i99.CompanyFinanceStateManager(
          get<_i20.AuthService>(), get<_i53.CompanyService>()));
  gh.factory<_i100.CompanyProfileStateManager>(() =>
      _i100.CompanyProfileStateManager(
          get<_i20.AuthService>(), get<_i53.CompanyService>()));
  gh.factory<_i101.HomeScreen>(
      () => _i101.HomeScreen(get<_i58.HomeStateManager>()));
  gh.factory<_i102.InActiveCaptainsScreen>(() =>
      _i102.InActiveCaptainsScreen(get<_i59.InActiveCaptainsStateManager>()));
  gh.factory<_i103.InActiveSupplierStateManager>(
      () => _i103.InActiveSupplierStateManager(get<_i79.SupplierService>()));
  gh.factory<_i104.InitBranchesStateManager>(
      () => _i104.InitBranchesStateManager(get<_i83.BranchesListService>()));
  gh.factory<_i105.MainScreen>(() => _i105.MainScreen(get<_i101.HomeScreen>()));
  gh.factory<_i106.NoticeScreen>(
      () => _i106.NoticeScreen(get<_i63.NoticeStateManager>()));
  gh.factory<_i107.OrderCaptainNotArrivedStateManager>(() =>
      _i107.OrderCaptainNotArrivedStateManager(get<_i74.StoresService>()));
  gh.factory<_i108.OrderLogsStateManager>(
      () => _i108.OrderLogsStateManager(get<_i74.StoresService>()));
  gh.factory<_i109.OrderStatusStateManager>(() => _i109.OrderStatusStateManager(
      get<_i74.StoresService>(), get<_i20.AuthService>()));
  gh.factory<_i110.OrderTimeLineStateManager>(() =>
      _i110.OrderTimeLineStateManager(
          get<_i74.StoresService>(), get<_i20.AuthService>()));
  gh.factory<_i111.PackagesScreen>(
      () => _i111.PackagesScreen(get<_i65.PackagesStateManager>()));
  gh.factory<_i112.PaymentsToCaptainScreen>(() =>
      _i112.PaymentsToCaptainScreen(get<_i68.PaymentsToCaptainStateManager>()));
  gh.factory<_i113.SettingsModule>(() => _i113.SettingsModule(
      get<_i70.SettingsScreen>(), get<_i17.ChooseLocalScreen>()));
  gh.factory<_i114.StoreBalanceScreen>(
      () => _i114.StoreBalanceScreen(get<_i72.StoreBalanceStateManager>()));
  gh.factory<_i115.StoreProfileStateManager>(
      () => _i115.StoreProfileStateManager(get<_i74.StoresService>()));
  gh.factory<_i116.StoresInActiveStateManager>(() =>
      _i116.StoresInActiveStateManager(get<_i74.StoresService>(),
          get<_i20.AuthService>(), get<_i29.ImageUploadService>()));
  gh.factory<_i117.StoresNeedsSupportStateManager>(
      () => _i117.StoresNeedsSupportStateManager(get<_i74.StoresService>()));
  gh.factory<_i118.StoresScreen>(
      () => _i118.StoresScreen(get<_i75.StoresStateManager>()));
  gh.factory<_i119.SupplierAdsStateManager>(
      () => _i119.SupplierAdsStateManager(get<_i79.SupplierService>()));
  gh.factory<_i120.SupplierCategoriesScreen>(() =>
      _i120.SupplierCategoriesScreen(
          get<_i78.SupplierCategoriesStateManager>()));
  gh.factory<_i121.SupplierNeedsSupportStateManager>(() =>
      _i121.SupplierNeedsSupportStateManager(get<_i79.SupplierService>()));
  gh.factory<_i122.SupplierProfileStateManager>(
      () => _i122.SupplierProfileStateManager(get<_i79.SupplierService>()));
  gh.factory<_i123.SuppliersScreen>(
      () => _i123.SuppliersScreen(get<_i80.SuppliersStateManager>()));
  gh.factory<_i124.UpdateBranchStateManager>(
      () => _i124.UpdateBranchStateManager(get<_i83.BranchesListService>()));
  gh.factory<_i125.BranchesListScreen>(
      () => _i125.BranchesListScreen(get<_i84.BranchesListStateManager>()));
  gh.factory<_i126.CaptainFinanceByCountOrderScreen>(() =>
      _i126.CaptainFinanceByCountOrderScreen(
          get<_i87.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i127.CaptainFinanceByHoursScreen>(() =>
      _i127.CaptainFinanceByHoursScreen(
          get<_i86.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i128.CaptainFinanceByOrderScreen>(() =>
      _i128.CaptainFinanceByOrderScreen(
          get<_i88.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i129.CaptainFinancialDuesDetailsScreen>(() =>
      _i129.CaptainFinancialDuesDetailsScreen(
          get<_i89.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i130.CaptainFinancialDuesScreen>(() =>
      _i130.CaptainFinancialDuesScreen(
          get<_i90.CaptainFinancialDuesStateManager>()));
  gh.factory<_i131.CaptainProfileScreen>(
      () => _i131.CaptainProfileScreen(get<_i93.CaptainProfileStateManager>()));
  gh.factory<_i132.CaptainsNeedsSupportScreen>(() =>
      _i132.CaptainsNeedsSupportScreen(
          get<_i94.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i133.CarsModule>(() => _i133.CarsModule(get<_i96.CarsScreen>()));
  gh.factory<_i134.CategoriesModule>(() => _i134.CategoriesModule(
      get<_i97.CategoriesScreen>(), get<_i111.PackagesScreen>()));
  gh.factory<_i135.ChatModule>(
      () => _i135.ChatModule(get<_i98.ChatPage>(), get<_i20.AuthService>()));
  gh.factory<_i136.CompanyFinanceScreen>(
      () => _i136.CompanyFinanceScreen(get<_i99.CompanyFinanceStateManager>()));
  gh.factory<_i137.CompanyProfileScreen>(() =>
      _i137.CompanyProfileScreen(get<_i100.CompanyProfileStateManager>()));
  gh.factory<_i138.InActiveSupplierScreen>(() =>
      _i138.InActiveSupplierScreen(get<_i103.InActiveSupplierStateManager>()));
  gh.factory<_i139.InitBranchesScreen>(
      () => _i139.InitBranchesScreen(get<_i104.InitBranchesStateManager>()));
  gh.factory<_i140.MainModule>(
      () => _i140.MainModule(get<_i105.MainScreen>(), get<_i101.HomeScreen>()));
  gh.factory<_i141.NoticeModule>(
      () => _i141.NoticeModule(get<_i106.NoticeScreen>()));
  gh.factory<_i142.OrderCaptainNotArrivedScreen>(() =>
      _i142.OrderCaptainNotArrivedScreen(
          get<_i107.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i143.OrderDetailsScreen>(
      () => _i143.OrderDetailsScreen(get<_i109.OrderStatusStateManager>()));
  gh.factory<_i144.OrderLogsScreen>(
      () => _i144.OrderLogsScreen(get<_i108.OrderLogsStateManager>()));
  gh.factory<_i145.OrderTimeLineScreen>(
      () => _i145.OrderTimeLineScreen(get<_i110.OrderTimeLineStateManager>()));
  gh.factory<_i146.PaymentsModule>(() => _i146.PaymentsModule(
      get<_i126.CaptainFinanceByCountOrderScreen>(),
      get<_i127.CaptainFinanceByHoursScreen>(),
      get<_i128.CaptainFinanceByOrderScreen>(),
      get<_i112.PaymentsToCaptainScreen>()));
  gh.factory<_i147.StoreInfoScreen>(
      () => _i147.StoreInfoScreen(get<_i115.StoreProfileStateManager>()));
  gh.factory<_i148.StoresInActiveScreen>(() =>
      _i148.StoresInActiveScreen(get<_i116.StoresInActiveStateManager>()));
  gh.factory<_i149.StoresNeedsSupportScreen>(() =>
      _i149.StoresNeedsSupportScreen(
          get<_i117.StoresNeedsSupportStateManager>()));
  gh.factory<_i150.SupplierAdsScreen>(
      () => _i150.SupplierAdsScreen(get<_i119.SupplierAdsStateManager>()));
  gh.factory<_i151.SupplierCategoriesModule>(() =>
      _i151.SupplierCategoriesModule(get<_i120.SupplierCategoriesScreen>()));
  gh.factory<_i152.SupplierNeedsSupportScreen>(() =>
      _i152.SupplierNeedsSupportScreen(
          get<_i121.SupplierNeedsSupportStateManager>()));
  gh.factory<_i153.SupplierProfileScreen>(() =>
      _i153.SupplierProfileScreen(get<_i122.SupplierProfileStateManager>()));
  gh.factory<_i154.UpdateBranchScreen>(
      () => _i154.UpdateBranchScreen(get<_i124.UpdateBranchStateManager>()));
  gh.factory<_i155.BranchesModule>(() => _i155.BranchesModule(
      get<_i125.BranchesListScreen>(),
      get<_i154.UpdateBranchScreen>(),
      get<_i139.InitBranchesScreen>()));
  gh.factory<_i156.CaptainsModule>(() => _i156.CaptainsModule(
      get<_i92.CaptainOffersScreen>(),
      get<_i102.InActiveCaptainsScreen>(),
      get<_i95.CaptainsScreen>(),
      get<_i131.CaptainProfileScreen>(),
      get<_i132.CaptainsNeedsSupportScreen>(),
      get<_i85.CaptainAccountBalanceScreen>(),
      get<_i129.CaptainFinancialDuesDetailsScreen>(),
      get<_i130.CaptainFinancialDuesScreen>()));
  gh.factory<_i157.CompanyModule>(() => _i157.CompanyModule(
      get<_i137.CompanyProfileScreen>(), get<_i136.CompanyFinanceScreen>()));
  gh.factory<_i158.StoresModule>(() => _i158.StoresModule(
      get<_i118.StoresScreen>(),
      get<_i147.StoreInfoScreen>(),
      get<_i148.StoresInActiveScreen>(),
      get<_i114.StoreBalanceScreen>(),
      get<_i149.StoresNeedsSupportScreen>(),
      get<_i143.OrderDetailsScreen>(),
      get<_i144.OrderLogsScreen>(),
      get<_i142.OrderCaptainNotArrivedScreen>(),
      get<_i145.OrderTimeLineScreen>()));
  gh.factory<_i159.SupplierModule>(() => _i159.SupplierModule(
      get<_i138.InActiveSupplierScreen>(),
      get<_i123.SuppliersScreen>(),
      get<_i153.SupplierProfileScreen>(),
      get<_i152.SupplierNeedsSupportScreen>(),
      get<_i150.SupplierAdsScreen>()));
  gh.factory<_i160.MyApp>(() => _i160.MyApp(
      get<_i15.AppThemeDataService>(),
      get<_i9.LocalizationService>(),
      get<_i54.FireNotificationService>(),
      get<_i7.LocalNotificationService>(),
      get<_i71.SplashModule>(),
      get<_i82.AuthorizationModule>(),
      get<_i135.ChatModule>(),
      get<_i113.SettingsModule>(),
      get<_i140.MainModule>(),
      get<_i158.StoresModule>(),
      get<_i134.CategoriesModule>(),
      get<_i157.CompanyModule>(),
      get<_i155.BranchesModule>(),
      get<_i141.NoticeModule>(),
      get<_i156.CaptainsModule>(),
      get<_i146.PaymentsModule>(),
      get<_i151.SupplierCategoriesModule>(),
      get<_i159.SupplierModule>(),
      get<_i133.CarsModule>()));
  gh.singleton<_i161.GlobalStateManager>(_i161.GlobalStateManager());
  return get;
}

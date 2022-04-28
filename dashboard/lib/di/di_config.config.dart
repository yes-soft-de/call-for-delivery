// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i154;
import '../module_auth/authoriazation_module.dart' as _i78;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i19;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i16;
import '../module_auth/service/auth_service/auth_service.dart' as _i20;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i29;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i33;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i51;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i56;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i65;
import '../module_branches/branches_module.dart' as _i149;
import '../module_branches/manager/branches_manager.dart' as _i39;
import '../module_branches/repository/branches_repository.dart' as _i21;
import '../module_branches/service/branches_list_service.dart' as _i79;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i80;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i99;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i119;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i120;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i133;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i148;
import '../module_captain/captains_module.dart' as _i150;
import '../module_captain/hive/captain_hive_helper.dart' as _i4;
import '../module_captain/manager/captains_manager.dart' as _i40;
import '../module_captain/repository/captains_repository.dart' as _i22;
import '../module_captain/service/captains_service.dart' as _i41;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i77;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i85;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i86;
import '../module_captain/state_manager/captain_list.dart' as _i42;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i90;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i87;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i89;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i55;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i81;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i124;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i125;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i127;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i126;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i91;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i88;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i97;
import '../module_categories/categories_module.dart' as _i128;
import '../module_categories/manager/categories_manager.dart' as _i43;
import '../module_categories/repository/categories_repository.dart' as _i23;
import '../module_categories/service/store_categories_service.dart' as _i44;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i60;
import '../module_categories/state_manager/packages_state_manager.dart' as _i61;
import '../module_categories/ui/screen/categories_screen.dart' as _i92;
import '../module_categories/ui/screen/packages_screen.dart' as _i106;
import '../module_chat/chat_module.dart' as _i129;
import '../module_chat/manager/chat/chat_manager.dart' as _i45;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i24;
import '../module_chat/service/chat/char_service.dart' as _i46;
import '../module_chat/state_manager/chat_state_manager.dart' as _i47;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i93;
import '../module_company/company_module.dart' as _i151;
import '../module_company/manager/company_manager.dart' as _i48;
import '../module_company/repository/company_repository.dart' as _i25;
import '../module_company/service/company_service.dart' as _i49;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i94;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i95;
import '../module_company/ui/screen/company_finance_screen.dart' as _i130;
import '../module_company/ui/screen/company_profile_screen.dart' as _i131;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i8;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i9;
import '../module_main/main_module.dart' as _i134;
import '../module_main/manager/home_manager.dart' as _i52;
import '../module_main/repository/home_repository.dart' as _i27;
import '../module_main/sceen/home_screen.dart' as _i96;
import '../module_main/sceen/main_screen.dart' as _i100;
import '../module_main/service/home_service.dart' as _i53;
import '../module_main/state_manager/home_state_manager.dart' as _i54;
import '../module_network/http_client/http_client.dart' as _i14;
import '../module_notice/manager/notice_manager.dart' as _i57;
import '../module_notice/notice_module.dart' as _i135;
import '../module_notice/repository/notice_repository.dart' as _i30;
import '../module_notice/service/notice_service.dart' as _i58;
import '../module_notice/state_manager/notice_state_manager.dart' as _i59;
import '../module_notice/ui/screen/notice_screen.dart' as _i101;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i31;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i50;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i7;
import '../module_payments/manager/payments_manager.dart' as _i62;
import '../module_payments/payments_module.dart' as _i140;
import '../module_payments/repository/payments_repository.dart' as _i32;
import '../module_payments/service/payments_service.dart' as _i63;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i82;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i83;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i84;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i64;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i68;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i122;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i121;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i123;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i107;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i109;
import '../module_settings/settings_module.dart' as _i108;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i17;
import '../module_settings/ui/settings_page/settings_page.dart' as _i66;
import '../module_splash/splash_module.dart' as _i67;
import '../module_splash/ui/screen/splash_screen.dart' as _i34;
import '../module_stores/manager/stores_manager.dart' as _i69;
import '../module_stores/repository/stores_repository.dart' as _i35;
import '../module_stores/service/store_service.dart' as _i70;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i102;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i103;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i104;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i105;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i110;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i111;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i112;
import '../module_stores/state_manager/stores_state_manager.dart' as _i71;
import '../module_stores/stores_module.dart' as _i152;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i136;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i137;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i138;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i139;
import '../module_stores/ui/screen/store_info_screen.dart' as _i141;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i142;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i143;
import '../module_stores/ui/screen/stores_screen.dart' as _i113;
import '../module_supplier/manager/supplier_manager.dart' as _i38;
import '../module_supplier/repository/supplier_repository.dart' as _i37;
import '../module_supplier/service/supplier_service.dart' as _i75;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i98;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i114;
import '../module_supplier/state_manager/supplier_list.dart' as _i76;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i116;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i117;
import '../module_supplier/supplier_module.dart' as _i153;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i132;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i144;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i118;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i146;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i147;
import '../module_supplier_categories/categories_supplier_module.dart' as _i145;
import '../module_supplier_categories/manager/categories_manager.dart' as _i72;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i36;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i73;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i74;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i115;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i12;
import '../module_theme/service/theme_service/theme_service.dart' as _i15;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i18;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i13;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i28;
import '../utils/global/global_state_manager.dart' as _i155;
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
  gh.factory<_i23.CategoriesRepository>(() => _i23.CategoriesRepository(
      get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i24.ChatRepository>(() =>
      _i24.ChatRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i25.CompanyRepository>(() =>
      _i25.CompanyRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i26.ForgotPassStateManager>(
      () => _i26.ForgotPassStateManager(get<_i20.AuthService>()));
  gh.factory<_i27.HomeRepository>(() =>
      _i27.HomeRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i28.ImageUploadService>(
      () => _i28.ImageUploadService(get<_i18.UploadManager>()));
  gh.factory<_i29.LoginStateManager>(
      () => _i29.LoginStateManager(get<_i20.AuthService>()));
  gh.factory<_i30.NoticeRepository>(() =>
      _i30.NoticeRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i31.NotificationRepo>(() =>
      _i31.NotificationRepo(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i32.PaymentsRepository>(() =>
      _i32.PaymentsRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i33.RegisterStateManager>(
      () => _i33.RegisterStateManager(get<_i20.AuthService>()));
  gh.factory<_i34.SplashScreen>(
      () => _i34.SplashScreen(get<_i20.AuthService>()));
  gh.factory<_i35.StoresRepository>(() =>
      _i35.StoresRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i36.SupplierCategoriesRepository>(() =>
      _i36.SupplierCategoriesRepository(
          get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i37.SupplierRepository>(() =>
      _i37.SupplierRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i38.SuppliersManager>(
      () => _i38.SuppliersManager(get<_i37.SupplierRepository>()));
  gh.factory<_i39.BranchesManager>(
      () => _i39.BranchesManager(get<_i21.BranchesRepository>()));
  gh.factory<_i40.CaptainsManager>(
      () => _i40.CaptainsManager(get<_i22.CaptainsRepository>()));
  gh.factory<_i41.CaptainsService>(
      () => _i41.CaptainsService(get<_i40.CaptainsManager>()));
  gh.factory<_i42.CaptainsStateManager>(
      () => _i42.CaptainsStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i43.CategoriesManager>(
      () => _i43.CategoriesManager(get<_i23.CategoriesRepository>()));
  gh.factory<_i44.CategoriesService>(
      () => _i44.CategoriesService(get<_i43.CategoriesManager>()));
  gh.factory<_i45.ChatManager>(
      () => _i45.ChatManager(get<_i24.ChatRepository>()));
  gh.factory<_i46.ChatService>(() => _i46.ChatService(get<_i45.ChatManager>()));
  gh.factory<_i47.ChatStateManager>(
      () => _i47.ChatStateManager(get<_i46.ChatService>()));
  gh.factory<_i48.CompanyManager>(
      () => _i48.CompanyManager(get<_i25.CompanyRepository>()));
  gh.factory<_i49.CompanyService>(
      () => _i49.CompanyService(get<_i48.CompanyManager>()));
  gh.factory<_i50.FireNotificationService>(() => _i50.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i31.NotificationRepo>()));
  gh.factory<_i51.ForgotPassScreen>(
      () => _i51.ForgotPassScreen(get<_i26.ForgotPassStateManager>()));
  gh.factory<_i52.HomeManager>(
      () => _i52.HomeManager(get<_i27.HomeRepository>()));
  gh.factory<_i53.HomeService>(() => _i53.HomeService(get<_i52.HomeManager>()));
  gh.factory<_i54.HomeStateManager>(
      () => _i54.HomeStateManager(get<_i53.HomeService>()));
  gh.factory<_i55.InActiveCaptainsStateManager>(
      () => _i55.InActiveCaptainsStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i56.LoginScreen>(
      () => _i56.LoginScreen(get<_i29.LoginStateManager>()));
  gh.factory<_i57.NoticeManager>(
      () => _i57.NoticeManager(get<_i30.NoticeRepository>()));
  gh.factory<_i58.NoticeService>(
      () => _i58.NoticeService(get<_i57.NoticeManager>()));
  gh.factory<_i59.NoticeStateManager>(
      () => _i59.NoticeStateManager(get<_i58.NoticeService>()));
  gh.factory<_i60.PackageCategoriesStateManager>(() =>
      _i60.PackageCategoriesStateManager(
          get<_i44.CategoriesService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i61.PackagesStateManager>(() => _i61.PackagesStateManager(
      get<_i44.CategoriesService>(), get<_i20.AuthService>()));
  gh.factory<_i62.PaymentsManager>(
      () => _i62.PaymentsManager(get<_i32.PaymentsRepository>()));
  gh.factory<_i63.PaymentsService>(
      () => _i63.PaymentsService(get<_i62.PaymentsManager>()));
  gh.factory<_i64.PaymentsToCaptainStateManager>(
      () => _i64.PaymentsToCaptainStateManager(get<_i63.PaymentsService>()));
  gh.factory<_i65.RegisterScreen>(
      () => _i65.RegisterScreen(get<_i33.RegisterStateManager>()));
  gh.factory<_i66.SettingsScreen>(() => _i66.SettingsScreen(
      get<_i20.AuthService>(),
      get<_i9.LocalizationService>(),
      get<_i15.AppThemeDataService>(),
      get<_i50.FireNotificationService>()));
  gh.factory<_i67.SplashModule>(
      () => _i67.SplashModule(get<_i34.SplashScreen>()));
  gh.factory<_i68.StoreBalanceStateManager>(
      () => _i68.StoreBalanceStateManager(get<_i63.PaymentsService>()));
  gh.factory<_i69.StoreManager>(
      () => _i69.StoreManager(get<_i35.StoresRepository>()));
  gh.factory<_i70.StoresService>(
      () => _i70.StoresService(get<_i69.StoreManager>()));
  gh.factory<_i71.StoresStateManager>(() => _i71.StoresStateManager(
      get<_i70.StoresService>(),
      get<_i20.AuthService>(),
      get<_i28.ImageUploadService>()));
  gh.factory<_i72.SupplierCategoriesManager>(() =>
      _i72.SupplierCategoriesManager(get<_i36.SupplierCategoriesRepository>()));
  gh.factory<_i73.SupplierCategoriesService>(() =>
      _i73.SupplierCategoriesService(get<_i72.SupplierCategoriesManager>()));
  gh.factory<_i74.SupplierCategoriesStateManager>(() =>
      _i74.SupplierCategoriesStateManager(get<_i73.SupplierCategoriesService>(),
          get<_i28.ImageUploadService>()));
  gh.factory<_i75.SupplierService>(
      () => _i75.SupplierService(get<_i38.SuppliersManager>()));
  gh.factory<_i76.SuppliersStateManager>(
      () => _i76.SuppliersStateManager(get<_i75.SupplierService>()));
  gh.factory<_i77.AccountBalanceStateManager>(
      () => _i77.AccountBalanceStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i78.AuthorizationModule>(() => _i78.AuthorizationModule(
      get<_i56.LoginScreen>(),
      get<_i65.RegisterScreen>(),
      get<_i51.ForgotPassScreen>()));
  gh.factory<_i79.BranchesListService>(
      () => _i79.BranchesListService(get<_i39.BranchesManager>()));
  gh.factory<_i80.BranchesListStateManager>(
      () => _i80.BranchesListStateManager(get<_i79.BranchesListService>()));
  gh.factory<_i81.CaptainAccountBalanceScreen>(() =>
      _i81.CaptainAccountBalanceScreen(get<_i77.AccountBalanceStateManager>()));
  gh.factory<_i82.CaptainFinanceByHoursStateManager>(() =>
      _i82.CaptainFinanceByHoursStateManager(get<_i63.PaymentsService>()));
  gh.factory<_i83.CaptainFinanceByOrderCountStateManager>(() =>
      _i83.CaptainFinanceByOrderCountStateManager(get<_i63.PaymentsService>()));
  gh.factory<_i84.CaptainFinanceByOrderStateManager>(() =>
      _i84.CaptainFinanceByOrderStateManager(get<_i63.PaymentsService>()));
  gh.factory<_i85.CaptainFinancialDuesDetailsStateManager>(() =>
      _i85.CaptainFinancialDuesDetailsStateManager(
          get<_i63.PaymentsService>(), get<_i41.CaptainsService>()));
  gh.factory<_i86.CaptainFinancialDuesStateManager>(
      () => _i86.CaptainFinancialDuesStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i87.CaptainOfferStateManager>(() => _i87.CaptainOfferStateManager(
      get<_i41.CaptainsService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i88.CaptainOffersScreen>(
      () => _i88.CaptainOffersScreen(get<_i87.CaptainOfferStateManager>()));
  gh.factory<_i89.CaptainProfileStateManager>(
      () => _i89.CaptainProfileStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i90.CaptainsNeedsSupportStateManager>(
      () => _i90.CaptainsNeedsSupportStateManager(get<_i41.CaptainsService>()));
  gh.factory<_i91.CaptainsScreen>(
      () => _i91.CaptainsScreen(get<_i42.CaptainsStateManager>()));
  gh.factory<_i92.CategoriesScreen>(
      () => _i92.CategoriesScreen(get<_i60.PackageCategoriesStateManager>()));
  gh.factory<_i93.ChatPage>(() => _i93.ChatPage(
      get<_i47.ChatStateManager>(),
      get<_i28.ImageUploadService>(),
      get<_i20.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i94.CompanyFinanceStateManager>(() =>
      _i94.CompanyFinanceStateManager(
          get<_i20.AuthService>(), get<_i49.CompanyService>()));
  gh.factory<_i95.CompanyProfileStateManager>(() =>
      _i95.CompanyProfileStateManager(
          get<_i20.AuthService>(), get<_i49.CompanyService>()));
  gh.factory<_i96.HomeScreen>(
      () => _i96.HomeScreen(get<_i54.HomeStateManager>()));
  gh.factory<_i97.InActiveCaptainsScreen>(() =>
      _i97.InActiveCaptainsScreen(get<_i55.InActiveCaptainsStateManager>()));
  gh.factory<_i98.InActiveSupplierStateManager>(
      () => _i98.InActiveSupplierStateManager(get<_i75.SupplierService>()));
  gh.factory<_i99.InitBranchesStateManager>(
      () => _i99.InitBranchesStateManager(get<_i79.BranchesListService>()));
  gh.factory<_i100.MainScreen>(() => _i100.MainScreen(get<_i96.HomeScreen>()));
  gh.factory<_i101.NoticeScreen>(
      () => _i101.NoticeScreen(get<_i59.NoticeStateManager>()));
  gh.factory<_i102.OrderCaptainNotArrivedStateManager>(() =>
      _i102.OrderCaptainNotArrivedStateManager(get<_i70.StoresService>()));
  gh.factory<_i103.OrderLogsStateManager>(
      () => _i103.OrderLogsStateManager(get<_i70.StoresService>()));
  gh.factory<_i104.OrderStatusStateManager>(() => _i104.OrderStatusStateManager(
      get<_i70.StoresService>(), get<_i20.AuthService>()));
  gh.factory<_i105.OrderTimeLineStateManager>(() =>
      _i105.OrderTimeLineStateManager(
          get<_i70.StoresService>(), get<_i20.AuthService>()));
  gh.factory<_i106.PackagesScreen>(
      () => _i106.PackagesScreen(get<_i61.PackagesStateManager>()));
  gh.factory<_i107.PaymentsToCaptainScreen>(() =>
      _i107.PaymentsToCaptainScreen(get<_i64.PaymentsToCaptainStateManager>()));
  gh.factory<_i108.SettingsModule>(() => _i108.SettingsModule(
      get<_i66.SettingsScreen>(), get<_i17.ChooseLocalScreen>()));
  gh.factory<_i109.StoreBalanceScreen>(
      () => _i109.StoreBalanceScreen(get<_i68.StoreBalanceStateManager>()));
  gh.factory<_i110.StoreProfileStateManager>(
      () => _i110.StoreProfileStateManager(get<_i70.StoresService>()));
  gh.factory<_i111.StoresInActiveStateManager>(() =>
      _i111.StoresInActiveStateManager(get<_i70.StoresService>(),
          get<_i20.AuthService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i112.StoresNeedsSupportStateManager>(
      () => _i112.StoresNeedsSupportStateManager(get<_i70.StoresService>()));
  gh.factory<_i113.StoresScreen>(
      () => _i113.StoresScreen(get<_i71.StoresStateManager>()));
  gh.factory<_i114.SupplierAdsStateManager>(
      () => _i114.SupplierAdsStateManager(get<_i75.SupplierService>()));
  gh.factory<_i115.SupplierCategoriesScreen>(() =>
      _i115.SupplierCategoriesScreen(
          get<_i74.SupplierCategoriesStateManager>()));
  gh.factory<_i116.SupplierNeedsSupportStateManager>(() =>
      _i116.SupplierNeedsSupportStateManager(get<_i75.SupplierService>()));
  gh.factory<_i117.SupplierProfileStateManager>(
      () => _i117.SupplierProfileStateManager(get<_i75.SupplierService>()));
  gh.factory<_i118.SuppliersScreen>(
      () => _i118.SuppliersScreen(get<_i76.SuppliersStateManager>()));
  gh.factory<_i119.UpdateBranchStateManager>(
      () => _i119.UpdateBranchStateManager(get<_i79.BranchesListService>()));
  gh.factory<_i120.BranchesListScreen>(
      () => _i120.BranchesListScreen(get<_i80.BranchesListStateManager>()));
  gh.factory<_i121.CaptainFinanceByCountOrderScreen>(() =>
      _i121.CaptainFinanceByCountOrderScreen(
          get<_i83.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i122.CaptainFinanceByHoursScreen>(() =>
      _i122.CaptainFinanceByHoursScreen(
          get<_i82.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i123.CaptainFinanceByOrderScreen>(() =>
      _i123.CaptainFinanceByOrderScreen(
          get<_i84.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i124.CaptainFinancialDuesDetailsScreen>(() =>
      _i124.CaptainFinancialDuesDetailsScreen(
          get<_i85.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i125.CaptainFinancialDuesScreen>(() =>
      _i125.CaptainFinancialDuesScreen(
          get<_i86.CaptainFinancialDuesStateManager>()));
  gh.factory<_i126.CaptainProfileScreen>(
      () => _i126.CaptainProfileScreen(get<_i89.CaptainProfileStateManager>()));
  gh.factory<_i127.CaptainsNeedsSupportScreen>(() =>
      _i127.CaptainsNeedsSupportScreen(
          get<_i90.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i128.CategoriesModule>(() => _i128.CategoriesModule(
      get<_i92.CategoriesScreen>(), get<_i106.PackagesScreen>()));
  gh.factory<_i129.ChatModule>(
      () => _i129.ChatModule(get<_i93.ChatPage>(), get<_i20.AuthService>()));
  gh.factory<_i130.CompanyFinanceScreen>(
      () => _i130.CompanyFinanceScreen(get<_i94.CompanyFinanceStateManager>()));
  gh.factory<_i131.CompanyProfileScreen>(
      () => _i131.CompanyProfileScreen(get<_i95.CompanyProfileStateManager>()));
  gh.factory<_i132.InActiveSupplierScreen>(() =>
      _i132.InActiveSupplierScreen(get<_i98.InActiveSupplierStateManager>()));
  gh.factory<_i133.InitBranchesScreen>(
      () => _i133.InitBranchesScreen(get<_i99.InitBranchesStateManager>()));
  gh.factory<_i134.MainModule>(
      () => _i134.MainModule(get<_i100.MainScreen>(), get<_i96.HomeScreen>()));
  gh.factory<_i135.NoticeModule>(
      () => _i135.NoticeModule(get<_i101.NoticeScreen>()));
  gh.factory<_i136.OrderCaptainNotArrivedScreen>(() =>
      _i136.OrderCaptainNotArrivedScreen(
          get<_i102.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i137.OrderDetailsScreen>(
      () => _i137.OrderDetailsScreen(get<_i104.OrderStatusStateManager>()));
  gh.factory<_i138.OrderLogsScreen>(
      () => _i138.OrderLogsScreen(get<_i103.OrderLogsStateManager>()));
  gh.factory<_i139.OrderTimeLineScreen>(
      () => _i139.OrderTimeLineScreen(get<_i105.OrderTimeLineStateManager>()));
  gh.factory<_i140.PaymentsModule>(() => _i140.PaymentsModule(
      get<_i121.CaptainFinanceByCountOrderScreen>(),
      get<_i122.CaptainFinanceByHoursScreen>(),
      get<_i123.CaptainFinanceByOrderScreen>(),
      get<_i107.PaymentsToCaptainScreen>()));
  gh.factory<_i141.StoreInfoScreen>(
      () => _i141.StoreInfoScreen(get<_i110.StoreProfileStateManager>()));
  gh.factory<_i142.StoresInActiveScreen>(() =>
      _i142.StoresInActiveScreen(get<_i111.StoresInActiveStateManager>()));
  gh.factory<_i143.StoresNeedsSupportScreen>(() =>
      _i143.StoresNeedsSupportScreen(
          get<_i112.StoresNeedsSupportStateManager>()));
  gh.factory<_i144.SupplierAdsScreen>(
      () => _i144.SupplierAdsScreen(get<_i114.SupplierAdsStateManager>()));
  gh.factory<_i145.SupplierCategoriesModule>(() =>
      _i145.SupplierCategoriesModule(get<_i115.SupplierCategoriesScreen>()));
  gh.factory<_i146.SupplierNeedsSupportScreen>(() =>
      _i146.SupplierNeedsSupportScreen(
          get<_i116.SupplierNeedsSupportStateManager>()));
  gh.factory<_i147.SupplierProfileScreen>(() =>
      _i147.SupplierProfileScreen(get<_i117.SupplierProfileStateManager>()));
  gh.factory<_i148.UpdateBranchScreen>(
      () => _i148.UpdateBranchScreen(get<_i119.UpdateBranchStateManager>()));
  gh.factory<_i149.BranchesModule>(() => _i149.BranchesModule(
      get<_i120.BranchesListScreen>(),
      get<_i148.UpdateBranchScreen>(),
      get<_i133.InitBranchesScreen>()));
  gh.factory<_i150.CaptainsModule>(() => _i150.CaptainsModule(
      get<_i88.CaptainOffersScreen>(),
      get<_i97.InActiveCaptainsScreen>(),
      get<_i91.CaptainsScreen>(),
      get<_i126.CaptainProfileScreen>(),
      get<_i127.CaptainsNeedsSupportScreen>(),
      get<_i81.CaptainAccountBalanceScreen>(),
      get<_i124.CaptainFinancialDuesDetailsScreen>(),
      get<_i125.CaptainFinancialDuesScreen>()));
  gh.factory<_i151.CompanyModule>(() => _i151.CompanyModule(
      get<_i131.CompanyProfileScreen>(), get<_i130.CompanyFinanceScreen>()));
  gh.factory<_i152.StoresModule>(() => _i152.StoresModule(
      get<_i113.StoresScreen>(),
      get<_i141.StoreInfoScreen>(),
      get<_i142.StoresInActiveScreen>(),
      get<_i109.StoreBalanceScreen>(),
      get<_i143.StoresNeedsSupportScreen>(),
      get<_i137.OrderDetailsScreen>(),
      get<_i138.OrderLogsScreen>(),
      get<_i136.OrderCaptainNotArrivedScreen>(),
      get<_i139.OrderTimeLineScreen>()));
  gh.factory<_i153.SupplierModule>(() => _i153.SupplierModule(
      get<_i132.InActiveSupplierScreen>(),
      get<_i118.SuppliersScreen>(),
      get<_i147.SupplierProfileScreen>(),
      get<_i146.SupplierNeedsSupportScreen>(),
      get<_i144.SupplierAdsScreen>()));
  gh.factory<_i154.MyApp>(() => _i154.MyApp(
      get<_i15.AppThemeDataService>(),
      get<_i9.LocalizationService>(),
      get<_i50.FireNotificationService>(),
      get<_i7.LocalNotificationService>(),
      get<_i67.SplashModule>(),
      get<_i78.AuthorizationModule>(),
      get<_i129.ChatModule>(),
      get<_i108.SettingsModule>(),
      get<_i134.MainModule>(),
      get<_i152.StoresModule>(),
      get<_i128.CategoriesModule>(),
      get<_i151.CompanyModule>(),
      get<_i149.BranchesModule>(),
      get<_i135.NoticeModule>(),
      get<_i150.CaptainsModule>(),
      get<_i140.PaymentsModule>(),
      get<_i145.SupplierCategoriesModule>(),
      get<_i153.SupplierModule>()));
  gh.singleton<_i155.GlobalStateManager>(_i155.GlobalStateManager());
  return get;
}

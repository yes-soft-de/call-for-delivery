// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i94;
import '../module_auth/authoriazation_module.dart' as _i59;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i18;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i19;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i24;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i30;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i42;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i46;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i52;
import '../module_branches/branches_module.dart' as _i91;
import '../module_branches/manager/branches_manager.dart' as _i33;
import '../module_branches/repository/branches_repository.dart' as _i20;
import '../module_branches/service/branches_list_service.dart' as _i60;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i61;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i67;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i77;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i78;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i83;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i90;
import '../module_categories/categories_module.dart' as _i79;
import '../module_categories/manager/categories_manager.dart' as _i34;
import '../module_categories/repository/categories_repository.dart' as _i21;
import '../module_categories/service/store_categories_service.dart' as _i35;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i50;
import '../module_categories/state_manager/packages_state_manager.dart' as _i51;
import '../module_categories/ui/screen/categories_screen.dart' as _i62;
import '../module_categories/ui/screen/packages_screen.dart' as _i70;
import '../module_chat/chat_module.dart' as _i80;
import '../module_chat/manager/chat/chat_manager.dart' as _i36;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i22;
import '../module_chat/service/chat/char_service.dart' as _i37;
import '../module_chat/state_manager/chat_state_manager.dart' as _i38;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i63;
import '../module_company/company_module.dart' as _i92;
import '../module_company/manager/company_manager.dart' as _i39;
import '../module_company/repository/company_repository.dart' as _i23;
import '../module_company/service/company_service.dart' as _i40;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i64;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i65;
import '../module_company/ui/screen/company_finance_screen.dart' as _i81;
import '../module_company/ui/screen/company_profile_screen.dart' as _i82;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_main/main_module.dart' as _i84;
import '../module_main/manager/home_manager.dart' as _i43;
import '../module_main/repository/home_repository.dart' as _i25;
import '../module_main/sceen/home_screen.dart' as _i66;
import '../module_main/sceen/main_screen.dart' as _i68;
import '../module_main/service/home_service.dart' as _i44;
import '../module_main/state_manager/home_state_manager.dart' as _i45;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notice/manager/notice_manager.dart' as _i47;
import '../module_notice/notice_module.dart' as _i85;
import '../module_notice/repository/notice_repository.dart' as _i28;
import '../module_notice/service/notice_service.dart' as _i48;
import '../module_notice/state_manager/notice_state_manager.dart' as _i49;
import '../module_notice/ui/screen/notice_screen.dart' as _i69;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i29;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i41;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_settings/settings_module.dart' as _i71;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i53;
import '../module_splash/splash_module.dart' as _i54;
import '../module_splash/ui/screen/splash_screen.dart' as _i31;
import '../module_stores/manager/stores_manager.dart' as _i55;
import '../module_stores/repository/stores_repository.dart' as _i32;
import '../module_stores/service/store_payment.dart' as _i56;
import '../module_stores/service/store_service.dart' as _i57;
import '../module_stores/state_manager/store_balance_state_manager.dart'
    as _i72;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i73;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i74;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i75;
import '../module_stores/state_manager/stores_state_manager.dart' as _i58;
import '../module_stores/stores_module.dart' as _i93;
import '../module_stores/ui/screen/store_balance_screen.dart' as _i86;
import '../module_stores/ui/screen/store_info_screen.dart' as _i87;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i88;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i89;
import '../module_stores/ui/screen/stores_screen.dart' as _i76;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i26;
import '../utils/global/global_state_manager.dart' as _i95;
import '../utils/helpers/firestore_helper.dart' as _i5;
import '../utils/logger/logger.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.ChatHiveHelper>(() => _i4.ChatHiveHelper());
  gh.factory<_i5.FireStoreHelper>(() => _i5.FireStoreHelper());
  gh.factory<_i6.LocalNotificationService>(
      () => _i6.LocalNotificationService());
  gh.factory<_i7.LocalizationPreferencesHelper>(
      () => _i7.LocalizationPreferencesHelper());
  gh.factory<_i8.LocalizationService>(
      () => _i8.LocalizationService(get<_i7.LocalizationPreferencesHelper>()));
  gh.factory<_i9.Logger>(() => _i9.Logger());
  gh.factory<_i10.NotificationsPrefHelper>(
      () => _i10.NotificationsPrefHelper());
  gh.factory<_i11.ThemePreferencesHelper>(() => _i11.ThemePreferencesHelper());
  gh.factory<_i12.UploadRepository>(() => _i12.UploadRepository());
  gh.factory<_i13.ApiClient>(() => _i13.ApiClient(get<_i9.Logger>()));
  gh.factory<_i14.AppThemeDataService>(
      () => _i14.AppThemeDataService(get<_i11.ThemePreferencesHelper>()));
  gh.factory<_i15.AuthRepository>(
      () => _i15.AuthRepository(get<_i13.ApiClient>(), get<_i9.Logger>()));
  gh.factory<_i16.ChooseLocalScreen>(
      () => _i16.ChooseLocalScreen(get<_i8.LocalizationService>()));
  gh.factory<_i17.UploadManager>(
      () => _i17.UploadManager(get<_i12.UploadRepository>()));
  gh.factory<_i18.AuthManager>(
      () => _i18.AuthManager(get<_i15.AuthRepository>()));
  gh.factory<_i19.AuthService>(() =>
      _i19.AuthService(get<_i3.AuthPrefsHelper>(), get<_i18.AuthManager>()));
  gh.factory<_i20.BranchesRepository>(() =>
      _i20.BranchesRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i21.CategoriesRepository>(() => _i21.CategoriesRepository(
      get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i22.ChatRepository>(() =>
      _i22.ChatRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i23.CompanyRepository>(() =>
      _i23.CompanyRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i24.ForgotPassStateManager>(
      () => _i24.ForgotPassStateManager(get<_i19.AuthService>()));
  gh.factory<_i25.HomeRepository>(() =>
      _i25.HomeRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i26.ImageUploadService>(
      () => _i26.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i27.LoginStateManager>(
      () => _i27.LoginStateManager(get<_i19.AuthService>()));
  gh.factory<_i28.NoticeRepository>(() =>
      _i28.NoticeRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i29.NotificationRepo>(() =>
      _i29.NotificationRepo(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i30.RegisterStateManager>(
      () => _i30.RegisterStateManager(get<_i19.AuthService>()));
  gh.factory<_i31.SplashScreen>(
      () => _i31.SplashScreen(get<_i19.AuthService>()));
  gh.factory<_i32.StoresRepository>(() =>
      _i32.StoresRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i33.BranchesManager>(
      () => _i33.BranchesManager(get<_i20.BranchesRepository>()));
  gh.factory<_i34.CategoriesManager>(
      () => _i34.CategoriesManager(get<_i21.CategoriesRepository>()));
  gh.factory<_i35.CategoriesService>(
      () => _i35.CategoriesService(get<_i34.CategoriesManager>()));
  gh.factory<_i36.ChatManager>(
      () => _i36.ChatManager(get<_i22.ChatRepository>()));
  gh.factory<_i37.ChatService>(() => _i37.ChatService(get<_i36.ChatManager>()));
  gh.factory<_i38.ChatStateManager>(
      () => _i38.ChatStateManager(get<_i37.ChatService>()));
  gh.factory<_i39.CompanyManager>(
      () => _i39.CompanyManager(get<_i23.CompanyRepository>()));
  gh.factory<_i40.CompanyService>(
      () => _i40.CompanyService(get<_i39.CompanyManager>()));
  gh.factory<_i41.FireNotificationService>(() => _i41.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i29.NotificationRepo>()));
  gh.factory<_i42.ForgotPassScreen>(
      () => _i42.ForgotPassScreen(get<_i24.ForgotPassStateManager>()));
  gh.factory<_i43.HomeManager>(
      () => _i43.HomeManager(get<_i25.HomeRepository>()));
  gh.factory<_i44.HomeService>(() => _i44.HomeService(get<_i43.HomeManager>()));
  gh.factory<_i45.HomeStateManager>(
      () => _i45.HomeStateManager(get<_i44.HomeService>()));
  gh.factory<_i46.LoginScreen>(
      () => _i46.LoginScreen(get<_i27.LoginStateManager>()));
  gh.factory<_i47.NoticeManager>(
      () => _i47.NoticeManager(get<_i28.NoticeRepository>()));
  gh.factory<_i48.NoticeService>(
      () => _i48.NoticeService(get<_i47.NoticeManager>()));
  gh.factory<_i49.NoticeStateManager>(
      () => _i49.NoticeStateManager(get<_i48.NoticeService>()));
  gh.factory<_i50.PackageCategoriesStateManager>(() =>
      _i50.PackageCategoriesStateManager(
          get<_i35.CategoriesService>(), get<_i26.ImageUploadService>()));
  gh.factory<_i51.PackagesStateManager>(() => _i51.PackagesStateManager(
      get<_i35.CategoriesService>(), get<_i19.AuthService>()));
  gh.factory<_i52.RegisterScreen>(
      () => _i52.RegisterScreen(get<_i30.RegisterStateManager>()));
  gh.factory<_i53.SettingsScreen>(() => _i53.SettingsScreen(
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i41.FireNotificationService>()));
  gh.factory<_i54.SplashModule>(
      () => _i54.SplashModule(get<_i31.SplashScreen>()));
  gh.factory<_i55.StoreManager>(
      () => _i55.StoreManager(get<_i32.StoresRepository>()));
  gh.factory<_i56.StorePaymentsService>(
      () => _i56.StorePaymentsService(get<_i55.StoreManager>()));
  gh.factory<_i57.StoresService>(
      () => _i57.StoresService(get<_i55.StoreManager>()));
  gh.factory<_i58.StoresStateManager>(() => _i58.StoresStateManager(
      get<_i57.StoresService>(),
      get<_i19.AuthService>(),
      get<_i26.ImageUploadService>()));
  gh.factory<_i59.AuthorizationModule>(() => _i59.AuthorizationModule(
      get<_i46.LoginScreen>(),
      get<_i52.RegisterScreen>(),
      get<_i42.ForgotPassScreen>()));
  gh.factory<_i60.BranchesListService>(
      () => _i60.BranchesListService(get<_i33.BranchesManager>()));
  gh.factory<_i61.BranchesListStateManager>(
      () => _i61.BranchesListStateManager(get<_i60.BranchesListService>()));
  gh.factory<_i62.CategoriesScreen>(
      () => _i62.CategoriesScreen(get<_i50.PackageCategoriesStateManager>()));
  gh.factory<_i63.ChatPage>(() => _i63.ChatPage(
      get<_i38.ChatStateManager>(),
      get<_i26.ImageUploadService>(),
      get<_i19.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i64.CompanyFinanceStateManager>(() =>
      _i64.CompanyFinanceStateManager(
          get<_i19.AuthService>(), get<_i40.CompanyService>()));
  gh.factory<_i65.CompanyProfileStateManager>(() =>
      _i65.CompanyProfileStateManager(
          get<_i19.AuthService>(), get<_i40.CompanyService>()));
  gh.factory<_i66.HomeScreen>(
      () => _i66.HomeScreen(get<_i45.HomeStateManager>()));
  gh.factory<_i67.InitBranchesStateManager>(
      () => _i67.InitBranchesStateManager(get<_i60.BranchesListService>()));
  gh.factory<_i68.MainScreen>(() => _i68.MainScreen(get<_i66.HomeScreen>()));
  gh.factory<_i69.NoticeScreen>(
      () => _i69.NoticeScreen(get<_i49.NoticeStateManager>()));
  gh.factory<_i70.PackagesScreen>(
      () => _i70.PackagesScreen(get<_i51.PackagesStateManager>()));
  gh.factory<_i71.SettingsModule>(() => _i71.SettingsModule(
      get<_i53.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i72.StoreBalanceStateManager>(() => _i72.StoreBalanceStateManager(
      get<_i57.StoresService>(), get<_i56.StorePaymentsService>()));
  gh.factory<_i73.StoreProfileStateManager>(
      () => _i73.StoreProfileStateManager(get<_i57.StoresService>()));
  gh.factory<_i74.StoresInActiveStateManager>(() =>
      _i74.StoresInActiveStateManager(get<_i57.StoresService>(),
          get<_i19.AuthService>(), get<_i26.ImageUploadService>()));
  gh.factory<_i75.StoresNeedsSupportStateManager>(
      () => _i75.StoresNeedsSupportStateManager(get<_i57.StoresService>()));
  gh.factory<_i76.StoresScreen>(
      () => _i76.StoresScreen(get<_i58.StoresStateManager>()));
  gh.factory<_i77.UpdateBranchStateManager>(
      () => _i77.UpdateBranchStateManager(get<_i60.BranchesListService>()));
  gh.factory<_i78.BranchesListScreen>(
      () => _i78.BranchesListScreen(get<_i61.BranchesListStateManager>()));
  gh.factory<_i79.CategoriesModule>(() => _i79.CategoriesModule(
      get<_i62.CategoriesScreen>(), get<_i70.PackagesScreen>()));
  gh.factory<_i80.ChatModule>(
      () => _i80.ChatModule(get<_i63.ChatPage>(), get<_i19.AuthService>()));
  gh.factory<_i81.CompanyFinanceScreen>(
      () => _i81.CompanyFinanceScreen(get<_i64.CompanyFinanceStateManager>()));
  gh.factory<_i82.CompanyProfileScreen>(
      () => _i82.CompanyProfileScreen(get<_i65.CompanyProfileStateManager>()));
  gh.factory<_i83.InitBranchesScreen>(
      () => _i83.InitBranchesScreen(get<_i67.InitBranchesStateManager>()));
  gh.factory<_i84.MainModule>(
      () => _i84.MainModule(get<_i68.MainScreen>(), get<_i66.HomeScreen>()));
  gh.factory<_i85.NoticeModule>(
      () => _i85.NoticeModule(get<_i69.NoticeScreen>()));
  gh.factory<_i86.StoreBalanceScreen>(
      () => _i86.StoreBalanceScreen(get<_i72.StoreBalanceStateManager>()));
  gh.factory<_i87.StoreInfoScreen>(
      () => _i87.StoreInfoScreen(get<_i73.StoreProfileStateManager>()));
  gh.factory<_i88.StoresInActiveScreen>(
      () => _i88.StoresInActiveScreen(get<_i74.StoresInActiveStateManager>()));
  gh.factory<_i89.StoresNeedsSupportScreen>(() => _i89.StoresNeedsSupportScreen(
      get<_i75.StoresNeedsSupportStateManager>()));
  gh.factory<_i90.UpdateBranchScreen>(
      () => _i90.UpdateBranchScreen(get<_i77.UpdateBranchStateManager>()));
  gh.factory<_i91.BranchesModule>(() => _i91.BranchesModule(
      get<_i78.BranchesListScreen>(),
      get<_i90.UpdateBranchScreen>(),
      get<_i83.InitBranchesScreen>()));
  gh.factory<_i92.CompanyModule>(() => _i92.CompanyModule(
      get<_i82.CompanyProfileScreen>(), get<_i81.CompanyFinanceScreen>()));
  gh.factory<_i93.StoresModule>(() => _i93.StoresModule(
      get<_i76.StoresScreen>(),
      get<_i87.StoreInfoScreen>(),
      get<_i88.StoresInActiveScreen>(),
      get<_i86.StoreBalanceScreen>(),
      get<_i89.StoresNeedsSupportScreen>()));
  gh.factory<_i94.MyApp>(() => _i94.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i41.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i54.SplashModule>(),
      get<_i59.AuthorizationModule>(),
      get<_i80.ChatModule>(),
      get<_i71.SettingsModule>(),
      get<_i84.MainModule>(),
      get<_i93.StoresModule>(),
      get<_i79.CategoriesModule>(),
      get<_i92.CompanyModule>(),
      get<_i91.BranchesModule>(),
      get<_i85.NoticeModule>()));
  gh.singleton<_i95.GlobalStateManager>(_i95.GlobalStateManager());
  return get;
}

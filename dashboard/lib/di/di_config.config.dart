// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i86;
import '../module_auth/authoriazation_module.dart' as _i55;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i18;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i19;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i24;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i29;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i41;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i45;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i48;
import '../module_branches/branches_module.dart' as _i84;
import '../module_branches/manager/branches_manager.dart' as _i32;
import '../module_branches/repository/branches_repository.dart' as _i20;
import '../module_branches/service/branches_list_service.dart' as _i56;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i57;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i63;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i71;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i72;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i77;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i83;
import '../module_categories/categories_module.dart' as _i73;
import '../module_categories/manager/categories_manager.dart' as _i33;
import '../module_categories/repository/categories_repository.dart' as _i21;
import '../module_categories/service/store_categories_service.dart' as _i34;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i46;
import '../module_categories/state_manager/packages_state_manager.dart' as _i47;
import '../module_categories/ui/screen/categories_screen.dart' as _i58;
import '../module_categories/ui/screen/packages_screen.dart' as _i65;
import '../module_chat/chat_module.dart' as _i74;
import '../module_chat/manager/chat/chat_manager.dart' as _i35;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i22;
import '../module_chat/service/chat/char_service.dart' as _i36;
import '../module_chat/state_manager/chat_state_manager.dart' as _i37;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i59;
import '../module_company/company_module.dart' as _i85;
import '../module_company/manager/company_manager.dart' as _i38;
import '../module_company/repository/company_repository.dart' as _i23;
import '../module_company/service/company_service.dart' as _i39;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i60;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i61;
import '../module_company/ui/screen/company_finance_screen.dart' as _i75;
import '../module_company/ui/screen/company_profile_screen.dart' as _i76;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_main/main_module.dart' as _i78;
import '../module_main/manager/home_manager.dart' as _i42;
import '../module_main/repository/home_repository.dart' as _i25;
import '../module_main/sceen/home_screen.dart' as _i62;
import '../module_main/sceen/main_screen.dart' as _i64;
import '../module_main/service/home_service.dart' as _i43;
import '../module_main/state_manager/home_state_manager.dart' as _i44;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i28;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i40;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_settings/settings_module.dart' as _i66;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i49;
import '../module_splash/splash_module.dart' as _i50;
import '../module_splash/ui/screen/splash_screen.dart' as _i30;
import '../module_stores/manager/stores_manager.dart' as _i51;
import '../module_stores/repository/stores_repository.dart' as _i31;
import '../module_stores/service/store_payment.dart' as _i52;
import '../module_stores/service/store_service.dart' as _i53;
import '../module_stores/state_manager/store_balance_state_manager.dart'
    as _i67;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i68;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i69;
import '../module_stores/state_manager/stores_state_manager.dart' as _i54;
import '../module_stores/stores_module.dart' as _i82;
import '../module_stores/ui/screen/store_balance_screen.dart' as _i79;
import '../module_stores/ui/screen/store_info_screen.dart' as _i80;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i81;
import '../module_stores/ui/screen/stores_screen.dart' as _i70;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i26;
import '../utils/global/global_state_manager.dart' as _i87;
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
  gh.factory<_i28.NotificationRepo>(() =>
      _i28.NotificationRepo(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i29.RegisterStateManager>(
      () => _i29.RegisterStateManager(get<_i19.AuthService>()));
  gh.factory<_i30.SplashScreen>(
      () => _i30.SplashScreen(get<_i19.AuthService>()));
  gh.factory<_i31.StoresRepository>(() =>
      _i31.StoresRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i32.BranchesManager>(
      () => _i32.BranchesManager(get<_i20.BranchesRepository>()));
  gh.factory<_i33.CategoriesManager>(
      () => _i33.CategoriesManager(get<_i21.CategoriesRepository>()));
  gh.factory<_i34.CategoriesService>(
      () => _i34.CategoriesService(get<_i33.CategoriesManager>()));
  gh.factory<_i35.ChatManager>(
      () => _i35.ChatManager(get<_i22.ChatRepository>()));
  gh.factory<_i36.ChatService>(() => _i36.ChatService(get<_i35.ChatManager>()));
  gh.factory<_i37.ChatStateManager>(
      () => _i37.ChatStateManager(get<_i36.ChatService>()));
  gh.factory<_i38.CompanyManager>(
      () => _i38.CompanyManager(get<_i23.CompanyRepository>()));
  gh.factory<_i39.CompanyService>(
      () => _i39.CompanyService(get<_i38.CompanyManager>()));
  gh.factory<_i40.FireNotificationService>(() => _i40.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i28.NotificationRepo>()));
  gh.factory<_i41.ForgotPassScreen>(
      () => _i41.ForgotPassScreen(get<_i24.ForgotPassStateManager>()));
  gh.factory<_i42.HomeManager>(
      () => _i42.HomeManager(get<_i25.HomeRepository>()));
  gh.factory<_i43.HomeService>(() => _i43.HomeService(get<_i42.HomeManager>()));
  gh.factory<_i44.HomeStateManager>(
      () => _i44.HomeStateManager(get<_i43.HomeService>()));
  gh.factory<_i45.LoginScreen>(
      () => _i45.LoginScreen(get<_i27.LoginStateManager>()));
  gh.factory<_i46.PackageCategoriesStateManager>(() =>
      _i46.PackageCategoriesStateManager(
          get<_i34.CategoriesService>(), get<_i26.ImageUploadService>()));
  gh.factory<_i47.PackagesStateManager>(() => _i47.PackagesStateManager(
      get<_i34.CategoriesService>(), get<_i19.AuthService>()));
  gh.factory<_i48.RegisterScreen>(
      () => _i48.RegisterScreen(get<_i29.RegisterStateManager>()));
  gh.factory<_i49.SettingsScreen>(() => _i49.SettingsScreen(
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i40.FireNotificationService>()));
  gh.factory<_i50.SplashModule>(
      () => _i50.SplashModule(get<_i30.SplashScreen>()));
  gh.factory<_i51.StoreManager>(
      () => _i51.StoreManager(get<_i31.StoresRepository>()));
  gh.factory<_i52.StorePaymentsService>(
      () => _i52.StorePaymentsService(get<_i51.StoreManager>()));
  gh.factory<_i53.StoresService>(
      () => _i53.StoresService(get<_i51.StoreManager>()));
  gh.factory<_i54.StoresStateManager>(() => _i54.StoresStateManager(
      get<_i53.StoresService>(),
      get<_i19.AuthService>(),
      get<_i26.ImageUploadService>()));
  gh.factory<_i55.AuthorizationModule>(() => _i55.AuthorizationModule(
      get<_i45.LoginScreen>(),
      get<_i48.RegisterScreen>(),
      get<_i41.ForgotPassScreen>()));
  gh.factory<_i56.BranchesListService>(
      () => _i56.BranchesListService(get<_i32.BranchesManager>()));
  gh.factory<_i57.BranchesListStateManager>(
      () => _i57.BranchesListStateManager(get<_i56.BranchesListService>()));
  gh.factory<_i58.CategoriesScreen>(
      () => _i58.CategoriesScreen(get<_i46.PackageCategoriesStateManager>()));
  gh.factory<_i59.ChatPage>(() => _i59.ChatPage(
      get<_i37.ChatStateManager>(),
      get<_i26.ImageUploadService>(),
      get<_i19.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i60.CompanyFinanceStateManager>(() =>
      _i60.CompanyFinanceStateManager(
          get<_i19.AuthService>(), get<_i39.CompanyService>()));
  gh.factory<_i61.CompanyProfileStateManager>(() =>
      _i61.CompanyProfileStateManager(
          get<_i19.AuthService>(), get<_i39.CompanyService>()));
  gh.factory<_i62.HomeScreen>(
      () => _i62.HomeScreen(get<_i44.HomeStateManager>()));
  gh.factory<_i63.InitBranchesStateManager>(
      () => _i63.InitBranchesStateManager(get<_i56.BranchesListService>()));
  gh.factory<_i64.MainScreen>(() => _i64.MainScreen(get<_i62.HomeScreen>()));
  gh.factory<_i65.PackagesScreen>(
      () => _i65.PackagesScreen(get<_i47.PackagesStateManager>()));
  gh.factory<_i66.SettingsModule>(() => _i66.SettingsModule(
      get<_i49.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i67.StoreBalanceStateManager>(() => _i67.StoreBalanceStateManager(
      get<_i53.StoresService>(), get<_i52.StorePaymentsService>()));
  gh.factory<_i68.StoreProfileStateManager>(
      () => _i68.StoreProfileStateManager(get<_i53.StoresService>()));
  gh.factory<_i69.StoresInActiveStateManager>(() =>
      _i69.StoresInActiveStateManager(get<_i53.StoresService>(),
          get<_i19.AuthService>(), get<_i26.ImageUploadService>()));
  gh.factory<_i70.StoresScreen>(
      () => _i70.StoresScreen(get<_i54.StoresStateManager>()));
  gh.factory<_i71.UpdateBranchStateManager>(
      () => _i71.UpdateBranchStateManager(get<_i56.BranchesListService>()));
  gh.factory<_i72.BranchesListScreen>(
      () => _i72.BranchesListScreen(get<_i57.BranchesListStateManager>()));
  gh.factory<_i73.CategoriesModule>(() => _i73.CategoriesModule(
      get<_i58.CategoriesScreen>(), get<_i65.PackagesScreen>()));
  gh.factory<_i74.ChatModule>(
      () => _i74.ChatModule(get<_i59.ChatPage>(), get<_i19.AuthService>()));
  gh.factory<_i75.CompanyFinanceScreen>(
      () => _i75.CompanyFinanceScreen(get<_i60.CompanyFinanceStateManager>()));
  gh.factory<_i76.CompanyProfileScreen>(
      () => _i76.CompanyProfileScreen(get<_i61.CompanyProfileStateManager>()));
  gh.factory<_i77.InitBranchesScreen>(
      () => _i77.InitBranchesScreen(get<_i63.InitBranchesStateManager>()));
  gh.factory<_i78.MainModule>(
      () => _i78.MainModule(get<_i64.MainScreen>(), get<_i62.HomeScreen>()));
  gh.factory<_i79.StoreBalanceScreen>(
      () => _i79.StoreBalanceScreen(get<_i67.StoreBalanceStateManager>()));
  gh.factory<_i80.StoreInfoScreen>(
      () => _i80.StoreInfoScreen(get<_i68.StoreProfileStateManager>()));
  gh.factory<_i81.StoresInActiveScreen>(
      () => _i81.StoresInActiveScreen(get<_i69.StoresInActiveStateManager>()));
  gh.factory<_i82.StoresModule>(() => _i82.StoresModule(
      get<_i70.StoresScreen>(),
      get<_i80.StoreInfoScreen>(),
      get<_i81.StoresInActiveScreen>(),
      get<_i79.StoreBalanceScreen>()));
  gh.factory<_i83.UpdateBranchScreen>(
      () => _i83.UpdateBranchScreen(get<_i71.UpdateBranchStateManager>()));
  gh.factory<_i84.BranchesModule>(() => _i84.BranchesModule(
      get<_i72.BranchesListScreen>(),
      get<_i83.UpdateBranchScreen>(),
      get<_i77.InitBranchesScreen>()));
  gh.factory<_i85.CompanyModule>(() => _i85.CompanyModule(
      get<_i76.CompanyProfileScreen>(), get<_i75.CompanyFinanceScreen>()));
  gh.factory<_i86.MyApp>(() => _i86.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i40.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i50.SplashModule>(),
      get<_i55.AuthorizationModule>(),
      get<_i74.ChatModule>(),
      get<_i66.SettingsModule>(),
      get<_i78.MainModule>(),
      get<_i82.StoresModule>(),
      get<_i73.CategoriesModule>(),
      get<_i85.CompanyModule>(),
      get<_i84.BranchesModule>()));
  gh.singleton<_i87.GlobalStateManager>(_i87.GlobalStateManager());
  return get;
}

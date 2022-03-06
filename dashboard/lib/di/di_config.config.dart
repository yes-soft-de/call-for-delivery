// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i68;
import '../module_auth/authoriazation_module.dart' as _i50;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i18;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i19;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i22;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i25;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i27;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i36;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i40;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i43;
import '../module_categories/categories_module.dart' as _i61;
import '../module_categories/manager/categories_manager.dart' as _i30;
import '../module_categories/repository/categories_repository.dart' as _i20;
import '../module_categories/service/store_categories_service.dart' as _i31;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i41;
import '../module_categories/state_manager/packages_state_manager.dart' as _i42;
import '../module_categories/ui/screen/categories_screen.dart' as _i51;
import '../module_categories/ui/screen/packages_screen.dart' as _i55;
import '../module_chat/chat_module.dart' as _i62;
import '../module_chat/manager/chat/chat_manager.dart' as _i32;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i21;
import '../module_chat/service/chat/char_service.dart' as _i33;
import '../module_chat/state_manager/chat_state_manager.dart' as _i34;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i52;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_main/main_module.dart' as _i63;
import '../module_main/manager/home_manager.dart' as _i37;
import '../module_main/repository/home_repository.dart' as _i23;
import '../module_main/sceen/home_screen.dart' as _i53;
import '../module_main/sceen/main_screen.dart' as _i54;
import '../module_main/service/home_service.dart' as _i38;
import '../module_main/state_manager/home_state_manager.dart' as _i39;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i26;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i35;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_settings/settings_module.dart' as _i56;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i44;
import '../module_splash/splash_module.dart' as _i45;
import '../module_splash/ui/screen/splash_screen.dart' as _i28;
import '../module_stores/manager/stores_manager.dart' as _i46;
import '../module_stores/repository/stores_repository.dart' as _i29;
import '../module_stores/service/store_payment.dart' as _i47;
import '../module_stores/service/store_service.dart' as _i48;
import '../module_stores/state_manager/store_balance_state_manager.dart'
    as _i57;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i58;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i59;
import '../module_stores/state_manager/stores_state_manager.dart' as _i49;
import '../module_stores/stores_module.dart' as _i67;
import '../module_stores/ui/screen/store_balance_screen.dart' as _i64;
import '../module_stores/ui/screen/store_info_screen.dart' as _i65;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i66;
import '../module_stores/ui/screen/stores_screen.dart' as _i60;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i24;
import '../utils/global/global_state_manager.dart' as _i69;
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
  gh.factory<_i20.CategoriesRepository>(() => _i20.CategoriesRepository(
      get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i21.ChatRepository>(() =>
      _i21.ChatRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i22.ForgotPassStateManager>(
      () => _i22.ForgotPassStateManager(get<_i19.AuthService>()));
  gh.factory<_i23.HomeRepository>(() =>
      _i23.HomeRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i24.ImageUploadService>(
      () => _i24.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i25.LoginStateManager>(
      () => _i25.LoginStateManager(get<_i19.AuthService>()));
  gh.factory<_i26.NotificationRepo>(() =>
      _i26.NotificationRepo(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i27.RegisterStateManager>(
      () => _i27.RegisterStateManager(get<_i19.AuthService>()));
  gh.factory<_i28.SplashScreen>(
      () => _i28.SplashScreen(get<_i19.AuthService>()));
  gh.factory<_i29.StoresRepository>(() =>
      _i29.StoresRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i30.CategoriesManager>(
      () => _i30.CategoriesManager(get<_i20.CategoriesRepository>()));
  gh.factory<_i31.CategoriesService>(
      () => _i31.CategoriesService(get<_i30.CategoriesManager>()));
  gh.factory<_i32.ChatManager>(
      () => _i32.ChatManager(get<_i21.ChatRepository>()));
  gh.factory<_i33.ChatService>(() => _i33.ChatService(get<_i32.ChatManager>()));
  gh.factory<_i34.ChatStateManager>(
      () => _i34.ChatStateManager(get<_i33.ChatService>()));
  gh.factory<_i35.FireNotificationService>(() => _i35.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i26.NotificationRepo>()));
  gh.factory<_i36.ForgotPassScreen>(
      () => _i36.ForgotPassScreen(get<_i22.ForgotPassStateManager>()));
  gh.factory<_i37.HomeManager>(
      () => _i37.HomeManager(get<_i23.HomeRepository>()));
  gh.factory<_i38.HomeService>(() => _i38.HomeService(get<_i37.HomeManager>()));
  gh.factory<_i39.HomeStateManager>(
      () => _i39.HomeStateManager(get<_i38.HomeService>()));
  gh.factory<_i40.LoginScreen>(
      () => _i40.LoginScreen(get<_i25.LoginStateManager>()));
  gh.factory<_i41.PackageCategoriesStateManager>(() =>
      _i41.PackageCategoriesStateManager(
          get<_i31.CategoriesService>(), get<_i24.ImageUploadService>()));
  gh.factory<_i42.PackagesStateManager>(() => _i42.PackagesStateManager(
      get<_i31.CategoriesService>(), get<_i19.AuthService>()));
  gh.factory<_i43.RegisterScreen>(
      () => _i43.RegisterScreen(get<_i27.RegisterStateManager>()));
  gh.factory<_i44.SettingsScreen>(() => _i44.SettingsScreen(
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i35.FireNotificationService>()));
  gh.factory<_i45.SplashModule>(
      () => _i45.SplashModule(get<_i28.SplashScreen>()));
  gh.factory<_i46.StoreManager>(
      () => _i46.StoreManager(get<_i29.StoresRepository>()));
  gh.factory<_i47.StorePaymentsService>(
      () => _i47.StorePaymentsService(get<_i46.StoreManager>()));
  gh.factory<_i48.StoresService>(
      () => _i48.StoresService(get<_i46.StoreManager>()));
  gh.factory<_i49.StoresStateManager>(() => _i49.StoresStateManager(
      get<_i48.StoresService>(),
      get<_i19.AuthService>(),
      get<_i24.ImageUploadService>()));
  gh.factory<_i50.AuthorizationModule>(() => _i50.AuthorizationModule(
      get<_i40.LoginScreen>(),
      get<_i43.RegisterScreen>(),
      get<_i36.ForgotPassScreen>()));
  gh.factory<_i51.CategoriesScreen>(
      () => _i51.CategoriesScreen(get<_i41.PackageCategoriesStateManager>()));
  gh.factory<_i52.ChatPage>(() => _i52.ChatPage(
      get<_i34.ChatStateManager>(),
      get<_i24.ImageUploadService>(),
      get<_i19.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i53.HomeScreen>(
      () => _i53.HomeScreen(get<_i39.HomeStateManager>()));
  gh.factory<_i54.MainScreen>(() => _i54.MainScreen(get<_i53.HomeScreen>()));
  gh.factory<_i55.PackagesScreen>(
      () => _i55.PackagesScreen(get<_i42.PackagesStateManager>()));
  gh.factory<_i56.SettingsModule>(() => _i56.SettingsModule(
      get<_i44.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i57.StoreBalanceStateManager>(() => _i57.StoreBalanceStateManager(
      get<_i48.StoresService>(), get<_i47.StorePaymentsService>()));
  gh.factory<_i58.StoreProfileStateManager>(
      () => _i58.StoreProfileStateManager(get<_i48.StoresService>()));
  gh.factory<_i59.StoresInActiveStateManager>(() =>
      _i59.StoresInActiveStateManager(get<_i48.StoresService>(),
          get<_i19.AuthService>(), get<_i24.ImageUploadService>()));
  gh.factory<_i60.StoresScreen>(
      () => _i60.StoresScreen(get<_i49.StoresStateManager>()));
  gh.factory<_i61.CategoriesModule>(() => _i61.CategoriesModule(
      get<_i51.CategoriesScreen>(), get<_i55.PackagesScreen>()));
  gh.factory<_i62.ChatModule>(
      () => _i62.ChatModule(get<_i52.ChatPage>(), get<_i19.AuthService>()));
  gh.factory<_i63.MainModule>(
      () => _i63.MainModule(get<_i54.MainScreen>(), get<_i53.HomeScreen>()));
  gh.factory<_i64.StoreBalanceScreen>(
      () => _i64.StoreBalanceScreen(get<_i57.StoreBalanceStateManager>()));
  gh.factory<_i65.StoreInfoScreen>(
      () => _i65.StoreInfoScreen(get<_i58.StoreProfileStateManager>()));
  gh.factory<_i66.StoresInActiveScreen>(
      () => _i66.StoresInActiveScreen(get<_i59.StoresInActiveStateManager>()));
  gh.factory<_i67.StoresModule>(() => _i67.StoresModule(
      get<_i60.StoresScreen>(),
      get<_i65.StoreInfoScreen>(),
      get<_i66.StoresInActiveScreen>(),
      get<_i64.StoreBalanceScreen>()));
  gh.factory<_i68.MyApp>(() => _i68.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i35.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i45.SplashModule>(),
      get<_i50.AuthorizationModule>(),
      get<_i62.ChatModule>(),
      get<_i56.SettingsModule>(),
      get<_i63.MainModule>(),
      get<_i67.StoresModule>(),
      get<_i61.CategoriesModule>()));
  gh.singleton<_i69.GlobalStateManager>(_i69.GlobalStateManager());
  return get;
}

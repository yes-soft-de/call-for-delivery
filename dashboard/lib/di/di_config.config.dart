// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i60;
import '../module_auth/authoriazation_module.dart' as _i45;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i18;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i19;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i21;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i24;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i26;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i33;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i37;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i38;
import '../module_chat/chat_module.dart' as _i54;
import '../module_chat/manager/chat/chat_manager.dart' as _i29;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i20;
import '../module_chat/service/chat/char_service.dart' as _i30;
import '../module_chat/state_manager/chat_state_manager.dart' as _i31;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i46;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_main/main_module.dart' as _i55;
import '../module_main/manager/home_manager.dart' as _i34;
import '../module_main/repository/home_repository.dart' as _i22;
import '../module_main/sceen/home_screen.dart' as _i47;
import '../module_main/sceen/main_screen.dart' as _i48;
import '../module_main/service/home_service.dart' as _i35;
import '../module_main/state_manager/home_state_manager.dart' as _i36;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i25;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i32;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_settings/settings_module.dart' as _i49;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i39;
import '../module_splash/splash_module.dart' as _i40;
import '../module_splash/ui/screen/splash_screen.dart' as _i27;
import '../module_stores/manager/stores_manager.dart' as _i41;
import '../module_stores/repository/stores_repository.dart' as _i28;
import '../module_stores/service/store_payment.dart' as _i42;
import '../module_stores/service/store_service.dart' as _i43;
import '../module_stores/state_manager/store_balance_state_manager.dart'
    as _i50;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i51;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i52;
import '../module_stores/state_manager/stores_state_manager.dart' as _i44;
import '../module_stores/stores_module.dart' as _i59;
import '../module_stores/ui/screen/store_balance_screen.dart' as _i56;
import '../module_stores/ui/screen/store_info_screen.dart' as _i57;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i58;
import '../module_stores/ui/screen/stores_screen.dart' as _i53;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i23;
import '../utils/global/global_state_manager.dart' as _i61;
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
  gh.factory<_i20.ChatRepository>(() =>
      _i20.ChatRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i21.ForgotPassStateManager>(
      () => _i21.ForgotPassStateManager(get<_i19.AuthService>()));
  gh.factory<_i22.HomeRepository>(() =>
      _i22.HomeRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i23.ImageUploadService>(
      () => _i23.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i24.LoginStateManager>(
      () => _i24.LoginStateManager(get<_i19.AuthService>()));
  gh.factory<_i25.NotificationRepo>(() =>
      _i25.NotificationRepo(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i26.RegisterStateManager>(
      () => _i26.RegisterStateManager(get<_i19.AuthService>()));
  gh.factory<_i27.SplashScreen>(
      () => _i27.SplashScreen(get<_i19.AuthService>()));
  gh.factory<_i28.StoresRepository>(() =>
      _i28.StoresRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i29.ChatManager>(
      () => _i29.ChatManager(get<_i20.ChatRepository>()));
  gh.factory<_i30.ChatService>(() => _i30.ChatService(get<_i29.ChatManager>()));
  gh.factory<_i31.ChatStateManager>(
      () => _i31.ChatStateManager(get<_i30.ChatService>()));
  gh.factory<_i32.FireNotificationService>(() => _i32.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i25.NotificationRepo>()));
  gh.factory<_i33.ForgotPassScreen>(
      () => _i33.ForgotPassScreen(get<_i21.ForgotPassStateManager>()));
  gh.factory<_i34.HomeManager>(
      () => _i34.HomeManager(get<_i22.HomeRepository>()));
  gh.factory<_i35.HomeService>(() => _i35.HomeService(get<_i34.HomeManager>()));
  gh.factory<_i36.HomeStateManager>(
      () => _i36.HomeStateManager(get<_i35.HomeService>()));
  gh.factory<_i37.LoginScreen>(
      () => _i37.LoginScreen(get<_i24.LoginStateManager>()));
  gh.factory<_i38.RegisterScreen>(
      () => _i38.RegisterScreen(get<_i26.RegisterStateManager>()));
  gh.factory<_i39.SettingsScreen>(() => _i39.SettingsScreen(
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i32.FireNotificationService>()));
  gh.factory<_i40.SplashModule>(
      () => _i40.SplashModule(get<_i27.SplashScreen>()));
  gh.factory<_i41.StoreManager>(
      () => _i41.StoreManager(get<_i28.StoresRepository>()));
  gh.factory<_i42.StorePaymentsService>(
      () => _i42.StorePaymentsService(get<_i41.StoreManager>()));
  gh.factory<_i43.StoresService>(
      () => _i43.StoresService(get<_i41.StoreManager>()));
  gh.factory<_i44.StoresStateManager>(() => _i44.StoresStateManager(
      get<_i43.StoresService>(),
      get<_i19.AuthService>(),
      get<_i23.ImageUploadService>()));
  gh.factory<_i45.AuthorizationModule>(() => _i45.AuthorizationModule(
      get<_i37.LoginScreen>(),
      get<_i38.RegisterScreen>(),
      get<_i33.ForgotPassScreen>()));
  gh.factory<_i46.ChatPage>(() => _i46.ChatPage(
      get<_i31.ChatStateManager>(),
      get<_i23.ImageUploadService>(),
      get<_i19.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i47.HomeScreen>(
      () => _i47.HomeScreen(get<_i36.HomeStateManager>()));
  gh.factory<_i48.MainScreen>(() => _i48.MainScreen(get<_i47.HomeScreen>()));
  gh.factory<_i49.SettingsModule>(() => _i49.SettingsModule(
      get<_i39.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i50.StoreBalanceStateManager>(() => _i50.StoreBalanceStateManager(
      get<_i43.StoresService>(), get<_i42.StorePaymentsService>()));
  gh.factory<_i51.StoreProfileStateManager>(
      () => _i51.StoreProfileStateManager(get<_i43.StoresService>()));
  gh.factory<_i52.StoresInActiveStateManager>(() =>
      _i52.StoresInActiveStateManager(get<_i43.StoresService>(),
          get<_i19.AuthService>(), get<_i23.ImageUploadService>()));
  gh.factory<_i53.StoresScreen>(
      () => _i53.StoresScreen(get<_i44.StoresStateManager>()));
  gh.factory<_i54.ChatModule>(
      () => _i54.ChatModule(get<_i46.ChatPage>(), get<_i19.AuthService>()));
  gh.factory<_i55.MainModule>(
      () => _i55.MainModule(get<_i48.MainScreen>(), get<_i47.HomeScreen>()));
  gh.factory<_i56.StoreBalanceScreen>(
      () => _i56.StoreBalanceScreen(get<_i50.StoreBalanceStateManager>()));
  gh.factory<_i57.StoreInfoScreen>(
      () => _i57.StoreInfoScreen(get<_i51.StoreProfileStateManager>()));
  gh.factory<_i58.StoresInActiveScreen>(
      () => _i58.StoresInActiveScreen(get<_i52.StoresInActiveStateManager>()));
  gh.factory<_i59.StoresModule>(() => _i59.StoresModule(
      get<_i53.StoresScreen>(),
      get<_i57.StoreInfoScreen>(),
      get<_i58.StoresInActiveScreen>(),
      get<_i56.StoreBalanceScreen>()));
  gh.factory<_i60.MyApp>(() => _i60.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i32.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i40.SplashModule>(),
      get<_i45.AuthorizationModule>(),
      get<_i54.ChatModule>(),
      get<_i49.SettingsModule>(),
      get<_i55.MainModule>(),
      get<_i59.StoresModule>()));
  gh.singleton<_i61.GlobalStateManager>(_i61.GlobalStateManager());
  return get;
}

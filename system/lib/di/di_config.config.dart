// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i48;
import '../module_auth/authoriazation_module.dart' as _i42;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i20;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i16;
import '../module_auth/service/auth_service/auth_service.dart' as _i21;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i24;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i28;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i37;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i38;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i39;
import '../module_chat/chat_module.dart' as _i46;
import '../module_chat/manager/chat/chat_manager.dart' as _i30;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i22;
import '../module_chat/service/chat/char_service.dart' as _i31;
import '../module_chat/state_manager/chat_state_manager.dart' as _i32;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i43;
import '../module_check_api/check_api_module.dart' as _i47;
import '../module_check_api/manager/check_api_manager.dart' as _i33;
import '../module_check_api/repository/check_api_repository.dart' as _i23;
import '../module_check_api/service/check_api_service.dart' as _i34;
import '../module_check_api/state_manager/check_api_state_manager.dart' as _i35;
import '../module_check_api/ui/screen/check_api_screen.dart' as _i44;
import '../module_home/home_module.dart' as _i18;
import '../module_home/ui/home_screen.dart' as _i6;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i8;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i9;
import '../module_network/http_client/http_client.dart' as _i14;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i27;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i36;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i7;
import '../module_settings/settings_module.dart' as _i45;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i17;
import '../module_settings/ui/settings_page/settings_page.dart' as _i40;
import '../module_splash/splash_module.dart' as _i41;
import '../module_splash/ui/screen/splash_screen.dart' as _i29;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i12;
import '../module_theme/service/theme_service/theme_service.dart' as _i15;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i19;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i13;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i25;
import '../utils/global/global_state_manager.dart' as _i49;
import '../utils/helpers/firestore_helper.dart' as _i5;
import '../utils/logger/logger.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.ChatHiveHelper>(() => _i4.ChatHiveHelper());
  gh.factory<_i5.FireStoreHelper>(() => _i5.FireStoreHelper());
  gh.factory<_i6.HomeScreen>(() => _i6.HomeScreen());
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
  gh.factory<_i18.HomeModule>(() => _i18.HomeModule(get<_i6.HomeScreen>()));
  gh.factory<_i19.UploadManager>(
      () => _i19.UploadManager(get<_i13.UploadRepository>()));
  gh.factory<_i20.AuthManager>(
      () => _i20.AuthManager(get<_i16.AuthRepository>()));
  gh.factory<_i21.AuthService>(() =>
      _i21.AuthService(get<_i3.AuthPrefsHelper>(), get<_i20.AuthManager>()));
  gh.factory<_i22.ChatRepository>(() =>
      _i22.ChatRepository(get<_i14.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i23.CheckApiRepository>(() =>
      _i23.CheckApiRepository(get<_i14.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i24.ForgotPassStateManager>(
      () => _i24.ForgotPassStateManager(get<_i21.AuthService>()));
  gh.factory<_i25.ImageUploadService>(
      () => _i25.ImageUploadService(get<_i19.UploadManager>()));
  gh.factory<_i26.LoginStateManager>(
      () => _i26.LoginStateManager(get<_i21.AuthService>()));
  gh.factory<_i27.NotificationRepo>(() =>
      _i27.NotificationRepo(get<_i14.ApiClient>(), get<_i21.AuthService>()));
  gh.factory<_i28.RegisterStateManager>(
      () => _i28.RegisterStateManager(get<_i21.AuthService>()));
  gh.factory<_i29.SplashScreen>(
      () => _i29.SplashScreen(get<_i21.AuthService>()));
  gh.factory<_i30.ChatManager>(
      () => _i30.ChatManager(get<_i22.ChatRepository>()));
  gh.factory<_i31.ChatService>(() => _i31.ChatService(get<_i30.ChatManager>()));
  gh.factory<_i32.ChatStateManager>(
      () => _i32.ChatStateManager(get<_i31.ChatService>()));
  gh.factory<_i33.CheckApiManager>(
      () => _i33.CheckApiManager(get<_i23.CheckApiRepository>()));
  gh.factory<_i34.CheckApiService>(
      () => _i34.CheckApiService(get<_i33.CheckApiManager>()));
  gh.factory<_i35.CheckApiStateManager>(
      () => _i35.CheckApiStateManager(get<_i34.CheckApiService>()));
  gh.factory<_i36.FireNotificationService>(() => _i36.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i27.NotificationRepo>()));
  gh.factory<_i37.ForgotPassScreen>(
      () => _i37.ForgotPassScreen(get<_i24.ForgotPassStateManager>()));
  gh.factory<_i38.LoginScreen>(
      () => _i38.LoginScreen(get<_i26.LoginStateManager>()));
  gh.factory<_i39.RegisterScreen>(
      () => _i39.RegisterScreen(get<_i28.RegisterStateManager>()));
  gh.factory<_i40.SettingsScreen>(() => _i40.SettingsScreen(
      get<_i21.AuthService>(),
      get<_i9.LocalizationService>(),
      get<_i15.AppThemeDataService>(),
      get<_i36.FireNotificationService>()));
  gh.factory<_i41.SplashModule>(
      () => _i41.SplashModule(get<_i29.SplashScreen>()));
  gh.factory<_i42.AuthorizationModule>(() => _i42.AuthorizationModule(
      get<_i38.LoginScreen>(),
      get<_i39.RegisterScreen>(),
      get<_i37.ForgotPassScreen>()));
  gh.factory<_i43.ChatPage>(() => _i43.ChatPage(
      get<_i32.ChatStateManager>(),
      get<_i25.ImageUploadService>(),
      get<_i21.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i44.CheckApiScreen>(
      () => _i44.CheckApiScreen(get<_i35.CheckApiStateManager>()));
  gh.factory<_i45.SettingsModule>(() => _i45.SettingsModule(
      get<_i40.SettingsScreen>(), get<_i17.ChooseLocalScreen>()));
  gh.factory<_i46.ChatModule>(
      () => _i46.ChatModule(get<_i43.ChatPage>(), get<_i21.AuthService>()));
  gh.factory<_i47.CheckApiModule>(
      () => _i47.CheckApiModule(get<_i44.CheckApiScreen>()));
  gh.factory<_i48.MyApp>(() => _i48.MyApp(
      get<_i15.AppThemeDataService>(),
      get<_i9.LocalizationService>(),
      get<_i36.FireNotificationService>(),
      get<_i7.LocalNotificationService>(),
      get<_i41.SplashModule>(),
      get<_i42.AuthorizationModule>(),
      get<_i46.ChatModule>(),
      get<_i45.SettingsModule>(),
      get<_i47.CheckApiModule>(),
      get<_i18.HomeModule>()));
  gh.singleton<_i49.GlobalStateManager>(_i49.GlobalStateManager());
  return get;
}

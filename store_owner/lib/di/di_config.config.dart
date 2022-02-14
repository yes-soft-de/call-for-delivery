// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i45;
import '../module_about/about_module.dart' as _i43;
import '../module_about/manager/about_manager.dart' as _i28;
import '../module_about/repository/about_repository.dart' as _i18;
import '../module_about/service/about_service/about_service.dart' as _i29;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i39;
import '../module_auth/authoriazation_module.dart' as _i40;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i19;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i20;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i22;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i24;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i26;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i34;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i35;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i36;
import '../module_chat/chat_module.dart' as _i44;
import '../module_chat/manager/chat/chat_manager.dart' as _i30;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i21;
import '../module_chat/service/chat/char_service.dart' as _i31;
import '../module_chat/state_manager/chat_state_manager.dart' as _i32;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i41;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i25;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i33;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_settings/settings_module.dart' as _i42;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i37;
import '../module_splash/splash_module.dart' as _i38;
import '../module_splash/ui/screen/splash_screen.dart' as _i27;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i23;
import '../utils/global/global_state_manager.dart' as _i46;
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
  gh.factory<_i18.AboutRepository>(
      () => _i18.AboutRepository(get<_i13.ApiClient>()));
  gh.factory<_i19.AuthManager>(
      () => _i19.AuthManager(get<_i15.AuthRepository>()));
  gh.factory<_i20.AuthService>(() =>
      _i20.AuthService(get<_i3.AuthPrefsHelper>(), get<_i19.AuthManager>()));
  gh.factory<_i21.ChatRepository>(() =>
      _i21.ChatRepository(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i22.ForgotPassStateManager>(
      () => _i22.ForgotPassStateManager(get<_i20.AuthService>()));
  gh.factory<_i23.ImageUploadService>(
      () => _i23.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i24.LoginStateManager>(
      () => _i24.LoginStateManager(get<_i20.AuthService>()));
  gh.factory<_i25.NotificationRepo>(() =>
      _i25.NotificationRepo(get<_i13.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i26.RegisterStateManager>(
      () => _i26.RegisterStateManager(get<_i20.AuthService>()));
  gh.factory<_i27.SplashScreen>(
      () => _i27.SplashScreen(get<_i20.AuthService>()));
  gh.factory<_i28.AboutManager>(
      () => _i28.AboutManager(get<_i18.AboutRepository>()));
  gh.factory<_i29.AboutService>(
      () => _i29.AboutService(get<_i28.AboutManager>()));
  gh.factory<_i30.ChatManager>(
      () => _i30.ChatManager(get<_i21.ChatRepository>()));
  gh.factory<_i31.ChatService>(() => _i31.ChatService(get<_i30.ChatManager>()));
  gh.factory<_i32.ChatStateManager>(
      () => _i32.ChatStateManager(get<_i31.ChatService>()));
  gh.factory<_i33.FireNotificationService>(() => _i33.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i25.NotificationRepo>()));
  gh.factory<_i34.ForgotPassScreen>(
      () => _i34.ForgotPassScreen(get<_i22.ForgotPassStateManager>()));
  gh.factory<_i35.LoginScreen>(
      () => _i35.LoginScreen(get<_i24.LoginStateManager>()));
  gh.factory<_i36.RegisterScreen>(
      () => _i36.RegisterScreen(get<_i26.RegisterStateManager>()));
  gh.factory<_i37.SettingsScreen>(() => _i37.SettingsScreen(
      get<_i20.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i33.FireNotificationService>()));
  gh.factory<_i38.SplashModule>(
      () => _i38.SplashModule(get<_i27.SplashScreen>()));
  gh.factory<_i39.AboutScreenStateManager>(() => _i39.AboutScreenStateManager(
      get<_i8.LocalizationService>(), get<_i29.AboutService>()));
  gh.factory<_i40.AuthorizationModule>(() => _i40.AuthorizationModule(
      get<_i35.LoginScreen>(),
      get<_i36.RegisterScreen>(),
      get<_i34.ForgotPassScreen>()));
  gh.factory<_i41.ChatPage>(() => _i41.ChatPage(
      get<_i32.ChatStateManager>(),
      get<_i23.ImageUploadService>(),
      get<_i20.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i42.SettingsModule>(() => _i42.SettingsModule(
      get<_i37.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i43.AboutModule>(
      () => _i43.AboutModule(get<_i39.AboutScreenStateManager>()));
  gh.factory<_i44.ChatModule>(
      () => _i44.ChatModule(get<_i41.ChatPage>(), get<_i20.AuthService>()));
  gh.factory<_i45.MyApp>(() => _i45.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i33.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i38.SplashModule>(),
      get<_i40.AuthorizationModule>(),
      get<_i44.ChatModule>(),
      get<_i42.SettingsModule>(),
      get<_i43.AboutModule>()));
  gh.singleton<_i46.GlobalStateManager>(_i46.GlobalStateManager());
  return get;
}

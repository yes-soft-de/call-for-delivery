// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i57;
import '../module_about/about_module.dart' as _i51;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i31;
import '../module_about/repository/about_repository.dart' as _i20;
import '../module_about/service/about_service/about_service.dart' as _i32;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i44;
import '../module_auth/authoriazation_module.dart' as _i46;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i21;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i17;
import '../module_auth/service/auth_service/auth_service.dart' as _i22;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i24;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i29;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i37;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i38;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i41;
import '../module_chat/chat_module.dart' as _i53;
import '../module_chat/manager/chat/chat_manager.dart' as _i33;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i23;
import '../module_chat/service/chat/char_service.dart' as _i34;
import '../module_chat/state_manager/chat_state_manager.dart' as _i35;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i47;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i8;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i9;
import '../module_network/http_client/http_client.dart' as _i15;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i27;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i36;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i7;
import '../module_profile/manager/profile/profile.manager.dart' as _i39;
import '../module_profile/module_profile.dart' as _i56;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i12;
import '../module_profile/repository/profile/profile.repository.dart' as _i28;
import '../module_profile/service/profile/profile.service.dart' as _i40;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i45;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i48;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i49;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i52;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i54;
import '../module_profile/ui/screen/init_account_screen.dart' as _i55;
import '../module_settings/settings_module.dart' as _i50;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i18;
import '../module_settings/ui/settings_page/settings_page.dart' as _i42;
import '../module_splash/splash_module.dart' as _i43;
import '../module_splash/ui/screen/splash_screen.dart' as _i30;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i13;
import '../module_theme/service/theme_service/theme_service.dart' as _i16;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i19;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i14;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i25;
import '../utils/global/global_state_manager.dart' as _i58;
import '../utils/helpers/firestore_helper.dart' as _i6;
import '../utils/logger/logger.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutHiveHelper>(() => _i3.AboutHiveHelper());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
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
  gh.factory<_i12.ProfilePreferencesHelper>(
      () => _i12.ProfilePreferencesHelper());
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
  gh.factory<_i20.AboutRepository>(
      () => _i20.AboutRepository(get<_i15.ApiClient>()));
  gh.factory<_i21.AuthManager>(
      () => _i21.AuthManager(get<_i17.AuthRepository>()));
  gh.factory<_i22.AuthService>(() =>
      _i22.AuthService(get<_i4.AuthPrefsHelper>(), get<_i21.AuthManager>()));
  gh.factory<_i23.ChatRepository>(() =>
      _i23.ChatRepository(get<_i15.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i24.ForgotPassStateManager>(
      () => _i24.ForgotPassStateManager(get<_i22.AuthService>()));
  gh.factory<_i25.ImageUploadService>(
      () => _i25.ImageUploadService(get<_i19.UploadManager>()));
  gh.factory<_i26.LoginStateManager>(
      () => _i26.LoginStateManager(get<_i22.AuthService>()));
  gh.factory<_i27.NotificationRepo>(() =>
      _i27.NotificationRepo(get<_i15.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i28.ProfileRepository>(() =>
      _i28.ProfileRepository(get<_i15.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i29.RegisterStateManager>(
      () => _i29.RegisterStateManager(get<_i22.AuthService>()));
  gh.factory<_i30.SplashScreen>(
      () => _i30.SplashScreen(get<_i22.AuthService>()));
  gh.factory<_i31.AboutManager>(
      () => _i31.AboutManager(get<_i20.AboutRepository>()));
  gh.factory<_i32.AboutService>(
      () => _i32.AboutService(get<_i31.AboutManager>()));
  gh.factory<_i33.ChatManager>(
      () => _i33.ChatManager(get<_i23.ChatRepository>()));
  gh.factory<_i34.ChatService>(() => _i34.ChatService(get<_i33.ChatManager>()));
  gh.factory<_i35.ChatStateManager>(
      () => _i35.ChatStateManager(get<_i34.ChatService>()));
  gh.factory<_i36.FireNotificationService>(() => _i36.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i27.NotificationRepo>()));
  gh.factory<_i37.ForgotPassScreen>(
      () => _i37.ForgotPassScreen(get<_i24.ForgotPassStateManager>()));
  gh.factory<_i38.LoginScreen>(
      () => _i38.LoginScreen(get<_i26.LoginStateManager>()));
  gh.factory<_i39.ProfileManager>(
      () => _i39.ProfileManager(get<_i28.ProfileRepository>()));
  gh.factory<_i40.ProfileService>(() => _i40.ProfileService(
      get<_i39.ProfileManager>(),
      get<_i12.ProfilePreferencesHelper>(),
      get<_i22.AuthService>()));
  gh.factory<_i41.RegisterScreen>(
      () => _i41.RegisterScreen(get<_i29.RegisterStateManager>()));
  gh.factory<_i42.SettingsScreen>(() => _i42.SettingsScreen(
      get<_i22.AuthService>(),
      get<_i9.LocalizationService>(),
      get<_i16.AppThemeDataService>(),
      get<_i36.FireNotificationService>()));
  gh.factory<_i43.SplashModule>(
      () => _i43.SplashModule(get<_i30.SplashScreen>()));
  gh.factory<_i44.AboutScreenStateManager>(() => _i44.AboutScreenStateManager(
      get<_i9.LocalizationService>(), get<_i32.AboutService>()));
  gh.factory<_i45.ActivityStateManager>(() => _i45.ActivityStateManager(
      get<_i40.ProfileService>(), get<_i22.AuthService>()));
  gh.factory<_i46.AuthorizationModule>(() => _i46.AuthorizationModule(
      get<_i38.LoginScreen>(),
      get<_i41.RegisterScreen>(),
      get<_i37.ForgotPassScreen>()));
  gh.factory<_i47.ChatPage>(() => _i47.ChatPage(
      get<_i35.ChatStateManager>(),
      get<_i25.ImageUploadService>(),
      get<_i22.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i48.EditProfileStateManager>(() => _i48.EditProfileStateManager(
      get<_i25.ImageUploadService>(),
      get<_i40.ProfileService>(),
      get<_i22.AuthService>()));
  gh.factory<_i49.InitAccountStateManager>(() => _i49.InitAccountStateManager(
      get<_i40.ProfileService>(),
      get<_i22.AuthService>(),
      get<_i25.ImageUploadService>()));
  gh.factory<_i50.SettingsModule>(() => _i50.SettingsModule(
      get<_i42.SettingsScreen>(), get<_i18.ChooseLocalScreen>()));
  gh.factory<_i51.AboutModule>(
      () => _i51.AboutModule(get<_i44.AboutScreenStateManager>()));
  gh.factory<_i52.ActivityScreen>(
      () => _i52.ActivityScreen(get<_i45.ActivityStateManager>()));
  gh.factory<_i53.ChatModule>(
      () => _i53.ChatModule(get<_i47.ChatPage>(), get<_i22.AuthService>()));
  gh.factory<_i54.EditProfileScreen>(
      () => _i54.EditProfileScreen(get<_i48.EditProfileStateManager>()));
  gh.factory<_i55.InitAccountScreen>(
      () => _i55.InitAccountScreen(get<_i49.InitAccountStateManager>()));
  gh.factory<_i56.ProfileModule>(() => _i56.ProfileModule(
      get<_i52.ActivityScreen>(),
      get<_i54.EditProfileScreen>(),
      get<_i55.InitAccountScreen>()));
  gh.factory<_i57.MyApp>(() => _i57.MyApp(
      get<_i16.AppThemeDataService>(),
      get<_i9.LocalizationService>(),
      get<_i36.FireNotificationService>(),
      get<_i7.LocalNotificationService>(),
      get<_i43.SplashModule>(),
      get<_i46.AuthorizationModule>(),
      get<_i53.ChatModule>(),
      get<_i50.SettingsModule>(),
      get<_i51.AboutModule>(),
      get<_i56.ProfileModule>()));
  gh.singleton<_i58.GlobalStateManager>(_i58.GlobalStateManager());
  return get;
}

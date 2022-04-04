// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i65;
import '../module_auth/authoriazation_module.dart' as _i52;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i19;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i16;
import '../module_auth/service/auth_service/auth_service.dart' as _i20;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i23;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i25;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i28;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i39;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i40;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i44;
import '../module_chat/chat_module.dart' as _i60;
import '../module_chat/manager/chat/chat_manager.dart' as _i32;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i21;
import '../module_chat/service/chat/char_service.dart' as _i33;
import '../module_chat/state_manager/chat_state_manager.dart' as _i34;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i53;
import '../module_check_api/check_api_module.dart' as _i61;
import '../module_check_api/manager/check_api_manager.dart' as _i35;
import '../module_check_api/repository/check_api_repository.dart' as _i22;
import '../module_check_api/service/check_api_service.dart' as _i36;
import '../module_check_api/state_manager/check_api_state_manager.dart' as _i37;
import '../module_check_api/ui/screen/check_api_screen.dart' as _i54;
import '../module_home/home_module.dart' as _i62;
import '../module_home/ui/home_screen.dart' as _i55;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_network/http_client/http_client.dart' as _i14;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i26;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i38;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_order/manager/order_manager.dart' as _i41;
import '../module_order/order_module.dart' as _i11;
import '../module_order/repository/order_repository.dart' as _i27;
import '../module_order/service/orders_service.dart' as _i42;
import '../module_order/state_manager/orders_state_manager.dart' as _i43;
import '../module_rest_data/manager/rest_data_manager.dart' as _i45;
import '../module_rest_data/repository/rest_data_repository.dart' as _i29;
import '../module_rest_data/rest_data_module.dart' as _i63;
import '../module_rest_data/service/rest_data_service.dart' as _i46;
import '../module_rest_data/state_manager/rest_data_state_manager.dart' as _i47;
import '../module_rest_data/ui/screen/rest_data_screen.dart' as _i56;
import '../module_settings/settings_module.dart' as _i57;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i17;
import '../module_settings/ui/settings_page/settings_page.dart' as _i48;
import '../module_splash/splash_module.dart' as _i49;
import '../module_splash/ui/screen/splash_screen.dart' as _i30;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i12;
import '../module_theme/service/theme_service/theme_service.dart' as _i15;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i18;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i13;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i24;
import '../module_users/manager/users_manager.dart' as _i50;
import '../module_users/repository/users_repository.dart' as _i31;
import '../module_users/service/users_service.dart' as _i51;
import '../module_users/state_manager/users_state_manager.dart' as _i58;
import '../module_users/ui/screen/users_screen.dart' as _i59;
import '../module_users/users_module.dart' as _i64;
import '../utils/global/global_state_manager.dart' as _i66;
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
  gh.factory<_i11.OrdersModule>(() => _i11.OrdersModule());
  gh.factory<_i12.ThemePreferencesHelper>(() => _i12.ThemePreferencesHelper());
  gh.factory<_i13.UploadRepository>(() => _i13.UploadRepository());
  gh.factory<_i14.ApiClient>(() => _i14.ApiClient(get<_i9.Logger>()));
  gh.factory<_i15.AppThemeDataService>(
      () => _i15.AppThemeDataService(get<_i12.ThemePreferencesHelper>()));
  gh.factory<_i16.AuthRepository>(
      () => _i16.AuthRepository(get<_i14.ApiClient>(), get<_i9.Logger>()));
  gh.factory<_i17.ChooseLocalScreen>(
      () => _i17.ChooseLocalScreen(get<_i8.LocalizationService>()));
  gh.factory<_i18.UploadManager>(
      () => _i18.UploadManager(get<_i13.UploadRepository>()));
  gh.factory<_i19.AuthManager>(
      () => _i19.AuthManager(get<_i16.AuthRepository>()));
  gh.factory<_i20.AuthService>(() =>
      _i20.AuthService(get<_i3.AuthPrefsHelper>(), get<_i19.AuthManager>()));
  gh.factory<_i21.ChatRepository>(() =>
      _i21.ChatRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i22.CheckApiRepository>(() =>
      _i22.CheckApiRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i23.ForgotPassStateManager>(
      () => _i23.ForgotPassStateManager(get<_i20.AuthService>()));
  gh.factory<_i24.ImageUploadService>(
      () => _i24.ImageUploadService(get<_i18.UploadManager>()));
  gh.factory<_i25.LoginStateManager>(
      () => _i25.LoginStateManager(get<_i20.AuthService>()));
  gh.factory<_i26.NotificationRepo>(() =>
      _i26.NotificationRepo(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i27.OrdersRepository>(() =>
      _i27.OrdersRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i28.RegisterStateManager>(
      () => _i28.RegisterStateManager(get<_i20.AuthService>()));
  gh.factory<_i29.RestDataRepository>(() =>
      _i29.RestDataRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i30.SplashScreen>(
      () => _i30.SplashScreen(get<_i20.AuthService>()));
  gh.factory<_i31.UsersRepository>(() =>
      _i31.UsersRepository(get<_i14.ApiClient>(), get<_i20.AuthService>()));
  gh.factory<_i32.ChatManager>(
      () => _i32.ChatManager(get<_i21.ChatRepository>()));
  gh.factory<_i33.ChatService>(() => _i33.ChatService(get<_i32.ChatManager>()));
  gh.factory<_i34.ChatStateManager>(
      () => _i34.ChatStateManager(get<_i33.ChatService>()));
  gh.factory<_i35.CheckApiManager>(
      () => _i35.CheckApiManager(get<_i22.CheckApiRepository>()));
  gh.factory<_i36.CheckApiService>(
      () => _i36.CheckApiService(get<_i35.CheckApiManager>()));
  gh.factory<_i37.CheckApiStateManager>(
      () => _i37.CheckApiStateManager(get<_i36.CheckApiService>()));
  gh.factory<_i38.FireNotificationService>(() => _i38.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i26.NotificationRepo>()));
  gh.factory<_i39.ForgotPassScreen>(
      () => _i39.ForgotPassScreen(get<_i23.ForgotPassStateManager>()));
  gh.factory<_i40.LoginScreen>(
      () => _i40.LoginScreen(get<_i25.LoginStateManager>()));
  gh.factory<_i41.OrdersManager>(
      () => _i41.OrdersManager(get<_i27.OrdersRepository>()));
  gh.factory<_i42.OrdersService>(
      () => _i42.OrdersService(get<_i41.OrdersManager>()));
  gh.factory<_i43.OrdersStateManager>(
      () => _i43.OrdersStateManager(get<_i42.OrdersService>()));
  gh.factory<_i44.RegisterScreen>(
      () => _i44.RegisterScreen(get<_i28.RegisterStateManager>()));
  gh.factory<_i45.RestDataManager>(
      () => _i45.RestDataManager(get<_i29.RestDataRepository>()));
  gh.factory<_i46.RestDataService>(
      () => _i46.RestDataService(get<_i45.RestDataManager>()));
  gh.factory<_i47.RestDataStateManager>(() => _i47.RestDataStateManager(
      get<_i46.RestDataService>(), get<_i20.AuthService>()));
  gh.factory<_i48.SettingsScreen>(() => _i48.SettingsScreen(
      get<_i20.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i15.AppThemeDataService>(),
      get<_i38.FireNotificationService>()));
  gh.factory<_i49.SplashModule>(
      () => _i49.SplashModule(get<_i30.SplashScreen>()));
  gh.factory<_i50.UsersManager>(
      () => _i50.UsersManager(get<_i31.UsersRepository>()));
  gh.factory<_i51.UsersService>(
      () => _i51.UsersService(get<_i50.UsersManager>()));
  gh.factory<_i52.AuthorizationModule>(() => _i52.AuthorizationModule(
      get<_i40.LoginScreen>(),
      get<_i44.RegisterScreen>(),
      get<_i39.ForgotPassScreen>()));
  gh.factory<_i53.ChatPage>(() => _i53.ChatPage(
      get<_i34.ChatStateManager>(),
      get<_i24.ImageUploadService>(),
      get<_i20.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i54.CheckApiScreen>(
      () => _i54.CheckApiScreen(get<_i37.CheckApiStateManager>()));
  gh.factory<_i55.HomeScreen>(
      () => _i55.HomeScreen(get<_i43.OrdersStateManager>()));
  gh.factory<_i56.RestDataScreen>(
      () => _i56.RestDataScreen(get<_i47.RestDataStateManager>()));
  gh.factory<_i57.SettingsModule>(() => _i57.SettingsModule(
      get<_i48.SettingsScreen>(), get<_i17.ChooseLocalScreen>()));
  gh.factory<_i58.UserStateManager>(
      () => _i58.UserStateManager(get<_i51.UsersService>()));
  gh.factory<_i59.UsersScreen>(
      () => _i59.UsersScreen(get<_i58.UserStateManager>()));
  gh.factory<_i60.ChatModule>(
      () => _i60.ChatModule(get<_i53.ChatPage>(), get<_i20.AuthService>()));
  gh.factory<_i61.CheckApiModule>(
      () => _i61.CheckApiModule(get<_i54.CheckApiScreen>()));
  gh.factory<_i62.HomeModule>(() => _i62.HomeModule(get<_i55.HomeScreen>()));
  gh.factory<_i63.RestDataModule>(
      () => _i63.RestDataModule(get<_i56.RestDataScreen>()));
  gh.factory<_i64.UsersModule>(() => _i64.UsersModule(get<_i59.UsersScreen>()));
  gh.factory<_i65.MyApp>(() => _i65.MyApp(
      get<_i15.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i38.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i49.SplashModule>(),
      get<_i52.AuthorizationModule>(),
      get<_i60.ChatModule>(),
      get<_i57.SettingsModule>(),
      get<_i61.CheckApiModule>(),
      get<_i62.HomeModule>(),
      get<_i64.UsersModule>(),
      get<_i63.RestDataModule>()));
  gh.singleton<_i66.GlobalStateManager>(_i66.GlobalStateManager());
  return get;
}

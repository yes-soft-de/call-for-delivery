// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i71;
import '../module_about/about_module.dart' as _i70;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i47;
import '../module_about/repository/about_repository.dart' as _i33;
import '../module_about/service/about_service/about_service.dart' as _i48;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i58;
import '../module_about/state_manager/company_info_state_manager.dart' as _i51;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i66;
import '../module_about/ui/screen/company_info/company_info_screen.dart'
    as _i60;
import '../module_auth/authoriazation_module.dart' as _i49;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i21;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i22;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i24;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i31;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i40;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i41;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i44;
import '../module_chat/chat_module.dart' as _i59;
import '../module_chat/manager/chat/chat_manager.dart' as _i36;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i23;
import '../module_chat/service/chat/char_service.dart' as _i37;
import '../module_chat/state_manager/chat_state_manager.dart' as _i38;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i50;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i8;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i9;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i27;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i39;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i7;
import '../module_orders/hive/order_hive_helper.dart' as _i12;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i29;
import '../module_orders/orders_module.dart' as _i69;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i28;
import '../module_orders/service/orders/orders.service.dart' as _i54;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i62;
import '../module_orders/state_manager/order_time_line_state_manager.dart'
    as _i63;
import '../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i55;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i67;
import '../module_orders/ui/screens/order_time_line_screen.dart' as _i68;
import '../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i64;
import '../module_profile/manager/category/category_manager.dart' as _i34;
import '../module_profile/manager/profile/profile.manager.dart' as _i42;
import '../module_profile/module_profile.dart' as _i65;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i13;
import '../module_profile/repository/profile/profile.repository.dart' as _i30;
import '../module_profile/service/category/category_service.dart' as _i35;
import '../module_profile/service/profile/profile.service.dart' as _i43;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i52;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i53;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i56;
import '../module_profile/ui/screen/init_account_screen.dart' as _i61;
import '../module_settings/settings_module.dart' as _i57;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i19;
import '../module_settings/ui/settings_page/settings_page.dart' as _i45;
import '../module_splash/splash_module.dart' as _i46;
import '../module_splash/ui/screen/splash_screen.dart' as _i32;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i20;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i25;
import '../utils/global/global_state_manager.dart' as _i72;
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
  gh.factory<_i12.OrderHiveHelper>(() => _i12.OrderHiveHelper());
  gh.factory<_i13.ProfilePreferencesHelper>(
      () => _i13.ProfilePreferencesHelper());
  gh.factory<_i14.ThemePreferencesHelper>(() => _i14.ThemePreferencesHelper());
  gh.factory<_i15.UploadRepository>(() => _i15.UploadRepository());
  gh.factory<_i16.ApiClient>(() => _i16.ApiClient(get<_i10.Logger>()));
  gh.factory<_i17.AppThemeDataService>(
      () => _i17.AppThemeDataService(get<_i14.ThemePreferencesHelper>()));
  gh.factory<_i18.AuthRepository>(
      () => _i18.AuthRepository(get<_i16.ApiClient>(), get<_i10.Logger>()));
  gh.factory<_i19.ChooseLocalScreen>(
      () => _i19.ChooseLocalScreen(get<_i9.LocalizationService>()));
  gh.factory<_i20.UploadManager>(
      () => _i20.UploadManager(get<_i15.UploadRepository>()));
  gh.factory<_i21.AuthManager>(
      () => _i21.AuthManager(get<_i18.AuthRepository>()));
  gh.factory<_i22.AuthService>(() =>
      _i22.AuthService(get<_i4.AuthPrefsHelper>(), get<_i21.AuthManager>()));
  gh.factory<_i23.ChatRepository>(() =>
      _i23.ChatRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i24.ForgotPassStateManager>(
      () => _i24.ForgotPassStateManager(get<_i22.AuthService>()));
  gh.factory<_i25.ImageUploadService>(
      () => _i25.ImageUploadService(get<_i20.UploadManager>()));
  gh.factory<_i26.LoginStateManager>(
      () => _i26.LoginStateManager(get<_i22.AuthService>()));
  gh.factory<_i27.NotificationRepo>(() =>
      _i27.NotificationRepo(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i28.OrderRepository>(() =>
      _i28.OrderRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i29.OrdersManager>(
      () => _i29.OrdersManager(get<_i28.OrderRepository>()));
  gh.factory<_i30.ProfileRepository>(() =>
      _i30.ProfileRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i31.RegisterStateManager>(
      () => _i31.RegisterStateManager(get<_i22.AuthService>()));
  gh.factory<_i32.SplashScreen>(
      () => _i32.SplashScreen(get<_i22.AuthService>()));
  gh.factory<_i33.AboutRepository>(() =>
      _i33.AboutRepository(get<_i16.ApiClient>(), get<_i22.AuthService>()));
  gh.factory<_i34.CategoryManager>(
      () => _i34.CategoryManager(get<_i30.ProfileRepository>()));
  gh.factory<_i35.CategoryService>(
      () => _i35.CategoryService(get<_i34.CategoryManager>()));
  gh.factory<_i36.ChatManager>(
      () => _i36.ChatManager(get<_i23.ChatRepository>()));
  gh.factory<_i37.ChatService>(() => _i37.ChatService(get<_i36.ChatManager>()));
  gh.factory<_i38.ChatStateManager>(
      () => _i38.ChatStateManager(get<_i37.ChatService>()));
  gh.factory<_i39.FireNotificationService>(() => _i39.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i27.NotificationRepo>()));
  gh.factory<_i40.ForgotPassScreen>(
      () => _i40.ForgotPassScreen(get<_i24.ForgotPassStateManager>()));
  gh.factory<_i41.LoginScreen>(
      () => _i41.LoginScreen(get<_i26.LoginStateManager>()));
  gh.factory<_i42.ProfileManager>(
      () => _i42.ProfileManager(get<_i30.ProfileRepository>()));
  gh.factory<_i43.ProfileService>(() => _i43.ProfileService(
      get<_i42.ProfileManager>(),
      get<_i13.ProfilePreferencesHelper>(),
      get<_i22.AuthService>()));
  gh.factory<_i44.RegisterScreen>(
      () => _i44.RegisterScreen(get<_i31.RegisterStateManager>()));
  gh.factory<_i45.SettingsScreen>(() => _i45.SettingsScreen(
      get<_i22.AuthService>(),
      get<_i9.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i39.FireNotificationService>()));
  gh.factory<_i46.SplashModule>(
      () => _i46.SplashModule(get<_i32.SplashScreen>()));
  gh.factory<_i47.AboutManager>(
      () => _i47.AboutManager(get<_i33.AboutRepository>()));
  gh.factory<_i48.AboutService>(
      () => _i48.AboutService(get<_i47.AboutManager>()));
  gh.factory<_i49.AuthorizationModule>(() => _i49.AuthorizationModule(
      get<_i41.LoginScreen>(),
      get<_i44.RegisterScreen>(),
      get<_i40.ForgotPassScreen>()));
  gh.factory<_i50.ChatPage>(() => _i50.ChatPage(
      get<_i38.ChatStateManager>(),
      get<_i25.ImageUploadService>(),
      get<_i22.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i51.CompanyInfoStateManager>(() => _i51.CompanyInfoStateManager(
      get<_i48.AboutService>(),
      get<_i22.AuthService>(),
      get<_i43.ProfileService>()));
  gh.factory<_i52.EditProfileStateManager>(() => _i52.EditProfileStateManager(
      get<_i25.ImageUploadService>(),
      get<_i43.ProfileService>(),
      get<_i22.AuthService>()));
  gh.factory<_i53.InitAccountStateManager>(() => _i53.InitAccountStateManager(
      get<_i43.ProfileService>(),
      get<_i22.AuthService>(),
      get<_i25.ImageUploadService>(),
      get<_i35.CategoryService>()));
  gh.factory<_i54.OrdersService>(() => _i54.OrdersService(
      get<_i29.OrdersManager>(), get<_i43.ProfileService>()));
  gh.factory<_i55.OwnerOrdersStateManager>(() => _i55.OwnerOrdersStateManager(
      get<_i54.OrdersService>(),
      get<_i22.AuthService>(),
      get<_i43.ProfileService>(),
      get<_i48.AboutService>()));
  gh.factory<_i56.ProfileScreen>(
      () => _i56.ProfileScreen(get<_i52.EditProfileStateManager>()));
  gh.factory<_i57.SettingsModule>(() => _i57.SettingsModule(
      get<_i45.SettingsScreen>(), get<_i19.ChooseLocalScreen>()));
  gh.factory<_i58.AboutScreenStateManager>(() => _i58.AboutScreenStateManager(
      get<_i9.LocalizationService>(), get<_i48.AboutService>()));
  gh.factory<_i59.ChatModule>(
      () => _i59.ChatModule(get<_i50.ChatPage>(), get<_i22.AuthService>()));
  gh.factory<_i60.CompanyInfoScreen>(
      () => _i60.CompanyInfoScreen(get<_i51.CompanyInfoStateManager>()));
  gh.factory<_i61.InitAccountScreen>(
      () => _i61.InitAccountScreen(get<_i53.InitAccountStateManager>()));
  gh.factory<_i62.OrderLogsStateManager>(
      () => _i62.OrderLogsStateManager(get<_i54.OrdersService>()));
  gh.factory<_i63.OrderTimeLineStateManager>(() =>
      _i63.OrderTimeLineStateManager(
          get<_i54.OrdersService>(), get<_i22.AuthService>()));
  gh.factory<_i64.OwnerOrdersScreen>(() => _i64.OwnerOrdersScreen(
      get<_i55.OwnerOrdersStateManager>(),
      get<_i55.OwnerOrdersStateManager>()));
  gh.factory<_i65.ProfileModule>(() => _i65.ProfileModule(
      get<_i56.ProfileScreen>(), get<_i61.InitAccountScreen>()));
  gh.factory<_i66.AboutScreen>(
      () => _i66.AboutScreen(get<_i58.AboutScreenStateManager>()));
  gh.factory<_i67.OrderLogsScreen>(
      () => _i67.OrderLogsScreen(get<_i62.OrderLogsStateManager>()));
  gh.factory<_i68.OrderTimeLineScreen>(
      () => _i68.OrderTimeLineScreen(get<_i63.OrderTimeLineStateManager>()));
  gh.factory<_i69.OrdersModule>(() => _i69.OrdersModule(
      get<_i64.OwnerOrdersScreen>(),
      get<_i68.OrderTimeLineScreen>(),
      get<_i67.OrderLogsScreen>()));
  gh.factory<_i70.AboutModule>(() =>
      _i70.AboutModule(get<_i66.AboutScreen>(), get<_i60.CompanyInfoScreen>()));
  gh.factory<_i71.MyApp>(() => _i71.MyApp(
      get<_i17.AppThemeDataService>(),
      get<_i9.LocalizationService>(),
      get<_i39.FireNotificationService>(),
      get<_i7.LocalNotificationService>(),
      get<_i46.SplashModule>(),
      get<_i49.AuthorizationModule>(),
      get<_i59.ChatModule>(),
      get<_i57.SettingsModule>(),
      get<_i65.ProfileModule>(),
      get<_i69.OrdersModule>(),
      get<_i70.AboutModule>()));
  gh.singleton<_i72.GlobalStateManager>(_i72.GlobalStateManager());
  return get;
}

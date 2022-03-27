// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i91;
import '../module_about/about_module.dart' as _i89;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i40;
import '../module_about/repository/about_repository.dart' as _i23;
import '../module_about/service/about_service/about_service.dart' as _i41;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i65;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i80;
import '../module_auth/authoriazation_module.dart' as _i67;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i24;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i20;
import '../module_auth/service/auth_service/auth_service.dart' as _i25;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i30;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i38;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i47;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i51;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i60;
import '../module_chat/chat_module.dart' as _i82;
import '../module_chat/manager/chat/chat_manager.dart' as _i43;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i26;
import '../module_chat/service/chat/char_service.dart' as _i44;
import '../module_chat/state_manager/chat_state_manager.dart' as _i45;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i70;
import '../module_init/init_account_module.dart' as _i84;
import '../module_init/manager/init_account/init_account.manager.dart' as _i48;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i29;
import '../module_init/service/init_account/init_account.service.dart' as _i49;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i50;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i72;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i11;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i52;
import '../module_my_notifications/my_notifications_module.dart' as _i85;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i31;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i53;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i54;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i64;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i73;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i79;
import '../module_network/http_client/http_client.dart' as _i18;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import '../module_notifications/repository/notification_repo.dart' as _i32;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i46;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i34;
import '../module_orders/orders_module.dart' as _i86;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i33;
import '../module_orders/service/orders/orders.service.dart' as _i35;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i68;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i55;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i56;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i63;
import '../module_orders/ui/screens/captain_orders/captain_orders.dart' as _i69;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i74;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i75;
import '../module_orders/ui/screens/terms/terms.dart' as _i78;
import '../module_plan/manager/captain_balance_manager.dart' as _i42;
import '../module_plan/plan_module.dart' as _i90;
import '../module_plan/repository/package_balance_repository.dart' as _i36;
import '../module_plan/service/plan_service.dart' as _i57;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i76;
import '../module_plan/ui/screen/plan_screen.dart' as _i87;
import '../module_profile/manager/profile/profile.manager.dart' as _i58;
import '../module_profile/module_profile.dart' as _i88;
import '../module_profile/repository/profile/profile.repository.dart' as _i37;
import '../module_profile/service/profile/profile.service.dart' as _i59;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i66;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i71;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i81;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i83;
import '../module_settings/settings_module.dart' as _i77;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i14;
import '../module_settings/ui/screen/terms_of_use.dart' as _i15;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i21;
import '../module_settings/ui/settings_page/settings_page.dart' as _i61;
import '../module_splash/splash_module.dart' as _i62;
import '../module_splash/ui/screen/splash_screen.dart' as _i39;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i16;
import '../module_theme/service/theme_service/theme_service.dart' as _i19;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i22;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i17;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i28;
import '../utils/global/global_state_manager.dart' as _i92;
import '../utils/helpers/firestore_helper.dart' as _i7;
import '../utils/helpers/text_reader.dart' as _i8;
import '../utils/logger/logger.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutHiveHelper>(() => _i3.AboutHiveHelper());
  gh.factory<_i4.AboutScreen>(() => _i4.AboutScreen());
  gh.factory<_i5.AuthPrefsHelper>(() => _i5.AuthPrefsHelper());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
  gh.factory<_i7.FireStoreHelper>(() => _i7.FireStoreHelper());
  gh.factory<_i8.FlutterTextToSpeech>(() => _i8.FlutterTextToSpeech());
  gh.factory<_i9.LocalNotificationService>(
      () => _i9.LocalNotificationService());
  gh.factory<_i10.LocalizationPreferencesHelper>(
      () => _i10.LocalizationPreferencesHelper());
  gh.factory<_i11.LocalizationService>(() =>
      _i11.LocalizationService(get<_i10.LocalizationPreferencesHelper>()));
  gh.factory<_i12.Logger>(() => _i12.Logger());
  gh.factory<_i13.NotificationsPrefHelper>(
      () => _i13.NotificationsPrefHelper());
  gh.factory<_i14.PrivecyPolicy>(() => _i14.PrivecyPolicy());
  gh.factory<_i15.TermsOfUse>(() => _i15.TermsOfUse());
  gh.factory<_i16.ThemePreferencesHelper>(() => _i16.ThemePreferencesHelper());
  gh.factory<_i17.UploadRepository>(() => _i17.UploadRepository());
  gh.factory<_i18.ApiClient>(() => _i18.ApiClient(get<_i12.Logger>()));
  gh.factory<_i19.AppThemeDataService>(
      () => _i19.AppThemeDataService(get<_i16.ThemePreferencesHelper>()));
  gh.factory<_i20.AuthRepository>(
      () => _i20.AuthRepository(get<_i18.ApiClient>(), get<_i12.Logger>()));
  gh.factory<_i21.ChooseLocalScreen>(
      () => _i21.ChooseLocalScreen(get<_i11.LocalizationService>()));
  gh.factory<_i22.UploadManager>(
      () => _i22.UploadManager(get<_i17.UploadRepository>()));
  gh.factory<_i23.AboutRepository>(
      () => _i23.AboutRepository(get<_i18.ApiClient>()));
  gh.factory<_i24.AuthManager>(
      () => _i24.AuthManager(get<_i20.AuthRepository>()));
  gh.factory<_i25.AuthService>(() =>
      _i25.AuthService(get<_i5.AuthPrefsHelper>(), get<_i24.AuthManager>()));
  gh.factory<_i26.ChatRepository>(() =>
      _i26.ChatRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i27.ForgotPassStateManager>(
      () => _i27.ForgotPassStateManager(get<_i25.AuthService>()));
  gh.factory<_i28.ImageUploadService>(
      () => _i28.ImageUploadService(get<_i22.UploadManager>()));
  gh.factory<_i29.InitAccountRepository>(() => _i29.InitAccountRepository(
      get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i30.LoginStateManager>(
      () => _i30.LoginStateManager(get<_i25.AuthService>()));
  gh.factory<_i31.MyNotificationsRepository>(() =>
      _i31.MyNotificationsRepository(
          get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i32.NotificationRepo>(() =>
      _i32.NotificationRepo(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i33.OrderRepository>(() =>
      _i33.OrderRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i34.OrdersManager>(
      () => _i34.OrdersManager(get<_i33.OrderRepository>()));
  gh.factory<_i35.OrdersService>(
      () => _i35.OrdersService(get<_i34.OrdersManager>()));
  gh.factory<_i36.PackageBalanceRepository>(() => _i36.PackageBalanceRepository(
      get<_i25.AuthService>(), get<_i18.ApiClient>()));
  gh.factory<_i37.ProfileRepository>(() =>
      _i37.ProfileRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i38.RegisterStateManager>(
      () => _i38.RegisterStateManager(get<_i25.AuthService>()));
  gh.factory<_i39.SplashScreen>(
      () => _i39.SplashScreen(get<_i25.AuthService>()));
  gh.factory<_i40.AboutManager>(
      () => _i40.AboutManager(get<_i23.AboutRepository>()));
  gh.factory<_i41.AboutService>(
      () => _i41.AboutService(get<_i40.AboutManager>()));
  gh.factory<_i42.CaptainBalanceManager>(
      () => _i42.CaptainBalanceManager(get<_i36.PackageBalanceRepository>()));
  gh.factory<_i43.ChatManager>(
      () => _i43.ChatManager(get<_i26.ChatRepository>()));
  gh.factory<_i44.ChatService>(() => _i44.ChatService(get<_i43.ChatManager>()));
  gh.factory<_i45.ChatStateManager>(
      () => _i45.ChatStateManager(get<_i44.ChatService>()));
  gh.factory<_i46.FireNotificationService>(() => _i46.FireNotificationService(
      get<_i13.NotificationsPrefHelper>(), get<_i32.NotificationRepo>()));
  gh.factory<_i47.ForgotPassScreen>(
      () => _i47.ForgotPassScreen(get<_i27.ForgotPassStateManager>()));
  gh.factory<_i48.InitAccountManager>(
      () => _i48.InitAccountManager(get<_i29.InitAccountRepository>()));
  gh.factory<_i49.InitAccountService>(
      () => _i49.InitAccountService(get<_i48.InitAccountManager>()));
  gh.factory<_i50.InitAccountStateManager>(() => _i50.InitAccountStateManager(
      get<_i49.InitAccountService>(),
      get<_i25.AuthService>(),
      get<_i28.ImageUploadService>()));
  gh.factory<_i51.LoginScreen>(
      () => _i51.LoginScreen(get<_i30.LoginStateManager>()));
  gh.factory<_i52.MyNotificationsManager>(
      () => _i52.MyNotificationsManager(get<_i31.MyNotificationsRepository>()));
  gh.factory<_i53.MyNotificationsService>(
      () => _i53.MyNotificationsService(get<_i52.MyNotificationsManager>()));
  gh.factory<_i54.MyNotificationsStateManager>(() =>
      _i54.MyNotificationsStateManager(get<_i53.MyNotificationsService>(),
          get<_i35.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i55.OrderLogsStateManager>(
      () => _i55.OrderLogsStateManager(get<_i35.OrdersService>()));
  gh.factory<_i56.OrderStatusStateManager>(() => _i56.OrderStatusStateManager(
      get<_i35.OrdersService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i57.PlanService>(
      () => _i57.PlanService(get<_i42.CaptainBalanceManager>()));
  gh.factory<_i58.ProfileManager>(
      () => _i58.ProfileManager(get<_i37.ProfileRepository>()));
  gh.factory<_i59.ProfileService>(() => _i59.ProfileService(
      get<_i58.ProfileManager>(), get<_i35.OrdersService>()));
  gh.factory<_i60.RegisterScreen>(
      () => _i60.RegisterScreen(get<_i38.RegisterStateManager>()));
  gh.factory<_i61.SettingsScreen>(() => _i61.SettingsScreen(
      get<_i25.AuthService>(),
      get<_i11.LocalizationService>(),
      get<_i19.AppThemeDataService>(),
      get<_i46.FireNotificationService>()));
  gh.factory<_i62.SplashModule>(
      () => _i62.SplashModule(get<_i39.SplashScreen>()));
  gh.factory<_i63.TermsStateManager>(
      () => _i63.TermsStateManager(get<_i59.ProfileService>()));
  gh.factory<_i64.UpdatesStateManager>(() => _i64.UpdatesStateManager(
      get<_i53.MyNotificationsService>(), get<_i25.AuthService>()));
  gh.factory<_i65.AboutScreenStateManager>(
      () => _i65.AboutScreenStateManager(get<_i41.AboutService>()));
  gh.factory<_i66.ActivityStateManager>(() => _i66.ActivityStateManager(
      get<_i59.ProfileService>(), get<_i25.AuthService>()));
  gh.factory<_i67.AuthorizationModule>(() => _i67.AuthorizationModule(
      get<_i51.LoginScreen>(),
      get<_i60.RegisterScreen>(),
      get<_i47.ForgotPassScreen>()));
  gh.factory<_i68.CaptainOrdersListStateManager>(() =>
      _i68.CaptainOrdersListStateManager(
          get<_i35.OrdersService>(), get<_i59.ProfileService>()));
  gh.factory<_i69.CaptainOrdersScreen>(() =>
      _i69.CaptainOrdersScreen(get<_i68.CaptainOrdersListStateManager>()));
  gh.factory<_i70.ChatPage>(() => _i70.ChatPage(
      get<_i45.ChatStateManager>(),
      get<_i28.ImageUploadService>(),
      get<_i25.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i71.EditProfileStateManager>(() => _i71.EditProfileStateManager(
      get<_i28.ImageUploadService>(),
      get<_i59.ProfileService>(),
      get<_i25.AuthService>()));
  gh.factory<_i72.InitAccountScreen>(
      () => _i72.InitAccountScreen(get<_i50.InitAccountStateManager>()));
  gh.factory<_i73.MyNotificationsScreen>(() =>
      _i73.MyNotificationsScreen(get<_i54.MyNotificationsStateManager>()));
  gh.factory<_i74.OrderLogsScreen>(
      () => _i74.OrderLogsScreen(get<_i55.OrderLogsStateManager>()));
  gh.factory<_i75.OrderStatusScreen>(
      () => _i75.OrderStatusScreen(get<_i56.OrderStatusStateManager>()));
  gh.factory<_i76.PlanScreenStateManager>(
      () => _i76.PlanScreenStateManager(get<_i57.PlanService>()));
  gh.factory<_i77.SettingsModule>(() => _i77.SettingsModule(
      get<_i61.SettingsScreen>(),
      get<_i21.ChooseLocalScreen>(),
      get<_i14.PrivecyPolicy>(),
      get<_i15.TermsOfUse>()));
  gh.factory<_i78.TermsScreen>(
      () => _i78.TermsScreen(get<_i63.TermsStateManager>()));
  gh.factory<_i79.UpdateScreen>(
      () => _i79.UpdateScreen(get<_i64.UpdatesStateManager>()));
  gh.factory<_i80.AboutScreen>(
      () => _i80.AboutScreen(get<_i65.AboutScreenStateManager>()));
  gh.factory<_i81.ActivityScreen>(
      () => _i81.ActivityScreen(get<_i66.ActivityStateManager>()));
  gh.factory<_i82.ChatModule>(
      () => _i82.ChatModule(get<_i70.ChatPage>(), get<_i25.AuthService>()));
  gh.factory<_i83.EditProfileScreen>(
      () => _i83.EditProfileScreen(get<_i71.EditProfileStateManager>()));
  gh.factory<_i84.InitAccountModule>(
      () => _i84.InitAccountModule(get<_i72.InitAccountScreen>()));
  gh.factory<_i85.MyNotificationsModule>(() => _i85.MyNotificationsModule(
      get<_i73.MyNotificationsScreen>(), get<_i79.UpdateScreen>()));
  gh.factory<_i86.OrdersModule>(() => _i86.OrdersModule(
      get<_i75.OrderStatusScreen>(),
      get<_i69.CaptainOrdersScreen>(),
      get<_i78.TermsScreen>(),
      get<_i74.OrderLogsScreen>()));
  gh.factory<_i87.PlanScreen>(
      () => _i87.PlanScreen(get<_i76.PlanScreenStateManager>()));
  gh.factory<_i88.ProfileModule>(() => _i88.ProfileModule(
      get<_i81.ActivityScreen>(), get<_i83.EditProfileScreen>()));
  gh.factory<_i89.AboutModule>(() => _i89.AboutModule(get<_i80.AboutScreen>()));
  gh.factory<_i90.PlanModule>(() => _i90.PlanModule(get<_i87.PlanScreen>()));
  gh.factory<_i91.MyApp>(() => _i91.MyApp(
      get<_i19.AppThemeDataService>(),
      get<_i11.LocalizationService>(),
      get<_i46.FireNotificationService>(),
      get<_i9.LocalNotificationService>(),
      get<_i62.SplashModule>(),
      get<_i67.AuthorizationModule>(),
      get<_i82.ChatModule>(),
      get<_i77.SettingsModule>(),
      get<_i89.AboutModule>(),
      get<_i84.InitAccountModule>(),
      get<_i86.OrdersModule>(),
      get<_i90.PlanModule>(),
      get<_i88.ProfileModule>(),
      get<_i85.MyNotificationsModule>()));
  gh.singleton<_i92.GlobalStateManager>(_i92.GlobalStateManager());
  return get;
}

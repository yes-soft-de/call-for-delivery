// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i90;
import '../module_about/about_module.dart' as _i88;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i39;
import '../module_about/repository/about_repository.dart' as _i22;
import '../module_about/service/about_service/about_service.dart' as _i40;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i64;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i79;
import '../module_auth/authoriazation_module.dart' as _i66;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i23;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../module_auth/service/auth_service/auth_service.dart' as _i24;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i29;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i37;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i46;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i50;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i59;
import '../module_chat/chat_module.dart' as _i81;
import '../module_chat/manager/chat/chat_manager.dart' as _i42;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i25;
import '../module_chat/service/chat/char_service.dart' as _i43;
import '../module_chat/state_manager/chat_state_manager.dart' as _i44;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i69;
import '../module_init/init_account_module.dart' as _i83;
import '../module_init/manager/init_account/init_account.manager.dart' as _i47;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i28;
import '../module_init/service/init_account/init_account.service.dart' as _i48;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i49;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i71;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i51;
import '../module_my_notifications/my_notifications_module.dart' as _i84;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i30;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i52;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i53;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i63;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i72;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i78;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i31;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i45;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i33;
import '../module_orders/orders_module.dart' as _i85;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i32;
import '../module_orders/service/orders/orders.service.dart' as _i34;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i67;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i54;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i55;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i62;
import '../module_orders/ui/screens/captain_orders/captain_orders.dart' as _i68;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i73;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i74;
import '../module_orders/ui/screens/terms/terms.dart' as _i77;
import '../module_plan/manager/captain_balance_manager.dart' as _i41;
import '../module_plan/plan_module.dart' as _i89;
import '../module_plan/repository/package_balance_repository.dart' as _i35;
import '../module_plan/service/plan_service.dart' as _i56;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i75;
import '../module_plan/ui/screen/plan_screen.dart' as _i86;
import '../module_profile/manager/profile/profile.manager.dart' as _i57;
import '../module_profile/module_profile.dart' as _i87;
import '../module_profile/repository/profile/profile.repository.dart' as _i36;
import '../module_profile/service/profile/profile.service.dart' as _i58;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i65;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i70;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i80;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i82;
import '../module_settings/settings_module.dart' as _i76;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i13;
import '../module_settings/ui/screen/terms_of_use.dart' as _i14;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/settings_page.dart' as _i60;
import '../module_splash/splash_module.dart' as _i61;
import '../module_splash/ui/screen/splash_screen.dart' as _i38;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i27;
import '../utils/global/global_state_manager.dart' as _i91;
import '../utils/helpers/firestore_helper.dart' as _i7;
import '../utils/logger/logger.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i8.LocalNotificationService>(
      () => _i8.LocalNotificationService());
  gh.factory<_i9.LocalizationPreferencesHelper>(
      () => _i9.LocalizationPreferencesHelper());
  gh.factory<_i10.LocalizationService>(
      () => _i10.LocalizationService(get<_i9.LocalizationPreferencesHelper>()));
  gh.factory<_i11.Logger>(() => _i11.Logger());
  gh.factory<_i12.NotificationsPrefHelper>(
      () => _i12.NotificationsPrefHelper());
  gh.factory<_i13.PrivecyPolicy>(() => _i13.PrivecyPolicy());
  gh.factory<_i14.TermsOfUse>(() => _i14.TermsOfUse());
  gh.factory<_i15.ThemePreferencesHelper>(() => _i15.ThemePreferencesHelper());
  gh.factory<_i16.UploadRepository>(() => _i16.UploadRepository());
  gh.factory<_i17.ApiClient>(() => _i17.ApiClient(get<_i11.Logger>()));
  gh.factory<_i18.AppThemeDataService>(
      () => _i18.AppThemeDataService(get<_i15.ThemePreferencesHelper>()));
  gh.factory<_i19.AuthRepository>(
      () => _i19.AuthRepository(get<_i17.ApiClient>(), get<_i11.Logger>()));
  gh.factory<_i20.ChooseLocalScreen>(
      () => _i20.ChooseLocalScreen(get<_i10.LocalizationService>()));
  gh.factory<_i21.UploadManager>(
      () => _i21.UploadManager(get<_i16.UploadRepository>()));
  gh.factory<_i22.AboutRepository>(
      () => _i22.AboutRepository(get<_i17.ApiClient>()));
  gh.factory<_i23.AuthManager>(
      () => _i23.AuthManager(get<_i19.AuthRepository>()));
  gh.factory<_i24.AuthService>(() =>
      _i24.AuthService(get<_i5.AuthPrefsHelper>(), get<_i23.AuthManager>()));
  gh.factory<_i25.ChatRepository>(() =>
      _i25.ChatRepository(get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i26.ForgotPassStateManager>(
      () => _i26.ForgotPassStateManager(get<_i24.AuthService>()));
  gh.factory<_i27.ImageUploadService>(
      () => _i27.ImageUploadService(get<_i21.UploadManager>()));
  gh.factory<_i28.InitAccountRepository>(() => _i28.InitAccountRepository(
      get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i29.LoginStateManager>(
      () => _i29.LoginStateManager(get<_i24.AuthService>()));
  gh.factory<_i30.MyNotificationsRepository>(() =>
      _i30.MyNotificationsRepository(
          get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i31.NotificationRepo>(() =>
      _i31.NotificationRepo(get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i32.OrderRepository>(() =>
      _i32.OrderRepository(get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i33.OrdersManager>(
      () => _i33.OrdersManager(get<_i32.OrderRepository>()));
  gh.factory<_i34.OrdersService>(
      () => _i34.OrdersService(get<_i33.OrdersManager>()));
  gh.factory<_i35.PackageBalanceRepository>(() => _i35.PackageBalanceRepository(
      get<_i24.AuthService>(), get<_i17.ApiClient>()));
  gh.factory<_i36.ProfileRepository>(() =>
      _i36.ProfileRepository(get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i37.RegisterStateManager>(
      () => _i37.RegisterStateManager(get<_i24.AuthService>()));
  gh.factory<_i38.SplashScreen>(
      () => _i38.SplashScreen(get<_i24.AuthService>()));
  gh.factory<_i39.AboutManager>(
      () => _i39.AboutManager(get<_i22.AboutRepository>()));
  gh.factory<_i40.AboutService>(
      () => _i40.AboutService(get<_i39.AboutManager>()));
  gh.factory<_i41.CaptainBalanceManager>(
      () => _i41.CaptainBalanceManager(get<_i35.PackageBalanceRepository>()));
  gh.factory<_i42.ChatManager>(
      () => _i42.ChatManager(get<_i25.ChatRepository>()));
  gh.factory<_i43.ChatService>(() => _i43.ChatService(get<_i42.ChatManager>()));
  gh.factory<_i44.ChatStateManager>(
      () => _i44.ChatStateManager(get<_i43.ChatService>()));
  gh.factory<_i45.FireNotificationService>(() => _i45.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i31.NotificationRepo>()));
  gh.factory<_i46.ForgotPassScreen>(
      () => _i46.ForgotPassScreen(get<_i26.ForgotPassStateManager>()));
  gh.factory<_i47.InitAccountManager>(
      () => _i47.InitAccountManager(get<_i28.InitAccountRepository>()));
  gh.factory<_i48.InitAccountService>(
      () => _i48.InitAccountService(get<_i47.InitAccountManager>()));
  gh.factory<_i49.InitAccountStateManager>(() => _i49.InitAccountStateManager(
      get<_i48.InitAccountService>(),
      get<_i24.AuthService>(),
      get<_i27.ImageUploadService>()));
  gh.factory<_i50.LoginScreen>(
      () => _i50.LoginScreen(get<_i29.LoginStateManager>()));
  gh.factory<_i51.MyNotificationsManager>(
      () => _i51.MyNotificationsManager(get<_i30.MyNotificationsRepository>()));
  gh.factory<_i52.MyNotificationsService>(
      () => _i52.MyNotificationsService(get<_i51.MyNotificationsManager>()));
  gh.factory<_i53.MyNotificationsStateManager>(() =>
      _i53.MyNotificationsStateManager(get<_i52.MyNotificationsService>(),
          get<_i34.OrdersService>(), get<_i24.AuthService>()));
  gh.factory<_i54.OrderLogsStateManager>(
      () => _i54.OrderLogsStateManager(get<_i34.OrdersService>()));
  gh.factory<_i55.OrderStatusStateManager>(() => _i55.OrderStatusStateManager(
      get<_i34.OrdersService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i56.PlanService>(
      () => _i56.PlanService(get<_i41.CaptainBalanceManager>()));
  gh.factory<_i57.ProfileManager>(
      () => _i57.ProfileManager(get<_i36.ProfileRepository>()));
  gh.factory<_i58.ProfileService>(() => _i58.ProfileService(
      get<_i57.ProfileManager>(), get<_i34.OrdersService>()));
  gh.factory<_i59.RegisterScreen>(
      () => _i59.RegisterScreen(get<_i37.RegisterStateManager>()));
  gh.factory<_i60.SettingsScreen>(() => _i60.SettingsScreen(
      get<_i24.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i18.AppThemeDataService>(),
      get<_i45.FireNotificationService>()));
  gh.factory<_i61.SplashModule>(
      () => _i61.SplashModule(get<_i38.SplashScreen>()));
  gh.factory<_i62.TermsStateManager>(
      () => _i62.TermsStateManager(get<_i58.ProfileService>()));
  gh.factory<_i63.UpdatesStateManager>(() => _i63.UpdatesStateManager(
      get<_i52.MyNotificationsService>(), get<_i24.AuthService>()));
  gh.factory<_i64.AboutScreenStateManager>(
      () => _i64.AboutScreenStateManager(get<_i40.AboutService>()));
  gh.factory<_i65.ActivityStateManager>(() => _i65.ActivityStateManager(
      get<_i58.ProfileService>(), get<_i24.AuthService>()));
  gh.factory<_i66.AuthorizationModule>(() => _i66.AuthorizationModule(
      get<_i50.LoginScreen>(),
      get<_i59.RegisterScreen>(),
      get<_i46.ForgotPassScreen>()));
  gh.factory<_i67.CaptainOrdersListStateManager>(() =>
      _i67.CaptainOrdersListStateManager(
          get<_i34.OrdersService>(), get<_i58.ProfileService>()));
  gh.factory<_i68.CaptainOrdersScreen>(() =>
      _i68.CaptainOrdersScreen(get<_i67.CaptainOrdersListStateManager>()));
  gh.factory<_i69.ChatPage>(() => _i69.ChatPage(
      get<_i44.ChatStateManager>(),
      get<_i27.ImageUploadService>(),
      get<_i24.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i70.EditProfileStateManager>(() => _i70.EditProfileStateManager(
      get<_i27.ImageUploadService>(),
      get<_i58.ProfileService>(),
      get<_i24.AuthService>()));
  gh.factory<_i71.InitAccountScreen>(
      () => _i71.InitAccountScreen(get<_i49.InitAccountStateManager>()));
  gh.factory<_i72.MyNotificationsScreen>(() =>
      _i72.MyNotificationsScreen(get<_i53.MyNotificationsStateManager>()));
  gh.factory<_i73.OrderLogsScreen>(
      () => _i73.OrderLogsScreen(get<_i54.OrderLogsStateManager>()));
  gh.factory<_i74.OrderStatusScreen>(
      () => _i74.OrderStatusScreen(get<_i55.OrderStatusStateManager>()));
  gh.factory<_i75.PlanScreenStateManager>(
      () => _i75.PlanScreenStateManager(get<_i56.PlanService>()));
  gh.factory<_i76.SettingsModule>(() => _i76.SettingsModule(
      get<_i60.SettingsScreen>(),
      get<_i20.ChooseLocalScreen>(),
      get<_i13.PrivecyPolicy>(),
      get<_i14.TermsOfUse>()));
  gh.factory<_i77.TermsScreen>(
      () => _i77.TermsScreen(get<_i62.TermsStateManager>()));
  gh.factory<_i78.UpdateScreen>(
      () => _i78.UpdateScreen(get<_i63.UpdatesStateManager>()));
  gh.factory<_i79.AboutScreen>(
      () => _i79.AboutScreen(get<_i64.AboutScreenStateManager>()));
  gh.factory<_i80.ActivityScreen>(
      () => _i80.ActivityScreen(get<_i65.ActivityStateManager>()));
  gh.factory<_i81.ChatModule>(
      () => _i81.ChatModule(get<_i69.ChatPage>(), get<_i24.AuthService>()));
  gh.factory<_i82.EditProfileScreen>(
      () => _i82.EditProfileScreen(get<_i70.EditProfileStateManager>()));
  gh.factory<_i83.InitAccountModule>(
      () => _i83.InitAccountModule(get<_i71.InitAccountScreen>()));
  gh.factory<_i84.MyNotificationsModule>(() => _i84.MyNotificationsModule(
      get<_i72.MyNotificationsScreen>(), get<_i78.UpdateScreen>()));
  gh.factory<_i85.OrdersModule>(() => _i85.OrdersModule(
      get<_i74.OrderStatusScreen>(),
      get<_i68.CaptainOrdersScreen>(),
      get<_i77.TermsScreen>(),
      get<_i73.OrderLogsScreen>()));
  gh.factory<_i86.PlanScreen>(
      () => _i86.PlanScreen(get<_i75.PlanScreenStateManager>()));
  gh.factory<_i87.ProfileModule>(() => _i87.ProfileModule(
      get<_i80.ActivityScreen>(), get<_i82.EditProfileScreen>()));
  gh.factory<_i88.AboutModule>(() => _i88.AboutModule(get<_i79.AboutScreen>()));
  gh.factory<_i89.PlanModule>(() => _i89.PlanModule(get<_i86.PlanScreen>()));
  gh.factory<_i90.MyApp>(() => _i90.MyApp(
      get<_i18.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i45.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i61.SplashModule>(),
      get<_i66.AuthorizationModule>(),
      get<_i81.ChatModule>(),
      get<_i76.SettingsModule>(),
      get<_i88.AboutModule>(),
      get<_i83.InitAccountModule>(),
      get<_i85.OrdersModule>(),
      get<_i89.PlanModule>(),
      get<_i87.ProfileModule>(),
      get<_i84.MyNotificationsModule>()));
  gh.singleton<_i91.GlobalStateManager>(_i91.GlobalStateManager());
  return get;
}

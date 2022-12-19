// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i104;
import '../module_about/about_module.dart' as _i102;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i44;
import '../module_about/repository/about_repository.dart' as _i25;
import '../module_about/service/about_service/about_service.dart' as _i45;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i71;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i90;
import '../module_auth/authoriazation_module.dart' as _i75;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i26;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i22;
import '../module_auth/service/auth_service/auth_service.dart' as _i27;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i30;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i33;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i41;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i51;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i55;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i65;
import '../module_chat/chat_module.dart' as _i95;
import '../module_chat/manager/chat/chat_manager.dart' as _i47;
import '../module_chat/presistance/chat_hive_helper.dart' as _i7;
import '../module_chat/repository/chat/chat_repository.dart' as _i28;
import '../module_chat/service/chat/char_service.dart' as _i48;
import '../module_chat/state_manager/chat_state_manager.dart' as _i49;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i79;
import '../module_deep_links/repository/deep_link_repository.dart' as _i29;
import '../module_init/init_account_module.dart' as _i97;
import '../module_init/manager/init_account/init_account.manager.dart' as _i52;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i32;
import '../module_init/service/init_account/init_account.service.dart' as _i53;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i54;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i81;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i12;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i13;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i56;
import '../module_my_notifications/my_notifications_module.dart' as _i98;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i34;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i57;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i58;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i70;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i82;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i89;
import '../module_network/http_client/http_client.dart' as _i20;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i15;
import '../module_notifications/repository/notification_repo.dart' as _i35;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i50;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i11;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i37;
import '../module_orders/orders_module.dart' as _i99;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i36;
import '../module_orders/service/orders/orders.service.dart' as _i38;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i77;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i59;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i60;
import '../module_orders/state_manager/order_status/order_status_without_actions_state_manager.dart'
    as _i61;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i43;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i69;
import '../module_orders/ui/screens/captain_orders/captain_orders.dart' as _i78;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i83;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i84;
import '../module_orders/ui/screens/order_status/order_status_without_actions.dart'
    as _i85;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i68;
import '../module_orders/ui/screens/terms/terms.dart' as _i88;
import '../module_plan/manager/captain_balance_manager.dart' as _i46;
import '../module_plan/plan_module.dart' as _i103;
import '../module_plan/repository/plan_repository.dart' as _i39;
import '../module_plan/service/plan_service.dart' as _i62;
import '../module_plan/state_manager/account_balance_state_manager.dart'
    as _i72;
import '../module_plan/state_manager/captain_financial_dues_state_manager.dart'
    as _i76;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i86;
import '../module_plan/ui/screen/account_balance_screen.dart' as _i91;
import '../module_plan/ui/screen/captain_financial_details_screen.dart' as _i6;
import '../module_plan/ui/screen/captain_financial_dues_screen.dart' as _i94;
import '../module_plan/ui/screen/plan_screen.dart' as _i100;
import '../module_profile/manager/profile/profile.manager.dart' as _i63;
import '../module_profile/module_profile.dart' as _i101;
import '../module_profile/repository/profile/profile.repository.dart' as _i40;
import '../module_profile/service/profile/profile.service.dart' as _i64;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i73;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i74;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i80;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i92;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i93;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i96;
import '../module_settings/settings_module.dart' as _i87;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i16;
import '../module_settings/ui/screen/terms_of_use.dart' as _i17;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i23;
import '../module_settings/ui/settings_page/settings_page.dart' as _i66;
import '../module_splash/splash_module.dart' as _i67;
import '../module_splash/ui/screen/splash_screen.dart' as _i42;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i18;
import '../module_theme/service/theme_service/theme_service.dart' as _i21;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i24;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i19;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i31;
import '../utils/global/global_state_manager.dart' as _i10;
import '../utils/helpers/firestore_helper.dart' as _i8;
import '../utils/helpers/text_reader.dart' as _i9;
import '../utils/logger/logger.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutHiveHelper>(() => _i3.AboutHiveHelper());
  gh.factory<_i4.AboutScreen>(() => _i4.AboutScreen());
  gh.factory<_i5.AuthPrefsHelper>(() => _i5.AuthPrefsHelper());
  gh.factory<_i6.CaptainFinancialDuesDetailsScreen>(
      () => _i6.CaptainFinancialDuesDetailsScreen());
  gh.factory<_i7.ChatHiveHelper>(() => _i7.ChatHiveHelper());
  gh.factory<_i8.FireStoreHelper>(() => _i8.FireStoreHelper());
  gh.factory<_i9.FlutterTextToSpeech>(() => _i9.FlutterTextToSpeech());
  gh.singleton<_i10.GlobalStateManager>(_i10.GlobalStateManager());
  gh.factory<_i11.LocalNotificationService>(
      () => _i11.LocalNotificationService());
  gh.factory<_i12.LocalizationPreferencesHelper>(
      () => _i12.LocalizationPreferencesHelper());
  gh.factory<_i13.LocalizationService>(() =>
      _i13.LocalizationService(get<_i12.LocalizationPreferencesHelper>()));
  gh.factory<_i14.Logger>(() => _i14.Logger());
  gh.factory<_i15.NotificationsPrefHelper>(
      () => _i15.NotificationsPrefHelper());
  gh.factory<_i16.PrivecyPolicy>(() => _i16.PrivecyPolicy());
  gh.factory<_i17.TermsOfUse>(() => _i17.TermsOfUse());
  gh.factory<_i18.ThemePreferencesHelper>(() => _i18.ThemePreferencesHelper());
  gh.factory<_i19.UploadRepository>(() => _i19.UploadRepository());
  gh.factory<_i20.ApiClient>(() => _i20.ApiClient(get<_i14.Logger>()));
  gh.factory<_i21.AppThemeDataService>(
      () => _i21.AppThemeDataService(get<_i18.ThemePreferencesHelper>()));
  gh.factory<_i22.AuthRepository>(
      () => _i22.AuthRepository(get<_i20.ApiClient>(), get<_i14.Logger>()));
  gh.factory<_i23.ChooseLocalScreen>(
      () => _i23.ChooseLocalScreen(get<_i13.LocalizationService>()));
  gh.factory<_i24.UploadManager>(
      () => _i24.UploadManager(get<_i19.UploadRepository>()));
  gh.factory<_i25.AboutRepository>(
      () => _i25.AboutRepository(get<_i20.ApiClient>()));
  gh.factory<_i26.AuthManager>(
      () => _i26.AuthManager(get<_i22.AuthRepository>()));
  gh.factory<_i27.AuthService>(() =>
      _i27.AuthService(get<_i5.AuthPrefsHelper>(), get<_i26.AuthManager>()));
  gh.factory<_i28.ChatRepository>(() =>
      _i28.ChatRepository(get<_i20.ApiClient>(), get<_i27.AuthService>()));
  gh.factory<_i29.DeepLinkRepository>(() =>
      _i29.DeepLinkRepository(get<_i20.ApiClient>(), get<_i27.AuthService>()));
  gh.factory<_i30.ForgotPassStateManager>(
      () => _i30.ForgotPassStateManager(get<_i27.AuthService>()));
  gh.factory<_i31.ImageUploadService>(
      () => _i31.ImageUploadService(get<_i24.UploadManager>()));
  gh.factory<_i32.InitAccountRepository>(() => _i32.InitAccountRepository(
      get<_i20.ApiClient>(), get<_i27.AuthService>()));
  gh.factory<_i33.LoginStateManager>(
      () => _i33.LoginStateManager(get<_i27.AuthService>()));
  gh.factory<_i34.MyNotificationsRepository>(() =>
      _i34.MyNotificationsRepository(
          get<_i20.ApiClient>(), get<_i27.AuthService>()));
  gh.factory<_i35.NotificationRepo>(() =>
      _i35.NotificationRepo(get<_i20.ApiClient>(), get<_i27.AuthService>()));
  gh.factory<_i36.OrderRepository>(() =>
      _i36.OrderRepository(get<_i20.ApiClient>(), get<_i27.AuthService>()));
  gh.factory<_i37.OrdersManager>(
      () => _i37.OrdersManager(get<_i36.OrderRepository>()));
  gh.factory<_i38.OrdersService>(
      () => _i38.OrdersService(get<_i37.OrdersManager>()));
  gh.factory<_i39.PackageBalanceRepository>(() => _i39.PackageBalanceRepository(
      get<_i27.AuthService>(), get<_i20.ApiClient>()));
  gh.factory<_i40.ProfileRepository>(() =>
      _i40.ProfileRepository(get<_i20.ApiClient>(), get<_i27.AuthService>()));
  gh.factory<_i41.RegisterStateManager>(
      () => _i41.RegisterStateManager(get<_i27.AuthService>()));
  gh.factory<_i42.SplashScreen>(
      () => _i42.SplashScreen(get<_i27.AuthService>()));
  gh.factory<_i43.SubOrdersStateManager>(() => _i43.SubOrdersStateManager(
      get<_i38.OrdersService>(), get<_i27.AuthService>()));
  gh.factory<_i44.AboutManager>(
      () => _i44.AboutManager(get<_i25.AboutRepository>()));
  gh.factory<_i45.AboutService>(
      () => _i45.AboutService(get<_i44.AboutManager>()));
  gh.factory<_i46.CaptainBalanceManager>(
      () => _i46.CaptainBalanceManager(get<_i39.PackageBalanceRepository>()));
  gh.factory<_i47.ChatManager>(
      () => _i47.ChatManager(get<_i28.ChatRepository>()));
  gh.factory<_i48.ChatService>(() => _i48.ChatService(get<_i47.ChatManager>()));
  gh.factory<_i49.ChatStateManager>(
      () => _i49.ChatStateManager(get<_i48.ChatService>()));
  gh.factory<_i50.FireNotificationService>(() => _i50.FireNotificationService(
      get<_i15.NotificationsPrefHelper>(), get<_i35.NotificationRepo>()));
  gh.factory<_i51.ForgotPassScreen>(
      () => _i51.ForgotPassScreen(get<_i30.ForgotPassStateManager>()));
  gh.factory<_i52.InitAccountManager>(
      () => _i52.InitAccountManager(get<_i32.InitAccountRepository>()));
  gh.factory<_i53.InitAccountService>(
      () => _i53.InitAccountService(get<_i52.InitAccountManager>()));
  gh.factory<_i54.InitAccountStateManager>(() => _i54.InitAccountStateManager(
      get<_i53.InitAccountService>(),
      get<_i27.AuthService>(),
      get<_i31.ImageUploadService>()));
  gh.factory<_i55.LoginScreen>(
      () => _i55.LoginScreen(get<_i33.LoginStateManager>()));
  gh.factory<_i56.MyNotificationsManager>(
      () => _i56.MyNotificationsManager(get<_i34.MyNotificationsRepository>()));
  gh.factory<_i57.MyNotificationsService>(
      () => _i57.MyNotificationsService(get<_i56.MyNotificationsManager>()));
  gh.factory<_i58.MyNotificationsStateManager>(() =>
      _i58.MyNotificationsStateManager(get<_i57.MyNotificationsService>(),
          get<_i38.OrdersService>(), get<_i27.AuthService>()));
  gh.factory<_i59.OrderLogsStateManager>(
      () => _i59.OrderLogsStateManager(get<_i38.OrdersService>()));
  gh.factory<_i60.OrderStatusStateManager>(() => _i60.OrderStatusStateManager(
      get<_i38.OrdersService>(), get<_i31.ImageUploadService>()));
  gh.factory<_i61.OrderStatusWithoutActionsStateManager>(() =>
      _i61.OrderStatusWithoutActionsStateManager(
          get<_i38.OrdersService>(), get<_i31.ImageUploadService>()));
  gh.factory<_i62.PlanService>(
      () => _i62.PlanService(get<_i46.CaptainBalanceManager>()));
  gh.factory<_i63.ProfileManager>(
      () => _i63.ProfileManager(get<_i40.ProfileRepository>()));
  gh.factory<_i64.ProfileService>(() => _i64.ProfileService(
      get<_i63.ProfileManager>(), get<_i38.OrdersService>()));
  gh.factory<_i65.RegisterScreen>(
      () => _i65.RegisterScreen(get<_i41.RegisterStateManager>()));
  gh.factory<_i66.SettingsScreen>(() => _i66.SettingsScreen(
      get<_i27.AuthService>(),
      get<_i13.LocalizationService>(),
      get<_i21.AppThemeDataService>(),
      get<_i50.FireNotificationService>()));
  gh.factory<_i67.SplashModule>(
      () => _i67.SplashModule(get<_i42.SplashScreen>()));
  gh.factory<_i68.SubOrdersScreen>(
      () => _i68.SubOrdersScreen(get<_i43.SubOrdersStateManager>()));
  gh.factory<_i69.TermsStateManager>(
      () => _i69.TermsStateManager(get<_i64.ProfileService>()));
  gh.factory<_i70.UpdatesStateManager>(() => _i70.UpdatesStateManager(
      get<_i57.MyNotificationsService>(), get<_i27.AuthService>()));
  gh.factory<_i71.AboutScreenStateManager>(
      () => _i71.AboutScreenStateManager(get<_i45.AboutService>()));
  gh.factory<_i72.AccountBalanceStateManager>(
      () => _i72.AccountBalanceStateManager(get<_i62.PlanService>()));
  gh.factory<_i73.AccountBalanceStateManager>(() =>
      _i73.AccountBalanceStateManager(get<_i64.ProfileService>(),
          get<_i27.AuthService>(), get<_i31.ImageUploadService>()));
  gh.factory<_i74.ActivityStateManager>(() => _i74.ActivityStateManager(
      get<_i64.ProfileService>(), get<_i27.AuthService>()));
  gh.factory<_i75.AuthorizationModule>(() => _i75.AuthorizationModule(
      get<_i55.LoginScreen>(),
      get<_i65.RegisterScreen>(),
      get<_i51.ForgotPassScreen>()));
  gh.factory<_i76.CaptainFinancialDuesStateManager>(
      () => _i76.CaptainFinancialDuesStateManager(get<_i62.PlanService>()));
  gh.factory<_i77.CaptainOrdersListStateManager>(() =>
      _i77.CaptainOrdersListStateManager(
          get<_i38.OrdersService>(), get<_i64.ProfileService>()));
  gh.factory<_i78.CaptainOrdersScreen>(() =>
      _i78.CaptainOrdersScreen(get<_i77.CaptainOrdersListStateManager>()));
  gh.factory<_i79.ChatPage>(() => _i79.ChatPage(
      get<_i49.ChatStateManager>(),
      get<_i31.ImageUploadService>(),
      get<_i27.AuthService>(),
      get<_i7.ChatHiveHelper>()));
  gh.factory<_i80.EditProfileStateManager>(() => _i80.EditProfileStateManager(
      get<_i31.ImageUploadService>(),
      get<_i64.ProfileService>(),
      get<_i27.AuthService>()));
  gh.factory<_i81.InitAccountScreen>(
      () => _i81.InitAccountScreen(get<_i54.InitAccountStateManager>()));
  gh.factory<_i82.MyNotificationsScreen>(() =>
      _i82.MyNotificationsScreen(get<_i58.MyNotificationsStateManager>()));
  gh.factory<_i83.OrderLogsScreen>(
      () => _i83.OrderLogsScreen(get<_i59.OrderLogsStateManager>()));
  gh.factory<_i84.OrderStatusScreen>(
      () => _i84.OrderStatusScreen(get<_i60.OrderStatusStateManager>()));
  gh.factory<_i85.OrderStatusWithoutActionsScreen>(() =>
      _i85.OrderStatusWithoutActionsScreen(
          get<_i61.OrderStatusWithoutActionsStateManager>()));
  gh.factory<_i86.PlanScreenStateManager>(
      () => _i86.PlanScreenStateManager(get<_i62.PlanService>()));
  gh.factory<_i87.SettingsModule>(() => _i87.SettingsModule(
      get<_i66.SettingsScreen>(),
      get<_i23.ChooseLocalScreen>(),
      get<_i16.PrivecyPolicy>(),
      get<_i17.TermsOfUse>()));
  gh.factory<_i88.TermsScreen>(
      () => _i88.TermsScreen(get<_i69.TermsStateManager>()));
  gh.factory<_i89.UpdateScreen>(
      () => _i89.UpdateScreen(get<_i70.UpdatesStateManager>()));
  gh.factory<_i90.AboutScreen>(
      () => _i90.AboutScreen(get<_i71.AboutScreenStateManager>()));
  gh.factory<_i91.AccountBalanceScreen>(
      () => _i91.AccountBalanceScreen(get<_i72.AccountBalanceStateManager>()));
  gh.factory<_i92.AccountBalanceScreen>(
      () => _i92.AccountBalanceScreen(get<_i73.AccountBalanceStateManager>()));
  gh.factory<_i93.ActivityScreen>(
      () => _i93.ActivityScreen(get<_i74.ActivityStateManager>()));
  gh.factory<_i94.CaptainFinancialDuesScreen>(() =>
      _i94.CaptainFinancialDuesScreen(
          get<_i76.CaptainFinancialDuesStateManager>()));
  gh.factory<_i95.ChatModule>(
      () => _i95.ChatModule(get<_i79.ChatPage>(), get<_i27.AuthService>()));
  gh.factory<_i96.EditProfileScreen>(
      () => _i96.EditProfileScreen(get<_i80.EditProfileStateManager>()));
  gh.factory<_i97.InitAccountModule>(
      () => _i97.InitAccountModule(get<_i81.InitAccountScreen>()));
  gh.factory<_i98.MyNotificationsModule>(() => _i98.MyNotificationsModule(
      get<_i82.MyNotificationsScreen>(), get<_i89.UpdateScreen>()));
  gh.factory<_i99.OrdersModule>(() => _i99.OrdersModule(
      get<_i84.OrderStatusScreen>(),
      get<_i78.CaptainOrdersScreen>(),
      get<_i88.TermsScreen>(),
      get<_i68.SubOrdersScreen>(),
      get<_i83.OrderLogsScreen>(),
      get<_i85.OrderStatusWithoutActionsScreen>()));
  gh.factory<_i100.PlanScreen>(
      () => _i100.PlanScreen(get<_i86.PlanScreenStateManager>()));
  gh.factory<_i101.ProfileModule>(() => _i101.ProfileModule(
      get<_i93.ActivityScreen>(),
      get<_i96.EditProfileScreen>(),
      get<_i92.AccountBalanceScreen>()));
  gh.factory<_i102.AboutModule>(
      () => _i102.AboutModule(get<_i90.AboutScreen>()));
  gh.factory<_i103.PlanModule>(() => _i103.PlanModule(
      get<_i100.PlanScreen>(),
      get<_i91.AccountBalanceScreen>(),
      get<_i6.CaptainFinancialDuesDetailsScreen>(),
      get<_i94.CaptainFinancialDuesScreen>()));
  gh.factory<_i104.MyApp>(() => _i104.MyApp(
      get<_i21.AppThemeDataService>(),
      get<_i13.LocalizationService>(),
      get<_i50.FireNotificationService>(),
      get<_i11.LocalNotificationService>(),
      get<_i67.SplashModule>(),
      get<_i75.AuthorizationModule>(),
      get<_i95.ChatModule>(),
      get<_i87.SettingsModule>(),
      get<_i102.AboutModule>(),
      get<_i97.InitAccountModule>(),
      get<_i99.OrdersModule>(),
      get<_i103.PlanModule>(),
      get<_i101.ProfileModule>(),
      get<_i98.MyNotificationsModule>()));
  return get;
}

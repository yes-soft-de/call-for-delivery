// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i103;
import '../module_about/about_module.dart' as _i101;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i43;
import '../module_about/repository/about_repository.dart' as _i24;
import '../module_about/service/about_service/about_service.dart' as _i44;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i70;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i89;
import '../module_auth/authoriazation_module.dart' as _i74;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i25;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i21;
import '../module_auth/service/auth_service/auth_service.dart' as _i26;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i29;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i32;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i40;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i50;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i54;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i64;
import '../module_chat/chat_module.dart' as _i94;
import '../module_chat/manager/chat/chat_manager.dart' as _i46;
import '../module_chat/presistance/chat_hive_helper.dart' as _i7;
import '../module_chat/repository/chat/chat_repository.dart' as _i27;
import '../module_chat/service/chat/char_service.dart' as _i47;
import '../module_chat/state_manager/chat_state_manager.dart' as _i48;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i78;
import '../module_deep_links/repository/deep_link_repository.dart' as _i28;
import '../module_init/init_account_module.dart' as _i96;
import '../module_init/manager/init_account/init_account.manager.dart' as _i51;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i31;
import '../module_init/service/init_account/init_account.service.dart' as _i52;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i53;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i80;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i11;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i12;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i55;
import '../module_my_notifications/my_notifications_module.dart' as _i97;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i33;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i56;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i57;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i69;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i81;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i88;
import '../module_network/http_client/http_client.dart' as _i19;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i14;
import '../module_notifications/repository/notification_repo.dart' as _i34;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i49;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i10;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i36;
import '../module_orders/orders_module.dart' as _i98;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i35;
import '../module_orders/service/orders/orders.service.dart' as _i37;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i76;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i58;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i59;
import '../module_orders/state_manager/order_status/order_status_without_actions_state_manager.dart'
    as _i60;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i42;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i68;
import '../module_orders/ui/screens/captain_orders/captain_orders.dart' as _i77;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i82;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i83;
import '../module_orders/ui/screens/order_status/order_status_without_actions.dart'
    as _i84;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i67;
import '../module_orders/ui/screens/terms/terms.dart' as _i87;
import '../module_plan/manager/captain_balance_manager.dart' as _i45;
import '../module_plan/plan_module.dart' as _i102;
import '../module_plan/repository/plan_repository.dart' as _i38;
import '../module_plan/service/plan_service.dart' as _i61;
import '../module_plan/state_manager/account_balance_state_manager.dart'
    as _i71;
import '../module_plan/state_manager/captain_financial_dues_state_manager.dart'
    as _i75;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i85;
import '../module_plan/ui/screen/account_balance_screen.dart' as _i90;
import '../module_plan/ui/screen/captain_financial_details_screen.dart' as _i6;
import '../module_plan/ui/screen/captain_financial_dues_screen.dart' as _i93;
import '../module_plan/ui/screen/plan_screen.dart' as _i99;
import '../module_profile/manager/profile/profile.manager.dart' as _i62;
import '../module_profile/module_profile.dart' as _i100;
import '../module_profile/repository/profile/profile.repository.dart' as _i39;
import '../module_profile/service/profile/profile.service.dart' as _i63;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i72;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i73;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i79;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i91;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i92;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i95;
import '../module_settings/settings_module.dart' as _i86;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i15;
import '../module_settings/ui/screen/terms_of_use.dart' as _i16;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i22;
import '../module_settings/ui/settings_page/settings_page.dart' as _i65;
import '../module_splash/splash_module.dart' as _i66;
import '../module_splash/ui/screen/splash_screen.dart' as _i41;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i17;
import '../module_theme/service/theme_service/theme_service.dart' as _i20;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i23;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i18;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i30;
import '../utils/global/global_state_manager.dart' as _i104;
import '../utils/helpers/firestore_helper.dart' as _i8;
import '../utils/helpers/text_reader.dart' as _i9;
import '../utils/logger/logger.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i10.LocalNotificationService>(
      () => _i10.LocalNotificationService());
  gh.factory<_i11.LocalizationPreferencesHelper>(
      () => _i11.LocalizationPreferencesHelper());
  gh.factory<_i12.LocalizationService>(() =>
      _i12.LocalizationService(get<_i11.LocalizationPreferencesHelper>()));
  gh.factory<_i13.Logger>(() => _i13.Logger());
  gh.factory<_i14.NotificationsPrefHelper>(
      () => _i14.NotificationsPrefHelper());
  gh.factory<_i15.PrivecyPolicy>(() => _i15.PrivecyPolicy());
  gh.factory<_i16.TermsOfUse>(() => _i16.TermsOfUse());
  gh.factory<_i17.ThemePreferencesHelper>(() => _i17.ThemePreferencesHelper());
  gh.factory<_i18.UploadRepository>(() => _i18.UploadRepository());
  gh.factory<_i19.ApiClient>(() => _i19.ApiClient(get<_i13.Logger>()));
  gh.factory<_i20.AppThemeDataService>(
      () => _i20.AppThemeDataService(get<_i17.ThemePreferencesHelper>()));
  gh.factory<_i21.AuthRepository>(
      () => _i21.AuthRepository(get<_i19.ApiClient>(), get<_i13.Logger>()));
  gh.factory<_i22.ChooseLocalScreen>(
      () => _i22.ChooseLocalScreen(get<_i12.LocalizationService>()));
  gh.factory<_i23.UploadManager>(
      () => _i23.UploadManager(get<_i18.UploadRepository>()));
  gh.factory<_i24.AboutRepository>(
      () => _i24.AboutRepository(get<_i19.ApiClient>()));
  gh.factory<_i25.AuthManager>(
      () => _i25.AuthManager(get<_i21.AuthRepository>()));
  gh.factory<_i26.AuthService>(() =>
      _i26.AuthService(get<_i5.AuthPrefsHelper>(), get<_i25.AuthManager>()));
  gh.factory<_i27.ChatRepository>(() =>
      _i27.ChatRepository(get<_i19.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i28.DeepLinkRepository>(() =>
      _i28.DeepLinkRepository(get<_i19.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i29.ForgotPassStateManager>(
      () => _i29.ForgotPassStateManager(get<_i26.AuthService>()));
  gh.factory<_i30.ImageUploadService>(
      () => _i30.ImageUploadService(get<_i23.UploadManager>()));
  gh.factory<_i31.InitAccountRepository>(() => _i31.InitAccountRepository(
      get<_i19.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i32.LoginStateManager>(
      () => _i32.LoginStateManager(get<_i26.AuthService>()));
  gh.factory<_i33.MyNotificationsRepository>(() =>
      _i33.MyNotificationsRepository(
          get<_i19.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i34.NotificationRepo>(() =>
      _i34.NotificationRepo(get<_i19.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i35.OrderRepository>(() =>
      _i35.OrderRepository(get<_i19.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i36.OrdersManager>(
      () => _i36.OrdersManager(get<_i35.OrderRepository>()));
  gh.factory<_i37.OrdersService>(
      () => _i37.OrdersService(get<_i36.OrdersManager>()));
  gh.factory<_i38.PackageBalanceRepository>(() => _i38.PackageBalanceRepository(
      get<_i26.AuthService>(), get<_i19.ApiClient>()));
  gh.factory<_i39.ProfileRepository>(() =>
      _i39.ProfileRepository(get<_i19.ApiClient>(), get<_i26.AuthService>()));
  gh.factory<_i40.RegisterStateManager>(
      () => _i40.RegisterStateManager(get<_i26.AuthService>()));
  gh.factory<_i41.SplashScreen>(
      () => _i41.SplashScreen(get<_i26.AuthService>()));
  gh.factory<_i42.SubOrdersStateManager>(() => _i42.SubOrdersStateManager(
      get<_i37.OrdersService>(), get<_i26.AuthService>()));
  gh.factory<_i43.AboutManager>(
      () => _i43.AboutManager(get<_i24.AboutRepository>()));
  gh.factory<_i44.AboutService>(
      () => _i44.AboutService(get<_i43.AboutManager>()));
  gh.factory<_i45.CaptainBalanceManager>(
      () => _i45.CaptainBalanceManager(get<_i38.PackageBalanceRepository>()));
  gh.factory<_i46.ChatManager>(
      () => _i46.ChatManager(get<_i27.ChatRepository>()));
  gh.factory<_i47.ChatService>(() => _i47.ChatService(get<_i46.ChatManager>()));
  gh.factory<_i48.ChatStateManager>(
      () => _i48.ChatStateManager(get<_i47.ChatService>()));
  gh.factory<_i49.FireNotificationService>(() => _i49.FireNotificationService(
      get<_i14.NotificationsPrefHelper>(), get<_i34.NotificationRepo>()));
  gh.factory<_i50.ForgotPassScreen>(
      () => _i50.ForgotPassScreen(get<_i29.ForgotPassStateManager>()));
  gh.factory<_i51.InitAccountManager>(
      () => _i51.InitAccountManager(get<_i31.InitAccountRepository>()));
  gh.factory<_i52.InitAccountService>(
      () => _i52.InitAccountService(get<_i51.InitAccountManager>()));
  gh.factory<_i53.InitAccountStateManager>(() => _i53.InitAccountStateManager(
      get<_i52.InitAccountService>(),
      get<_i26.AuthService>(),
      get<_i30.ImageUploadService>()));
  gh.factory<_i54.LoginScreen>(
      () => _i54.LoginScreen(get<_i32.LoginStateManager>()));
  gh.factory<_i55.MyNotificationsManager>(
      () => _i55.MyNotificationsManager(get<_i33.MyNotificationsRepository>()));
  gh.factory<_i56.MyNotificationsService>(
      () => _i56.MyNotificationsService(get<_i55.MyNotificationsManager>()));
  gh.factory<_i57.MyNotificationsStateManager>(() =>
      _i57.MyNotificationsStateManager(get<_i56.MyNotificationsService>(),
          get<_i37.OrdersService>(), get<_i26.AuthService>()));
  gh.factory<_i58.OrderLogsStateManager>(
      () => _i58.OrderLogsStateManager(get<_i37.OrdersService>()));
  gh.factory<_i59.OrderStatusStateManager>(() => _i59.OrderStatusStateManager(
      get<_i37.OrdersService>(), get<_i30.ImageUploadService>()));
  gh.factory<_i60.OrderStatusWithoutActionsStateManager>(() =>
      _i60.OrderStatusWithoutActionsStateManager(
          get<_i37.OrdersService>(), get<_i30.ImageUploadService>()));
  gh.factory<_i61.PlanService>(
      () => _i61.PlanService(get<_i45.CaptainBalanceManager>()));
  gh.factory<_i62.ProfileManager>(
      () => _i62.ProfileManager(get<_i39.ProfileRepository>()));
  gh.factory<_i63.ProfileService>(() => _i63.ProfileService(
      get<_i62.ProfileManager>(), get<_i37.OrdersService>()));
  gh.factory<_i64.RegisterScreen>(
      () => _i64.RegisterScreen(get<_i40.RegisterStateManager>()));
  gh.factory<_i65.SettingsScreen>(() => _i65.SettingsScreen(
      get<_i26.AuthService>(),
      get<_i12.LocalizationService>(),
      get<_i20.AppThemeDataService>(),
      get<_i49.FireNotificationService>()));
  gh.factory<_i66.SplashModule>(
      () => _i66.SplashModule(get<_i41.SplashScreen>()));
  gh.factory<_i67.SubOrdersScreen>(
      () => _i67.SubOrdersScreen(get<_i42.SubOrdersStateManager>()));
  gh.factory<_i68.TermsStateManager>(
      () => _i68.TermsStateManager(get<_i63.ProfileService>()));
  gh.factory<_i69.UpdatesStateManager>(() => _i69.UpdatesStateManager(
      get<_i56.MyNotificationsService>(), get<_i26.AuthService>()));
  gh.factory<_i70.AboutScreenStateManager>(
      () => _i70.AboutScreenStateManager(get<_i44.AboutService>()));
  gh.factory<_i71.AccountBalanceStateManager>(
      () => _i71.AccountBalanceStateManager(get<_i61.PlanService>()));
  gh.factory<_i72.AccountBalanceStateManager>(() =>
      _i72.AccountBalanceStateManager(get<_i63.ProfileService>(),
          get<_i26.AuthService>(), get<_i30.ImageUploadService>()));
  gh.factory<_i73.ActivityStateManager>(() => _i73.ActivityStateManager(
      get<_i63.ProfileService>(), get<_i26.AuthService>()));
  gh.factory<_i74.AuthorizationModule>(() => _i74.AuthorizationModule(
      get<_i54.LoginScreen>(),
      get<_i64.RegisterScreen>(),
      get<_i50.ForgotPassScreen>()));
  gh.factory<_i75.CaptainFinancialDuesStateManager>(
      () => _i75.CaptainFinancialDuesStateManager(get<_i61.PlanService>()));
  gh.factory<_i76.CaptainOrdersListStateManager>(() =>
      _i76.CaptainOrdersListStateManager(
          get<_i37.OrdersService>(), get<_i63.ProfileService>()));
  gh.factory<_i77.CaptainOrdersScreen>(() =>
      _i77.CaptainOrdersScreen(get<_i76.CaptainOrdersListStateManager>()));
  gh.factory<_i78.ChatPage>(() => _i78.ChatPage(
      get<_i48.ChatStateManager>(),
      get<_i30.ImageUploadService>(),
      get<_i26.AuthService>(),
      get<_i7.ChatHiveHelper>()));
  gh.factory<_i79.EditProfileStateManager>(() => _i79.EditProfileStateManager(
      get<_i30.ImageUploadService>(),
      get<_i63.ProfileService>(),
      get<_i26.AuthService>()));
  gh.factory<_i80.InitAccountScreen>(
      () => _i80.InitAccountScreen(get<_i53.InitAccountStateManager>()));
  gh.factory<_i81.MyNotificationsScreen>(() =>
      _i81.MyNotificationsScreen(get<_i57.MyNotificationsStateManager>()));
  gh.factory<_i82.OrderLogsScreen>(
      () => _i82.OrderLogsScreen(get<_i58.OrderLogsStateManager>()));
  gh.factory<_i83.OrderStatusScreen>(
      () => _i83.OrderStatusScreen(get<_i59.OrderStatusStateManager>()));
  gh.factory<_i84.OrderStatusWithoutActionsScreen>(() =>
      _i84.OrderStatusWithoutActionsScreen(
          get<_i60.OrderStatusWithoutActionsStateManager>()));
  gh.factory<_i85.PlanScreenStateManager>(
      () => _i85.PlanScreenStateManager(get<_i61.PlanService>()));
  gh.factory<_i86.SettingsModule>(() => _i86.SettingsModule(
      get<_i65.SettingsScreen>(),
      get<_i22.ChooseLocalScreen>(),
      get<_i15.PrivecyPolicy>(),
      get<_i16.TermsOfUse>()));
  gh.factory<_i87.TermsScreen>(
      () => _i87.TermsScreen(get<_i68.TermsStateManager>()));
  gh.factory<_i88.UpdateScreen>(
      () => _i88.UpdateScreen(get<_i69.UpdatesStateManager>()));
  gh.factory<_i89.AboutScreen>(
      () => _i89.AboutScreen(get<_i70.AboutScreenStateManager>()));
  gh.factory<_i90.AccountBalanceScreen>(
      () => _i90.AccountBalanceScreen(get<_i71.AccountBalanceStateManager>()));
  gh.factory<_i91.AccountBalanceScreen>(
      () => _i91.AccountBalanceScreen(get<_i72.AccountBalanceStateManager>()));
  gh.factory<_i92.ActivityScreen>(
      () => _i92.ActivityScreen(get<_i73.ActivityStateManager>()));
  gh.factory<_i93.CaptainFinancialDuesScreen>(() =>
      _i93.CaptainFinancialDuesScreen(
          get<_i75.CaptainFinancialDuesStateManager>()));
  gh.factory<_i94.ChatModule>(
      () => _i94.ChatModule(get<_i78.ChatPage>(), get<_i26.AuthService>()));
  gh.factory<_i95.EditProfileScreen>(
      () => _i95.EditProfileScreen(get<_i79.EditProfileStateManager>()));
  gh.factory<_i96.InitAccountModule>(
      () => _i96.InitAccountModule(get<_i80.InitAccountScreen>()));
  gh.factory<_i97.MyNotificationsModule>(() => _i97.MyNotificationsModule(
      get<_i81.MyNotificationsScreen>(), get<_i88.UpdateScreen>()));
  gh.factory<_i98.OrdersModule>(() => _i98.OrdersModule(
      get<_i83.OrderStatusScreen>(),
      get<_i77.CaptainOrdersScreen>(),
      get<_i87.TermsScreen>(),
      get<_i67.SubOrdersScreen>(),
      get<_i82.OrderLogsScreen>(),
      get<_i84.OrderStatusWithoutActionsScreen>()));
  gh.factory<_i99.PlanScreen>(
      () => _i99.PlanScreen(get<_i85.PlanScreenStateManager>()));
  gh.factory<_i100.ProfileModule>(() => _i100.ProfileModule(
      get<_i92.ActivityScreen>(),
      get<_i95.EditProfileScreen>(),
      get<_i91.AccountBalanceScreen>()));
  gh.factory<_i101.AboutModule>(
      () => _i101.AboutModule(get<_i89.AboutScreen>()));
  gh.factory<_i102.PlanModule>(() => _i102.PlanModule(
      get<_i99.PlanScreen>(),
      get<_i90.AccountBalanceScreen>(),
      get<_i6.CaptainFinancialDuesDetailsScreen>(),
      get<_i93.CaptainFinancialDuesScreen>()));
  gh.factory<_i103.MyApp>(() => _i103.MyApp(
      get<_i20.AppThemeDataService>(),
      get<_i12.LocalizationService>(),
      get<_i49.FireNotificationService>(),
      get<_i10.LocalNotificationService>(),
      get<_i66.SplashModule>(),
      get<_i74.AuthorizationModule>(),
      get<_i94.ChatModule>(),
      get<_i86.SettingsModule>(),
      get<_i101.AboutModule>(),
      get<_i96.InitAccountModule>(),
      get<_i98.OrdersModule>(),
      get<_i102.PlanModule>(),
      get<_i100.ProfileModule>(),
      get<_i97.MyNotificationsModule>()));
  gh.singleton<_i104.GlobalStateManager>(_i104.GlobalStateManager());
  return get;
}

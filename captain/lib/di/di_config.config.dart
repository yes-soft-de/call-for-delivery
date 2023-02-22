// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:c4d/main.dart' as _i106;
import 'package:c4d/module_about/about_module.dart' as _i104;
import 'package:c4d/module_about/hive/about_hive_helper.dart' as _i3;
import 'package:c4d/module_about/manager/about_manager.dart' as _i44;
import 'package:c4d/module_about/repository/about_repository.dart' as _i25;
import 'package:c4d/module_about/service/about_service/about_service.dart'
    as _i45;
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart'
    as _i71;
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart'
    as _i92;
import 'package:c4d/module_auth/authoriazation_module.dart' as _i75;
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart' as _i26;
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart' as _i5;
import 'package:c4d/module_auth/repository/auth/auth_repository.dart' as _i22;
import 'package:c4d/module_auth/service/auth_service/auth_service.dart' as _i27;
import 'package:c4d/module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i30;
import 'package:c4d/module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i33;
import 'package:c4d/module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i41;
import 'package:c4d/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i51;
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart'
    as _i55;
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart'
    as _i65;
import 'package:c4d/module_chat/chat_module.dart' as _i97;
import 'package:c4d/module_chat/manager/chat/chat_manager.dart' as _i47;
import 'package:c4d/module_chat/presistance/chat_hive_helper.dart' as _i7;
import 'package:c4d/module_chat/repository/chat/chat_repository.dart' as _i28;
import 'package:c4d/module_chat/service/chat/char_service.dart' as _i48;
import 'package:c4d/module_chat/state_manager/chat_state_manager.dart' as _i49;
import 'package:c4d/module_chat/ui/screens/chat_page/chat_page.dart' as _i79;
import 'package:c4d/module_deep_links/repository/deep_link_repository.dart'
    as _i29;
import 'package:c4d/module_init/init_account_module.dart' as _i99;
import 'package:c4d/module_init/manager/init_account/init_account.manager.dart'
    as _i52;
import 'package:c4d/module_init/repository/init_account/init_account.repository.dart'
    as _i32;
import 'package:c4d/module_init/service/init_account/init_account.service.dart'
    as _i53;
import 'package:c4d/module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i54;
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i83;
import 'package:c4d/module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i12;
import 'package:c4d/module_localization/service/localization_service/localization_service.dart'
    as _i13;
import 'package:c4d/module_my_notifications/manager/my_notifications_manager.dart'
    as _i56;
import 'package:c4d/module_my_notifications/my_notifications_module.dart'
    as _i100;
import 'package:c4d/module_my_notifications/repository/my_notifications_repository.dart'
    as _i34;
import 'package:c4d/module_my_notifications/service/my_notification_service.dart'
    as _i57;
import 'package:c4d/module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i58;
import 'package:c4d/module_my_notifications/state_manager/update_state_manager.dart'
    as _i70;
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i84;
import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart'
    as _i91;
import 'package:c4d/module_network/http_client/http_client.dart' as _i20;
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i15;
import 'package:c4d/module_notifications/repository/notification_repo.dart'
    as _i35;
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i50;
import 'package:c4d/module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i11;
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart'
    as _i37;
import 'package:c4d/module_orders/orders_module.dart' as _i101;
import 'package:c4d/module_orders/repository/order_repository/order_repository.dart'
    as _i36;
import 'package:c4d/module_orders/service/orders/orders.service.dart' as _i38;
import 'package:c4d/module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i77;
import 'package:c4d/module_orders/state_manager/order_logs_state_manager.dart'
    as _i59;
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i60;
import 'package:c4d/module_orders/state_manager/order_status/order_status_without_actions_state_manager.dart'
    as _i61;
import 'package:c4d/module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i43;
import 'package:c4d/module_orders/state_manager/terms/terms_state_manager.dart'
    as _i69;
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart'
    as _i78;
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart' as _i85;
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i86;
import 'package:c4d/module_orders/ui/screens/order_status/order_status_without_actions.dart'
    as _i87;
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart' as _i68;
import 'package:c4d/module_orders/ui/screens/terms/terms.dart' as _i90;
import 'package:c4d/module_plan/manager/captain_balance_manager.dart' as _i46;
import 'package:c4d/module_plan/plan_module.dart' as _i105;
import 'package:c4d/module_plan/repository/plan_repository.dart' as _i39;
import 'package:c4d/module_plan/service/plan_service.dart' as _i62;
import 'package:c4d/module_plan/state_manager/account_balance_state_manager.dart'
    as _i73;
import 'package:c4d/module_plan/state_manager/captain_financial_dues_state_manager.dart'
    as _i76;
import 'package:c4d/module_plan/state_manager/daily_payments_state_manager.dart'
    as _i80;
import 'package:c4d/module_plan/state_manager/plan_screen_state_manager.dart'
    as _i88;
import 'package:c4d/module_plan/ui/screen/account_balance_screen.dart' as _i93;
import 'package:c4d/module_plan/ui/screen/captain_financial_details_screen.dart'
    as _i6;
import 'package:c4d/module_plan/ui/screen/captain_financial_dues_screen.dart'
    as _i96;
import 'package:c4d/module_plan/ui/screen/daily_payments_screen.dart' as _i81;
import 'package:c4d/module_plan/ui/screen/plan_screen.dart' as _i102;
import 'package:c4d/module_profile/manager/profile/profile.manager.dart'
    as _i63;
import 'package:c4d/module_profile/module_profile.dart' as _i103;
import 'package:c4d/module_profile/repository/profile/profile.repository.dart'
    as _i40;
import 'package:c4d/module_profile/service/profile/profile.service.dart'
    as _i64;
import 'package:c4d/module_profile/state_manager/account_balance_state_manager.dart'
    as _i72;
import 'package:c4d/module_profile/state_manager/activity/activity_state_manager.dart'
    as _i74;
import 'package:c4d/module_profile/state_manager/edit_profile/edit_profile.dart'
    as _i82;
import 'package:c4d/module_profile/ui/screen/account_balance_screen.dart'
    as _i94;
import 'package:c4d/module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i95;
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart'
    as _i98;
import 'package:c4d/module_settings/settings_module.dart' as _i89;
import 'package:c4d/module_settings/ui/screen/about.dart' as _i4;
import 'package:c4d/module_settings/ui/screen/privecy_policy.dart' as _i16;
import 'package:c4d/module_settings/ui/screen/terms_of_use.dart' as _i17;
import 'package:c4d/module_settings/ui/settings_page/choose_local_page.dart'
    as _i23;
import 'package:c4d/module_settings/ui/settings_page/settings_page.dart'
    as _i66;
import 'package:c4d/module_splash/splash_module.dart' as _i67;
import 'package:c4d/module_splash/ui/screen/splash_screen.dart' as _i42;
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart'
    as _i18;
import 'package:c4d/module_theme/service/theme_service/theme_service.dart'
    as _i21;
import 'package:c4d/module_upload/manager/upload_manager/upload_manager.dart'
    as _i24;
import 'package:c4d/module_upload/repository/upload_repository/upload_repository.dart'
    as _i19;
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart'
    as _i31;
import 'package:c4d/utils/global/global_state_manager.dart' as _i10;
import 'package:c4d/utils/helpers/firestore_helper.dart' as _i8;
import 'package:c4d/utils/helpers/text_reader.dart' as _i9;
import 'package:c4d/utils/logger/logger.dart' as _i14;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt getIt,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(getIt, environment, environmentFilter);
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
  gh.factory<_i13.LocalizationService>(
      () => _i13.LocalizationService(gh<_i12.LocalizationPreferencesHelper>()));
  gh.factory<_i14.Logger>(() => _i14.Logger());
  gh.factory<_i15.NotificationsPrefHelper>(
      () => _i15.NotificationsPrefHelper());
  gh.factory<_i16.PrivecyPolicy>(() => _i16.PrivecyPolicy());
  gh.factory<_i17.TermsOfUse>(() => _i17.TermsOfUse());
  gh.factory<_i18.ThemePreferencesHelper>(() => _i18.ThemePreferencesHelper());
  gh.factory<_i19.UploadRepository>(() => _i19.UploadRepository());
  gh.factory<_i20.ApiClient>(() => _i20.ApiClient(gh<_i14.Logger>()));
  gh.factory<_i21.AppThemeDataService>(
      () => _i21.AppThemeDataService(gh<_i18.ThemePreferencesHelper>()));
  gh.factory<_i22.AuthRepository>(
      () => _i22.AuthRepository(gh<_i20.ApiClient>(), gh<_i14.Logger>()));
  gh.factory<_i23.ChooseLocalScreen>(
      () => _i23.ChooseLocalScreen(gh<_i13.LocalizationService>()));
  gh.factory<_i24.UploadManager>(
      () => _i24.UploadManager(gh<_i19.UploadRepository>()));
  gh.factory<_i25.AboutRepository>(
      () => _i25.AboutRepository(gh<_i20.ApiClient>()));
  gh.factory<_i26.AuthManager>(
      () => _i26.AuthManager(gh<_i22.AuthRepository>()));
  gh.factory<_i27.AuthService>(() =>
      _i27.AuthService(gh<_i5.AuthPrefsHelper>(), gh<_i26.AuthManager>()));
  gh.factory<_i28.ChatRepository>(
      () => _i28.ChatRepository(gh<_i20.ApiClient>(), gh<_i27.AuthService>()));
  gh.factory<_i29.DeepLinkRepository>(() =>
      _i29.DeepLinkRepository(gh<_i20.ApiClient>(), gh<_i27.AuthService>()));
  gh.factory<_i30.ForgotPassStateManager>(
      () => _i30.ForgotPassStateManager(gh<_i27.AuthService>()));
  gh.factory<_i31.ImageUploadService>(
      () => _i31.ImageUploadService(gh<_i24.UploadManager>()));
  gh.factory<_i32.InitAccountRepository>(() =>
      _i32.InitAccountRepository(gh<_i20.ApiClient>(), gh<_i27.AuthService>()));
  gh.factory<_i33.LoginStateManager>(
      () => _i33.LoginStateManager(gh<_i27.AuthService>()));
  gh.factory<_i34.MyNotificationsRepository>(() =>
      _i34.MyNotificationsRepository(
          gh<_i20.ApiClient>(), gh<_i27.AuthService>()));
  gh.factory<_i35.NotificationRepo>(() =>
      _i35.NotificationRepo(gh<_i20.ApiClient>(), gh<_i27.AuthService>()));
  gh.factory<_i36.OrderRepository>(
      () => _i36.OrderRepository(gh<_i20.ApiClient>(), gh<_i27.AuthService>()));
  gh.factory<_i37.OrdersManager>(
      () => _i37.OrdersManager(gh<_i36.OrderRepository>()));
  gh.factory<_i38.OrdersService>(
      () => _i38.OrdersService(gh<_i37.OrdersManager>()));
  gh.factory<_i39.PackageBalanceRepository>(() => _i39.PackageBalanceRepository(
      gh<_i27.AuthService>(), gh<_i20.ApiClient>()));
  gh.factory<_i40.ProfileRepository>(() =>
      _i40.ProfileRepository(gh<_i20.ApiClient>(), gh<_i27.AuthService>()));
  gh.factory<_i41.RegisterStateManager>(
      () => _i41.RegisterStateManager(gh<_i27.AuthService>()));
  gh.factory<_i42.SplashScreen>(
      () => _i42.SplashScreen(gh<_i27.AuthService>()));
  gh.factory<_i43.SubOrdersStateManager>(() => _i43.SubOrdersStateManager(
      gh<_i38.OrdersService>(), gh<_i27.AuthService>()));
  gh.factory<_i44.AboutManager>(
      () => _i44.AboutManager(gh<_i25.AboutRepository>()));
  gh.factory<_i45.AboutService>(
      () => _i45.AboutService(gh<_i44.AboutManager>()));
  gh.factory<_i46.CaptainBalanceManager>(
      () => _i46.CaptainBalanceManager(gh<_i39.PackageBalanceRepository>()));
  gh.factory<_i47.ChatManager>(
      () => _i47.ChatManager(gh<_i28.ChatRepository>()));
  gh.factory<_i48.ChatService>(() => _i48.ChatService(gh<_i47.ChatManager>()));
  gh.factory<_i49.ChatStateManager>(
      () => _i49.ChatStateManager(gh<_i48.ChatService>()));
  gh.factory<_i50.FireNotificationService>(() => _i50.FireNotificationService(
      gh<_i15.NotificationsPrefHelper>(), gh<_i35.NotificationRepo>()));
  gh.factory<_i51.ForgotPassScreen>(
      () => _i51.ForgotPassScreen(gh<_i30.ForgotPassStateManager>()));
  gh.factory<_i52.InitAccountManager>(
      () => _i52.InitAccountManager(gh<_i32.InitAccountRepository>()));
  gh.factory<_i53.InitAccountService>(
      () => _i53.InitAccountService(gh<_i52.InitAccountManager>()));
  gh.factory<_i54.InitAccountStateManager>(() => _i54.InitAccountStateManager(
      gh<_i53.InitAccountService>(),
      gh<_i27.AuthService>(),
      gh<_i31.ImageUploadService>()));
  gh.factory<_i55.LoginScreen>(
      () => _i55.LoginScreen(gh<_i33.LoginStateManager>()));
  gh.factory<_i56.MyNotificationsManager>(
      () => _i56.MyNotificationsManager(gh<_i34.MyNotificationsRepository>()));
  gh.factory<_i57.MyNotificationsService>(
      () => _i57.MyNotificationsService(gh<_i56.MyNotificationsManager>()));
  gh.factory<_i58.MyNotificationsStateManager>(() =>
      _i58.MyNotificationsStateManager(gh<_i57.MyNotificationsService>(),
          gh<_i38.OrdersService>(), gh<_i27.AuthService>()));
  gh.factory<_i59.OrderLogsStateManager>(
      () => _i59.OrderLogsStateManager(gh<_i38.OrdersService>()));
  gh.factory<_i60.OrderStatusStateManager>(() => _i60.OrderStatusStateManager(
      gh<_i38.OrdersService>(), gh<_i31.ImageUploadService>()));
  gh.factory<_i61.OrderStatusWithoutActionsStateManager>(() =>
      _i61.OrderStatusWithoutActionsStateManager(
          gh<_i38.OrdersService>(), gh<_i31.ImageUploadService>()));
  gh.factory<_i62.PlanService>(
      () => _i62.PlanService(gh<_i46.CaptainBalanceManager>()));
  gh.factory<_i63.ProfileManager>(
      () => _i63.ProfileManager(gh<_i40.ProfileRepository>()));
  gh.factory<_i64.ProfileService>(() =>
      _i64.ProfileService(gh<_i63.ProfileManager>(), gh<_i38.OrdersService>()));
  gh.factory<_i65.RegisterScreen>(
      () => _i65.RegisterScreen(gh<_i41.RegisterStateManager>()));
  gh.factory<_i66.SettingsScreen>(() => _i66.SettingsScreen(
      gh<_i27.AuthService>(),
      gh<_i13.LocalizationService>(),
      gh<_i21.AppThemeDataService>(),
      gh<_i50.FireNotificationService>()));
  gh.factory<_i67.SplashModule>(
      () => _i67.SplashModule(gh<_i42.SplashScreen>()));
  gh.factory<_i68.SubOrdersScreen>(
      () => _i68.SubOrdersScreen(gh<_i43.SubOrdersStateManager>()));
  gh.factory<_i69.TermsStateManager>(
      () => _i69.TermsStateManager(gh<_i64.ProfileService>()));
  gh.factory<_i70.UpdatesStateManager>(() => _i70.UpdatesStateManager(
      gh<_i57.MyNotificationsService>(), gh<_i27.AuthService>()));
  gh.factory<_i71.AboutScreenStateManager>(
      () => _i71.AboutScreenStateManager(gh<_i45.AboutService>()));
  gh.factory<_i72.AccountBalanceStateManager>(() =>
      _i72.AccountBalanceStateManager(gh<_i64.ProfileService>(),
          gh<_i27.AuthService>(), gh<_i31.ImageUploadService>()));
  gh.factory<_i73.AccountBalanceStateManager>(
      () => _i73.AccountBalanceStateManager(gh<_i62.PlanService>()));
  gh.factory<_i74.ActivityStateManager>(() => _i74.ActivityStateManager(
      gh<_i64.ProfileService>(), gh<_i27.AuthService>()));
  gh.factory<_i75.AuthorizationModule>(() => _i75.AuthorizationModule(
      gh<_i55.LoginScreen>(),
      gh<_i65.RegisterScreen>(),
      gh<_i51.ForgotPassScreen>()));
  gh.factory<_i76.CaptainFinancialDuesStateManager>(
      () => _i76.CaptainFinancialDuesStateManager(gh<_i62.PlanService>()));
  gh.factory<_i77.CaptainOrdersListStateManager>(() =>
      _i77.CaptainOrdersListStateManager(
          gh<_i38.OrdersService>(), gh<_i64.ProfileService>()));
  gh.factory<_i78.CaptainOrdersScreen>(
      () => _i78.CaptainOrdersScreen(gh<_i77.CaptainOrdersListStateManager>()));
  gh.factory<_i79.ChatPage>(() => _i79.ChatPage(
      gh<_i49.ChatStateManager>(),
      gh<_i31.ImageUploadService>(),
      gh<_i27.AuthService>(),
      gh<_i7.ChatHiveHelper>()));
  gh.factory<_i80.DailyBalanceStateManager>(() => _i80.DailyBalanceStateManager(
      gh<_i64.ProfileService>(),
      gh<_i27.AuthService>(),
      gh<_i31.ImageUploadService>()));
  gh.factory<_i81.DailyPaymentsScreen>(
      () => _i81.DailyPaymentsScreen(gh<_i80.DailyBalanceStateManager>()));
  gh.factory<_i82.EditProfileStateManager>(() => _i82.EditProfileStateManager(
      gh<_i31.ImageUploadService>(),
      gh<_i64.ProfileService>(),
      gh<_i27.AuthService>()));
  gh.factory<_i83.InitAccountScreen>(
      () => _i83.InitAccountScreen(gh<_i54.InitAccountStateManager>()));
  gh.factory<_i84.MyNotificationsScreen>(
      () => _i84.MyNotificationsScreen(gh<_i58.MyNotificationsStateManager>()));
  gh.factory<_i85.OrderLogsScreen>(
      () => _i85.OrderLogsScreen(gh<_i59.OrderLogsStateManager>()));
  gh.factory<_i86.OrderStatusScreen>(
      () => _i86.OrderStatusScreen(gh<_i60.OrderStatusStateManager>()));
  gh.factory<_i87.OrderStatusWithoutActionsScreen>(() =>
      _i87.OrderStatusWithoutActionsScreen(
          gh<_i61.OrderStatusWithoutActionsStateManager>()));
  gh.factory<_i88.PlanScreenStateManager>(
      () => _i88.PlanScreenStateManager(gh<_i62.PlanService>()));
  gh.factory<_i89.SettingsModule>(() => _i89.SettingsModule(
      gh<_i66.SettingsScreen>(),
      gh<_i23.ChooseLocalScreen>(),
      gh<_i16.PrivecyPolicy>(),
      gh<_i17.TermsOfUse>()));
  gh.factory<_i90.TermsScreen>(
      () => _i90.TermsScreen(gh<_i69.TermsStateManager>()));
  gh.factory<_i91.UpdateScreen>(
      () => _i91.UpdateScreen(gh<_i70.UpdatesStateManager>()));
  gh.factory<_i92.AboutScreen>(
      () => _i92.AboutScreen(gh<_i71.AboutScreenStateManager>()));
  gh.factory<_i93.AccountBalanceScreen>(
      () => _i93.AccountBalanceScreen(gh<_i73.AccountBalanceStateManager>()));
  gh.factory<_i94.AccountBalanceScreen>(
      () => _i94.AccountBalanceScreen(gh<_i72.AccountBalanceStateManager>()));
  gh.factory<_i95.ActivityScreen>(
      () => _i95.ActivityScreen(gh<_i74.ActivityStateManager>()));
  gh.factory<_i96.CaptainFinancialDuesScreen>(() =>
      _i96.CaptainFinancialDuesScreen(
          gh<_i76.CaptainFinancialDuesStateManager>()));
  gh.factory<_i97.ChatModule>(
      () => _i97.ChatModule(gh<_i79.ChatPage>(), gh<_i27.AuthService>()));
  gh.factory<_i98.EditProfileScreen>(
      () => _i98.EditProfileScreen(gh<_i82.EditProfileStateManager>()));
  gh.factory<_i99.InitAccountModule>(
      () => _i99.InitAccountModule(gh<_i83.InitAccountScreen>()));
  gh.factory<_i100.MyNotificationsModule>(() => _i100.MyNotificationsModule(
      gh<_i84.MyNotificationsScreen>(), gh<_i91.UpdateScreen>()));
  gh.factory<_i101.OrdersModule>(() => _i101.OrdersModule(
      gh<_i86.OrderStatusScreen>(),
      gh<_i78.CaptainOrdersScreen>(),
      gh<_i90.TermsScreen>(),
      gh<_i68.SubOrdersScreen>(),
      gh<_i85.OrderLogsScreen>(),
      gh<_i87.OrderStatusWithoutActionsScreen>()));
  gh.factory<_i102.PlanScreen>(
      () => _i102.PlanScreen(gh<_i88.PlanScreenStateManager>()));
  gh.factory<_i103.ProfileModule>(() => _i103.ProfileModule(
      gh<_i95.ActivityScreen>(),
      gh<_i98.EditProfileScreen>(),
      gh<_i94.AccountBalanceScreen>()));
  gh.factory<_i104.AboutModule>(
      () => _i104.AboutModule(gh<_i92.AboutScreen>()));
  gh.factory<_i105.PlanModule>(() => _i105.PlanModule(
      gh<_i102.PlanScreen>(),
      gh<_i93.AccountBalanceScreen>(),
      gh<_i6.CaptainFinancialDuesDetailsScreen>(),
      gh<_i96.CaptainFinancialDuesScreen>(),
      gh<_i81.DailyPaymentsScreen>()));
  gh.factory<_i106.MyApp>(() => _i106.MyApp(
      gh<_i21.AppThemeDataService>(),
      gh<_i13.LocalizationService>(),
      gh<_i50.FireNotificationService>(),
      gh<_i11.LocalNotificationService>(),
      gh<_i67.SplashModule>(),
      gh<_i75.AuthorizationModule>(),
      gh<_i97.ChatModule>(),
      gh<_i89.SettingsModule>(),
      gh<_i104.AboutModule>(),
      gh<_i99.InitAccountModule>(),
      gh<_i101.OrdersModule>(),
      gh<_i105.PlanModule>(),
      gh<_i103.ProfileModule>(),
      gh<_i100.MyNotificationsModule>()));
  return getIt;
}

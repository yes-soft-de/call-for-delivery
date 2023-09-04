// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i104;
import '../module_about/about_module.dart' as _i95;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i31;
import '../module_about/repository/about_repository.dart' as _i26;
import '../module_about/service/about_service/about_service.dart' as _i32;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i51;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i77;
import '../module_auth/authoriazation_module.dart' as _i81;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i33;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i6;
import '../module_auth/repository/auth/auth_repository.dart' as _i28;
import '../module_auth/service/auth_service/auth_service.dart' as _i34;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i37;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i40;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i48;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i58;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i62;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i72;
import '../module_chat/chat_module.dart' as _i98;
import '../module_chat/manager/chat/chat_manager.dart' as _i53;
import '../module_chat/presistance/chat_hive_helper.dart' as _i8;
import '../module_chat/repository/chat/chat_repository.dart' as _i35;
import '../module_chat/service/chat/char_service.dart' as _i54;
import '../module_chat/state_manager/chat_state_manager.dart' as _i55;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i84;
import '../module_deep_links/manager/deep_link_manager.dart' as _i56;
import '../module_deep_links/repository/deep_link_local_repository.dart' as _i9;
import '../module_deep_links/repository/deep_link_repository.dart' as _i36;
import '../module_deep_links/service/deep_links_service.dart' as _i10;
import '../module_init/init_account_module.dart' as _i100;
import '../module_init/manager/init_account/init_account.manager.dart' as _i59;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i39;
import '../module_init/service/init_account/init_account.service.dart' as _i60;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i61;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i88;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i15;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i16;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i63;
import '../module_my_notifications/my_notifications_module.dart' as _i101;
import '../module_my_notifications/presistance/my_notification_hive_helper.dart'
    as _i18;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i41;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i64;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i65;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i76;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i89;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i94;
import '../module_network/http_client/http_client.dart' as _i5;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i19;
import '../module_notifications/repository/notification_repo.dart' as _i42;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i57;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i14;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i44;
import '../module_orders/orders_module.dart' as _i20;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i43;
import '../module_orders/service/orders/orders.service.dart' as _i45;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i83;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i66;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i67;
import '../module_orders/state_manager/order_status/order_status_without_actions_state_manager.dart'
    as _i68;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i50;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i75;
import '../module_plan/manager/captain_balance_manager.dart' as _i52;
import '../module_plan/plan_module.dart' as _i21;
import '../module_plan/repository/plan_repository.dart' as _i46;
import '../module_plan/service/plan_service.dart' as _i69;
import '../module_plan/state_manager/account_balance_state_manager.dart'
    as _i78;
import '../module_plan/state_manager/captain_financial_dues_state_manager.dart'
    as _i82;
import '../module_plan/state_manager/daily_payments_state_manager.dart' as _i85;
import '../module_plan/state_manager/my_profits_state_manager.dart' as _i90;
import '../module_plan/state_manager/payment_history_state_manager.dart'
    as _i91;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i92;
import '../module_plan/ui/screen/captain_financial_details_screen.dart' as _i7;
import '../module_plan/ui/screen/daily_payments_screen.dart' as _i86;
import '../module_plan/ui/screen/plan_screen.dart' as _i102;
import '../module_profile/manager/profile/profile.manager.dart' as _i70;
import '../module_profile/module_profile.dart' as _i103;
import '../module_profile/repository/profile/profile.repository.dart' as _i47;
import '../module_profile/service/profile/profile.service.dart' as _i71;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i79;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i80;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i87;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i96;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i97;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i99;
import '../module_settings/settings_module.dart' as _i93;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i22;
import '../module_settings/ui/screen/terms_of_use.dart' as _i23;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i29;
import '../module_settings/ui/settings_page/settings_page.dart' as _i73;
import '../module_splash/splash_module.dart' as _i74;
import '../module_splash/ui/screen/splash_screen.dart' as _i49;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i24;
import '../module_theme/service/theme_service/theme_service.dart' as _i27;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i30;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i25;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i38;
import '../utils/global/global_state_manager.dart' as _i13;
import '../utils/helpers/firestore_helper.dart' as _i11;
import '../utils/helpers/text_reader.dart' as _i12;
import '../utils/logger/logger.dart' as _i17;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AboutHiveHelper>(() => _i3.AboutHiveHelper());
  gh.factory<_i4.AboutScreen>(() => _i4.AboutScreen());
  gh.factory<_i5.ApiClient>(() => _i5.ApiClient());
  gh.factory<_i6.AuthPrefsHelper>(() => _i6.AuthPrefsHelper());
  gh.factory<_i7.CaptainFinancialDuesDetailsScreen>(
      () => _i7.CaptainFinancialDuesDetailsScreen());
  gh.factory<_i8.ChatHiveHelper>(() => _i8.ChatHiveHelper());
  gh.factory<_i9.DeepLinkLocalRepository>(() => _i9.DeepLinkLocalRepository());
  gh.factory<_i10.DeepLinksService>(() => _i10.DeepLinksService());
  gh.factory<_i11.FireStoreHelper>(() => _i11.FireStoreHelper());
  gh.factory<_i12.FlutterTextToSpeech>(() => _i12.FlutterTextToSpeech());
  gh.singleton<_i13.GlobalStateManager>(_i13.GlobalStateManager());
  gh.factory<_i14.LocalNotificationService>(
      () => _i14.LocalNotificationService());
  gh.factory<_i15.LocalizationPreferencesHelper>(
      () => _i15.LocalizationPreferencesHelper());
  gh.factory<_i16.LocalizationService>(
      () => _i16.LocalizationService(gh<_i15.LocalizationPreferencesHelper>()));
  gh.factory<_i17.Logger>(() => _i17.Logger());
  gh.factory<_i18.MyNotificationHiveHelper>(
      () => _i18.MyNotificationHiveHelper());
  gh.factory<_i19.NotificationsPrefHelper>(
      () => _i19.NotificationsPrefHelper());
  gh.factory<_i20.OrdersModule>(() => _i20.OrdersModule());
  gh.factory<_i21.PlanModule>(() => _i21.PlanModule());
  gh.factory<_i22.PrivecyPolicy>(() => _i22.PrivecyPolicy());
  gh.factory<_i23.TermsOfUse>(() => _i23.TermsOfUse());
  gh.factory<_i24.ThemePreferencesHelper>(() => _i24.ThemePreferencesHelper());
  gh.factory<_i25.UploadRepository>(() => _i25.UploadRepository());
  gh.factory<_i26.AboutRepository>(
      () => _i26.AboutRepository(gh<_i5.ApiClient>()));
  gh.factory<_i27.AppThemeDataService>(
      () => _i27.AppThemeDataService(gh<_i24.ThemePreferencesHelper>()));
  gh.factory<_i28.AuthRepository>(() => _i28.AuthRepository(
        gh<_i5.ApiClient>(),
        gh<_i17.Logger>(),
      ));
  gh.factory<_i29.ChooseLocalScreen>(
      () => _i29.ChooseLocalScreen(gh<_i16.LocalizationService>()));
  gh.factory<_i30.UploadManager>(
      () => _i30.UploadManager(gh<_i25.UploadRepository>()));
  gh.factory<_i31.AboutManager>(
      () => _i31.AboutManager(gh<_i26.AboutRepository>()));
  gh.factory<_i32.AboutService>(
      () => _i32.AboutService(gh<_i31.AboutManager>()));
  gh.factory<_i33.AuthManager>(
      () => _i33.AuthManager(gh<_i28.AuthRepository>()));
  gh.factory<_i34.AuthService>(() => _i34.AuthService(
        gh<_i6.AuthPrefsHelper>(),
        gh<_i33.AuthManager>(),
      ));
  gh.factory<_i35.ChatRepository>(() => _i35.ChatRepository(
        gh<_i5.ApiClient>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i36.DeepLinkRepository>(() => _i36.DeepLinkRepository(
        gh<_i5.ApiClient>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i37.ForgotPassStateManager>(
      () => _i37.ForgotPassStateManager(gh<_i34.AuthService>()));
  gh.factory<_i38.ImageUploadService>(
      () => _i38.ImageUploadService(gh<_i30.UploadManager>()));
  gh.factory<_i39.InitAccountRepository>(() => _i39.InitAccountRepository(
        gh<_i5.ApiClient>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i40.LoginStateManager>(
      () => _i40.LoginStateManager(gh<_i34.AuthService>()));
  gh.factory<_i41.MyNotificationsRepository>(
      () => _i41.MyNotificationsRepository(
            gh<_i5.ApiClient>(),
            gh<_i34.AuthService>(),
          ));
  gh.factory<_i42.NotificationRepo>(() => _i42.NotificationRepo(
        gh<_i5.ApiClient>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i43.OrderRepository>(() => _i43.OrderRepository(
        gh<_i5.ApiClient>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i44.OrdersManager>(
      () => _i44.OrdersManager(gh<_i43.OrderRepository>()));
  gh.factory<_i45.OrdersService>(
      () => _i45.OrdersService(gh<_i44.OrdersManager>()));
  gh.factory<_i46.PackageBalanceRepository>(() => _i46.PackageBalanceRepository(
        gh<_i34.AuthService>(),
        gh<_i5.ApiClient>(),
      ));
  gh.factory<_i47.ProfileRepository>(() => _i47.ProfileRepository(
        gh<_i5.ApiClient>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i48.RegisterStateManager>(
      () => _i48.RegisterStateManager(gh<_i34.AuthService>()));
  gh.factory<_i49.SplashScreen>(
      () => _i49.SplashScreen(gh<_i34.AuthService>()));
  gh.factory<_i50.SubOrdersStateManager>(() => _i50.SubOrdersStateManager(
        gh<_i45.OrdersService>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i51.AboutScreenStateManager>(
      () => _i51.AboutScreenStateManager(gh<_i32.AboutService>()));
  gh.factory<_i52.CaptainBalanceManager>(
      () => _i52.CaptainBalanceManager(gh<_i46.PackageBalanceRepository>()));
  gh.factory<_i53.ChatManager>(
      () => _i53.ChatManager(gh<_i35.ChatRepository>()));
  gh.factory<_i54.ChatService>(() => _i54.ChatService(gh<_i53.ChatManager>()));
  gh.factory<_i55.ChatStateManager>(
      () => _i55.ChatStateManager(gh<_i54.ChatService>()));
  gh.factory<_i56.DeepLinkManager>(() => _i56.DeepLinkManager(
        gh<_i36.DeepLinkRepository>(),
        gh<_i9.DeepLinkLocalRepository>(),
      ));
  gh.factory<_i57.FireNotificationService>(() => _i57.FireNotificationService(
        gh<_i19.NotificationsPrefHelper>(),
        gh<_i42.NotificationRepo>(),
      ));
  gh.factory<_i58.ForgotPassScreen>(
      () => _i58.ForgotPassScreen(gh<_i37.ForgotPassStateManager>()));
  gh.factory<_i59.InitAccountManager>(
      () => _i59.InitAccountManager(gh<_i39.InitAccountRepository>()));
  gh.factory<_i60.InitAccountService>(
      () => _i60.InitAccountService(gh<_i59.InitAccountManager>()));
  gh.factory<_i61.InitAccountStateManager>(() => _i61.InitAccountStateManager(
        gh<_i60.InitAccountService>(),
        gh<_i34.AuthService>(),
        gh<_i38.ImageUploadService>(),
      ));
  gh.factory<_i62.LoginScreen>(
      () => _i62.LoginScreen(gh<_i40.LoginStateManager>()));
  gh.factory<_i63.MyNotificationsManager>(
      () => _i63.MyNotificationsManager(gh<_i41.MyNotificationsRepository>()));
  gh.factory<_i64.MyNotificationsService>(
      () => _i64.MyNotificationsService(gh<_i63.MyNotificationsManager>()));
  gh.factory<_i65.MyNotificationsStateManager>(
      () => _i65.MyNotificationsStateManager(
            gh<_i64.MyNotificationsService>(),
            gh<_i45.OrdersService>(),
            gh<_i34.AuthService>(),
          ));
  gh.factory<_i66.OrderLogsStateManager>(
      () => _i66.OrderLogsStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i67.OrderStatusStateManager>(
      () => _i67.OrderStatusStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i68.OrderStatusWithoutActionsStateManager>(() =>
      _i68.OrderStatusWithoutActionsStateManager(gh<_i45.OrdersService>()));
  gh.factory<_i69.PlanService>(
      () => _i69.PlanService(gh<_i52.CaptainBalanceManager>()));
  gh.factory<_i70.ProfileManager>(
      () => _i70.ProfileManager(gh<_i47.ProfileRepository>()));
  gh.factory<_i71.ProfileService>(() => _i71.ProfileService(
        gh<_i70.ProfileManager>(),
        gh<_i45.OrdersService>(),
      ));
  gh.factory<_i72.RegisterScreen>(
      () => _i72.RegisterScreen(gh<_i48.RegisterStateManager>()));
  gh.factory<_i73.SettingsScreen>(() => _i73.SettingsScreen(
        gh<_i34.AuthService>(),
        gh<_i16.LocalizationService>(),
        gh<_i27.AppThemeDataService>(),
        gh<_i57.FireNotificationService>(),
      ));
  gh.factory<_i74.SplashModule>(
      () => _i74.SplashModule(gh<_i49.SplashScreen>()));
  gh.factory<_i75.TermsStateManager>(
      () => _i75.TermsStateManager(gh<_i71.ProfileService>()));
  gh.factory<_i76.UpdatesStateManager>(() => _i76.UpdatesStateManager(
        gh<_i64.MyNotificationsService>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i77.AboutScreen>(
      () => _i77.AboutScreen(gh<_i51.AboutScreenStateManager>()));
  gh.factory<_i78.AccountBalanceStateManager>(
      () => _i78.AccountBalanceStateManager(gh<_i69.PlanService>()));
  gh.factory<_i79.AccountBalanceStateManager>(
      () => _i79.AccountBalanceStateManager(
            gh<_i71.ProfileService>(),
            gh<_i34.AuthService>(),
            gh<_i38.ImageUploadService>(),
          ));
  gh.factory<_i80.ActivityStateManager>(() => _i80.ActivityStateManager(
        gh<_i71.ProfileService>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i81.AuthorizationModule>(() => _i81.AuthorizationModule(
        gh<_i62.LoginScreen>(),
        gh<_i72.RegisterScreen>(),
        gh<_i58.ForgotPassScreen>(),
      ));
  gh.factory<_i82.CaptainFinancialDuesStateManager>(
      () => _i82.CaptainFinancialDuesStateManager(gh<_i69.PlanService>()));
  gh.factory<_i83.CaptainOrdersListStateManager>(
      () => _i83.CaptainOrdersListStateManager(
            gh<_i45.OrdersService>(),
            gh<_i71.ProfileService>(),
          ));
  gh.factory<_i84.ChatPage>(() => _i84.ChatPage(
        gh<_i55.ChatStateManager>(),
        gh<_i38.ImageUploadService>(),
        gh<_i34.AuthService>(),
        gh<_i8.ChatHiveHelper>(),
      ));
  gh.factory<_i85.DailyBalanceStateManager>(() => _i85.DailyBalanceStateManager(
        gh<_i71.ProfileService>(),
        gh<_i34.AuthService>(),
        gh<_i38.ImageUploadService>(),
      ));
  gh.factory<_i86.DailyPaymentsScreen>(
      () => _i86.DailyPaymentsScreen(gh<_i85.DailyBalanceStateManager>()));
  gh.factory<_i87.EditProfileStateManager>(() => _i87.EditProfileStateManager(
        gh<_i38.ImageUploadService>(),
        gh<_i71.ProfileService>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i88.InitAccountScreen>(
      () => _i88.InitAccountScreen(gh<_i61.InitAccountStateManager>()));
  gh.factory<_i89.MyNotificationsScreen>(
      () => _i89.MyNotificationsScreen(gh<_i65.MyNotificationsStateManager>()));
  gh.factory<_i90.MyProfitsStateManager>(
      () => _i90.MyProfitsStateManager(gh<_i69.PlanService>()));
  gh.factory<_i91.PaymentHistoryStateManager>(
      () => _i91.PaymentHistoryStateManager(gh<_i69.PlanService>()));
  gh.factory<_i92.PlanScreenStateManager>(
      () => _i92.PlanScreenStateManager(gh<_i69.PlanService>()));
  gh.factory<_i93.SettingsModule>(() => _i93.SettingsModule(
        gh<_i73.SettingsScreen>(),
        gh<_i29.ChooseLocalScreen>(),
        gh<_i22.PrivecyPolicy>(),
        gh<_i23.TermsOfUse>(),
      ));
  gh.factory<_i94.UpdateScreen>(
      () => _i94.UpdateScreen(gh<_i76.UpdatesStateManager>()));
  gh.factory<_i95.AboutModule>(() => _i95.AboutModule(gh<_i77.AboutScreen>()));
  gh.factory<_i96.AccountBalanceScreen>(
      () => _i96.AccountBalanceScreen(gh<_i79.AccountBalanceStateManager>()));
  gh.factory<_i97.ActivityScreen>(
      () => _i97.ActivityScreen(gh<_i80.ActivityStateManager>()));
  gh.factory<_i98.ChatModule>(() => _i98.ChatModule(
        gh<_i84.ChatPage>(),
        gh<_i34.AuthService>(),
      ));
  gh.factory<_i99.EditProfileScreen>(
      () => _i99.EditProfileScreen(gh<_i87.EditProfileStateManager>()));
  gh.factory<_i100.InitAccountModule>(
      () => _i100.InitAccountModule(gh<_i88.InitAccountScreen>()));
  gh.factory<_i101.MyNotificationsModule>(() => _i101.MyNotificationsModule(
        gh<_i89.MyNotificationsScreen>(),
        gh<_i94.UpdateScreen>(),
      ));
  gh.factory<_i102.PlanScreen>(
      () => _i102.PlanScreen(gh<_i92.PlanScreenStateManager>()));
  gh.factory<_i103.ProfileModule>(() => _i103.ProfileModule(
        gh<_i97.ActivityScreen>(),
        gh<_i99.EditProfileScreen>(),
        gh<_i96.AccountBalanceScreen>(),
      ));
  gh.factory<_i104.MyApp>(() => _i104.MyApp(
        gh<_i27.AppThemeDataService>(),
        gh<_i16.LocalizationService>(),
        gh<_i57.FireNotificationService>(),
        gh<_i14.LocalNotificationService>(),
        gh<_i74.SplashModule>(),
        gh<_i81.AuthorizationModule>(),
        gh<_i98.ChatModule>(),
        gh<_i93.SettingsModule>(),
        gh<_i95.AboutModule>(),
        gh<_i100.InitAccountModule>(),
        gh<_i20.OrdersModule>(),
        gh<_i21.PlanModule>(),
        gh<_i103.ProfileModule>(),
        gh<_i101.MyNotificationsModule>(),
      ));
  return getIt;
}

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

import '../main.dart' as _i97;
import '../module_about/about_module.dart' as _i94;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i34;
import '../module_about/repository/about_repository.dart' as _i29;
import '../module_about/service/about_service/about_service.dart' as _i35;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i54;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i80;
import '../module_auth/authoriazation_module.dart' as _i82;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i36;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i7;
import '../module_auth/repository/auth/auth_repository.dart' as _i31;
import '../module_auth/service/auth_service/auth_service.dart' as _i37;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i40;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i43;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i51;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i61;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i65;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i75;
import '../module_chat/chat_module.dart' as _i95;
import '../module_chat/manager/chat/chat_manager.dart' as _i56;
import '../module_chat/presistance/chat_hive_helper.dart' as _i9;
import '../module_chat/repository/chat/chat_repository.dart' as _i38;
import '../module_chat/service/chat/char_service.dart' as _i57;
import '../module_chat/state_manager/chat_state_manager.dart' as _i58;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i85;
import '../module_deep_links/manager/deep_link_manager.dart' as _i59;
import '../module_deep_links/repository/deep_link_local_repository.dart'
    as _i10;
import '../module_deep_links/repository/deep_link_repository.dart' as _i39;
import '../module_deep_links/service/deep_links_service.dart' as _i11;
import '../module_init/init_account_module.dart' as _i96;
import '../module_init/manager/init_account/init_account.manager.dart' as _i62;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i42;
import '../module_init/service/init_account/init_account.service.dart' as _i63;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i64;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i89;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i16;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i17;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i66;
import '../module_my_notifications/my_notifications_module.dart' as _i20;
import '../module_my_notifications/presistance/my_notification_hive_helper.dart'
    as _i19;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i44;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i67;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i68;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i79;
import '../module_network/http_client/http_client.dart' as _i6;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i21;
import '../module_notifications/repository/notification_repo.dart' as _i45;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i60;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i15;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i47;
import '../module_orders/orders_module.dart' as _i22;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i46;
import '../module_orders/service/orders/orders.service.dart' as _i48;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i84;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i69;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i70;
import '../module_orders/state_manager/order_status/order_status_without_actions_state_manager.dart'
    as _i71;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i53;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i78;
import '../module_plan/manager/captain_balance_manager.dart' as _i55;
import '../module_plan/plan_module.dart' as _i23;
import '../module_plan/repository/plan_repository.dart' as _i49;
import '../module_plan/service/plan_service.dart' as _i72;
import '../module_plan/state_manager/account_balance_state_manager.dart'
    as _i81;
import '../module_plan/state_manager/captain_financial_dues_state_manager.dart'
    as _i83;
import '../module_plan/state_manager/daily_payments_state_manager.dart' as _i86;
import '../module_plan/state_manager/my_profits_state_manager.dart' as _i90;
import '../module_plan/state_manager/payment_history_state_manager.dart'
    as _i91;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i92;
import '../module_plan/ui/screen/captain_financial_details_screen.dart' as _i8;
import '../module_plan/ui/screen/daily_payments_screen.dart' as _i87;
import '../module_plan/ui/screen/plan_screen.dart' as _i98;
import '../module_profile/manager/profile/profile.manager.dart' as _i73;
import '../module_profile/module_profile.dart' as _i25;
import '../module_profile/repository/profile/profile.repository.dart' as _i50;
import '../module_profile/service/profile/profile.service.dart' as _i74;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i5;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i88;
import '../module_settings/settings_module.dart' as _i93;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i24;
import '../module_settings/ui/screen/terms_of_use.dart' as _i26;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i32;
import '../module_settings/ui/settings_page/settings_page.dart' as _i76;
import '../module_splash/splash_module.dart' as _i77;
import '../module_splash/ui/screen/splash_screen.dart' as _i52;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i27;
import '../module_theme/service/theme_service/theme_service.dart' as _i30;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i33;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i28;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i41;
import '../utils/global/global_state_manager.dart' as _i14;
import '../utils/helpers/firestore_helper.dart' as _i12;
import '../utils/helpers/text_reader.dart' as _i13;
import '../utils/logger/logger.dart' as _i18;

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
  gh.factory<_i5.ActivityStateManager>(() => _i5.ActivityStateManager());
  gh.factory<_i6.ApiClient>(() => _i6.ApiClient());
  gh.factory<_i7.AuthPrefsHelper>(() => _i7.AuthPrefsHelper());
  gh.factory<_i8.CaptainFinancialDuesDetailsScreen>(
      () => _i8.CaptainFinancialDuesDetailsScreen());
  gh.factory<_i9.ChatHiveHelper>(() => _i9.ChatHiveHelper());
  gh.factory<_i10.DeepLinkLocalRepository>(
      () => _i10.DeepLinkLocalRepository());
  gh.factory<_i11.DeepLinksService>(() => _i11.DeepLinksService());
  gh.factory<_i12.FireStoreHelper>(() => _i12.FireStoreHelper());
  gh.factory<_i13.FlutterTextToSpeech>(() => _i13.FlutterTextToSpeech());
  gh.singleton<_i14.GlobalStateManager>(_i14.GlobalStateManager());
  gh.factory<_i15.LocalNotificationService>(
      () => _i15.LocalNotificationService());
  gh.factory<_i16.LocalizationPreferencesHelper>(
      () => _i16.LocalizationPreferencesHelper());
  gh.factory<_i17.LocalizationService>(
      () => _i17.LocalizationService(gh<_i16.LocalizationPreferencesHelper>()));
  gh.factory<_i18.Logger>(() => _i18.Logger());
  gh.factory<_i19.MyNotificationHiveHelper>(
      () => _i19.MyNotificationHiveHelper());
  gh.factory<_i20.MyNotificationsModule>(() => _i20.MyNotificationsModule());
  gh.factory<_i21.NotificationsPrefHelper>(
      () => _i21.NotificationsPrefHelper());
  gh.factory<_i22.OrdersModule>(() => _i22.OrdersModule());
  gh.factory<_i23.PlanModule>(() => _i23.PlanModule());
  gh.factory<_i24.PrivecyPolicy>(() => _i24.PrivecyPolicy());
  gh.factory<_i25.ProfileModule>(() => _i25.ProfileModule());
  gh.factory<_i26.TermsOfUse>(() => _i26.TermsOfUse());
  gh.factory<_i27.ThemePreferencesHelper>(() => _i27.ThemePreferencesHelper());
  gh.factory<_i28.UploadRepository>(() => _i28.UploadRepository());
  gh.factory<_i29.AboutRepository>(
      () => _i29.AboutRepository(gh<_i6.ApiClient>()));
  gh.factory<_i30.AppThemeDataService>(
      () => _i30.AppThemeDataService(gh<_i27.ThemePreferencesHelper>()));
  gh.factory<_i31.AuthRepository>(() => _i31.AuthRepository(
        gh<_i6.ApiClient>(),
        gh<_i18.Logger>(),
      ));
  gh.factory<_i32.ChooseLocalScreen>(
      () => _i32.ChooseLocalScreen(gh<_i17.LocalizationService>()));
  gh.factory<_i33.UploadManager>(
      () => _i33.UploadManager(gh<_i28.UploadRepository>()));
  gh.factory<_i34.AboutManager>(
      () => _i34.AboutManager(gh<_i29.AboutRepository>()));
  gh.factory<_i35.AboutService>(
      () => _i35.AboutService(gh<_i34.AboutManager>()));
  gh.factory<_i36.AuthManager>(
      () => _i36.AuthManager(gh<_i31.AuthRepository>()));
  gh.factory<_i37.AuthService>(() => _i37.AuthService(
        gh<_i7.AuthPrefsHelper>(),
        gh<_i36.AuthManager>(),
      ));
  gh.factory<_i38.ChatRepository>(() => _i38.ChatRepository(
        gh<_i6.ApiClient>(),
        gh<_i37.AuthService>(),
      ));
  gh.factory<_i39.DeepLinkRepository>(() => _i39.DeepLinkRepository(
        gh<_i6.ApiClient>(),
        gh<_i37.AuthService>(),
      ));
  gh.factory<_i40.ForgotPassStateManager>(
      () => _i40.ForgotPassStateManager(gh<_i37.AuthService>()));
  gh.factory<_i41.ImageUploadService>(
      () => _i41.ImageUploadService(gh<_i33.UploadManager>()));
  gh.factory<_i42.InitAccountRepository>(() => _i42.InitAccountRepository(
        gh<_i6.ApiClient>(),
        gh<_i37.AuthService>(),
      ));
  gh.factory<_i43.LoginStateManager>(
      () => _i43.LoginStateManager(gh<_i37.AuthService>()));
  gh.factory<_i44.MyNotificationsRepository>(
      () => _i44.MyNotificationsRepository(
            gh<_i6.ApiClient>(),
            gh<_i37.AuthService>(),
          ));
  gh.factory<_i45.NotificationRepo>(() => _i45.NotificationRepo(
        gh<_i6.ApiClient>(),
        gh<_i37.AuthService>(),
      ));
  gh.factory<_i46.OrderRepository>(() => _i46.OrderRepository(
        gh<_i6.ApiClient>(),
        gh<_i37.AuthService>(),
      ));
  gh.factory<_i47.OrdersManager>(
      () => _i47.OrdersManager(gh<_i46.OrderRepository>()));
  gh.factory<_i48.OrdersService>(
      () => _i48.OrdersService(gh<_i47.OrdersManager>()));
  gh.factory<_i49.PackageBalanceRepository>(() => _i49.PackageBalanceRepository(
        gh<_i37.AuthService>(),
        gh<_i6.ApiClient>(),
      ));
  gh.factory<_i50.ProfileRepository>(() => _i50.ProfileRepository(
        gh<_i6.ApiClient>(),
        gh<_i37.AuthService>(),
      ));
  gh.factory<_i51.RegisterStateManager>(
      () => _i51.RegisterStateManager(gh<_i37.AuthService>()));
  gh.factory<_i52.SplashScreen>(
      () => _i52.SplashScreen(gh<_i37.AuthService>()));
  gh.factory<_i53.SubOrdersStateManager>(() => _i53.SubOrdersStateManager(
        gh<_i48.OrdersService>(),
        gh<_i37.AuthService>(),
      ));
  gh.factory<_i54.AboutScreenStateManager>(
      () => _i54.AboutScreenStateManager(gh<_i35.AboutService>()));
  gh.factory<_i55.CaptainBalanceManager>(
      () => _i55.CaptainBalanceManager(gh<_i49.PackageBalanceRepository>()));
  gh.factory<_i56.ChatManager>(
      () => _i56.ChatManager(gh<_i38.ChatRepository>()));
  gh.factory<_i57.ChatService>(() => _i57.ChatService(gh<_i56.ChatManager>()));
  gh.factory<_i58.ChatStateManager>(
      () => _i58.ChatStateManager(gh<_i57.ChatService>()));
  gh.factory<_i59.DeepLinkManager>(() => _i59.DeepLinkManager(
        gh<_i39.DeepLinkRepository>(),
        gh<_i10.DeepLinkLocalRepository>(),
      ));
  gh.factory<_i60.FireNotificationService>(() => _i60.FireNotificationService(
        gh<_i21.NotificationsPrefHelper>(),
        gh<_i45.NotificationRepo>(),
      ));
  gh.factory<_i61.ForgotPassScreen>(
      () => _i61.ForgotPassScreen(gh<_i40.ForgotPassStateManager>()));
  gh.factory<_i62.InitAccountManager>(
      () => _i62.InitAccountManager(gh<_i42.InitAccountRepository>()));
  gh.factory<_i63.InitAccountService>(
      () => _i63.InitAccountService(gh<_i62.InitAccountManager>()));
  gh.factory<_i64.InitAccountStateManager>(() => _i64.InitAccountStateManager(
        gh<_i63.InitAccountService>(),
        gh<_i37.AuthService>(),
        gh<_i41.ImageUploadService>(),
      ));
  gh.factory<_i65.LoginScreen>(
      () => _i65.LoginScreen(gh<_i43.LoginStateManager>()));
  gh.factory<_i66.MyNotificationsManager>(
      () => _i66.MyNotificationsManager(gh<_i44.MyNotificationsRepository>()));
  gh.factory<_i67.MyNotificationsService>(
      () => _i67.MyNotificationsService(gh<_i66.MyNotificationsManager>()));
  gh.factory<_i68.MyNotificationsStateManager>(
      () => _i68.MyNotificationsStateManager(
            gh<_i67.MyNotificationsService>(),
            gh<_i48.OrdersService>(),
            gh<_i37.AuthService>(),
          ));
  gh.factory<_i69.OrderLogsStateManager>(
      () => _i69.OrderLogsStateManager(gh<_i48.OrdersService>()));
  gh.factory<_i70.OrderStatusStateManager>(
      () => _i70.OrderStatusStateManager(gh<_i48.OrdersService>()));
  gh.factory<_i71.OrderStatusWithoutActionsStateManager>(() =>
      _i71.OrderStatusWithoutActionsStateManager(gh<_i48.OrdersService>()));
  gh.factory<_i72.PlanService>(
      () => _i72.PlanService(gh<_i55.CaptainBalanceManager>()));
  gh.factory<_i73.ProfileManager>(
      () => _i73.ProfileManager(gh<_i50.ProfileRepository>()));
  gh.factory<_i74.ProfileService>(() => _i74.ProfileService(
        gh<_i73.ProfileManager>(),
        gh<_i48.OrdersService>(),
      ));
  gh.factory<_i75.RegisterScreen>(
      () => _i75.RegisterScreen(gh<_i51.RegisterStateManager>()));
  gh.factory<_i76.SettingsScreen>(() => _i76.SettingsScreen(
        gh<_i37.AuthService>(),
        gh<_i17.LocalizationService>(),
        gh<_i30.AppThemeDataService>(),
        gh<_i60.FireNotificationService>(),
      ));
  gh.factory<_i77.SplashModule>(
      () => _i77.SplashModule(gh<_i52.SplashScreen>()));
  gh.factory<_i78.TermsStateManager>(
      () => _i78.TermsStateManager(gh<_i74.ProfileService>()));
  gh.factory<_i79.UpdatesStateManager>(() => _i79.UpdatesStateManager(
        gh<_i67.MyNotificationsService>(),
        gh<_i37.AuthService>(),
      ));
  gh.factory<_i80.AboutScreen>(
      () => _i80.AboutScreen(gh<_i54.AboutScreenStateManager>()));
  gh.factory<_i81.AccountBalanceStateManager>(
      () => _i81.AccountBalanceStateManager(gh<_i72.PlanService>()));
  gh.factory<_i82.AuthorizationModule>(() => _i82.AuthorizationModule(
        gh<_i65.LoginScreen>(),
        gh<_i75.RegisterScreen>(),
        gh<_i61.ForgotPassScreen>(),
      ));
  gh.factory<_i83.CaptainFinancialDuesStateManager>(
      () => _i83.CaptainFinancialDuesStateManager(gh<_i72.PlanService>()));
  gh.factory<_i84.CaptainOrdersListStateManager>(
      () => _i84.CaptainOrdersListStateManager(
            gh<_i48.OrdersService>(),
            gh<_i74.ProfileService>(),
          ));
  gh.factory<_i85.ChatPage>(() => _i85.ChatPage(
        gh<_i58.ChatStateManager>(),
        gh<_i41.ImageUploadService>(),
        gh<_i37.AuthService>(),
        gh<_i9.ChatHiveHelper>(),
      ));
  gh.factory<_i86.DailyBalanceStateManager>(() => _i86.DailyBalanceStateManager(
        gh<_i74.ProfileService>(),
        gh<_i37.AuthService>(),
        gh<_i41.ImageUploadService>(),
      ));
  gh.factory<_i87.DailyPaymentsScreen>(
      () => _i87.DailyPaymentsScreen(gh<_i86.DailyBalanceStateManager>()));
  gh.factory<_i88.EditProfileStateManager>(() => _i88.EditProfileStateManager(
        gh<_i41.ImageUploadService>(),
        gh<_i74.ProfileService>(),
      ));
  gh.factory<_i89.InitAccountScreen>(
      () => _i89.InitAccountScreen(gh<_i64.InitAccountStateManager>()));
  gh.factory<_i90.MyProfitsStateManager>(
      () => _i90.MyProfitsStateManager(gh<_i72.PlanService>()));
  gh.factory<_i91.PaymentHistoryStateManager>(
      () => _i91.PaymentHistoryStateManager(gh<_i72.PlanService>()));
  gh.factory<_i92.PlanScreenStateManager>(
      () => _i92.PlanScreenStateManager(gh<_i72.PlanService>()));
  gh.factory<_i93.SettingsModule>(() => _i93.SettingsModule(
        gh<_i76.SettingsScreen>(),
        gh<_i32.ChooseLocalScreen>(),
        gh<_i24.PrivecyPolicy>(),
        gh<_i26.TermsOfUse>(),
      ));
  gh.factory<_i94.AboutModule>(() => _i94.AboutModule(gh<_i80.AboutScreen>()));
  gh.factory<_i95.ChatModule>(() => _i95.ChatModule(
        gh<_i85.ChatPage>(),
        gh<_i37.AuthService>(),
      ));
  gh.factory<_i96.InitAccountModule>(
      () => _i96.InitAccountModule(gh<_i89.InitAccountScreen>()));
  gh.factory<_i97.MyApp>(() => _i97.MyApp(
        gh<_i30.AppThemeDataService>(),
        gh<_i17.LocalizationService>(),
        gh<_i60.FireNotificationService>(),
        gh<_i15.LocalNotificationService>(),
        gh<_i77.SplashModule>(),
        gh<_i82.AuthorizationModule>(),
        gh<_i95.ChatModule>(),
        gh<_i93.SettingsModule>(),
        gh<_i94.AboutModule>(),
        gh<_i96.InitAccountModule>(),
        gh<_i22.OrdersModule>(),
        gh<_i23.PlanModule>(),
        gh<_i25.ProfileModule>(),
        gh<_i20.MyNotificationsModule>(),
      ));
  gh.factory<_i98.PlanScreen>(
      () => _i98.PlanScreen(gh<_i92.PlanScreenStateManager>()));
  return getIt;
}

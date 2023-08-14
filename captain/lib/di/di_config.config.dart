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

import '../main.dart' as _i112;
import '../module_about/about_module.dart' as _i111;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i45;
import '../module_about/repository/about_repository.dart' as _i26;
import '../module_about/service/about_service/about_service.dart' as _i46;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i72;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i96;
import '../module_auth/authoriazation_module.dart' as _i76;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i27;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i23;
import '../module_auth/service/auth_service/auth_service.dart' as _i28;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i31;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i34;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i42;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i52;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i56;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i66;
import '../module_chat/chat_module.dart' as _i101;
import '../module_chat/manager/chat/chat_manager.dart' as _i48;
import '../module_chat/presistance/chat_hive_helper.dart' as _i7;
import '../module_chat/repository/chat/chat_repository.dart' as _i29;
import '../module_chat/service/chat/char_service.dart' as _i49;
import '../module_chat/state_manager/chat_state_manager.dart' as _i50;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i80;
import '../module_deep_links/repository/deep_link_repository.dart' as _i30;
import '../module_init/init_account_module.dart' as _i103;
import '../module_init/manager/init_account/init_account.manager.dart' as _i53;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i33;
import '../module_init/service/init_account/init_account.service.dart' as _i54;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i55;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i84;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i12;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i13;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i57;
import '../module_my_notifications/my_notifications_module.dart' as _i104;
import '../module_my_notifications/presistance/my_notification_hive_helper.dart'
    as _i15;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i35;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i58;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i59;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i71;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i85;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i95;
import '../module_network/http_client/http_client.dart' as _i21;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i16;
import '../module_notifications/repository/notification_repo.dart' as _i36;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i51;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i11;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i38;
import '../module_orders/orders_module.dart' as _i106;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i37;
import '../module_orders/service/orders/orders.service.dart' as _i39;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i78;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i60;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i61;
import '../module_orders/state_manager/order_status/order_status_without_actions_state_manager.dart'
    as _i62;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i44;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i70;
import '../module_orders/ui/screens/captain_orders/captain_orders.dart' as _i79;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i87;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i88;
import '../module_orders/ui/screens/order_status/order_status_without_actions.dart'
    as _i89;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i69;
import '../module_orders/ui/screens/terms/terms.dart' as _i94;
import '../module_plan/manager/captain_balance_manager.dart' as _i47;
import '../module_plan/plan_module.dart' as _i108;
import '../module_plan/repository/plan_repository.dart' as _i40;
import '../module_plan/service/plan_service.dart' as _i63;
import '../module_plan/state_manager/account_balance_state_manager.dart'
    as _i73;
import '../module_plan/state_manager/captain_financial_dues_state_manager.dart'
    as _i77;
import '../module_plan/state_manager/daily_payments_state_manager.dart' as _i81;
import '../module_plan/state_manager/my_profits_state_manager.dart' as _i86;
import '../module_plan/state_manager/payment_history_state_manager.dart'
    as _i90;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i92;
import '../module_plan/ui/screen/account_balance_screen.dart' as _i97;
import '../module_plan/ui/screen/captain_financial_details_screen.dart' as _i6;
import '../module_plan/ui/screen/captain_financial_dues_screen.dart' as _i100;
import '../module_plan/ui/screen/daily_payments_screen.dart' as _i82;
import '../module_plan/ui/screen/my_profits_screen.dart' as _i105;
import '../module_plan/ui/screen/payment_history_screen.dart' as _i107;
import '../module_plan/ui/screen/plan_details_screen.dart' as _i91;
import '../module_plan/ui/screen/plan_screen.dart' as _i109;
import '../module_profile/manager/profile/profile.manager.dart' as _i64;
import '../module_profile/module_profile.dart' as _i110;
import '../module_profile/repository/profile/profile.repository.dart' as _i41;
import '../module_profile/service/profile/profile.service.dart' as _i65;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i74;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i75;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i83;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i98;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i99;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i102;
import '../module_settings/settings_module.dart' as _i93;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i17;
import '../module_settings/ui/screen/terms_of_use.dart' as _i18;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i24;
import '../module_settings/ui/settings_page/settings_page.dart' as _i67;
import '../module_splash/splash_module.dart' as _i68;
import '../module_splash/ui/screen/splash_screen.dart' as _i43;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i19;
import '../module_theme/service/theme_service/theme_service.dart' as _i22;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i25;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i20;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i32;
import '../utils/global/global_state_manager.dart' as _i10;
import '../utils/helpers/firestore_helper.dart' as _i8;
import '../utils/helpers/text_reader.dart' as _i9;
import '../utils/logger/logger.dart' as _i14;

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
  gh.factory<_i15.MyNotificationHiveHelper>(
      () => _i15.MyNotificationHiveHelper());
  gh.factory<_i16.NotificationsPrefHelper>(
      () => _i16.NotificationsPrefHelper());
  gh.factory<_i17.PrivecyPolicy>(() => _i17.PrivecyPolicy());
  gh.factory<_i18.TermsOfUse>(() => _i18.TermsOfUse());
  gh.factory<_i19.ThemePreferencesHelper>(() => _i19.ThemePreferencesHelper());
  gh.factory<_i20.UploadRepository>(() => _i20.UploadRepository());
  gh.factory<_i21.ApiClient>(() => _i21.ApiClient(gh<_i14.Logger>()));
  gh.factory<_i22.AppThemeDataService>(
      () => _i22.AppThemeDataService(gh<_i19.ThemePreferencesHelper>()));
  gh.factory<_i23.AuthRepository>(() => _i23.AuthRepository(
        gh<_i21.ApiClient>(),
        gh<_i14.Logger>(),
      ));
  gh.factory<_i24.ChooseLocalScreen>(
      () => _i24.ChooseLocalScreen(gh<_i13.LocalizationService>()));
  gh.factory<_i25.UploadManager>(
      () => _i25.UploadManager(gh<_i20.UploadRepository>()));
  gh.factory<_i26.AboutRepository>(
      () => _i26.AboutRepository(gh<_i21.ApiClient>()));
  gh.factory<_i27.AuthManager>(
      () => _i27.AuthManager(gh<_i23.AuthRepository>()));
  gh.factory<_i28.AuthService>(() => _i28.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i27.AuthManager>(),
      ));
  gh.factory<_i29.ChatRepository>(() => _i29.ChatRepository(
        gh<_i21.ApiClient>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i30.DeepLinkRepository>(() => _i30.DeepLinkRepository(
        gh<_i21.ApiClient>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i31.ForgotPassStateManager>(
      () => _i31.ForgotPassStateManager(gh<_i28.AuthService>()));
  gh.factory<_i32.ImageUploadService>(
      () => _i32.ImageUploadService(gh<_i25.UploadManager>()));
  gh.factory<_i33.InitAccountRepository>(() => _i33.InitAccountRepository(
        gh<_i21.ApiClient>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i34.LoginStateManager>(
      () => _i34.LoginStateManager(gh<_i28.AuthService>()));
  gh.factory<_i35.MyNotificationsRepository>(
      () => _i35.MyNotificationsRepository(
            gh<_i21.ApiClient>(),
            gh<_i28.AuthService>(),
          ));
  gh.factory<_i36.NotificationRepo>(() => _i36.NotificationRepo(
        gh<_i21.ApiClient>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i37.OrderRepository>(() => _i37.OrderRepository(
        gh<_i21.ApiClient>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i38.OrdersManager>(
      () => _i38.OrdersManager(gh<_i37.OrderRepository>()));
  gh.factory<_i39.OrdersService>(
      () => _i39.OrdersService(gh<_i38.OrdersManager>()));
  gh.factory<_i40.PackageBalanceRepository>(() => _i40.PackageBalanceRepository(
        gh<_i28.AuthService>(),
        gh<_i21.ApiClient>(),
      ));
  gh.factory<_i41.ProfileRepository>(() => _i41.ProfileRepository(
        gh<_i21.ApiClient>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i42.RegisterStateManager>(
      () => _i42.RegisterStateManager(gh<_i28.AuthService>()));
  gh.factory<_i43.SplashScreen>(
      () => _i43.SplashScreen(gh<_i28.AuthService>()));
  gh.factory<_i44.SubOrdersStateManager>(() => _i44.SubOrdersStateManager(
        gh<_i39.OrdersService>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i45.AboutManager>(
      () => _i45.AboutManager(gh<_i26.AboutRepository>()));
  gh.factory<_i46.AboutService>(
      () => _i46.AboutService(gh<_i45.AboutManager>()));
  gh.factory<_i47.CaptainBalanceManager>(
      () => _i47.CaptainBalanceManager(gh<_i40.PackageBalanceRepository>()));
  gh.factory<_i48.ChatManager>(
      () => _i48.ChatManager(gh<_i29.ChatRepository>()));
  gh.factory<_i49.ChatService>(() => _i49.ChatService(gh<_i48.ChatManager>()));
  gh.factory<_i50.ChatStateManager>(
      () => _i50.ChatStateManager(gh<_i49.ChatService>()));
  gh.factory<_i51.FireNotificationService>(() => _i51.FireNotificationService(
        gh<_i16.NotificationsPrefHelper>(),
        gh<_i36.NotificationRepo>(),
      ));
  gh.factory<_i52.ForgotPassScreen>(
      () => _i52.ForgotPassScreen(gh<_i31.ForgotPassStateManager>()));
  gh.factory<_i53.InitAccountManager>(
      () => _i53.InitAccountManager(gh<_i33.InitAccountRepository>()));
  gh.factory<_i54.InitAccountService>(
      () => _i54.InitAccountService(gh<_i53.InitAccountManager>()));
  gh.factory<_i55.InitAccountStateManager>(() => _i55.InitAccountStateManager(
        gh<_i54.InitAccountService>(),
        gh<_i28.AuthService>(),
        gh<_i32.ImageUploadService>(),
      ));
  gh.factory<_i56.LoginScreen>(
      () => _i56.LoginScreen(gh<_i34.LoginStateManager>()));
  gh.factory<_i57.MyNotificationsManager>(
      () => _i57.MyNotificationsManager(gh<_i35.MyNotificationsRepository>()));
  gh.factory<_i58.MyNotificationsService>(
      () => _i58.MyNotificationsService(gh<_i57.MyNotificationsManager>()));
  gh.factory<_i59.MyNotificationsStateManager>(
      () => _i59.MyNotificationsStateManager(
            gh<_i58.MyNotificationsService>(),
            gh<_i39.OrdersService>(),
            gh<_i28.AuthService>(),
          ));
  gh.factory<_i60.OrderLogsStateManager>(
      () => _i60.OrderLogsStateManager(gh<_i39.OrdersService>()));
  gh.factory<_i61.OrderStatusStateManager>(() => _i61.OrderStatusStateManager(
        gh<_i39.OrdersService>(),
        gh<_i32.ImageUploadService>(),
      ));
  gh.factory<_i62.OrderStatusWithoutActionsStateManager>(
      () => _i62.OrderStatusWithoutActionsStateManager(
            gh<_i39.OrdersService>(),
            gh<_i32.ImageUploadService>(),
          ));
  gh.factory<_i63.PlanService>(
      () => _i63.PlanService(gh<_i47.CaptainBalanceManager>()));
  gh.factory<_i64.ProfileManager>(
      () => _i64.ProfileManager(gh<_i41.ProfileRepository>()));
  gh.factory<_i65.ProfileService>(() => _i65.ProfileService(
        gh<_i64.ProfileManager>(),
        gh<_i39.OrdersService>(),
      ));
  gh.factory<_i66.RegisterScreen>(
      () => _i66.RegisterScreen(gh<_i42.RegisterStateManager>()));
  gh.factory<_i67.SettingsScreen>(() => _i67.SettingsScreen(
        gh<_i28.AuthService>(),
        gh<_i13.LocalizationService>(),
        gh<_i22.AppThemeDataService>(),
        gh<_i51.FireNotificationService>(),
      ));
  gh.factory<_i68.SplashModule>(
      () => _i68.SplashModule(gh<_i43.SplashScreen>()));
  gh.factory<_i69.SubOrdersScreen>(
      () => _i69.SubOrdersScreen(gh<_i44.SubOrdersStateManager>()));
  gh.factory<_i70.TermsStateManager>(
      () => _i70.TermsStateManager(gh<_i65.ProfileService>()));
  gh.factory<_i71.UpdatesStateManager>(() => _i71.UpdatesStateManager(
        gh<_i58.MyNotificationsService>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i72.AboutScreenStateManager>(
      () => _i72.AboutScreenStateManager(gh<_i46.AboutService>()));
  gh.factory<_i73.AccountBalanceStateManager>(
      () => _i73.AccountBalanceStateManager(gh<_i63.PlanService>()));
  gh.factory<_i74.AccountBalanceStateManager>(
      () => _i74.AccountBalanceStateManager(
            gh<_i65.ProfileService>(),
            gh<_i28.AuthService>(),
            gh<_i32.ImageUploadService>(),
          ));
  gh.factory<_i75.ActivityStateManager>(() => _i75.ActivityStateManager(
        gh<_i65.ProfileService>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i76.AuthorizationModule>(() => _i76.AuthorizationModule(
        gh<_i56.LoginScreen>(),
        gh<_i66.RegisterScreen>(),
        gh<_i52.ForgotPassScreen>(),
      ));
  gh.factory<_i77.CaptainFinancialDuesStateManager>(
      () => _i77.CaptainFinancialDuesStateManager(gh<_i63.PlanService>()));
  gh.factory<_i78.CaptainOrdersListStateManager>(
      () => _i78.CaptainOrdersListStateManager(
            gh<_i39.OrdersService>(),
            gh<_i65.ProfileService>(),
          ));
  gh.factory<_i79.CaptainOrdersScreen>(
      () => _i79.CaptainOrdersScreen(gh<_i78.CaptainOrdersListStateManager>()));
  gh.factory<_i80.ChatPage>(() => _i80.ChatPage(
        gh<_i50.ChatStateManager>(),
        gh<_i32.ImageUploadService>(),
        gh<_i28.AuthService>(),
        gh<_i7.ChatHiveHelper>(),
      ));
  gh.factory<_i81.DailyBalanceStateManager>(() => _i81.DailyBalanceStateManager(
        gh<_i65.ProfileService>(),
        gh<_i28.AuthService>(),
        gh<_i32.ImageUploadService>(),
      ));
  gh.factory<_i82.DailyPaymentsScreen>(
      () => _i82.DailyPaymentsScreen(gh<_i81.DailyBalanceStateManager>()));
  gh.factory<_i83.EditProfileStateManager>(() => _i83.EditProfileStateManager(
        gh<_i32.ImageUploadService>(),
        gh<_i65.ProfileService>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i84.InitAccountScreen>(
      () => _i84.InitAccountScreen(gh<_i55.InitAccountStateManager>()));
  gh.factory<_i85.MyNotificationsScreen>(
      () => _i85.MyNotificationsScreen(gh<_i59.MyNotificationsStateManager>()));
  gh.factory<_i86.MyProfitsStateManager>(
      () => _i86.MyProfitsStateManager(gh<_i63.PlanService>()));
  gh.factory<_i87.OrderLogsScreen>(
      () => _i87.OrderLogsScreen(gh<_i60.OrderLogsStateManager>()));
  gh.factory<_i88.OrderStatusScreen>(
      () => _i88.OrderStatusScreen(gh<_i61.OrderStatusStateManager>()));
  gh.factory<_i89.OrderStatusWithoutActionsScreen>(() =>
      _i89.OrderStatusWithoutActionsScreen(
          gh<_i62.OrderStatusWithoutActionsStateManager>()));
  gh.factory<_i90.PaymentHistoryStateManager>(
      () => _i90.PaymentHistoryStateManager(gh<_i63.PlanService>()));
  gh.factory<_i91.PlanDetailsScreen>(
      () => _i91.PlanDetailsScreen(gh<_i86.MyProfitsStateManager>()));
  gh.factory<_i92.PlanScreenStateManager>(
      () => _i92.PlanScreenStateManager(gh<_i63.PlanService>()));
  gh.factory<_i93.SettingsModule>(() => _i93.SettingsModule(
        gh<_i67.SettingsScreen>(),
        gh<_i24.ChooseLocalScreen>(),
        gh<_i17.PrivecyPolicy>(),
        gh<_i18.TermsOfUse>(),
      ));
  gh.factory<_i94.TermsScreen>(
      () => _i94.TermsScreen(gh<_i70.TermsStateManager>()));
  gh.factory<_i95.UpdateScreen>(
      () => _i95.UpdateScreen(gh<_i71.UpdatesStateManager>()));
  gh.factory<_i96.AboutScreen>(
      () => _i96.AboutScreen(gh<_i72.AboutScreenStateManager>()));
  gh.factory<_i97.AccountBalanceScreen>(
      () => _i97.AccountBalanceScreen(gh<_i73.AccountBalanceStateManager>()));
  gh.factory<_i98.AccountBalanceScreen>(
      () => _i98.AccountBalanceScreen(gh<_i74.AccountBalanceStateManager>()));
  gh.factory<_i99.ActivityScreen>(
      () => _i99.ActivityScreen(gh<_i75.ActivityStateManager>()));
  gh.factory<_i100.CaptainFinancialDuesScreen>(() =>
      _i100.CaptainFinancialDuesScreen(
          gh<_i77.CaptainFinancialDuesStateManager>()));
  gh.factory<_i101.ChatModule>(() => _i101.ChatModule(
        gh<_i80.ChatPage>(),
        gh<_i28.AuthService>(),
      ));
  gh.factory<_i102.EditProfileScreen>(
      () => _i102.EditProfileScreen(gh<_i83.EditProfileStateManager>()));
  gh.factory<_i103.InitAccountModule>(
      () => _i103.InitAccountModule(gh<_i84.InitAccountScreen>()));
  gh.factory<_i104.MyNotificationsModule>(() => _i104.MyNotificationsModule(
        gh<_i85.MyNotificationsScreen>(),
        gh<_i95.UpdateScreen>(),
      ));
  gh.factory<_i105.MyProfitsScreen>(
      () => _i105.MyProfitsScreen(gh<_i86.MyProfitsStateManager>()));
  gh.factory<_i106.OrdersModule>(() => _i106.OrdersModule(
        gh<_i88.OrderStatusScreen>(),
        gh<_i79.CaptainOrdersScreen>(),
        gh<_i94.TermsScreen>(),
        gh<_i69.SubOrdersScreen>(),
        gh<_i87.OrderLogsScreen>(),
        gh<_i89.OrderStatusWithoutActionsScreen>(),
      ));
  gh.factory<_i107.PaymentHistoryScreen>(
      () => _i107.PaymentHistoryScreen(gh<_i90.PaymentHistoryStateManager>()));
  gh.factory<_i108.PlanModule>(() => _i108.PlanModule(
        gh<_i97.AccountBalanceScreen>(),
        gh<_i6.CaptainFinancialDuesDetailsScreen>(),
        gh<_i100.CaptainFinancialDuesScreen>(),
        gh<_i105.MyProfitsScreen>(),
        gh<_i107.PaymentHistoryScreen>(),
        gh<_i91.PlanDetailsScreen>(),
      ));
  gh.factory<_i109.PlanScreen>(
      () => _i109.PlanScreen(gh<_i92.PlanScreenStateManager>()));
  gh.factory<_i110.ProfileModule>(() => _i110.ProfileModule(
        gh<_i99.ActivityScreen>(),
        gh<_i102.EditProfileScreen>(),
        gh<_i98.AccountBalanceScreen>(),
      ));
  gh.factory<_i111.AboutModule>(
      () => _i111.AboutModule(gh<_i96.AboutScreen>()));
  gh.factory<_i112.MyApp>(() => _i112.MyApp(
        gh<_i22.AppThemeDataService>(),
        gh<_i13.LocalizationService>(),
        gh<_i51.FireNotificationService>(),
        gh<_i11.LocalNotificationService>(),
        gh<_i68.SplashModule>(),
        gh<_i76.AuthorizationModule>(),
        gh<_i101.ChatModule>(),
        gh<_i93.SettingsModule>(),
        gh<_i111.AboutModule>(),
        gh<_i103.InitAccountModule>(),
        gh<_i106.OrdersModule>(),
        gh<_i108.PlanModule>(),
        gh<_i110.ProfileModule>(),
        gh<_i104.MyNotificationsModule>(),
      ));
  return getIt;
}

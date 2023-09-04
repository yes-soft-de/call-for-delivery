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

import '../main.dart' as _i115;
import '../module_about/about_module.dart' as _i100;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i29;
import '../module_about/repository/about_repository.dart' as _i24;
import '../module_about/service/about_service/about_service.dart' as _i30;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i49;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i76;
import '../module_auth/authoriazation_module.dart' as _i80;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i31;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i6;
import '../module_auth/repository/auth/auth_repository.dart' as _i26;
import '../module_auth/service/auth_service/auth_service.dart' as _i32;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i35;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i38;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i46;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i56;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i60;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i70;
import '../module_chat/chat_module.dart' as _i105;
import '../module_chat/manager/chat/chat_manager.dart' as _i51;
import '../module_chat/presistance/chat_hive_helper.dart' as _i8;
import '../module_chat/repository/chat/chat_repository.dart' as _i33;
import '../module_chat/service/chat/char_service.dart' as _i52;
import '../module_chat/state_manager/chat_state_manager.dart' as _i53;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i84;
import '../module_deep_links/manager/deep_link_manager.dart' as _i54;
import '../module_deep_links/repository/deep_link_local_repository.dart' as _i9;
import '../module_deep_links/repository/deep_link_repository.dart' as _i34;
import '../module_deep_links/service/deep_links_service.dart' as _i10;
import '../module_init/init_account_module.dart' as _i107;
import '../module_init/manager/init_account/init_account.manager.dart' as _i57;
import '../module_init/repository/init_account/init_account.repository.dart'
    as _i37;
import '../module_init/service/init_account/init_account.service.dart' as _i58;
import '../module_init/state_manager/init_account/init_account.state_manager.dart'
    as _i59;
import '../module_init/ui/screens/init_account_screen/init_account_screen.dart'
    as _i88;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i15;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i16;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i61;
import '../module_my_notifications/my_notifications_module.dart' as _i108;
import '../module_my_notifications/presistance/my_notification_hive_helper.dart'
    as _i18;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i39;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i62;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i63;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i75;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i89;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i99;
import '../module_network/http_client/http_client.dart' as _i5;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i19;
import '../module_notifications/repository/notification_repo.dart' as _i40;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i55;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i14;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i42;
import '../module_orders/orders_module.dart' as _i110;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i41;
import '../module_orders/service/orders/orders.service.dart' as _i43;
import '../module_orders/state_manager/captain_orders/captain_orders.dart'
    as _i82;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i64;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i65;
import '../module_orders/state_manager/order_status/order_status_without_actions_state_manager.dart'
    as _i66;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i48;
import '../module_orders/state_manager/terms/terms_state_manager.dart' as _i74;
import '../module_orders/ui/screens/captain_orders/captain_orders.dart' as _i83;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i91;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i92;
import '../module_orders/ui/screens/order_status/order_status_without_actions.dart'
    as _i93;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i73;
import '../module_orders/ui/screens/terms/terms.dart' as _i98;
import '../module_plan/manager/captain_balance_manager.dart' as _i50;
import '../module_plan/plan_module.dart' as _i112;
import '../module_plan/repository/plan_repository.dart' as _i44;
import '../module_plan/service/plan_service.dart' as _i67;
import '../module_plan/state_manager/account_balance_state_manager.dart'
    as _i77;
import '../module_plan/state_manager/captain_financial_dues_state_manager.dart'
    as _i81;
import '../module_plan/state_manager/daily_payments_state_manager.dart' as _i85;
import '../module_plan/state_manager/my_profits_state_manager.dart' as _i90;
import '../module_plan/state_manager/payment_history_state_manager.dart'
    as _i94;
import '../module_plan/state_manager/plan_screen_state_manager.dart' as _i96;
import '../module_plan/ui/screen/account_balance_screen.dart' as _i101;
import '../module_plan/ui/screen/captain_financial_details_screen.dart' as _i7;
import '../module_plan/ui/screen/captain_financial_dues_screen.dart' as _i104;
import '../module_plan/ui/screen/daily_payments_screen.dart' as _i86;
import '../module_plan/ui/screen/my_profits_screen.dart' as _i109;
import '../module_plan/ui/screen/payment_history_screen.dart' as _i111;
import '../module_plan/ui/screen/plan_details_screen.dart' as _i95;
import '../module_plan/ui/screen/plan_screen.dart' as _i113;
import '../module_profile/manager/profile/profile.manager.dart' as _i68;
import '../module_profile/module_profile.dart' as _i114;
import '../module_profile/repository/profile/profile.repository.dart' as _i45;
import '../module_profile/service/profile/profile.service.dart' as _i69;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i78;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i79;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i87;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i102;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i103;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i106;
import '../module_settings/settings_module.dart' as _i97;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i20;
import '../module_settings/ui/screen/terms_of_use.dart' as _i21;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i27;
import '../module_settings/ui/settings_page/settings_page.dart' as _i71;
import '../module_splash/splash_module.dart' as _i72;
import '../module_splash/ui/screen/splash_screen.dart' as _i47;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i22;
import '../module_theme/service/theme_service/theme_service.dart' as _i25;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i28;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i23;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i36;
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
  gh.factory<_i20.PrivecyPolicy>(() => _i20.PrivecyPolicy());
  gh.factory<_i21.TermsOfUse>(() => _i21.TermsOfUse());
  gh.factory<_i22.ThemePreferencesHelper>(() => _i22.ThemePreferencesHelper());
  gh.factory<_i23.UploadRepository>(() => _i23.UploadRepository());
  gh.factory<_i24.AboutRepository>(
      () => _i24.AboutRepository(gh<_i5.ApiClient>()));
  gh.factory<_i25.AppThemeDataService>(
      () => _i25.AppThemeDataService(gh<_i22.ThemePreferencesHelper>()));
  gh.factory<_i26.AuthRepository>(() => _i26.AuthRepository(
        gh<_i5.ApiClient>(),
        gh<_i17.Logger>(),
      ));
  gh.factory<_i27.ChooseLocalScreen>(
      () => _i27.ChooseLocalScreen(gh<_i16.LocalizationService>()));
  gh.factory<_i28.UploadManager>(
      () => _i28.UploadManager(gh<_i23.UploadRepository>()));
  gh.factory<_i29.AboutManager>(
      () => _i29.AboutManager(gh<_i24.AboutRepository>()));
  gh.factory<_i30.AboutService>(
      () => _i30.AboutService(gh<_i29.AboutManager>()));
  gh.factory<_i31.AuthManager>(
      () => _i31.AuthManager(gh<_i26.AuthRepository>()));
  gh.factory<_i32.AuthService>(() => _i32.AuthService(
        gh<_i6.AuthPrefsHelper>(),
        gh<_i31.AuthManager>(),
      ));
  gh.factory<_i33.ChatRepository>(() => _i33.ChatRepository(
        gh<_i5.ApiClient>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i34.DeepLinkRepository>(() => _i34.DeepLinkRepository(
        gh<_i5.ApiClient>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i35.ForgotPassStateManager>(
      () => _i35.ForgotPassStateManager(gh<_i32.AuthService>()));
  gh.factory<_i36.ImageUploadService>(
      () => _i36.ImageUploadService(gh<_i28.UploadManager>()));
  gh.factory<_i37.InitAccountRepository>(() => _i37.InitAccountRepository(
        gh<_i5.ApiClient>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i38.LoginStateManager>(
      () => _i38.LoginStateManager(gh<_i32.AuthService>()));
  gh.factory<_i39.MyNotificationsRepository>(
      () => _i39.MyNotificationsRepository(
            gh<_i5.ApiClient>(),
            gh<_i32.AuthService>(),
          ));
  gh.factory<_i40.NotificationRepo>(() => _i40.NotificationRepo(
        gh<_i5.ApiClient>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i41.OrderRepository>(() => _i41.OrderRepository(
        gh<_i5.ApiClient>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i42.OrdersManager>(
      () => _i42.OrdersManager(gh<_i41.OrderRepository>()));
  gh.factory<_i43.OrdersService>(
      () => _i43.OrdersService(gh<_i42.OrdersManager>()));
  gh.factory<_i44.PackageBalanceRepository>(() => _i44.PackageBalanceRepository(
        gh<_i32.AuthService>(),
        gh<_i5.ApiClient>(),
      ));
  gh.factory<_i45.ProfileRepository>(() => _i45.ProfileRepository(
        gh<_i5.ApiClient>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i46.RegisterStateManager>(
      () => _i46.RegisterStateManager(gh<_i32.AuthService>()));
  gh.factory<_i47.SplashScreen>(
      () => _i47.SplashScreen(gh<_i32.AuthService>()));
  gh.factory<_i48.SubOrdersStateManager>(() => _i48.SubOrdersStateManager(
        gh<_i43.OrdersService>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i49.AboutScreenStateManager>(
      () => _i49.AboutScreenStateManager(gh<_i30.AboutService>()));
  gh.factory<_i50.CaptainBalanceManager>(
      () => _i50.CaptainBalanceManager(gh<_i44.PackageBalanceRepository>()));
  gh.factory<_i51.ChatManager>(
      () => _i51.ChatManager(gh<_i33.ChatRepository>()));
  gh.factory<_i52.ChatService>(() => _i52.ChatService(gh<_i51.ChatManager>()));
  gh.factory<_i53.ChatStateManager>(
      () => _i53.ChatStateManager(gh<_i52.ChatService>()));
  gh.factory<_i54.DeepLinkManager>(() => _i54.DeepLinkManager(
        gh<_i34.DeepLinkRepository>(),
        gh<_i9.DeepLinkLocalRepository>(),
      ));
  gh.factory<_i55.FireNotificationService>(() => _i55.FireNotificationService(
        gh<_i19.NotificationsPrefHelper>(),
        gh<_i40.NotificationRepo>(),
      ));
  gh.factory<_i56.ForgotPassScreen>(
      () => _i56.ForgotPassScreen(gh<_i35.ForgotPassStateManager>()));
  gh.factory<_i57.InitAccountManager>(
      () => _i57.InitAccountManager(gh<_i37.InitAccountRepository>()));
  gh.factory<_i58.InitAccountService>(
      () => _i58.InitAccountService(gh<_i57.InitAccountManager>()));
  gh.factory<_i59.InitAccountStateManager>(() => _i59.InitAccountStateManager(
        gh<_i58.InitAccountService>(),
        gh<_i32.AuthService>(),
        gh<_i36.ImageUploadService>(),
      ));
  gh.factory<_i60.LoginScreen>(
      () => _i60.LoginScreen(gh<_i38.LoginStateManager>()));
  gh.factory<_i61.MyNotificationsManager>(
      () => _i61.MyNotificationsManager(gh<_i39.MyNotificationsRepository>()));
  gh.factory<_i62.MyNotificationsService>(
      () => _i62.MyNotificationsService(gh<_i61.MyNotificationsManager>()));
  gh.factory<_i63.MyNotificationsStateManager>(
      () => _i63.MyNotificationsStateManager(
            gh<_i62.MyNotificationsService>(),
            gh<_i43.OrdersService>(),
            gh<_i32.AuthService>(),
          ));
  gh.factory<_i64.OrderLogsStateManager>(
      () => _i64.OrderLogsStateManager(gh<_i43.OrdersService>()));
  gh.factory<_i65.OrderStatusStateManager>(() => _i65.OrderStatusStateManager(
        gh<_i43.OrdersService>(),
        gh<_i36.ImageUploadService>(),
      ));
  gh.factory<_i66.OrderStatusWithoutActionsStateManager>(
      () => _i66.OrderStatusWithoutActionsStateManager(
            gh<_i43.OrdersService>(),
            gh<_i36.ImageUploadService>(),
          ));
  gh.factory<_i67.PlanService>(
      () => _i67.PlanService(gh<_i50.CaptainBalanceManager>()));
  gh.factory<_i68.ProfileManager>(
      () => _i68.ProfileManager(gh<_i45.ProfileRepository>()));
  gh.factory<_i69.ProfileService>(() => _i69.ProfileService(
        gh<_i68.ProfileManager>(),
        gh<_i43.OrdersService>(),
      ));
  gh.factory<_i70.RegisterScreen>(
      () => _i70.RegisterScreen(gh<_i46.RegisterStateManager>()));
  gh.factory<_i71.SettingsScreen>(() => _i71.SettingsScreen(
        gh<_i32.AuthService>(),
        gh<_i16.LocalizationService>(),
        gh<_i25.AppThemeDataService>(),
        gh<_i55.FireNotificationService>(),
      ));
  gh.factory<_i72.SplashModule>(
      () => _i72.SplashModule(gh<_i47.SplashScreen>()));
  gh.factory<_i73.SubOrdersScreen>(
      () => _i73.SubOrdersScreen(gh<_i48.SubOrdersStateManager>()));
  gh.factory<_i74.TermsStateManager>(
      () => _i74.TermsStateManager(gh<_i69.ProfileService>()));
  gh.factory<_i75.UpdatesStateManager>(() => _i75.UpdatesStateManager(
        gh<_i62.MyNotificationsService>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i76.AboutScreen>(
      () => _i76.AboutScreen(gh<_i49.AboutScreenStateManager>()));
  gh.factory<_i77.AccountBalanceStateManager>(
      () => _i77.AccountBalanceStateManager(gh<_i67.PlanService>()));
  gh.factory<_i78.AccountBalanceStateManager>(
      () => _i78.AccountBalanceStateManager(
            gh<_i69.ProfileService>(),
            gh<_i32.AuthService>(),
            gh<_i36.ImageUploadService>(),
          ));
  gh.factory<_i79.ActivityStateManager>(() => _i79.ActivityStateManager(
        gh<_i69.ProfileService>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i80.AuthorizationModule>(() => _i80.AuthorizationModule(
        gh<_i60.LoginScreen>(),
        gh<_i70.RegisterScreen>(),
        gh<_i56.ForgotPassScreen>(),
      ));
  gh.factory<_i81.CaptainFinancialDuesStateManager>(
      () => _i81.CaptainFinancialDuesStateManager(gh<_i67.PlanService>()));
  gh.factory<_i82.CaptainOrdersListStateManager>(
      () => _i82.CaptainOrdersListStateManager(
            gh<_i43.OrdersService>(),
            gh<_i69.ProfileService>(),
          ));
  gh.factory<_i83.CaptainOrdersScreen>(
      () => _i83.CaptainOrdersScreen(gh<_i82.CaptainOrdersListStateManager>()));
  gh.factory<_i84.ChatPage>(() => _i84.ChatPage(
        gh<_i53.ChatStateManager>(),
        gh<_i36.ImageUploadService>(),
        gh<_i32.AuthService>(),
        gh<_i8.ChatHiveHelper>(),
      ));
  gh.factory<_i85.DailyBalanceStateManager>(() => _i85.DailyBalanceStateManager(
        gh<_i69.ProfileService>(),
        gh<_i32.AuthService>(),
        gh<_i36.ImageUploadService>(),
      ));
  gh.factory<_i86.DailyPaymentsScreen>(
      () => _i86.DailyPaymentsScreen(gh<_i85.DailyBalanceStateManager>()));
  gh.factory<_i87.EditProfileStateManager>(() => _i87.EditProfileStateManager(
        gh<_i36.ImageUploadService>(),
        gh<_i69.ProfileService>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i88.InitAccountScreen>(
      () => _i88.InitAccountScreen(gh<_i59.InitAccountStateManager>()));
  gh.factory<_i89.MyNotificationsScreen>(
      () => _i89.MyNotificationsScreen(gh<_i63.MyNotificationsStateManager>()));
  gh.factory<_i90.MyProfitsStateManager>(
      () => _i90.MyProfitsStateManager(gh<_i67.PlanService>()));
  gh.factory<_i91.OrderLogsScreen>(
      () => _i91.OrderLogsScreen(gh<_i64.OrderLogsStateManager>()));
  gh.factory<_i92.OrderStatusScreen>(
      () => _i92.OrderStatusScreen(gh<_i65.OrderStatusStateManager>()));
  gh.factory<_i93.OrderStatusWithoutActionsScreen>(() =>
      _i93.OrderStatusWithoutActionsScreen(
          gh<_i66.OrderStatusWithoutActionsStateManager>()));
  gh.factory<_i94.PaymentHistoryStateManager>(
      () => _i94.PaymentHistoryStateManager(gh<_i67.PlanService>()));
  gh.factory<_i95.PlanDetailsScreen>(
      () => _i95.PlanDetailsScreen(gh<_i90.MyProfitsStateManager>()));
  gh.factory<_i96.PlanScreenStateManager>(
      () => _i96.PlanScreenStateManager(gh<_i67.PlanService>()));
  gh.factory<_i97.SettingsModule>(() => _i97.SettingsModule(
        gh<_i71.SettingsScreen>(),
        gh<_i27.ChooseLocalScreen>(),
        gh<_i20.PrivecyPolicy>(),
        gh<_i21.TermsOfUse>(),
      ));
  gh.factory<_i98.TermsScreen>(
      () => _i98.TermsScreen(gh<_i74.TermsStateManager>()));
  gh.factory<_i99.UpdateScreen>(
      () => _i99.UpdateScreen(gh<_i75.UpdatesStateManager>()));
  gh.factory<_i100.AboutModule>(
      () => _i100.AboutModule(gh<_i76.AboutScreen>()));
  gh.factory<_i101.AccountBalanceScreen>(
      () => _i101.AccountBalanceScreen(gh<_i77.AccountBalanceStateManager>()));
  gh.factory<_i102.AccountBalanceScreen>(
      () => _i102.AccountBalanceScreen(gh<_i78.AccountBalanceStateManager>()));
  gh.factory<_i103.ActivityScreen>(
      () => _i103.ActivityScreen(gh<_i79.ActivityStateManager>()));
  gh.factory<_i104.CaptainFinancialDuesScreen>(() =>
      _i104.CaptainFinancialDuesScreen(
          gh<_i81.CaptainFinancialDuesStateManager>()));
  gh.factory<_i105.ChatModule>(() => _i105.ChatModule(
        gh<_i84.ChatPage>(),
        gh<_i32.AuthService>(),
      ));
  gh.factory<_i106.EditProfileScreen>(
      () => _i106.EditProfileScreen(gh<_i87.EditProfileStateManager>()));
  gh.factory<_i107.InitAccountModule>(
      () => _i107.InitAccountModule(gh<_i88.InitAccountScreen>()));
  gh.factory<_i108.MyNotificationsModule>(() => _i108.MyNotificationsModule(
        gh<_i89.MyNotificationsScreen>(),
        gh<_i99.UpdateScreen>(),
      ));
  gh.factory<_i109.MyProfitsScreen>(
      () => _i109.MyProfitsScreen(gh<_i90.MyProfitsStateManager>()));
  gh.factory<_i110.OrdersModule>(() => _i110.OrdersModule(
        gh<_i92.OrderStatusScreen>(),
        gh<_i83.CaptainOrdersScreen>(),
        gh<_i98.TermsScreen>(),
        gh<_i73.SubOrdersScreen>(),
        gh<_i91.OrderLogsScreen>(),
        gh<_i93.OrderStatusWithoutActionsScreen>(),
      ));
  gh.factory<_i111.PaymentHistoryScreen>(
      () => _i111.PaymentHistoryScreen(gh<_i94.PaymentHistoryStateManager>()));
  gh.factory<_i112.PlanModule>(() => _i112.PlanModule(
        gh<_i101.AccountBalanceScreen>(),
        gh<_i7.CaptainFinancialDuesDetailsScreen>(),
        gh<_i104.CaptainFinancialDuesScreen>(),
        gh<_i109.MyProfitsScreen>(),
        gh<_i111.PaymentHistoryScreen>(),
        gh<_i95.PlanDetailsScreen>(),
      ));
  gh.factory<_i113.PlanScreen>(
      () => _i113.PlanScreen(gh<_i96.PlanScreenStateManager>()));
  gh.factory<_i114.ProfileModule>(() => _i114.ProfileModule(
        gh<_i103.ActivityScreen>(),
        gh<_i106.EditProfileScreen>(),
        gh<_i102.AccountBalanceScreen>(),
      ));
  gh.factory<_i115.MyApp>(() => _i115.MyApp(
        gh<_i25.AppThemeDataService>(),
        gh<_i16.LocalizationService>(),
        gh<_i55.FireNotificationService>(),
        gh<_i14.LocalNotificationService>(),
        gh<_i72.SplashModule>(),
        gh<_i80.AuthorizationModule>(),
        gh<_i105.ChatModule>(),
        gh<_i97.SettingsModule>(),
        gh<_i100.AboutModule>(),
        gh<_i107.InitAccountModule>(),
        gh<_i110.OrdersModule>(),
        gh<_i112.PlanModule>(),
        gh<_i114.ProfileModule>(),
        gh<_i108.MyNotificationsModule>(),
      ));
  return getIt;
}

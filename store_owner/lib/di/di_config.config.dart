// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i100;
import '../module_about/about_module.dart' as _i98;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i38;
import '../module_about/repository/about_repository.dart' as _i22;
import '../module_about/service/about_service/about_service.dart' as _i39;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i56;
import '../module_about/state_manager/company_info_state_manager.dart' as _i76;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i72;
import '../module_about/ui/screen/company_info/company_info_screen.dart'
    as _i89;
import '../module_auth/authoriazation_module.dart' as _i58;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i23;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../module_auth/service/auth_service/auth_service.dart' as _i24;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i29;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i35;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i45;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i46;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i51;
import '../module_branches/branches_module.dart' as _i88;
import '../module_branches/manager/branches_manager.dart' as _i40;
import '../module_branches/repository/branches_repository.dart' as _i25;
import '../module_branches/service/branches_list_service.dart' as _i59;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i60;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i64;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i70;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i74;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i78;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i87;
import '../module_chat/chat_module.dart' as _i75;
import '../module_chat/manager/chat/chat_manager.dart' as _i41;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i26;
import '../module_chat/service/chat/char_service.dart' as _i42;
import '../module_chat/state_manager/chat_state_manager.dart' as _i43;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i61;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i47;
import '../module_my_notifications/my_notifications_module.dart' as _i99;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i30;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i48;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i80;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i55;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i91;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i71;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i31;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i44;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/hive/order_hive_helper.dart' as _i13;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i33;
import '../module_orders/orders_module.dart' as _i95;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i32;
import '../module_orders/service/orders/orders.service.dart' as _i65;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i81;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i82;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i83;
import '../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i66;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i92;
import '../module_orders/ui/screens/order_details/order_details_screen.dart'
    as _i93;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i94;
import '../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i84;
import '../module_profile/manager/profile/profile.manager.dart' as _i49;
import '../module_profile/module_profile.dart' as _i85;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i14;
import '../module_profile/repository/profile/profile.repository.dart' as _i34;
import '../module_profile/service/profile/profile.service.dart' as _i50;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i57;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i62;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i63;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i73;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i67;
import '../module_profile/ui/screen/init_account_screen.dart' as _i77;
import '../module_settings/settings_module.dart' as _i68;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/copy_map_link.dart' as _i6;
import '../module_settings/ui/settings_page/settings_page.dart' as _i52;
import '../module_splash/splash_module.dart' as _i53;
import '../module_splash/ui/screen/splash_screen.dart' as _i36;
import '../module_subscription/manager/subscription_manager.dart' as _i54;
import '../module_subscription/repository/subscription_repository.dart' as _i37;
import '../module_subscription/service/subscription_service.dart' as _i69;
import '../module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i79;
import '../module_subscription/state_manager/subscription_balance_state_manager.dart'
    as _i86;
import '../module_subscription/subscriptions_module.dart' as _i97;
import '../module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i90;
import '../module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart'
    as _i96;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i28;
import '../utils/global/global_state_manager.dart' as _i101;
import '../utils/helpers/firestore_helper.dart' as _i7;
import '../utils/logger/logger.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutHiveHelper>(() => _i3.AboutHiveHelper());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.ChatHiveHelper>(() => _i5.ChatHiveHelper());
  gh.factory<_i6.CopyMapLinkScreen>(() => _i6.CopyMapLinkScreen());
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
  gh.factory<_i13.OrderHiveHelper>(() => _i13.OrderHiveHelper());
  gh.factory<_i14.ProfilePreferencesHelper>(
      () => _i14.ProfilePreferencesHelper());
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
      _i24.AuthService(get<_i4.AuthPrefsHelper>(), get<_i23.AuthManager>()));
  gh.factory<_i25.BranchesRepository>(() =>
      _i25.BranchesRepository(get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i26.ChatRepository>(() =>
      _i26.ChatRepository(get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i27.ForgotPassStateManager>(
      () => _i27.ForgotPassStateManager(get<_i24.AuthService>()));
  gh.factory<_i28.ImageUploadService>(
      () => _i28.ImageUploadService(get<_i21.UploadManager>()));
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
  gh.factory<_i34.ProfileRepository>(() =>
      _i34.ProfileRepository(get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i35.RegisterStateManager>(
      () => _i35.RegisterStateManager(get<_i24.AuthService>()));
  gh.factory<_i36.SplashScreen>(
      () => _i36.SplashScreen(get<_i24.AuthService>()));
  gh.factory<_i37.SubscriptionsRepository>(() => _i37.SubscriptionsRepository(
      get<_i17.ApiClient>(), get<_i24.AuthService>()));
  gh.factory<_i38.AboutManager>(
      () => _i38.AboutManager(get<_i22.AboutRepository>()));
  gh.factory<_i39.AboutService>(
      () => _i39.AboutService(get<_i38.AboutManager>()));
  gh.factory<_i40.BranchesManager>(
      () => _i40.BranchesManager(get<_i25.BranchesRepository>()));
  gh.factory<_i41.ChatManager>(
      () => _i41.ChatManager(get<_i26.ChatRepository>()));
  gh.factory<_i42.ChatService>(() => _i42.ChatService(get<_i41.ChatManager>()));
  gh.factory<_i43.ChatStateManager>(
      () => _i43.ChatStateManager(get<_i42.ChatService>()));
  gh.factory<_i44.FireNotificationService>(() => _i44.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i31.NotificationRepo>()));
  gh.factory<_i45.ForgotPassScreen>(
      () => _i45.ForgotPassScreen(get<_i27.ForgotPassStateManager>()));
  gh.factory<_i46.LoginScreen>(
      () => _i46.LoginScreen(get<_i29.LoginStateManager>()));
  gh.factory<_i47.MyNotificationsManager>(
      () => _i47.MyNotificationsManager(get<_i30.MyNotificationsRepository>()));
  gh.factory<_i48.MyNotificationsService>(
      () => _i48.MyNotificationsService(get<_i47.MyNotificationsManager>()));
  gh.factory<_i49.ProfileManager>(
      () => _i49.ProfileManager(get<_i34.ProfileRepository>()));
  gh.factory<_i50.ProfileService>(() => _i50.ProfileService(
      get<_i49.ProfileManager>(),
      get<_i14.ProfilePreferencesHelper>(),
      get<_i24.AuthService>()));
  gh.factory<_i51.RegisterScreen>(
      () => _i51.RegisterScreen(get<_i35.RegisterStateManager>()));
  gh.factory<_i52.SettingsScreen>(() => _i52.SettingsScreen(
      get<_i24.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i18.AppThemeDataService>(),
      get<_i44.FireNotificationService>()));
  gh.factory<_i53.SplashModule>(
      () => _i53.SplashModule(get<_i36.SplashScreen>()));
  gh.factory<_i54.SubscriptionsManager>(
      () => _i54.SubscriptionsManager(get<_i37.SubscriptionsRepository>()));
  gh.factory<_i55.UpdatesStateManager>(() => _i55.UpdatesStateManager(
      get<_i48.MyNotificationsService>(), get<_i24.AuthService>()));
  gh.factory<_i56.AboutScreenStateManager>(() => _i56.AboutScreenStateManager(
      get<_i10.LocalizationService>(), get<_i39.AboutService>()));
  gh.factory<_i57.AccountBalanceStateManager>(() =>
      _i57.AccountBalanceStateManager(get<_i50.ProfileService>(),
          get<_i24.AuthService>(), get<_i28.ImageUploadService>()));
  gh.factory<_i58.AuthorizationModule>(() => _i58.AuthorizationModule(
      get<_i46.LoginScreen>(),
      get<_i51.RegisterScreen>(),
      get<_i45.ForgotPassScreen>()));
  gh.factory<_i59.BranchesListService>(() => _i59.BranchesListService(
      get<_i40.BranchesManager>(), get<_i14.ProfilePreferencesHelper>()));
  gh.factory<_i60.BranchesListStateManager>(
      () => _i60.BranchesListStateManager(get<_i59.BranchesListService>()));
  gh.factory<_i61.ChatPage>(() => _i61.ChatPage(
      get<_i43.ChatStateManager>(),
      get<_i28.ImageUploadService>(),
      get<_i24.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i62.EditProfileStateManager>(() => _i62.EditProfileStateManager(
      get<_i28.ImageUploadService>(),
      get<_i50.ProfileService>(),
      get<_i24.AuthService>()));
  gh.factory<_i63.InitAccountStateManager>(() => _i63.InitAccountStateManager(
      get<_i50.ProfileService>(),
      get<_i24.AuthService>(),
      get<_i28.ImageUploadService>()));
  gh.factory<_i64.InitBranchesStateManager>(
      () => _i64.InitBranchesStateManager(get<_i59.BranchesListService>()));
  gh.factory<_i65.OrdersService>(() => _i65.OrdersService(
      get<_i33.OrdersManager>(), get<_i50.ProfileService>()));
  gh.factory<_i66.OwnerOrdersStateManager>(() => _i66.OwnerOrdersStateManager(
      get<_i65.OrdersService>(),
      get<_i24.AuthService>(),
      get<_i50.ProfileService>()));
  gh.factory<_i67.ProfileScreen>(
      () => _i67.ProfileScreen(get<_i62.EditProfileStateManager>()));
  gh.factory<_i68.SettingsModule>(() => _i68.SettingsModule(
      get<_i52.SettingsScreen>(),
      get<_i20.ChooseLocalScreen>(),
      get<_i6.CopyMapLinkScreen>()));
  gh.factory<_i69.SubscriptionService>(
      () => _i69.SubscriptionService(get<_i54.SubscriptionsManager>()));
  gh.factory<_i70.UpdateBranchStateManager>(
      () => _i70.UpdateBranchStateManager(get<_i59.BranchesListService>()));
  gh.factory<_i71.UpdateScreen>(
      () => _i71.UpdateScreen(get<_i55.UpdatesStateManager>()));
  gh.factory<_i72.AboutScreen>(
      () => _i72.AboutScreen(get<_i56.AboutScreenStateManager>()));
  gh.factory<_i73.AccountBalanceScreen>(
      () => _i73.AccountBalanceScreen(get<_i57.AccountBalanceStateManager>()));
  gh.factory<_i74.BranchesListScreen>(
      () => _i74.BranchesListScreen(get<_i60.BranchesListStateManager>()));
  gh.factory<_i75.ChatModule>(
      () => _i75.ChatModule(get<_i61.ChatPage>(), get<_i24.AuthService>()));
  gh.factory<_i76.CompanyInfoStateManager>(() => _i76.CompanyInfoStateManager(
      get<_i65.OrdersService>(),
      get<_i24.AuthService>(),
      get<_i50.ProfileService>()));
  gh.factory<_i77.InitAccountScreen>(
      () => _i77.InitAccountScreen(get<_i63.InitAccountStateManager>()));
  gh.factory<_i78.InitBranchesScreen>(
      () => _i78.InitBranchesScreen(get<_i64.InitBranchesStateManager>()));
  gh.factory<_i79.InitSubscriptionStateManager>(() =>
      _i79.InitSubscriptionStateManager(
          get<_i69.SubscriptionService>(),
          get<_i50.ProfileService>(),
          get<_i24.AuthService>(),
          get<_i28.ImageUploadService>()));
  gh.factory<_i80.MyNotificationsStateManager>(() =>
      _i80.MyNotificationsStateManager(get<_i48.MyNotificationsService>(),
          get<_i65.OrdersService>(), get<_i24.AuthService>()));
  gh.factory<_i81.NewOrderStateManager>(
      () => _i81.NewOrderStateManager(get<_i65.OrdersService>()));
  gh.factory<_i82.OrderLogsStateManager>(
      () => _i82.OrderLogsStateManager(get<_i65.OrdersService>()));
  gh.factory<_i83.OrderStatusStateManager>(() => _i83.OrderStatusStateManager(
      get<_i65.OrdersService>(), get<_i24.AuthService>()));
  gh.factory<_i84.OwnerOrdersScreen>(() => _i84.OwnerOrdersScreen(
      get<_i66.OwnerOrdersStateManager>(), get<_i81.NewOrderStateManager>()));
  gh.factory<_i85.ProfileModule>(() => _i85.ProfileModule(
      get<_i67.ProfileScreen>(),
      get<_i77.InitAccountScreen>(),
      get<_i73.AccountBalanceScreen>()));
  gh.factory<_i86.SubscriptionBalanceStateManager>(() =>
      _i86.SubscriptionBalanceStateManager(
          get<_i69.SubscriptionService>(),
          get<_i50.ProfileService>(),
          get<_i24.AuthService>(),
          get<_i28.ImageUploadService>()));
  gh.factory<_i87.UpdateBranchScreen>(
      () => _i87.UpdateBranchScreen(get<_i70.UpdateBranchStateManager>()));
  gh.factory<_i88.BranchesModule>(() => _i88.BranchesModule(
      get<_i74.BranchesListScreen>(),
      get<_i87.UpdateBranchScreen>(),
      get<_i78.InitBranchesScreen>()));
  gh.factory<_i89.CompanyInfoScreen>(
      () => _i89.CompanyInfoScreen(get<_i76.CompanyInfoStateManager>()));
  gh.factory<_i90.InitSubscriptionScreen>(() =>
      _i90.InitSubscriptionScreen(get<_i79.InitSubscriptionStateManager>()));
  gh.factory<_i91.MyNotificationsScreen>(() =>
      _i91.MyNotificationsScreen(get<_i80.MyNotificationsStateManager>()));
  gh.factory<_i92.NewOrderScreen>(
      () => _i92.NewOrderScreen(get<_i81.NewOrderStateManager>()));
  gh.factory<_i93.OrderDetailsScreen>(
      () => _i93.OrderDetailsScreen(get<_i83.OrderStatusStateManager>()));
  gh.factory<_i94.OrderLogsScreen>(
      () => _i94.OrderLogsScreen(get<_i82.OrderLogsStateManager>()));
  gh.factory<_i95.OrdersModule>(() => _i95.OrdersModule(
      get<_i92.NewOrderScreen>(),
      get<_i93.OrderDetailsScreen>(),
      get<_i84.OwnerOrdersScreen>(),
      get<_i94.OrderLogsScreen>()));
  gh.factory<_i96.SubscriptionBalanceScreen>(() =>
      _i96.SubscriptionBalanceScreen(
          get<_i86.SubscriptionBalanceStateManager>()));
  gh.factory<_i97.SubscriptionsModule>(() => _i97.SubscriptionsModule(
      get<_i90.InitSubscriptionScreen>(),
      get<_i96.SubscriptionBalanceScreen>()));
  gh.factory<_i98.AboutModule>(() =>
      _i98.AboutModule(get<_i72.AboutScreen>(), get<_i89.CompanyInfoScreen>()));
  gh.factory<_i99.MyNotificationsModule>(() => _i99.MyNotificationsModule(
      get<_i91.MyNotificationsScreen>(), get<_i71.UpdateScreen>()));
  gh.factory<_i100.MyApp>(() => _i100.MyApp(
      get<_i95.OrdersModule>(),
      get<_i18.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i44.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i53.SplashModule>(),
      get<_i58.AuthorizationModule>(),
      get<_i75.ChatModule>(),
      get<_i68.SettingsModule>(),
      get<_i98.AboutModule>(),
      get<_i85.ProfileModule>(),
      get<_i88.BranchesModule>(),
      get<_i97.SubscriptionsModule>(),
      get<_i99.MyNotificationsModule>()));
  gh.singleton<_i101.GlobalStateManager>(_i101.GlobalStateManager());
  return get;
}

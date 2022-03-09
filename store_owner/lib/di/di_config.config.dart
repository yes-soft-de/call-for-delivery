// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i94;
import '../module_about/about_module.dart' as _i71;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i37;
import '../module_about/repository/about_repository.dart' as _i21;
import '../module_about/service/about_service/about_service.dart' as _i38;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i55;
import '../module_auth/authoriazation_module.dart' as _i57;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i22;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i23;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i28;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i34;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i44;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i45;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i51;
import '../module_branches/branches_module.dart' as _i86;
import '../module_branches/manager/branches_manager.dart' as _i39;
import '../module_branches/repository/branches_repository.dart' as _i24;
import '../module_branches/service/branches_list_service.dart' as _i58;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i59;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i63;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i70;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i73;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i76;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i85;
import '../module_chat/chat_module.dart' as _i74;
import '../module_chat/manager/chat/chat_manager.dart' as _i40;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i25;
import '../module_chat/service/chat/char_service.dart' as _i41;
import '../module_chat/state_manager/chat_state_manager.dart' as _i42;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i60;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i8;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i9;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i46;
import '../module_my_notifications/my_notifications_module.dart' as _i78;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i29;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i47;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i48;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i64;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i30;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i43;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i7;
import '../module_orders/hive/order_hive_helper.dart' as _i12;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i32;
import '../module_orders/orders_module.dart' as _i91;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i31;
import '../module_orders/service/orders/orders.service.dart' as _i65;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i79;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i80;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i81;
import '../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i66;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i88;
import '../module_orders/ui/screens/order_details/order_details_screen.dart'
    as _i89;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i90;
import '../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i82;
import '../module_profile/manager/profile/profile.manager.dart' as _i49;
import '../module_profile/module_profile.dart' as _i83;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i13;
import '../module_profile/repository/profile/profile.repository.dart' as _i33;
import '../module_profile/service/profile/profile.service.dart' as _i50;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i56;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i61;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i62;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i72;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i67;
import '../module_profile/ui/screen/init_account_screen.dart' as _i75;
import '../module_settings/settings_module.dart' as _i68;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i19;
import '../module_settings/ui/settings_page/settings_page.dart' as _i52;
import '../module_splash/splash_module.dart' as _i53;
import '../module_splash/ui/screen/splash_screen.dart' as _i35;
import '../module_subscription/manager/subscription_manager.dart' as _i54;
import '../module_subscription/repository/subscription_repository.dart' as _i36;
import '../module_subscription/service/subscription_service.dart' as _i69;
import '../module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i77;
import '../module_subscription/state_manager/subscription_balance_state_manager.dart'
    as _i84;
import '../module_subscription/subscriptions_module.dart' as _i93;
import '../module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i87;
import '../module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart'
    as _i92;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i20;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i27;
import '../utils/global/global_state_manager.dart' as _i95;
import '../utils/helpers/firestore_helper.dart' as _i6;
import '../utils/logger/logger.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutHiveHelper>(() => _i3.AboutHiveHelper());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.ChatHiveHelper>(() => _i5.ChatHiveHelper());
  gh.factory<_i6.FireStoreHelper>(() => _i6.FireStoreHelper());
  gh.factory<_i7.LocalNotificationService>(
      () => _i7.LocalNotificationService());
  gh.factory<_i8.LocalizationPreferencesHelper>(
      () => _i8.LocalizationPreferencesHelper());
  gh.factory<_i9.LocalizationService>(
      () => _i9.LocalizationService(get<_i8.LocalizationPreferencesHelper>()));
  gh.factory<_i10.Logger>(() => _i10.Logger());
  gh.factory<_i11.NotificationsPrefHelper>(
      () => _i11.NotificationsPrefHelper());
  gh.factory<_i12.OrderHiveHelper>(() => _i12.OrderHiveHelper());
  gh.factory<_i13.ProfilePreferencesHelper>(
      () => _i13.ProfilePreferencesHelper());
  gh.factory<_i14.ThemePreferencesHelper>(() => _i14.ThemePreferencesHelper());
  gh.factory<_i15.UploadRepository>(() => _i15.UploadRepository());
  gh.factory<_i16.ApiClient>(() => _i16.ApiClient(get<_i10.Logger>()));
  gh.factory<_i17.AppThemeDataService>(
      () => _i17.AppThemeDataService(get<_i14.ThemePreferencesHelper>()));
  gh.factory<_i18.AuthRepository>(
      () => _i18.AuthRepository(get<_i16.ApiClient>(), get<_i10.Logger>()));
  gh.factory<_i19.ChooseLocalScreen>(
      () => _i19.ChooseLocalScreen(get<_i9.LocalizationService>()));
  gh.factory<_i20.UploadManager>(
      () => _i20.UploadManager(get<_i15.UploadRepository>()));
  gh.factory<_i21.AboutRepository>(
      () => _i21.AboutRepository(get<_i16.ApiClient>()));
  gh.factory<_i22.AuthManager>(
      () => _i22.AuthManager(get<_i18.AuthRepository>()));
  gh.factory<_i23.AuthService>(() =>
      _i23.AuthService(get<_i4.AuthPrefsHelper>(), get<_i22.AuthManager>()));
  gh.factory<_i24.BranchesRepository>(() =>
      _i24.BranchesRepository(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i25.ChatRepository>(() =>
      _i25.ChatRepository(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i26.ForgotPassStateManager>(
      () => _i26.ForgotPassStateManager(get<_i23.AuthService>()));
  gh.factory<_i27.ImageUploadService>(
      () => _i27.ImageUploadService(get<_i20.UploadManager>()));
  gh.factory<_i28.LoginStateManager>(
      () => _i28.LoginStateManager(get<_i23.AuthService>()));
  gh.factory<_i29.MyNotificationsRepository>(() =>
      _i29.MyNotificationsRepository(
          get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i30.NotificationRepo>(() =>
      _i30.NotificationRepo(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i31.OrderRepository>(() =>
      _i31.OrderRepository(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i32.OrdersManager>(
      () => _i32.OrdersManager(get<_i31.OrderRepository>()));
  gh.factory<_i33.ProfileRepository>(() =>
      _i33.ProfileRepository(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i34.RegisterStateManager>(
      () => _i34.RegisterStateManager(get<_i23.AuthService>()));
  gh.factory<_i35.SplashScreen>(
      () => _i35.SplashScreen(get<_i23.AuthService>()));
  gh.factory<_i36.SubscriptionsRepository>(() => _i36.SubscriptionsRepository(
      get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i37.AboutManager>(
      () => _i37.AboutManager(get<_i21.AboutRepository>()));
  gh.factory<_i38.AboutService>(
      () => _i38.AboutService(get<_i37.AboutManager>()));
  gh.factory<_i39.BranchesManager>(
      () => _i39.BranchesManager(get<_i24.BranchesRepository>()));
  gh.factory<_i40.ChatManager>(
      () => _i40.ChatManager(get<_i25.ChatRepository>()));
  gh.factory<_i41.ChatService>(() => _i41.ChatService(get<_i40.ChatManager>()));
  gh.factory<_i42.ChatStateManager>(
      () => _i42.ChatStateManager(get<_i41.ChatService>()));
  gh.factory<_i43.FireNotificationService>(() => _i43.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i30.NotificationRepo>()));
  gh.factory<_i44.ForgotPassScreen>(
      () => _i44.ForgotPassScreen(get<_i26.ForgotPassStateManager>()));
  gh.factory<_i45.LoginScreen>(
      () => _i45.LoginScreen(get<_i28.LoginStateManager>()));
  gh.factory<_i46.MyNotificationsManager>(
      () => _i46.MyNotificationsManager(get<_i29.MyNotificationsRepository>()));
  gh.factory<_i47.MyNotificationsService>(
      () => _i47.MyNotificationsService(get<_i46.MyNotificationsManager>()));
  gh.factory<_i48.MyNotificationsStateManager>(() =>
      _i48.MyNotificationsStateManager(
          get<_i47.MyNotificationsService>(), get<_i23.AuthService>()));
  gh.factory<_i49.ProfileManager>(
      () => _i49.ProfileManager(get<_i33.ProfileRepository>()));
  gh.factory<_i50.ProfileService>(() => _i50.ProfileService(
      get<_i49.ProfileManager>(),
      get<_i13.ProfilePreferencesHelper>(),
      get<_i23.AuthService>()));
  gh.factory<_i51.RegisterScreen>(
      () => _i51.RegisterScreen(get<_i34.RegisterStateManager>()));
  gh.factory<_i52.SettingsScreen>(() => _i52.SettingsScreen(
      get<_i23.AuthService>(),
      get<_i9.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i43.FireNotificationService>()));
  gh.factory<_i53.SplashModule>(
      () => _i53.SplashModule(get<_i35.SplashScreen>()));
  gh.factory<_i54.SubscriptionsManager>(
      () => _i54.SubscriptionsManager(get<_i36.SubscriptionsRepository>()));
  gh.factory<_i55.AboutScreenStateManager>(() => _i55.AboutScreenStateManager(
      get<_i9.LocalizationService>(), get<_i38.AboutService>()));
  gh.factory<_i56.AccountBalanceStateManager>(() =>
      _i56.AccountBalanceStateManager(get<_i50.ProfileService>(),
          get<_i23.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i57.AuthorizationModule>(() => _i57.AuthorizationModule(
      get<_i45.LoginScreen>(),
      get<_i51.RegisterScreen>(),
      get<_i44.ForgotPassScreen>()));
  gh.factory<_i58.BranchesListService>(() => _i58.BranchesListService(
      get<_i39.BranchesManager>(), get<_i13.ProfilePreferencesHelper>()));
  gh.factory<_i59.BranchesListStateManager>(
      () => _i59.BranchesListStateManager(get<_i58.BranchesListService>()));
  gh.factory<_i60.ChatPage>(() => _i60.ChatPage(
      get<_i42.ChatStateManager>(),
      get<_i27.ImageUploadService>(),
      get<_i23.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i61.EditProfileStateManager>(() => _i61.EditProfileStateManager(
      get<_i27.ImageUploadService>(),
      get<_i50.ProfileService>(),
      get<_i23.AuthService>()));
  gh.factory<_i62.InitAccountStateManager>(() => _i62.InitAccountStateManager(
      get<_i50.ProfileService>(),
      get<_i23.AuthService>(),
      get<_i27.ImageUploadService>()));
  gh.factory<_i63.InitBranchesStateManager>(
      () => _i63.InitBranchesStateManager(get<_i58.BranchesListService>()));
  gh.factory<_i64.MyNotificationsScreen>(() =>
      _i64.MyNotificationsScreen(get<_i48.MyNotificationsStateManager>()));
  gh.factory<_i65.OrdersService>(() => _i65.OrdersService(
      get<_i32.OrdersManager>(), get<_i50.ProfileService>()));
  gh.factory<_i66.OwnerOrdersStateManager>(() => _i66.OwnerOrdersStateManager(
      get<_i65.OrdersService>(),
      get<_i23.AuthService>(),
      get<_i50.ProfileService>()));
  gh.factory<_i67.ProfileScreen>(
      () => _i67.ProfileScreen(get<_i61.EditProfileStateManager>()));
  gh.factory<_i68.SettingsModule>(() => _i68.SettingsModule(
      get<_i52.SettingsScreen>(), get<_i19.ChooseLocalScreen>()));
  gh.factory<_i69.SubscriptionService>(
      () => _i69.SubscriptionService(get<_i54.SubscriptionsManager>()));
  gh.factory<_i70.UpdateBranchStateManager>(
      () => _i70.UpdateBranchStateManager(get<_i58.BranchesListService>()));
  gh.factory<_i71.AboutModule>(
      () => _i71.AboutModule(get<_i55.AboutScreenStateManager>()));
  gh.factory<_i72.AccountBalanceScreen>(
      () => _i72.AccountBalanceScreen(get<_i56.AccountBalanceStateManager>()));
  gh.factory<_i73.BranchesListScreen>(
      () => _i73.BranchesListScreen(get<_i59.BranchesListStateManager>()));
  gh.factory<_i74.ChatModule>(
      () => _i74.ChatModule(get<_i60.ChatPage>(), get<_i23.AuthService>()));
  gh.factory<_i75.InitAccountScreen>(
      () => _i75.InitAccountScreen(get<_i62.InitAccountStateManager>()));
  gh.factory<_i76.InitBranchesScreen>(
      () => _i76.InitBranchesScreen(get<_i63.InitBranchesStateManager>()));
  gh.factory<_i77.InitSubscriptionStateManager>(() =>
      _i77.InitSubscriptionStateManager(
          get<_i69.SubscriptionService>(),
          get<_i50.ProfileService>(),
          get<_i23.AuthService>(),
          get<_i27.ImageUploadService>()));
  gh.factory<_i78.MyNotificationsModule>(
      () => _i78.MyNotificationsModule(get<_i64.MyNotificationsScreen>()));
  gh.factory<_i79.NewOrderStateManager>(
      () => _i79.NewOrderStateManager(get<_i65.OrdersService>()));
  gh.factory<_i80.OrderLogsStateManager>(
      () => _i80.OrderLogsStateManager(get<_i65.OrdersService>()));
  gh.factory<_i81.OrderStatusStateManager>(() => _i81.OrderStatusStateManager(
      get<_i65.OrdersService>(), get<_i23.AuthService>()));
  gh.factory<_i82.OwnerOrdersScreen>(() => _i82.OwnerOrdersScreen(
      get<_i66.OwnerOrdersStateManager>(), get<_i79.NewOrderStateManager>()));
  gh.factory<_i83.ProfileModule>(() => _i83.ProfileModule(
      get<_i67.ProfileScreen>(),
      get<_i75.InitAccountScreen>(),
      get<_i72.AccountBalanceScreen>()));
  gh.factory<_i84.SubscriptionBalanceStateManager>(() =>
      _i84.SubscriptionBalanceStateManager(
          get<_i69.SubscriptionService>(),
          get<_i50.ProfileService>(),
          get<_i23.AuthService>(),
          get<_i27.ImageUploadService>()));
  gh.factory<_i85.UpdateBranchScreen>(
      () => _i85.UpdateBranchScreen(get<_i70.UpdateBranchStateManager>()));
  gh.factory<_i86.BranchesModule>(() => _i86.BranchesModule(
      get<_i73.BranchesListScreen>(),
      get<_i85.UpdateBranchScreen>(),
      get<_i76.InitBranchesScreen>()));
  gh.factory<_i87.InitSubscriptionScreen>(() =>
      _i87.InitSubscriptionScreen(get<_i77.InitSubscriptionStateManager>()));
  gh.factory<_i88.NewOrderScreen>(
      () => _i88.NewOrderScreen(get<_i79.NewOrderStateManager>()));
  gh.factory<_i89.OrderDetailsScreen>(
      () => _i89.OrderDetailsScreen(get<_i81.OrderStatusStateManager>()));
  gh.factory<_i90.OrderLogsScreen>(
      () => _i90.OrderLogsScreen(get<_i80.OrderLogsStateManager>()));
  gh.factory<_i91.OrdersModule>(() => _i91.OrdersModule(
      get<_i88.NewOrderScreen>(),
      get<_i89.OrderDetailsScreen>(),
      get<_i82.OwnerOrdersScreen>(),
      get<_i90.OrderLogsScreen>()));
  gh.factory<_i92.SubscriptionBalanceScreen>(() =>
      _i92.SubscriptionBalanceScreen(
          get<_i84.SubscriptionBalanceStateManager>()));
  gh.factory<_i93.SubscriptionsModule>(() => _i93.SubscriptionsModule(
      get<_i87.InitSubscriptionScreen>(),
      get<_i92.SubscriptionBalanceScreen>()));
  gh.factory<_i94.MyApp>(() => _i94.MyApp(
      get<_i91.OrdersModule>(),
      get<_i17.AppThemeDataService>(),
      get<_i9.LocalizationService>(),
      get<_i43.FireNotificationService>(),
      get<_i7.LocalNotificationService>(),
      get<_i53.SplashModule>(),
      get<_i57.AuthorizationModule>(),
      get<_i74.ChatModule>(),
      get<_i68.SettingsModule>(),
      get<_i71.AboutModule>(),
      get<_i83.ProfileModule>(),
      get<_i86.BranchesModule>(),
      get<_i93.SubscriptionsModule>(),
      get<_i78.MyNotificationsModule>()));
  gh.singleton<_i95.GlobalStateManager>(_i95.GlobalStateManager());
  return get;
}

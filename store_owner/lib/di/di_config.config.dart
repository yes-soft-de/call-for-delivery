// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i84;
import '../module_about/about_module.dart' as _i65;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i36;
import '../module_about/repository/about_repository.dart' as _i21;
import '../module_about/service/about_service/about_service.dart' as _i37;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i51;
import '../module_auth/authoriazation_module.dart' as _i53;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i22;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i18;
import '../module_auth/service/auth_service/auth_service.dart' as _i23;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i26;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i28;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i33;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i43;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i44;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i47;
import '../module_branches/branches_module.dart' as _i78;
import '../module_branches/manager/branches_manager.dart' as _i38;
import '../module_branches/repository/branches_repository.dart' as _i24;
import '../module_branches/service/branches_list_service.dart' as _i54;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i55;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i59;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i64;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i67;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i71;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i77;
import '../module_chat/chat_module.dart' as _i68;
import '../module_chat/manager/chat/chat_manager.dart' as _i39;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i25;
import '../module_chat/service/chat/char_service.dart' as _i40;
import '../module_chat/state_manager/chat_state_manager.dart' as _i41;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i56;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i8;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i9;
import '../module_network/http_client/http_client.dart' as _i16;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i11;
import '../module_notifications/repository/notification_repo.dart' as _i29;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i42;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i7;
import '../module_orders/hive/order_hive_helper.dart' as _i12;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i31;
import '../module_orders/orders_module.dart' as _i82;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i30;
import '../module_orders/service/orders/orders.service.dart' as _i60;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i73;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i74;
import '../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i61;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i80;
import '../module_orders/ui/screens/order_status/order_status_screen.dart'
    as _i81;
import '../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i75;
import '../module_profile/manager/profile/profile.manager.dart' as _i45;
import '../module_profile/module_profile.dart' as _i76;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i13;
import '../module_profile/repository/profile/profile.repository.dart' as _i32;
import '../module_profile/service/profile/profile.service.dart' as _i46;
import '../module_profile/state_manager/activity/activity_state_manager.dart'
    as _i52;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i57;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i58;
import '../module_profile/ui/screen/activity_screen/activity_screen.dart'
    as _i66;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i69;
import '../module_profile/ui/screen/init_account_screen.dart' as _i70;
import '../module_settings/settings_module.dart' as _i62;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i19;
import '../module_settings/ui/settings_page/settings_page.dart' as _i48;
import '../module_splash/splash_module.dart' as _i49;
import '../module_splash/ui/screen/splash_screen.dart' as _i34;
import '../module_subscription/manager/subscription_manager.dart' as _i50;
import '../module_subscription/repository/subscription_repository.dart' as _i35;
import '../module_subscription/service/subscription_service.dart' as _i63;
import '../module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i72;
import '../module_subscription/subscriptions_module.dart' as _i83;
import '../module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i79;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i14;
import '../module_theme/service/theme_service/theme_service.dart' as _i17;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i20;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i15;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i27;
import '../utils/global/global_state_manager.dart' as _i85;
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
  gh.factory<_i29.NotificationRepo>(() =>
      _i29.NotificationRepo(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i30.OrderRepository>(() =>
      _i30.OrderRepository(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i31.OrdersManager>(
      () => _i31.OrdersManager(get<_i30.OrderRepository>()));
  gh.factory<_i32.ProfileRepository>(() =>
      _i32.ProfileRepository(get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i33.RegisterStateManager>(
      () => _i33.RegisterStateManager(get<_i23.AuthService>()));
  gh.factory<_i34.SplashScreen>(
      () => _i34.SplashScreen(get<_i23.AuthService>()));
  gh.factory<_i35.SubscriptionsRepository>(() => _i35.SubscriptionsRepository(
      get<_i16.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i36.AboutManager>(
      () => _i36.AboutManager(get<_i21.AboutRepository>()));
  gh.factory<_i37.AboutService>(
      () => _i37.AboutService(get<_i36.AboutManager>()));
  gh.factory<_i38.BranchesManager>(
      () => _i38.BranchesManager(get<_i24.BranchesRepository>()));
  gh.factory<_i39.ChatManager>(
      () => _i39.ChatManager(get<_i25.ChatRepository>()));
  gh.factory<_i40.ChatService>(() => _i40.ChatService(get<_i39.ChatManager>()));
  gh.factory<_i41.ChatStateManager>(
      () => _i41.ChatStateManager(get<_i40.ChatService>()));
  gh.factory<_i42.FireNotificationService>(() => _i42.FireNotificationService(
      get<_i11.NotificationsPrefHelper>(), get<_i29.NotificationRepo>()));
  gh.factory<_i43.ForgotPassScreen>(
      () => _i43.ForgotPassScreen(get<_i26.ForgotPassStateManager>()));
  gh.factory<_i44.LoginScreen>(
      () => _i44.LoginScreen(get<_i28.LoginStateManager>()));
  gh.factory<_i45.ProfileManager>(
      () => _i45.ProfileManager(get<_i32.ProfileRepository>()));
  gh.factory<_i46.ProfileService>(() => _i46.ProfileService(
      get<_i45.ProfileManager>(),
      get<_i13.ProfilePreferencesHelper>(),
      get<_i23.AuthService>()));
  gh.factory<_i47.RegisterScreen>(
      () => _i47.RegisterScreen(get<_i33.RegisterStateManager>()));
  gh.factory<_i48.SettingsScreen>(() => _i48.SettingsScreen(
      get<_i23.AuthService>(),
      get<_i9.LocalizationService>(),
      get<_i17.AppThemeDataService>(),
      get<_i42.FireNotificationService>()));
  gh.factory<_i49.SplashModule>(
      () => _i49.SplashModule(get<_i34.SplashScreen>()));
  gh.factory<_i50.SubscriptionsManager>(
      () => _i50.SubscriptionsManager(get<_i35.SubscriptionsRepository>()));
  gh.factory<_i51.AboutScreenStateManager>(() => _i51.AboutScreenStateManager(
      get<_i9.LocalizationService>(), get<_i37.AboutService>()));
  gh.factory<_i52.ActivityStateManager>(() => _i52.ActivityStateManager(
      get<_i46.ProfileService>(), get<_i23.AuthService>()));
  gh.factory<_i53.AuthorizationModule>(() => _i53.AuthorizationModule(
      get<_i44.LoginScreen>(),
      get<_i47.RegisterScreen>(),
      get<_i43.ForgotPassScreen>()));
  gh.factory<_i54.BranchesListService>(() => _i54.BranchesListService(
      get<_i38.BranchesManager>(), get<_i13.ProfilePreferencesHelper>()));
  gh.factory<_i55.BranchesListStateManager>(
      () => _i55.BranchesListStateManager(get<_i54.BranchesListService>()));
  gh.factory<_i56.ChatPage>(() => _i56.ChatPage(
      get<_i41.ChatStateManager>(),
      get<_i27.ImageUploadService>(),
      get<_i23.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i57.EditProfileStateManager>(() => _i57.EditProfileStateManager(
      get<_i27.ImageUploadService>(),
      get<_i46.ProfileService>(),
      get<_i23.AuthService>()));
  gh.factory<_i58.InitAccountStateManager>(() => _i58.InitAccountStateManager(
      get<_i46.ProfileService>(),
      get<_i23.AuthService>(),
      get<_i27.ImageUploadService>()));
  gh.factory<_i59.InitBranchesStateManager>(
      () => _i59.InitBranchesStateManager(get<_i54.BranchesListService>()));
  gh.factory<_i60.OrdersService>(() => _i60.OrdersService(
      get<_i31.OrdersManager>(), get<_i46.ProfileService>()));
  gh.factory<_i61.OwnerOrdersStateManager>(() => _i61.OwnerOrdersStateManager(
      get<_i60.OrdersService>(),
      get<_i23.AuthService>(),
      get<_i46.ProfileService>()));
  gh.factory<_i62.SettingsModule>(() => _i62.SettingsModule(
      get<_i48.SettingsScreen>(), get<_i19.ChooseLocalScreen>()));
  gh.factory<_i63.SubscriptionService>(
      () => _i63.SubscriptionService(get<_i50.SubscriptionsManager>()));
  gh.factory<_i64.UpdateBranchStateManager>(
      () => _i64.UpdateBranchStateManager(get<_i54.BranchesListService>()));
  gh.factory<_i65.AboutModule>(
      () => _i65.AboutModule(get<_i51.AboutScreenStateManager>()));
  gh.factory<_i66.ActivityScreen>(
      () => _i66.ActivityScreen(get<_i52.ActivityStateManager>()));
  gh.factory<_i67.BranchesListScreen>(
      () => _i67.BranchesListScreen(get<_i55.BranchesListStateManager>()));
  gh.factory<_i68.ChatModule>(
      () => _i68.ChatModule(get<_i56.ChatPage>(), get<_i23.AuthService>()));
  gh.factory<_i69.EditProfileScreen>(
      () => _i69.EditProfileScreen(get<_i57.EditProfileStateManager>()));
  gh.factory<_i70.InitAccountScreen>(
      () => _i70.InitAccountScreen(get<_i58.InitAccountStateManager>()));
  gh.factory<_i71.InitBranchesScreen>(
      () => _i71.InitBranchesScreen(get<_i59.InitBranchesStateManager>()));
  gh.factory<_i72.InitSubscriptionStateManager>(() =>
      _i72.InitSubscriptionStateManager(
          get<_i63.SubscriptionService>(),
          get<_i46.ProfileService>(),
          get<_i23.AuthService>(),
          get<_i27.ImageUploadService>()));
  gh.factory<_i73.NewOrderStateManager>(() => _i73.NewOrderStateManager(
      get<_i60.OrdersService>(), get<_i46.ProfileService>()));
  gh.factory<_i74.OrderStatusStateManager>(() => _i74.OrderStatusStateManager(
      get<_i60.OrdersService>(), get<_i23.AuthService>()));
  gh.factory<_i75.OwnerOrdersScreen>(() => _i75.OwnerOrdersScreen(
      get<_i61.OwnerOrdersStateManager>(), get<_i73.NewOrderStateManager>()));
  gh.factory<_i76.ProfileModule>(() => _i76.ProfileModule(
      get<_i66.ActivityScreen>(),
      get<_i69.EditProfileScreen>(),
      get<_i70.InitAccountScreen>()));
  gh.factory<_i77.UpdateBranchScreen>(
      () => _i77.UpdateBranchScreen(get<_i64.UpdateBranchStateManager>()));
  gh.factory<_i78.BranchesModule>(() => _i78.BranchesModule(
      get<_i67.BranchesListScreen>(),
      get<_i77.UpdateBranchScreen>(),
      get<_i71.InitBranchesScreen>()));
  gh.factory<_i79.InitSubscriptionScreen>(() =>
      _i79.InitSubscriptionScreen(get<_i72.InitSubscriptionStateManager>()));
  gh.factory<_i80.NewOrderScreen>(
      () => _i80.NewOrderScreen(get<_i73.NewOrderStateManager>()));
  gh.factory<_i81.OrderStatusScreen>(
      () => _i81.OrderStatusScreen(get<_i74.OrderStatusStateManager>()));
  gh.factory<_i82.OrdersModule>(() => _i82.OrdersModule(
      get<_i80.NewOrderScreen>(),
      get<_i81.OrderStatusScreen>(),
      get<_i75.OwnerOrdersScreen>()));
  gh.factory<_i83.SubscriptionsModule>(
      () => _i83.SubscriptionsModule(get<_i79.InitSubscriptionScreen>()));
  gh.factory<_i84.MyApp>(() => _i84.MyApp(
      get<_i82.OrdersModule>(),
      get<_i17.AppThemeDataService>(),
      get<_i9.LocalizationService>(),
      get<_i42.FireNotificationService>(),
      get<_i7.LocalNotificationService>(),
      get<_i49.SplashModule>(),
      get<_i53.AuthorizationModule>(),
      get<_i68.ChatModule>(),
      get<_i62.SettingsModule>(),
      get<_i65.AboutModule>(),
      get<_i76.ProfileModule>(),
      get<_i78.BranchesModule>(),
      get<_i83.SubscriptionsModule>()));
  gh.singleton<_i85.GlobalStateManager>(_i85.GlobalStateManager());
  return get;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i85;
import '../module_about/about_module.dart' as _i82;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i53;
import '../module_about/repository/about_repository.dart' as _i35;
import '../module_about/service/about_service/about_service.dart' as _i54;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i68;
import '../module_about/state_manager/company_info_state_manager.dart' as _i58;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i78;
import '../module_about/ui/screen/company_info/company_info_screen.dart'
    as _i70;
import '../module_ads/ads_module.dart' as _i4;
import '../module_ads/repository/ads_repository.dart' as _i36;
import '../module_auth/authoriazation_module.dart' as _i55;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i22;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../module_auth/service/auth_service/auth_service.dart' as _i23;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i25;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i27;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i33;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i43;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i44;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i49;
import '../module_bid_orders/bid_orders_module.dart' as _i83;
import '../module_bid_orders/hive/order_hive_helper.dart' as _i13;
import '../module_bid_orders/manager/orders_manager/orders_manager.dart'
    as _i31;
import '../module_bid_orders/repository/order_repository/order_repository.dart'
    as _i30;
import '../module_bid_orders/service/orders/orders.service.dart' as _i63;
import '../module_bid_orders/state_manager/order_logs_state_manager.dart'
    as _i74;
import '../module_bid_orders/state_manager/order_time_line_state_manager.dart'
    as _i75;
import '../module_bid_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i64;
import '../module_bid_orders/ui/screens/order_logs_screen.dart' as _i80;
import '../module_bid_orders/ui/screens/order_time_line_screen.dart' as _i81;
import '../module_bid_orders/ui/screens/orders/my_offer_order_screen.dart'
    as _i73;
import '../module_bid_orders/ui/screens/orders/owner_orders_screen.dart'
    as _i76;
import '../module_chat/chat_module.dart' as _i69;
import '../module_chat/manager/chat/chat_manager.dart' as _i39;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i24;
import '../module_chat/service/chat/char_service.dart' as _i40;
import '../module_chat/state_manager/chat_state_manager.dart' as _i41;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i57;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main_navigation/nav_module.dart' as _i62;
import '../module_main_navigation/state_manager/bottom_nav_state_manager.dart'
    as _i56;
import '../module_main_navigation/ui/botto_nav_screen.dart' as _i61;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i45;
import '../module_my_notifications/my_notifications_module.dart' as _i84;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i28;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i46;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i72;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i52;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i79;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i67;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i29;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i42;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_profile/manager/category/category_manager.dart' as _i37;
import '../module_profile/manager/profile/profile.manager.dart' as _i47;
import '../module_profile/module_profile.dart' as _i77;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i14;
import '../module_profile/repository/profile/profile.repository.dart' as _i32;
import '../module_profile/service/category/category_service.dart' as _i38;
import '../module_profile/service/profile/profile.service.dart' as _i48;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i59;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i60;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i65;
import '../module_profile/ui/screen/init_account_screen.dart' as _i71;
import '../module_settings/settings_module.dart' as _i66;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/settings_page.dart' as _i50;
import '../module_splash/splash_module.dart' as _i51;
import '../module_splash/ui/screen/splash_screen.dart' as _i34;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i26;
import '../utils/global/global_state_manager.dart' as _i86;
import '../utils/helpers/firestore_helper.dart' as _i7;
import '../utils/logger/logger.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutHiveHelper>(() => _i3.AboutHiveHelper());
  gh.factory<_i4.AdsModule>(() => _i4.AdsModule());
  gh.factory<_i5.AuthPrefsHelper>(() => _i5.AuthPrefsHelper());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
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
  gh.factory<_i22.AuthManager>(
      () => _i22.AuthManager(get<_i19.AuthRepository>()));
  gh.factory<_i23.AuthService>(() =>
      _i23.AuthService(get<_i5.AuthPrefsHelper>(), get<_i22.AuthManager>()));
  gh.factory<_i24.ChatRepository>(() =>
      _i24.ChatRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i25.ForgotPassStateManager>(
      () => _i25.ForgotPassStateManager(get<_i23.AuthService>()));
  gh.factory<_i26.ImageUploadService>(
      () => _i26.ImageUploadService(get<_i21.UploadManager>()));
  gh.factory<_i27.LoginStateManager>(
      () => _i27.LoginStateManager(get<_i23.AuthService>()));
  gh.factory<_i28.MyNotificationsRepository>(() =>
      _i28.MyNotificationsRepository(
          get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i29.NotificationRepo>(() =>
      _i29.NotificationRepo(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i30.OrderRepository>(() =>
      _i30.OrderRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i31.OrdersManager>(
      () => _i31.OrdersManager(get<_i30.OrderRepository>()));
  gh.factory<_i32.ProfileRepository>(() =>
      _i32.ProfileRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i33.RegisterStateManager>(
      () => _i33.RegisterStateManager(get<_i23.AuthService>()));
  gh.factory<_i34.SplashScreen>(
      () => _i34.SplashScreen(get<_i23.AuthService>()));
  gh.factory<_i35.AboutRepository>(() =>
      _i35.AboutRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i36.AdsRepository>(
      () => _i36.AdsRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i37.CategoryManager>(
      () => _i37.CategoryManager(get<_i32.ProfileRepository>()));
  gh.factory<_i38.CategoryService>(
      () => _i38.CategoryService(get<_i37.CategoryManager>()));
  gh.factory<_i39.ChatManager>(
      () => _i39.ChatManager(get<_i24.ChatRepository>()));
  gh.factory<_i40.ChatService>(() => _i40.ChatService(get<_i39.ChatManager>()));
  gh.factory<_i41.ChatStateManager>(
      () => _i41.ChatStateManager(get<_i40.ChatService>()));
  gh.factory<_i42.FireNotificationService>(() => _i42.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i29.NotificationRepo>()));
  gh.factory<_i43.ForgotPassScreen>(
      () => _i43.ForgotPassScreen(get<_i25.ForgotPassStateManager>()));
  gh.factory<_i44.LoginScreen>(
      () => _i44.LoginScreen(get<_i27.LoginStateManager>()));
  gh.factory<_i45.MyNotificationsManager>(
      () => _i45.MyNotificationsManager(get<_i28.MyNotificationsRepository>()));
  gh.factory<_i46.MyNotificationsService>(
      () => _i46.MyNotificationsService(get<_i45.MyNotificationsManager>()));
  gh.factory<_i47.ProfileManager>(
      () => _i47.ProfileManager(get<_i32.ProfileRepository>()));
  gh.factory<_i48.ProfileService>(() => _i48.ProfileService(
      get<_i47.ProfileManager>(),
      get<_i14.ProfilePreferencesHelper>(),
      get<_i23.AuthService>()));
  gh.factory<_i49.RegisterScreen>(
      () => _i49.RegisterScreen(get<_i33.RegisterStateManager>()));
  gh.factory<_i50.SettingsScreen>(() => _i50.SettingsScreen(
      get<_i23.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i18.AppThemeDataService>(),
      get<_i42.FireNotificationService>()));
  gh.factory<_i51.SplashModule>(
      () => _i51.SplashModule(get<_i34.SplashScreen>()));
  gh.factory<_i52.UpdatesStateManager>(() => _i52.UpdatesStateManager(
      get<_i46.MyNotificationsService>(), get<_i23.AuthService>()));
  gh.factory<_i53.AboutManager>(
      () => _i53.AboutManager(get<_i35.AboutRepository>()));
  gh.factory<_i54.AboutService>(
      () => _i54.AboutService(get<_i53.AboutManager>()));
  gh.factory<_i55.AuthorizationModule>(() => _i55.AuthorizationModule(
      get<_i44.LoginScreen>(),
      get<_i49.RegisterScreen>(),
      get<_i43.ForgotPassScreen>()));
  gh.factory<_i56.BottomNavStateManager>(() => _i56.BottomNavStateManager(
      get<_i23.AuthService>(),
      get<_i48.ProfileService>(),
      get<_i54.AboutService>()));
  gh.factory<_i57.ChatPage>(() => _i57.ChatPage(
      get<_i41.ChatStateManager>(),
      get<_i26.ImageUploadService>(),
      get<_i23.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i58.CompanyInfoStateManager>(() => _i58.CompanyInfoStateManager(
      get<_i54.AboutService>(),
      get<_i23.AuthService>(),
      get<_i48.ProfileService>()));
  gh.factory<_i59.EditProfileStateManager>(() => _i59.EditProfileStateManager(
      get<_i26.ImageUploadService>(),
      get<_i48.ProfileService>(),
      get<_i23.AuthService>()));
  gh.factory<_i60.InitAccountStateManager>(() => _i60.InitAccountStateManager(
      get<_i48.ProfileService>(),
      get<_i23.AuthService>(),
      get<_i26.ImageUploadService>(),
      get<_i38.CategoryService>()));
  gh.factory<_i61.MainNavigation>(
      () => _i61.MainNavigation(get<_i56.BottomNavStateManager>()));
  gh.factory<_i62.NavigationModule>(
      () => _i62.NavigationModule(get<_i61.MainNavigation>()));
  gh.factory<_i63.OrdersService>(() => _i63.OrdersService(
      get<_i31.OrdersManager>(), get<_i48.ProfileService>()));
  gh.factory<_i64.OwnerOrdersStateManager>(() => _i64.OwnerOrdersStateManager(
      get<_i63.OrdersService>(), get<_i23.AuthService>()));
  gh.factory<_i65.ProfileScreen>(
      () => _i65.ProfileScreen(get<_i59.EditProfileStateManager>()));
  gh.factory<_i66.SettingsModule>(() => _i66.SettingsModule(
      get<_i50.SettingsScreen>(), get<_i20.ChooseLocalScreen>()));
  gh.factory<_i67.UpdateScreen>(
      () => _i67.UpdateScreen(get<_i52.UpdatesStateManager>()));
  gh.factory<_i68.AboutScreenStateManager>(() => _i68.AboutScreenStateManager(
      get<_i10.LocalizationService>(), get<_i54.AboutService>()));
  gh.factory<_i69.ChatModule>(
      () => _i69.ChatModule(get<_i57.ChatPage>(), get<_i23.AuthService>()));
  gh.factory<_i70.CompanyInfoScreen>(
      () => _i70.CompanyInfoScreen(get<_i58.CompanyInfoStateManager>()));
  gh.factory<_i71.InitAccountScreen>(
      () => _i71.InitAccountScreen(get<_i60.InitAccountStateManager>()));
  gh.factory<_i72.MyNotificationsStateManager>(() =>
      _i72.MyNotificationsStateManager(get<_i46.MyNotificationsService>(),
          get<_i63.OrdersService>(), get<_i23.AuthService>()));
  gh.factory<_i73.OfferOrdersScreen>(
      () => _i73.OfferOrdersScreen(get<_i64.OwnerOrdersStateManager>()));
  gh.factory<_i74.OrderLogsStateManager>(
      () => _i74.OrderLogsStateManager(get<_i63.OrdersService>()));
  gh.factory<_i75.OrderTimeLineStateManager>(() =>
      _i75.OrderTimeLineStateManager(
          get<_i63.OrdersService>(), get<_i23.AuthService>()));
  gh.factory<_i76.OwnerOrdersScreen>(
      () => _i76.OwnerOrdersScreen(get<_i64.OwnerOrdersStateManager>()));
  gh.factory<_i77.ProfileModule>(() => _i77.ProfileModule(
      get<_i65.ProfileScreen>(), get<_i71.InitAccountScreen>()));
  gh.factory<_i78.AboutScreen>(
      () => _i78.AboutScreen(get<_i68.AboutScreenStateManager>()));
  gh.factory<_i79.MyNotificationsScreen>(() =>
      _i79.MyNotificationsScreen(get<_i72.MyNotificationsStateManager>()));
  gh.factory<_i80.OrderLogsScreen>(
      () => _i80.OrderLogsScreen(get<_i74.OrderLogsStateManager>()));
  gh.factory<_i81.OrderTimeLineScreen>(
      () => _i81.OrderTimeLineScreen(get<_i75.OrderTimeLineStateManager>()));
  gh.factory<_i82.AboutModule>(() =>
      _i82.AboutModule(get<_i78.AboutScreen>(), get<_i70.CompanyInfoScreen>()));
  gh.factory<_i83.BidOrdersModule>(() => _i83.BidOrdersModule(
      get<_i76.OwnerOrdersScreen>(),
      get<_i81.OrderTimeLineScreen>(),
      get<_i73.OfferOrdersScreen>()));
  gh.factory<_i84.MyNotificationsModule>(() => _i84.MyNotificationsModule(
      get<_i79.MyNotificationsScreen>(), get<_i67.UpdateScreen>()));
  gh.factory<_i85.MyApp>(() => _i85.MyApp(
      get<_i18.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i42.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i51.SplashModule>(),
      get<_i55.AuthorizationModule>(),
      get<_i69.ChatModule>(),
      get<_i66.SettingsModule>(),
      get<_i77.ProfileModule>(),
      get<_i83.BidOrdersModule>(),
      get<_i82.AboutModule>(),
      get<_i84.MyNotificationsModule>(),
      get<_i62.NavigationModule>()));
  gh.singleton<_i86.GlobalStateManager>(_i86.GlobalStateManager());
  return get;
}

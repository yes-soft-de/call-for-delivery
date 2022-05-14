// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i113;
import '../module_about/about_module.dart' as _i111;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i39;
import '../module_about/repository/about_repository.dart' as _i23;
import '../module_about/service/about_service/about_service.dart' as _i40;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i58;
import '../module_about/state_manager/company_info_state_manager.dart' as _i80;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i76;
import '../module_about/ui/screen/company_info/company_info_screen.dart'
    as _i98;
import '../module_auth/authoriazation_module.dart' as _i60;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i24;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i20;
import '../module_auth/service/auth_service/auth_service.dart' as _i25;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i28;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i30;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i36;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i46;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i47;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i53;
import '../module_branches/branches_module.dart' as _i97;
import '../module_branches/manager/branches_manager.dart' as _i41;
import '../module_branches/repository/branches_repository.dart' as _i26;
import '../module_branches/service/branches_list_service.dart' as _i61;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i62;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i66;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i74;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i78;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i83;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i96;
import '../module_chat/chat_module.dart' as _i79;
import '../module_chat/manager/chat/chat_manager.dart' as _i42;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i27;
import '../module_chat/service/chat/char_service.dart' as _i43;
import '../module_chat/state_manager/chat_state_manager.dart' as _i44;
import '../module_chat/state_manager/order_chat_list_state_manager.dart'
    as _i50;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i63;
import '../module_chat/ui/screens/chat_rooms_screen.dart' as _i67;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i48;
import '../module_my_notifications/my_notifications_module.dart' as _i112;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i31;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i49;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i85;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i57;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i101;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i75;
import '../module_network/http_client/http_client.dart' as _i18;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i32;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i45;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/hive/order_hive_helper.dart' as _i13;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i34;
import '../module_orders/orders_module.dart' as _i107;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i33;
import '../module_orders/service/orders/orders.service.dart' as _i68;
import '../module_orders/state_manager/hidden_orders_state_manager.dart'
    as _i81;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i87;
import '../module_orders/state_manager/new_order_link_state_manager.dart'
    as _i86;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i88;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i89;
import '../module_orders/state_manager/order_time_line_state_manager.dart'
    as _i90;
import '../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i69;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i72;
import '../module_orders/ui/screens/hidden_orders_screen.dart' as _i99;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i103;
import '../module_orders/ui/screens/new_order_link.dart' as _i102;
import '../module_orders/ui/screens/order_details/order_details_screen.dart'
    as _i104;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i105;
import '../module_orders/ui/screens/order_time_line_screen.dart' as _i106;
import '../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i91;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i94;
import '../module_profile/manager/profile/profile.manager.dart' as _i51;
import '../module_profile/module_profile.dart' as _i92;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i14;
import '../module_profile/repository/profile/profile.repository.dart' as _i35;
import '../module_profile/service/profile/profile.service.dart' as _i52;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i59;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i64;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i65;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i77;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i70;
import '../module_profile/ui/screen/init_account_screen.dart' as _i82;
import '../module_settings/settings_module.dart' as _i71;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i21;
import '../module_settings/ui/settings_page/copy_map_link.dart' as _i6;
import '../module_settings/ui/settings_page/settings_page.dart' as _i54;
import '../module_splash/splash_module.dart' as _i55;
import '../module_splash/ui/screen/splash_screen.dart' as _i37;
import '../module_subscription/manager/subscription_manager.dart' as _i56;
import '../module_subscription/repository/subscription_repository.dart' as _i38;
import '../module_subscription/service/subscription_service.dart' as _i73;
import '../module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i84;
import '../module_subscription/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i93;
import '../module_subscription/state_manager/subscription_balance_state_manager.dart'
    as _i95;
import '../module_subscription/subscriptions_module.dart' as _i110;
import '../module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i100;
import '../module_subscription/ui/screens/store_subscriptions_details_screen.dart'
    as _i15;
import '../module_subscription/ui/screens/store_subscriptions_screen.dart'
    as _i108;
import '../module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart'
    as _i109;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i16;
import '../module_theme/service/theme_service/theme_service.dart' as _i19;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i22;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i17;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i29;
import '../utils/global/global_state_manager.dart' as _i114;
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
  gh.factory<_i15.StoreSubscriptionsFinanceDetailsScreen>(
      () => _i15.StoreSubscriptionsFinanceDetailsScreen());
  gh.factory<_i16.ThemePreferencesHelper>(() => _i16.ThemePreferencesHelper());
  gh.factory<_i17.UploadRepository>(() => _i17.UploadRepository());
  gh.factory<_i18.ApiClient>(() => _i18.ApiClient(get<_i11.Logger>()));
  gh.factory<_i19.AppThemeDataService>(
      () => _i19.AppThemeDataService(get<_i16.ThemePreferencesHelper>()));
  gh.factory<_i20.AuthRepository>(
      () => _i20.AuthRepository(get<_i18.ApiClient>(), get<_i11.Logger>()));
  gh.factory<_i21.ChooseLocalScreen>(
      () => _i21.ChooseLocalScreen(get<_i10.LocalizationService>()));
  gh.factory<_i22.UploadManager>(
      () => _i22.UploadManager(get<_i17.UploadRepository>()));
  gh.factory<_i23.AboutRepository>(
      () => _i23.AboutRepository(get<_i18.ApiClient>()));
  gh.factory<_i24.AuthManager>(
      () => _i24.AuthManager(get<_i20.AuthRepository>()));
  gh.factory<_i25.AuthService>(() =>
      _i25.AuthService(get<_i4.AuthPrefsHelper>(), get<_i24.AuthManager>()));
  gh.factory<_i26.BranchesRepository>(() =>
      _i26.BranchesRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i27.ChatRepository>(() =>
      _i27.ChatRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i28.ForgotPassStateManager>(
      () => _i28.ForgotPassStateManager(get<_i25.AuthService>()));
  gh.factory<_i29.ImageUploadService>(
      () => _i29.ImageUploadService(get<_i22.UploadManager>()));
  gh.factory<_i30.LoginStateManager>(
      () => _i30.LoginStateManager(get<_i25.AuthService>()));
  gh.factory<_i31.MyNotificationsRepository>(() =>
      _i31.MyNotificationsRepository(
          get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i32.NotificationRepo>(() =>
      _i32.NotificationRepo(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i33.OrderRepository>(() =>
      _i33.OrderRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i34.OrdersManager>(
      () => _i34.OrdersManager(get<_i33.OrderRepository>()));
  gh.factory<_i35.ProfileRepository>(() =>
      _i35.ProfileRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i36.RegisterStateManager>(
      () => _i36.RegisterStateManager(get<_i25.AuthService>()));
  gh.factory<_i37.SplashScreen>(
      () => _i37.SplashScreen(get<_i25.AuthService>()));
  gh.factory<_i38.SubscriptionsRepository>(() => _i38.SubscriptionsRepository(
      get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i39.AboutManager>(
      () => _i39.AboutManager(get<_i23.AboutRepository>()));
  gh.factory<_i40.AboutService>(
      () => _i40.AboutService(get<_i39.AboutManager>()));
  gh.factory<_i41.BranchesManager>(
      () => _i41.BranchesManager(get<_i26.BranchesRepository>()));
  gh.factory<_i42.ChatManager>(
      () => _i42.ChatManager(get<_i27.ChatRepository>()));
  gh.factory<_i43.ChatService>(() => _i43.ChatService(get<_i42.ChatManager>()));
  gh.factory<_i44.ChatStateManager>(
      () => _i44.ChatStateManager(get<_i43.ChatService>()));
  gh.factory<_i45.FireNotificationService>(() => _i45.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i32.NotificationRepo>()));
  gh.factory<_i46.ForgotPassScreen>(
      () => _i46.ForgotPassScreen(get<_i28.ForgotPassStateManager>()));
  gh.factory<_i47.LoginScreen>(
      () => _i47.LoginScreen(get<_i30.LoginStateManager>()));
  gh.factory<_i48.MyNotificationsManager>(
      () => _i48.MyNotificationsManager(get<_i31.MyNotificationsRepository>()));
  gh.factory<_i49.MyNotificationsService>(
      () => _i49.MyNotificationsService(get<_i48.MyNotificationsManager>()));
  gh.factory<_i50.OrdersChatListStateManager>(() =>
      _i50.OrdersChatListStateManager(
          get<_i43.ChatService>(), get<_i25.AuthService>()));
  gh.factory<_i51.ProfileManager>(
      () => _i51.ProfileManager(get<_i35.ProfileRepository>()));
  gh.factory<_i52.ProfileService>(() => _i52.ProfileService(
      get<_i51.ProfileManager>(),
      get<_i14.ProfilePreferencesHelper>(),
      get<_i25.AuthService>()));
  gh.factory<_i53.RegisterScreen>(
      () => _i53.RegisterScreen(get<_i36.RegisterStateManager>()));
  gh.factory<_i54.SettingsScreen>(() => _i54.SettingsScreen(
      get<_i25.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i19.AppThemeDataService>(),
      get<_i45.FireNotificationService>()));
  gh.factory<_i55.SplashModule>(
      () => _i55.SplashModule(get<_i37.SplashScreen>()));
  gh.factory<_i56.SubscriptionsManager>(
      () => _i56.SubscriptionsManager(get<_i38.SubscriptionsRepository>()));
  gh.factory<_i57.UpdatesStateManager>(() => _i57.UpdatesStateManager(
      get<_i49.MyNotificationsService>(), get<_i25.AuthService>()));
  gh.factory<_i58.AboutScreenStateManager>(() => _i58.AboutScreenStateManager(
      get<_i10.LocalizationService>(), get<_i40.AboutService>()));
  gh.factory<_i59.AccountBalanceStateManager>(() =>
      _i59.AccountBalanceStateManager(get<_i52.ProfileService>(),
          get<_i25.AuthService>(), get<_i29.ImageUploadService>()));
  gh.factory<_i60.AuthorizationModule>(() => _i60.AuthorizationModule(
      get<_i47.LoginScreen>(),
      get<_i53.RegisterScreen>(),
      get<_i46.ForgotPassScreen>()));
  gh.factory<_i61.BranchesListService>(() => _i61.BranchesListService(
      get<_i41.BranchesManager>(), get<_i14.ProfilePreferencesHelper>()));
  gh.factory<_i62.BranchesListStateManager>(
      () => _i62.BranchesListStateManager(get<_i61.BranchesListService>()));
  gh.factory<_i63.ChatPage>(() => _i63.ChatPage(
      get<_i44.ChatStateManager>(),
      get<_i29.ImageUploadService>(),
      get<_i25.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i64.EditProfileStateManager>(() => _i64.EditProfileStateManager(
      get<_i29.ImageUploadService>(),
      get<_i52.ProfileService>(),
      get<_i25.AuthService>()));
  gh.factory<_i65.InitAccountStateManager>(() => _i65.InitAccountStateManager(
      get<_i52.ProfileService>(),
      get<_i25.AuthService>(),
      get<_i29.ImageUploadService>()));
  gh.factory<_i66.InitBranchesStateManager>(
      () => _i66.InitBranchesStateManager(get<_i61.BranchesListService>()));
  gh.factory<_i67.OrderChatRoomsScreen>(
      () => _i67.OrderChatRoomsScreen(get<_i50.OrdersChatListStateManager>()));
  gh.factory<_i68.OrdersService>(() => _i68.OrdersService(
      get<_i34.OrdersManager>(), get<_i52.ProfileService>()));
  gh.factory<_i69.OwnerOrdersStateManager>(() => _i69.OwnerOrdersStateManager(
      get<_i68.OrdersService>(),
      get<_i25.AuthService>(),
      get<_i52.ProfileService>()));
  gh.factory<_i70.ProfileScreen>(
      () => _i70.ProfileScreen(get<_i64.EditProfileStateManager>()));
  gh.factory<_i71.SettingsModule>(() => _i71.SettingsModule(
      get<_i54.SettingsScreen>(),
      get<_i21.ChooseLocalScreen>(),
      get<_i6.CopyMapLinkScreen>()));
  gh.factory<_i72.SubOrdersStateManager>(() => _i72.SubOrdersStateManager(
      get<_i68.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i73.SubscriptionService>(
      () => _i73.SubscriptionService(get<_i56.SubscriptionsManager>()));
  gh.factory<_i74.UpdateBranchStateManager>(
      () => _i74.UpdateBranchStateManager(get<_i61.BranchesListService>()));
  gh.factory<_i75.UpdateScreen>(
      () => _i75.UpdateScreen(get<_i57.UpdatesStateManager>()));
  gh.factory<_i76.AboutScreen>(
      () => _i76.AboutScreen(get<_i58.AboutScreenStateManager>()));
  gh.factory<_i77.AccountBalanceScreen>(
      () => _i77.AccountBalanceScreen(get<_i59.AccountBalanceStateManager>()));
  gh.factory<_i78.BranchesListScreen>(
      () => _i78.BranchesListScreen(get<_i62.BranchesListStateManager>()));
  gh.factory<_i79.ChatModule>(() =>
      _i79.ChatModule(get<_i63.ChatPage>(), get<_i67.OrderChatRoomsScreen>()));
  gh.factory<_i80.CompanyInfoStateManager>(() => _i80.CompanyInfoStateManager(
      get<_i68.OrdersService>(),
      get<_i25.AuthService>(),
      get<_i52.ProfileService>()));
  gh.factory<_i81.HiddenOrdersStateManager>(
      () => _i81.HiddenOrdersStateManager(get<_i68.OrdersService>()));
  gh.factory<_i82.InitAccountScreen>(
      () => _i82.InitAccountScreen(get<_i65.InitAccountStateManager>()));
  gh.factory<_i83.InitBranchesScreen>(
      () => _i83.InitBranchesScreen(get<_i66.InitBranchesStateManager>()));
  gh.factory<_i84.InitSubscriptionStateManager>(() =>
      _i84.InitSubscriptionStateManager(
          get<_i73.SubscriptionService>(),
          get<_i52.ProfileService>(),
          get<_i25.AuthService>(),
          get<_i29.ImageUploadService>()));
  gh.factory<_i85.MyNotificationsStateManager>(() =>
      _i85.MyNotificationsStateManager(get<_i49.MyNotificationsService>(),
          get<_i68.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i86.NewOrderLinkStateManager>(
      () => _i86.NewOrderLinkStateManager(get<_i68.OrdersService>()));
  gh.factory<_i87.NewOrderStateManager>(
      () => _i87.NewOrderStateManager(get<_i68.OrdersService>()));
  gh.factory<_i88.OrderLogsStateManager>(
      () => _i88.OrderLogsStateManager(get<_i68.OrdersService>()));
  gh.factory<_i89.OrderStatusStateManager>(() => _i89.OrderStatusStateManager(
      get<_i68.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i90.OrderTimeLineStateManager>(() =>
      _i90.OrderTimeLineStateManager(
          get<_i68.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i91.OwnerOrdersScreen>(() => _i91.OwnerOrdersScreen(
      get<_i69.OwnerOrdersStateManager>(), get<_i87.NewOrderStateManager>()));
  gh.factory<_i92.ProfileModule>(() => _i92.ProfileModule(
      get<_i70.ProfileScreen>(),
      get<_i82.InitAccountScreen>(),
      get<_i77.AccountBalanceScreen>()));
  gh.factory<_i93.StoreSubscriptionsFinanceStateManager>(() =>
      _i93.StoreSubscriptionsFinanceStateManager(
          get<_i73.SubscriptionService>()));
  gh.factory<_i94.SubOrdersScreen>(
      () => _i94.SubOrdersScreen(get<_i72.SubOrdersStateManager>()));
  gh.factory<_i95.SubscriptionBalanceStateManager>(() =>
      _i95.SubscriptionBalanceStateManager(
          get<_i73.SubscriptionService>(),
          get<_i52.ProfileService>(),
          get<_i25.AuthService>(),
          get<_i29.ImageUploadService>()));
  gh.factory<_i96.UpdateBranchScreen>(
      () => _i96.UpdateBranchScreen(get<_i74.UpdateBranchStateManager>()));
  gh.factory<_i97.BranchesModule>(() => _i97.BranchesModule(
      get<_i78.BranchesListScreen>(),
      get<_i96.UpdateBranchScreen>(),
      get<_i83.InitBranchesScreen>()));
  gh.factory<_i98.CompanyInfoScreen>(
      () => _i98.CompanyInfoScreen(get<_i80.CompanyInfoStateManager>()));
  gh.factory<_i99.HiddenOrdersScreen>(
      () => _i99.HiddenOrdersScreen(get<_i81.HiddenOrdersStateManager>()));
  gh.factory<_i100.InitSubscriptionScreen>(() =>
      _i100.InitSubscriptionScreen(get<_i84.InitSubscriptionStateManager>()));
  gh.factory<_i101.MyNotificationsScreen>(() =>
      _i101.MyNotificationsScreen(get<_i85.MyNotificationsStateManager>()));
  gh.factory<_i102.NewOrderLinkScreen>(
      () => _i102.NewOrderLinkScreen(get<_i86.NewOrderLinkStateManager>()));
  gh.factory<_i103.NewOrderScreen>(
      () => _i103.NewOrderScreen(get<_i87.NewOrderStateManager>()));
  gh.factory<_i104.OrderDetailsScreen>(
      () => _i104.OrderDetailsScreen(get<_i89.OrderStatusStateManager>()));
  gh.factory<_i105.OrderLogsScreen>(
      () => _i105.OrderLogsScreen(get<_i88.OrderLogsStateManager>()));
  gh.factory<_i106.OrderTimeLineScreen>(
      () => _i106.OrderTimeLineScreen(get<_i90.OrderTimeLineStateManager>()));
  gh.factory<_i107.OrdersModule>(() => _i107.OrdersModule(
      get<_i103.NewOrderScreen>(),
      get<_i104.OrderDetailsScreen>(),
      get<_i91.OwnerOrdersScreen>(),
      get<_i94.SubOrdersScreen>(),
      get<_i102.NewOrderLinkScreen>(),
      get<_i106.OrderTimeLineScreen>(),
      get<_i105.OrderLogsScreen>(),
      get<_i99.HiddenOrdersScreen>()));
  gh.factory<_i108.StoreSubscriptionsFinanceScreen>(() =>
      _i108.StoreSubscriptionsFinanceScreen(
          get<_i93.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i109.SubscriptionBalanceScreen>(() =>
      _i109.SubscriptionBalanceScreen(
          get<_i95.SubscriptionBalanceStateManager>()));
  gh.factory<_i110.SubscriptionsModule>(() => _i110.SubscriptionsModule(
      get<_i100.InitSubscriptionScreen>(),
      get<_i109.SubscriptionBalanceScreen>(),
      get<_i108.StoreSubscriptionsFinanceScreen>(),
      get<_i15.StoreSubscriptionsFinanceDetailsScreen>()));
  gh.factory<_i111.AboutModule>(() => _i111.AboutModule(
      get<_i76.AboutScreen>(), get<_i98.CompanyInfoScreen>()));
  gh.factory<_i112.MyNotificationsModule>(() => _i112.MyNotificationsModule(
      get<_i101.MyNotificationsScreen>(), get<_i75.UpdateScreen>()));
  gh.factory<_i113.MyApp>(() => _i113.MyApp(
      get<_i107.OrdersModule>(),
      get<_i19.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i45.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i55.SplashModule>(),
      get<_i60.AuthorizationModule>(),
      get<_i79.ChatModule>(),
      get<_i71.SettingsModule>(),
      get<_i111.AboutModule>(),
      get<_i92.ProfileModule>(),
      get<_i97.BranchesModule>(),
      get<_i110.SubscriptionsModule>(),
      get<_i112.MyNotificationsModule>()));
  gh.singleton<_i114.GlobalStateManager>(_i114.GlobalStateManager());
  return get;
}

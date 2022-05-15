// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i127;
import '../module_about/about_module.dart' as _i125;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i40;
import '../module_about/repository/about_repository.dart' as _i23;
import '../module_about/service/about_service/about_service.dart' as _i41;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i64;
import '../module_about/state_manager/company_info_state_manager.dart' as _i94;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i87;
import '../module_about/ui/screen/company_info/company_info_screen.dart'
    as _i112;
import '../module_auth/authoriazation_module.dart' as _i67;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i24;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i20;
import '../module_auth/service/auth_service/auth_service.dart' as _i25;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i29;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i31;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i37;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i50;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i51;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i59;
import '../module_bidorder/bid_orders_module.dart' as _i91;
import '../module_bidorder/manager/bidorder_manager.dart' as _i42;
import '../module_bidorder/repository/bidorder_repoesitory.dart' as _i26;
import '../module_bidorder/service/bidorder_service.dart' as _i43;
import '../module_bidorder/state_manager/add_bidorder_state_manager.dart'
    as _i66;
import '../module_bidorder/state_manager/bidorder_details/bidorder_status.state_manager.dart'
    as _i44;
import '../module_bidorder/state_manager/bidorder_details/order_offer_state_manager.dart'
    as _i55;
import '../module_bidorder/state_manager/bidorder_logs_state_manager.dart'
    as _i69;
import '../module_bidorder/state_manager/open_order_state_manager.dart' as _i54;
import '../module_bidorder/ui/screens/add_bidorder_screen.dart' as _i89;
import '../module_bidorder/ui/screens/bidorder_details/bidorder_details_screen.dart'
    as _i68;
import '../module_bidorder/ui/screens/bidorder_details/order_offer_details_screen.dart'
    as _i78;
import '../module_bidorder/ui/screens/bidorder_logs_screen.dart' as _i90;
import '../module_bidorder/ui/screens/open_bidorder_screen.dart' as _i76;
import '../module_branches/branches_module.dart' as _i111;
import '../module_branches/manager/branches_manager.dart' as _i45;
import '../module_branches/repository/branches_repository.dart' as _i27;
import '../module_branches/service/branches_list_service.dart' as _i70;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i71;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i75;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i85;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i92;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i97;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i110;
import '../module_chat/chat_module.dart' as _i93;
import '../module_chat/manager/chat/chat_manager.dart' as _i46;
import '../module_chat/presistance/chat_hive_helper.dart' as _i5;
import '../module_chat/repository/chat/chat_repository.dart' as _i28;
import '../module_chat/service/chat/char_service.dart' as _i47;
import '../module_chat/state_manager/chat_state_manager.dart' as _i48;
import '../module_chat/state_manager/order_chat_list_state_manager.dart'
    as _i56;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i72;
import '../module_chat/ui/screens/chat_rooms_screen.dart' as _i77;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i52;
import '../module_my_notifications/my_notifications_module.dart' as _i126;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i32;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i53;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i99;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i63;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i115;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i86;
import '../module_network/http_client/http_client.dart' as _i18;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i33;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i49;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/hive/order_hive_helper.dart' as _i13;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i35;
import '../module_orders/orders_module.dart' as _i121;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i34;
import '../module_orders/service/orders/orders.service.dart' as _i79;
import '../module_orders/state_manager/hidden_orders_state_manager.dart'
    as _i95;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i101;
import '../module_orders/state_manager/new_order_link_state_manager.dart'
    as _i100;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i102;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i103;
import '../module_orders/state_manager/order_time_line_state_manager.dart'
    as _i104;
import '../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i80;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i83;
import '../module_orders/ui/screens/hidden_orders_screen.dart' as _i113;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i117;
import '../module_orders/ui/screens/new_order_link.dart' as _i116;
import '../module_orders/ui/screens/order_details/order_details_screen.dart'
    as _i118;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i119;
import '../module_orders/ui/screens/order_time_line_screen.dart' as _i120;
import '../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i105;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i108;
import '../module_profile/manager/profile/profile.manager.dart' as _i57;
import '../module_profile/module_profile.dart' as _i106;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i14;
import '../module_profile/repository/profile/profile.repository.dart' as _i36;
import '../module_profile/service/profile/profile.service.dart' as _i58;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i65;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i73;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i74;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i88;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i81;
import '../module_profile/ui/screen/init_account_screen.dart' as _i96;
import '../module_settings/settings_module.dart' as _i82;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i21;
import '../module_settings/ui/settings_page/copy_map_link.dart' as _i6;
import '../module_settings/ui/settings_page/settings_page.dart' as _i60;
import '../module_splash/splash_module.dart' as _i61;
import '../module_splash/ui/screen/splash_screen.dart' as _i38;
import '../module_subscription/manager/subscription_manager.dart' as _i62;
import '../module_subscription/repository/subscription_repository.dart' as _i39;
import '../module_subscription/service/subscription_service.dart' as _i84;
import '../module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i98;
import '../module_subscription/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i107;
import '../module_subscription/state_manager/subscription_balance_state_manager.dart'
    as _i109;
import '../module_subscription/subscriptions_module.dart' as _i124;
import '../module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i114;
import '../module_subscription/ui/screens/store_subscriptions_details_screen.dart'
    as _i15;
import '../module_subscription/ui/screens/store_subscriptions_screen.dart'
    as _i122;
import '../module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart'
    as _i123;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i16;
import '../module_theme/service/theme_service/theme_service.dart' as _i19;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i22;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i17;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i30;
import '../utils/global/global_state_manager.dart' as _i128;
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
  gh.factory<_i26.BidOrderRepository>(() =>
      _i26.BidOrderRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i27.BranchesRepository>(() =>
      _i27.BranchesRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i28.ChatRepository>(() =>
      _i28.ChatRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i29.ForgotPassStateManager>(
      () => _i29.ForgotPassStateManager(get<_i25.AuthService>()));
  gh.factory<_i30.ImageUploadService>(
      () => _i30.ImageUploadService(get<_i22.UploadManager>()));
  gh.factory<_i31.LoginStateManager>(
      () => _i31.LoginStateManager(get<_i25.AuthService>()));
  gh.factory<_i32.MyNotificationsRepository>(() =>
      _i32.MyNotificationsRepository(
          get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i33.NotificationRepo>(() =>
      _i33.NotificationRepo(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i34.OrderRepository>(() =>
      _i34.OrderRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i35.OrdersManager>(
      () => _i35.OrdersManager(get<_i34.OrderRepository>()));
  gh.factory<_i36.ProfileRepository>(() =>
      _i36.ProfileRepository(get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i37.RegisterStateManager>(
      () => _i37.RegisterStateManager(get<_i25.AuthService>()));
  gh.factory<_i38.SplashScreen>(
      () => _i38.SplashScreen(get<_i25.AuthService>()));
  gh.factory<_i39.SubscriptionsRepository>(() => _i39.SubscriptionsRepository(
      get<_i18.ApiClient>(), get<_i25.AuthService>()));
  gh.factory<_i40.AboutManager>(
      () => _i40.AboutManager(get<_i23.AboutRepository>()));
  gh.factory<_i41.AboutService>(
      () => _i41.AboutService(get<_i40.AboutManager>()));
  gh.factory<_i42.BidOrderManager>(
      () => _i42.BidOrderManager(get<_i26.BidOrderRepository>()));
  gh.factory<_i43.BidOrderService>(
      () => _i43.BidOrderService(get<_i42.BidOrderManager>()));
  gh.factory<_i44.BidOrderStatusStateManager>(() =>
      _i44.BidOrderStatusStateManager(
          get<_i43.BidOrderService>(), get<_i25.AuthService>()));
  gh.factory<_i45.BranchesManager>(
      () => _i45.BranchesManager(get<_i27.BranchesRepository>()));
  gh.factory<_i46.ChatManager>(
      () => _i46.ChatManager(get<_i28.ChatRepository>()));
  gh.factory<_i47.ChatService>(() => _i47.ChatService(get<_i46.ChatManager>()));
  gh.factory<_i48.ChatStateManager>(
      () => _i48.ChatStateManager(get<_i47.ChatService>()));
  gh.factory<_i49.FireNotificationService>(() => _i49.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i33.NotificationRepo>()));
  gh.factory<_i50.ForgotPassScreen>(
      () => _i50.ForgotPassScreen(get<_i29.ForgotPassStateManager>()));
  gh.factory<_i51.LoginScreen>(
      () => _i51.LoginScreen(get<_i31.LoginStateManager>()));
  gh.factory<_i52.MyNotificationsManager>(
      () => _i52.MyNotificationsManager(get<_i32.MyNotificationsRepository>()));
  gh.factory<_i53.MyNotificationsService>(
      () => _i53.MyNotificationsService(get<_i52.MyNotificationsManager>()));
  gh.factory<_i54.OpenBidOrderStateManager>(
      () => _i54.OpenBidOrderStateManager(get<_i43.BidOrderService>()));
  gh.factory<_i55.OrderOffersDetailsStateManager>(
      () => _i55.OrderOffersDetailsStateManager(get<_i43.BidOrderService>()));
  gh.factory<_i56.OrdersChatListStateManager>(() =>
      _i56.OrdersChatListStateManager(
          get<_i47.ChatService>(), get<_i25.AuthService>()));
  gh.factory<_i57.ProfileManager>(
      () => _i57.ProfileManager(get<_i36.ProfileRepository>()));
  gh.factory<_i58.ProfileService>(() => _i58.ProfileService(
      get<_i57.ProfileManager>(),
      get<_i14.ProfilePreferencesHelper>(),
      get<_i25.AuthService>()));
  gh.factory<_i59.RegisterScreen>(
      () => _i59.RegisterScreen(get<_i37.RegisterStateManager>()));
  gh.factory<_i60.SettingsScreen>(() => _i60.SettingsScreen(
      get<_i25.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i19.AppThemeDataService>(),
      get<_i49.FireNotificationService>()));
  gh.factory<_i61.SplashModule>(
      () => _i61.SplashModule(get<_i38.SplashScreen>()));
  gh.factory<_i62.SubscriptionsManager>(
      () => _i62.SubscriptionsManager(get<_i39.SubscriptionsRepository>()));
  gh.factory<_i63.UpdatesStateManager>(() => _i63.UpdatesStateManager(
      get<_i53.MyNotificationsService>(), get<_i25.AuthService>()));
  gh.factory<_i64.AboutScreenStateManager>(() => _i64.AboutScreenStateManager(
      get<_i10.LocalizationService>(), get<_i41.AboutService>()));
  gh.factory<_i65.AccountBalanceStateManager>(() =>
      _i65.AccountBalanceStateManager(get<_i58.ProfileService>(),
          get<_i25.AuthService>(), get<_i30.ImageUploadService>()));
  gh.factory<_i66.AddBidOrderStateManager>(
      () => _i66.AddBidOrderStateManager(get<_i43.BidOrderService>()));
  gh.factory<_i67.AuthorizationModule>(() => _i67.AuthorizationModule(
      get<_i51.LoginScreen>(),
      get<_i59.RegisterScreen>(),
      get<_i50.ForgotPassScreen>()));
  gh.factory<_i68.BidOrderDetailsScreen>(
      () => _i68.BidOrderDetailsScreen(get<_i44.BidOrderStatusStateManager>()));
  gh.factory<_i69.BidOrderLogsStateManager>(
      () => _i69.BidOrderLogsStateManager(get<_i43.BidOrderService>()));
  gh.factory<_i70.BranchesListService>(() => _i70.BranchesListService(
      get<_i45.BranchesManager>(), get<_i14.ProfilePreferencesHelper>()));
  gh.factory<_i71.BranchesListStateManager>(
      () => _i71.BranchesListStateManager(get<_i70.BranchesListService>()));
  gh.factory<_i72.ChatPage>(() => _i72.ChatPage(
      get<_i48.ChatStateManager>(),
      get<_i30.ImageUploadService>(),
      get<_i25.AuthService>(),
      get<_i5.ChatHiveHelper>()));
  gh.factory<_i73.EditProfileStateManager>(() => _i73.EditProfileStateManager(
      get<_i30.ImageUploadService>(),
      get<_i58.ProfileService>(),
      get<_i25.AuthService>()));
  gh.factory<_i74.InitAccountStateManager>(() => _i74.InitAccountStateManager(
      get<_i58.ProfileService>(),
      get<_i25.AuthService>(),
      get<_i30.ImageUploadService>()));
  gh.factory<_i75.InitBranchesStateManager>(
      () => _i75.InitBranchesStateManager(get<_i70.BranchesListService>()));
  gh.factory<_i76.OpenBidOrderScreen>(
      () => _i76.OpenBidOrderScreen(get<_i54.OpenBidOrderStateManager>()));
  gh.factory<_i77.OrderChatRoomsScreen>(
      () => _i77.OrderChatRoomsScreen(get<_i56.OrdersChatListStateManager>()));
  gh.factory<_i78.OrderOfferDetailsScreen>(() =>
      _i78.OrderOfferDetailsScreen(get<_i55.OrderOffersDetailsStateManager>()));
  gh.factory<_i79.OrdersService>(() => _i79.OrdersService(
      get<_i35.OrdersManager>(), get<_i58.ProfileService>()));
  gh.factory<_i80.OwnerOrdersStateManager>(() => _i80.OwnerOrdersStateManager(
      get<_i79.OrdersService>(),
      get<_i25.AuthService>(),
      get<_i58.ProfileService>()));
  gh.factory<_i81.ProfileScreen>(
      () => _i81.ProfileScreen(get<_i73.EditProfileStateManager>()));
  gh.factory<_i82.SettingsModule>(() => _i82.SettingsModule(
      get<_i60.SettingsScreen>(),
      get<_i21.ChooseLocalScreen>(),
      get<_i6.CopyMapLinkScreen>()));
  gh.factory<_i83.SubOrdersStateManager>(() => _i83.SubOrdersStateManager(
      get<_i79.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i84.SubscriptionService>(
      () => _i84.SubscriptionService(get<_i62.SubscriptionsManager>()));
  gh.factory<_i85.UpdateBranchStateManager>(
      () => _i85.UpdateBranchStateManager(get<_i70.BranchesListService>()));
  gh.factory<_i86.UpdateScreen>(
      () => _i86.UpdateScreen(get<_i63.UpdatesStateManager>()));
  gh.factory<_i87.AboutScreen>(
      () => _i87.AboutScreen(get<_i64.AboutScreenStateManager>()));
  gh.factory<_i88.AccountBalanceScreen>(
      () => _i88.AccountBalanceScreen(get<_i65.AccountBalanceStateManager>()));
  gh.factory<_i89.AddBidOrderScreen>(
      () => _i89.AddBidOrderScreen(get<_i66.AddBidOrderStateManager>()));
  gh.factory<_i90.BidOrderLogsScreen>(
      () => _i90.BidOrderLogsScreen(get<_i69.BidOrderLogsStateManager>()));
  gh.factory<_i91.BidOrdersModule>(() => _i91.BidOrdersModule(
      get<_i76.OpenBidOrderScreen>(),
      get<_i89.AddBidOrderScreen>(),
      get<_i78.OrderOfferDetailsScreen>(),
      get<_i90.BidOrderLogsScreen>(),
      get<_i68.BidOrderDetailsScreen>()));
  gh.factory<_i92.BranchesListScreen>(
      () => _i92.BranchesListScreen(get<_i71.BranchesListStateManager>()));
  gh.factory<_i93.ChatModule>(() =>
      _i93.ChatModule(get<_i72.ChatPage>(), get<_i77.OrderChatRoomsScreen>()));
  gh.factory<_i94.CompanyInfoStateManager>(() => _i94.CompanyInfoStateManager(
      get<_i79.OrdersService>(),
      get<_i25.AuthService>(),
      get<_i58.ProfileService>()));
  gh.factory<_i95.HiddenOrdersStateManager>(
      () => _i95.HiddenOrdersStateManager(get<_i79.OrdersService>()));
  gh.factory<_i96.InitAccountScreen>(
      () => _i96.InitAccountScreen(get<_i74.InitAccountStateManager>()));
  gh.factory<_i97.InitBranchesScreen>(
      () => _i97.InitBranchesScreen(get<_i75.InitBranchesStateManager>()));
  gh.factory<_i98.InitSubscriptionStateManager>(() =>
      _i98.InitSubscriptionStateManager(
          get<_i84.SubscriptionService>(),
          get<_i58.ProfileService>(),
          get<_i25.AuthService>(),
          get<_i30.ImageUploadService>()));
  gh.factory<_i99.MyNotificationsStateManager>(() =>
      _i99.MyNotificationsStateManager(get<_i53.MyNotificationsService>(),
          get<_i79.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i100.NewOrderLinkStateManager>(
      () => _i100.NewOrderLinkStateManager(get<_i79.OrdersService>()));
  gh.factory<_i101.NewOrderStateManager>(
      () => _i101.NewOrderStateManager(get<_i79.OrdersService>()));
  gh.factory<_i102.OrderLogsStateManager>(
      () => _i102.OrderLogsStateManager(get<_i79.OrdersService>()));
  gh.factory<_i103.OrderStatusStateManager>(() => _i103.OrderStatusStateManager(
      get<_i79.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i104.OrderTimeLineStateManager>(() =>
      _i104.OrderTimeLineStateManager(
          get<_i79.OrdersService>(), get<_i25.AuthService>()));
  gh.factory<_i105.OwnerOrdersScreen>(() => _i105.OwnerOrdersScreen(
      get<_i80.OwnerOrdersStateManager>(), get<_i101.NewOrderStateManager>()));
  gh.factory<_i106.ProfileModule>(() => _i106.ProfileModule(
      get<_i81.ProfileScreen>(),
      get<_i96.InitAccountScreen>(),
      get<_i88.AccountBalanceScreen>()));
  gh.factory<_i107.StoreSubscriptionsFinanceStateManager>(() =>
      _i107.StoreSubscriptionsFinanceStateManager(
          get<_i84.SubscriptionService>()));
  gh.factory<_i108.SubOrdersScreen>(
      () => _i108.SubOrdersScreen(get<_i83.SubOrdersStateManager>()));
  gh.factory<_i109.SubscriptionBalanceStateManager>(() =>
      _i109.SubscriptionBalanceStateManager(
          get<_i84.SubscriptionService>(),
          get<_i58.ProfileService>(),
          get<_i25.AuthService>(),
          get<_i30.ImageUploadService>()));
  gh.factory<_i110.UpdateBranchScreen>(
      () => _i110.UpdateBranchScreen(get<_i85.UpdateBranchStateManager>()));
  gh.factory<_i111.BranchesModule>(() => _i111.BranchesModule(
      get<_i92.BranchesListScreen>(),
      get<_i110.UpdateBranchScreen>(),
      get<_i97.InitBranchesScreen>()));
  gh.factory<_i112.CompanyInfoScreen>(
      () => _i112.CompanyInfoScreen(get<_i94.CompanyInfoStateManager>()));
  gh.factory<_i113.HiddenOrdersScreen>(
      () => _i113.HiddenOrdersScreen(get<_i95.HiddenOrdersStateManager>()));
  gh.factory<_i114.InitSubscriptionScreen>(() =>
      _i114.InitSubscriptionScreen(get<_i98.InitSubscriptionStateManager>()));
  gh.factory<_i115.MyNotificationsScreen>(() =>
      _i115.MyNotificationsScreen(get<_i99.MyNotificationsStateManager>()));
  gh.factory<_i116.NewOrderLinkScreen>(
      () => _i116.NewOrderLinkScreen(get<_i100.NewOrderLinkStateManager>()));
  gh.factory<_i117.NewOrderScreen>(
      () => _i117.NewOrderScreen(get<_i101.NewOrderStateManager>()));
  gh.factory<_i118.OrderDetailsScreen>(
      () => _i118.OrderDetailsScreen(get<_i103.OrderStatusStateManager>()));
  gh.factory<_i119.OrderLogsScreen>(
      () => _i119.OrderLogsScreen(get<_i102.OrderLogsStateManager>()));
  gh.factory<_i120.OrderTimeLineScreen>(
      () => _i120.OrderTimeLineScreen(get<_i104.OrderTimeLineStateManager>()));
  gh.factory<_i121.OrdersModule>(() => _i121.OrdersModule(
      get<_i117.NewOrderScreen>(),
      get<_i118.OrderDetailsScreen>(),
      get<_i105.OwnerOrdersScreen>(),
      get<_i108.SubOrdersScreen>(),
      get<_i116.NewOrderLinkScreen>(),
      get<_i120.OrderTimeLineScreen>(),
      get<_i119.OrderLogsScreen>(),
      get<_i113.HiddenOrdersScreen>()));
  gh.factory<_i122.StoreSubscriptionsFinanceScreen>(() =>
      _i122.StoreSubscriptionsFinanceScreen(
          get<_i107.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i123.SubscriptionBalanceScreen>(() =>
      _i123.SubscriptionBalanceScreen(
          get<_i109.SubscriptionBalanceStateManager>()));
  gh.factory<_i124.SubscriptionsModule>(() => _i124.SubscriptionsModule(
      get<_i114.InitSubscriptionScreen>(),
      get<_i123.SubscriptionBalanceScreen>(),
      get<_i122.StoreSubscriptionsFinanceScreen>(),
      get<_i15.StoreSubscriptionsFinanceDetailsScreen>()));
  gh.factory<_i125.AboutModule>(() => _i125.AboutModule(
      get<_i87.AboutScreen>(), get<_i112.CompanyInfoScreen>()));
  gh.factory<_i126.MyNotificationsModule>(() => _i126.MyNotificationsModule(
      get<_i115.MyNotificationsScreen>(), get<_i86.UpdateScreen>()));
  gh.factory<_i127.MyApp>(() => _i127.MyApp(
      get<_i121.OrdersModule>(),
      get<_i19.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i49.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i61.SplashModule>(),
      get<_i67.AuthorizationModule>(),
      get<_i93.ChatModule>(),
      get<_i82.SettingsModule>(),
      get<_i125.AboutModule>(),
      get<_i106.ProfileModule>(),
      get<_i111.BranchesModule>(),
      get<_i124.SubscriptionsModule>(),
      get<_i126.MyNotificationsModule>(),
      get<_i91.BidOrdersModule>()));
  gh.singleton<_i128.GlobalStateManager>(_i128.GlobalStateManager());
  return get;
}

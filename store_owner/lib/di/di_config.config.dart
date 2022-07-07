// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i135;
import '../module_about/about_module.dart' as _i133;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i44;
import '../module_about/repository/about_repository.dart' as _i26;
import '../module_about/service/about_service/about_service.dart' as _i45;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i68;
import '../module_about/state_manager/company_info_state_manager.dart' as _i99;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i92;
import '../module_about/ui/screen/company_info/company_info_screen.dart'
    as _i119;
import '../module_auth/authoriazation_module.dart' as _i71;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i27;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i23;
import '../module_auth/service/auth_service/auth_service.dart' as _i28;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i33;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i35;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i41;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i54;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i55;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i63;
import '../module_bidorder/bid_orders_module.dart' as _i96;
import '../module_bidorder/manager/bidorder_manager.dart' as _i46;
import '../module_bidorder/repository/bidorder_repoesitory.dart' as _i29;
import '../module_bidorder/service/bidorder_service.dart' as _i47;
import '../module_bidorder/state_manager/add_bidorder_state_manager.dart'
    as _i70;
import '../module_bidorder/state_manager/bidorder_details/bidorder_status.state_manager.dart'
    as _i48;
import '../module_bidorder/state_manager/bidorder_details/order_offer_state_manager.dart'
    as _i59;
import '../module_bidorder/state_manager/bidorder_logs_state_manager.dart'
    as _i73;
import '../module_bidorder/state_manager/open_order_state_manager.dart' as _i58;
import '../module_bidorder/ui/screens/add_bidorder_screen.dart' as _i94;
import '../module_bidorder/ui/screens/bidorder_details/bidorder_details_screen.dart'
    as _i72;
import '../module_bidorder/ui/screens/bidorder_details/order_offer_details_screen.dart'
    as _i82;
import '../module_bidorder/ui/screens/bidorder_logs_screen.dart' as _i95;
import '../module_bidorder/ui/screens/open_bidorder_screen.dart' as _i80;
import '../module_branches/branches_module.dart' as _i118;
import '../module_branches/manager/branches_manager.dart' as _i49;
import '../module_branches/repository/branches_repository.dart' as _i30;
import '../module_branches/service/branches_list_service.dart' as _i74;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i75;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i79;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i89;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i97;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i102;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i116;
import '../module_chat/chat_module.dart' as _i98;
import '../module_chat/manager/chat/chat_manager.dart' as _i50;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i31;
import '../module_chat/service/chat/char_service.dart' as _i51;
import '../module_chat/state_manager/chat_state_manager.dart' as _i52;
import '../module_chat/state_manager/order_chat_list_state_manager.dart'
    as _i60;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i76;
import '../module_chat/ui/screens/chat_rooms_screen.dart' as _i81;
import '../module_deep_links/repository/deep_link_repository.dart' as _i32;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i11;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i56;
import '../module_my_notifications/my_notifications_module.dart' as _i134;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i36;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i57;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i104;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i67;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i122;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i91;
import '../module_network/http_client/http_client.dart' as _i21;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import '../module_notifications/repository/notification_repo.dart' as _i37;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i53;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import '../module_orders/hive/order_hive_helper.dart' as _i14;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i39;
import '../module_orders/orders_module.dart' as _i129;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i38;
import '../module_orders/service/orders/orders.service.dart' as _i83;
import '../module_orders/state_manager/hidden_orders_state_manager.dart'
    as _i100;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i106;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i90;
import '../module_orders/state_manager/new_order_link_state_manager.dart'
    as _i105;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i107;
import '../module_orders/state_manager/order_recycling_state_manager.dart'
    as _i108;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i109;
import '../module_orders/state_manager/order_time_line_state_manager.dart'
    as _i110;
import '../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i84;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i87;
import '../module_orders/ui/screens/hidden_orders_screen.dart' as _i120;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i124;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i117;
import '../module_orders/ui/screens/new_order_link.dart' as _i123;
import '../module_orders/ui/screens/order_details/order_details_screen.dart'
    as _i125;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i126;
import '../module_orders/ui/screens/order_recylcing_screen.dart' as _i127;
import '../module_orders/ui/screens/order_time_line_screen.dart' as _i128;
import '../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i111;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i114;
import '../module_profile/manager/profile/profile.manager.dart' as _i61;
import '../module_profile/module_profile.dart' as _i112;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i16;
import '../module_profile/repository/profile/profile.repository.dart' as _i40;
import '../module_profile/service/profile/profile.service.dart' as _i62;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i69;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i77;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i78;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i93;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i85;
import '../module_profile/ui/screen/init_account_screen.dart' as _i101;
import '../module_settings/settings_module.dart' as _i86;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i15;
import '../module_settings/ui/screen/terms_of_use.dart' as _i18;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i24;
import '../module_settings/ui/settings_page/copy_map_link.dart' as _i7;
import '../module_settings/ui/settings_page/settings_page.dart' as _i64;
import '../module_splash/splash_module.dart' as _i65;
import '../module_splash/ui/screen/splash_screen.dart' as _i42;
import '../module_subscription/manager/subscription_manager.dart' as _i66;
import '../module_subscription/repository/subscription_repository.dart' as _i43;
import '../module_subscription/service/subscription_service.dart' as _i88;
import '../module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i103;
import '../module_subscription/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i113;
import '../module_subscription/state_manager/subscription_balance_state_manager.dart'
    as _i115;
import '../module_subscription/subscriptions_module.dart' as _i132;
import '../module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i121;
import '../module_subscription/ui/screens/store_subscriptions_details_screen.dart'
    as _i17;
import '../module_subscription/ui/screens/store_subscriptions_screen.dart'
    as _i130;
import '../module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart'
    as _i131;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i19;
import '../module_theme/service/theme_service/theme_service.dart' as _i22;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i25;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i20;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i34;
import '../utils/global/global_state_manager.dart' as _i136;
import '../utils/helpers/firestore_helper.dart' as _i8;
import '../utils/logger/logger.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AboutHiveHelper>(() => _i3.AboutHiveHelper());
  gh.factory<_i4.AboutScreen>(() => _i4.AboutScreen());
  gh.factory<_i5.AuthPrefsHelper>(() => _i5.AuthPrefsHelper());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
  gh.factory<_i7.CopyMapLinkScreen>(() => _i7.CopyMapLinkScreen());
  gh.factory<_i8.FireStoreHelper>(() => _i8.FireStoreHelper());
  gh.factory<_i9.LocalNotificationService>(
      () => _i9.LocalNotificationService());
  gh.factory<_i10.LocalizationPreferencesHelper>(
      () => _i10.LocalizationPreferencesHelper());
  gh.factory<_i11.LocalizationService>(() =>
      _i11.LocalizationService(get<_i10.LocalizationPreferencesHelper>()));
  gh.factory<_i12.Logger>(() => _i12.Logger());
  gh.factory<_i13.NotificationsPrefHelper>(
      () => _i13.NotificationsPrefHelper());
  gh.factory<_i14.OrderHiveHelper>(() => _i14.OrderHiveHelper());
  gh.factory<_i15.PrivecyPolicy>(() => _i15.PrivecyPolicy());
  gh.factory<_i16.ProfilePreferencesHelper>(
      () => _i16.ProfilePreferencesHelper());
  gh.factory<_i17.StoreSubscriptionsFinanceDetailsScreen>(
      () => _i17.StoreSubscriptionsFinanceDetailsScreen());
  gh.factory<_i18.TermsOfUse>(() => _i18.TermsOfUse());
  gh.factory<_i19.ThemePreferencesHelper>(() => _i19.ThemePreferencesHelper());
  gh.factory<_i20.UploadRepository>(() => _i20.UploadRepository());
  gh.factory<_i21.ApiClient>(() => _i21.ApiClient(get<_i12.Logger>()));
  gh.factory<_i22.AppThemeDataService>(
      () => _i22.AppThemeDataService(get<_i19.ThemePreferencesHelper>()));
  gh.factory<_i23.AuthRepository>(
      () => _i23.AuthRepository(get<_i21.ApiClient>(), get<_i12.Logger>()));
  gh.factory<_i24.ChooseLocalScreen>(
      () => _i24.ChooseLocalScreen(get<_i11.LocalizationService>()));
  gh.factory<_i25.UploadManager>(
      () => _i25.UploadManager(get<_i20.UploadRepository>()));
  gh.factory<_i26.AboutRepository>(
      () => _i26.AboutRepository(get<_i21.ApiClient>()));
  gh.factory<_i27.AuthManager>(
      () => _i27.AuthManager(get<_i23.AuthRepository>()));
  gh.factory<_i28.AuthService>(() =>
      _i28.AuthService(get<_i5.AuthPrefsHelper>(), get<_i27.AuthManager>()));
  gh.factory<_i29.BidOrderRepository>(() =>
      _i29.BidOrderRepository(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i30.BranchesRepository>(() =>
      _i30.BranchesRepository(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i31.ChatRepository>(() =>
      _i31.ChatRepository(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i32.DeepLinkRepository>(() =>
      _i32.DeepLinkRepository(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i33.ForgotPassStateManager>(
      () => _i33.ForgotPassStateManager(get<_i28.AuthService>()));
  gh.factory<_i34.ImageUploadService>(
      () => _i34.ImageUploadService(get<_i25.UploadManager>()));
  gh.factory<_i35.LoginStateManager>(
      () => _i35.LoginStateManager(get<_i28.AuthService>()));
  gh.factory<_i36.MyNotificationsRepository>(() =>
      _i36.MyNotificationsRepository(
          get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i37.NotificationRepo>(() =>
      _i37.NotificationRepo(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i38.OrderRepository>(() =>
      _i38.OrderRepository(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i39.OrdersManager>(
      () => _i39.OrdersManager(get<_i38.OrderRepository>()));
  gh.factory<_i40.ProfileRepository>(() =>
      _i40.ProfileRepository(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i41.RegisterStateManager>(
      () => _i41.RegisterStateManager(get<_i28.AuthService>()));
  gh.factory<_i42.SplashScreen>(
      () => _i42.SplashScreen(get<_i28.AuthService>()));
  gh.factory<_i43.SubscriptionsRepository>(() => _i43.SubscriptionsRepository(
      get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i44.AboutManager>(
      () => _i44.AboutManager(get<_i26.AboutRepository>()));
  gh.factory<_i45.AboutService>(
      () => _i45.AboutService(get<_i44.AboutManager>()));
  gh.factory<_i46.BidOrderManager>(
      () => _i46.BidOrderManager(get<_i29.BidOrderRepository>()));
  gh.factory<_i47.BidOrderService>(
      () => _i47.BidOrderService(get<_i46.BidOrderManager>()));
  gh.factory<_i48.BidOrderStatusStateManager>(() =>
      _i48.BidOrderStatusStateManager(
          get<_i47.BidOrderService>(), get<_i28.AuthService>()));
  gh.factory<_i49.BranchesManager>(
      () => _i49.BranchesManager(get<_i30.BranchesRepository>()));
  gh.factory<_i50.ChatManager>(
      () => _i50.ChatManager(get<_i31.ChatRepository>()));
  gh.factory<_i51.ChatService>(() => _i51.ChatService(get<_i50.ChatManager>()));
  gh.factory<_i52.ChatStateManager>(
      () => _i52.ChatStateManager(get<_i51.ChatService>()));
  gh.factory<_i53.FireNotificationService>(() => _i53.FireNotificationService(
      get<_i13.NotificationsPrefHelper>(), get<_i37.NotificationRepo>()));
  gh.factory<_i54.ForgotPassScreen>(
      () => _i54.ForgotPassScreen(get<_i33.ForgotPassStateManager>()));
  gh.factory<_i55.LoginScreen>(
      () => _i55.LoginScreen(get<_i35.LoginStateManager>()));
  gh.factory<_i56.MyNotificationsManager>(
      () => _i56.MyNotificationsManager(get<_i36.MyNotificationsRepository>()));
  gh.factory<_i57.MyNotificationsService>(
      () => _i57.MyNotificationsService(get<_i56.MyNotificationsManager>()));
  gh.factory<_i58.OpenBidOrderStateManager>(
      () => _i58.OpenBidOrderStateManager(get<_i47.BidOrderService>()));
  gh.factory<_i59.OrderOffersDetailsStateManager>(
      () => _i59.OrderOffersDetailsStateManager(get<_i47.BidOrderService>()));
  gh.factory<_i60.OrdersChatListStateManager>(() =>
      _i60.OrdersChatListStateManager(
          get<_i51.ChatService>(), get<_i28.AuthService>()));
  gh.factory<_i61.ProfileManager>(
      () => _i61.ProfileManager(get<_i40.ProfileRepository>()));
  gh.factory<_i62.ProfileService>(() => _i62.ProfileService(
      get<_i61.ProfileManager>(),
      get<_i16.ProfilePreferencesHelper>(),
      get<_i28.AuthService>()));
  gh.factory<_i63.RegisterScreen>(
      () => _i63.RegisterScreen(get<_i41.RegisterStateManager>()));
  gh.factory<_i64.SettingsScreen>(() => _i64.SettingsScreen(
      get<_i28.AuthService>(),
      get<_i11.LocalizationService>(),
      get<_i22.AppThemeDataService>(),
      get<_i53.FireNotificationService>()));
  gh.factory<_i65.SplashModule>(
      () => _i65.SplashModule(get<_i42.SplashScreen>()));
  gh.factory<_i66.SubscriptionsManager>(
      () => _i66.SubscriptionsManager(get<_i43.SubscriptionsRepository>()));
  gh.factory<_i67.UpdatesStateManager>(() => _i67.UpdatesStateManager(
      get<_i57.MyNotificationsService>(), get<_i28.AuthService>()));
  gh.factory<_i68.AboutScreenStateManager>(() => _i68.AboutScreenStateManager(
      get<_i11.LocalizationService>(), get<_i45.AboutService>()));
  gh.factory<_i69.AccountBalanceStateManager>(() =>
      _i69.AccountBalanceStateManager(get<_i62.ProfileService>(),
          get<_i28.AuthService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i70.AddBidOrderStateManager>(
      () => _i70.AddBidOrderStateManager(get<_i47.BidOrderService>()));
  gh.factory<_i71.AuthorizationModule>(() => _i71.AuthorizationModule(
      get<_i55.LoginScreen>(),
      get<_i63.RegisterScreen>(),
      get<_i54.ForgotPassScreen>()));
  gh.factory<_i72.BidOrderDetailsScreen>(
      () => _i72.BidOrderDetailsScreen(get<_i48.BidOrderStatusStateManager>()));
  gh.factory<_i73.BidOrderLogsStateManager>(
      () => _i73.BidOrderLogsStateManager(get<_i47.BidOrderService>()));
  gh.factory<_i74.BranchesListService>(() => _i74.BranchesListService(
      get<_i49.BranchesManager>(), get<_i16.ProfilePreferencesHelper>()));
  gh.factory<_i75.BranchesListStateManager>(
      () => _i75.BranchesListStateManager(get<_i74.BranchesListService>()));
  gh.factory<_i76.ChatPage>(() => _i76.ChatPage(
      get<_i52.ChatStateManager>(),
      get<_i34.ImageUploadService>(),
      get<_i28.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i77.EditProfileStateManager>(() => _i77.EditProfileStateManager(
      get<_i34.ImageUploadService>(),
      get<_i62.ProfileService>(),
      get<_i28.AuthService>()));
  gh.factory<_i78.InitAccountStateManager>(() => _i78.InitAccountStateManager(
      get<_i62.ProfileService>(),
      get<_i28.AuthService>(),
      get<_i34.ImageUploadService>()));
  gh.factory<_i79.InitBranchesStateManager>(
      () => _i79.InitBranchesStateManager(get<_i74.BranchesListService>()));
  gh.factory<_i80.OpenBidOrderScreen>(
      () => _i80.OpenBidOrderScreen(get<_i58.OpenBidOrderStateManager>()));
  gh.factory<_i81.OrderChatRoomsScreen>(
      () => _i81.OrderChatRoomsScreen(get<_i60.OrdersChatListStateManager>()));
  gh.factory<_i82.OrderOfferDetailsScreen>(() =>
      _i82.OrderOfferDetailsScreen(get<_i59.OrderOffersDetailsStateManager>()));
  gh.factory<_i83.OrdersService>(() => _i83.OrdersService(
      get<_i39.OrdersManager>(), get<_i62.ProfileService>()));
  gh.factory<_i84.OwnerOrdersStateManager>(() => _i84.OwnerOrdersStateManager(
      get<_i83.OrdersService>(),
      get<_i28.AuthService>(),
      get<_i62.ProfileService>()));
  gh.factory<_i85.ProfileScreen>(
      () => _i85.ProfileScreen(get<_i77.EditProfileStateManager>()));
  gh.factory<_i86.SettingsModule>(() => _i86.SettingsModule(
      get<_i64.SettingsScreen>(),
      get<_i24.ChooseLocalScreen>(),
      get<_i7.CopyMapLinkScreen>(),
      get<_i15.PrivecyPolicy>(),
      get<_i18.TermsOfUse>()));
  gh.factory<_i87.SubOrdersStateManager>(() => _i87.SubOrdersStateManager(
      get<_i83.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i88.SubscriptionService>(
      () => _i88.SubscriptionService(get<_i66.SubscriptionsManager>()));
  gh.factory<_i89.UpdateBranchStateManager>(
      () => _i89.UpdateBranchStateManager(get<_i74.BranchesListService>()));
  gh.factory<_i90.UpdateOrderStateManager>(
      () => _i90.UpdateOrderStateManager(get<_i83.OrdersService>()));
  gh.factory<_i91.UpdateScreen>(
      () => _i91.UpdateScreen(get<_i67.UpdatesStateManager>()));
  gh.factory<_i92.AboutScreen>(
      () => _i92.AboutScreen(get<_i68.AboutScreenStateManager>()));
  gh.factory<_i93.AccountBalanceScreen>(
      () => _i93.AccountBalanceScreen(get<_i69.AccountBalanceStateManager>()));
  gh.factory<_i94.AddBidOrderScreen>(
      () => _i94.AddBidOrderScreen(get<_i70.AddBidOrderStateManager>()));
  gh.factory<_i95.BidOrderLogsScreen>(
      () => _i95.BidOrderLogsScreen(get<_i73.BidOrderLogsStateManager>()));
  gh.factory<_i96.BidOrdersModule>(() => _i96.BidOrdersModule(
      get<_i80.OpenBidOrderScreen>(),
      get<_i94.AddBidOrderScreen>(),
      get<_i82.OrderOfferDetailsScreen>(),
      get<_i95.BidOrderLogsScreen>(),
      get<_i72.BidOrderDetailsScreen>()));
  gh.factory<_i97.BranchesListScreen>(
      () => _i97.BranchesListScreen(get<_i75.BranchesListStateManager>()));
  gh.factory<_i98.ChatModule>(() =>
      _i98.ChatModule(get<_i76.ChatPage>(), get<_i81.OrderChatRoomsScreen>()));
  gh.factory<_i99.CompanyInfoStateManager>(() => _i99.CompanyInfoStateManager(
      get<_i83.OrdersService>(),
      get<_i28.AuthService>(),
      get<_i62.ProfileService>()));
  gh.factory<_i100.HiddenOrdersStateManager>(
      () => _i100.HiddenOrdersStateManager(get<_i83.OrdersService>()));
  gh.factory<_i101.InitAccountScreen>(
      () => _i101.InitAccountScreen(get<_i78.InitAccountStateManager>()));
  gh.factory<_i102.InitBranchesScreen>(
      () => _i102.InitBranchesScreen(get<_i79.InitBranchesStateManager>()));
  gh.factory<_i103.InitSubscriptionStateManager>(() =>
      _i103.InitSubscriptionStateManager(
          get<_i88.SubscriptionService>(),
          get<_i62.ProfileService>(),
          get<_i28.AuthService>(),
          get<_i34.ImageUploadService>()));
  gh.factory<_i104.MyNotificationsStateManager>(() =>
      _i104.MyNotificationsStateManager(get<_i57.MyNotificationsService>(),
          get<_i83.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i105.NewOrderLinkStateManager>(
      () => _i105.NewOrderLinkStateManager(get<_i83.OrdersService>()));
  gh.factory<_i106.NewOrderStateManager>(
      () => _i106.NewOrderStateManager(get<_i83.OrdersService>()));
  gh.factory<_i107.OrderLogsStateManager>(
      () => _i107.OrderLogsStateManager(get<_i83.OrdersService>()));
  gh.factory<_i108.OrderRecyclingStateManager>(() =>
      _i108.OrderRecyclingStateManager(
          get<_i83.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i109.OrderStatusStateManager>(() => _i109.OrderStatusStateManager(
      get<_i83.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i110.OrderTimeLineStateManager>(() =>
      _i110.OrderTimeLineStateManager(
          get<_i83.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i111.OwnerOrdersScreen>(() => _i111.OwnerOrdersScreen(
      get<_i84.OwnerOrdersStateManager>(), get<_i106.NewOrderStateManager>()));
  gh.factory<_i112.ProfileModule>(() => _i112.ProfileModule(
      get<_i85.ProfileScreen>(),
      get<_i101.InitAccountScreen>(),
      get<_i93.AccountBalanceScreen>()));
  gh.factory<_i113.StoreSubscriptionsFinanceStateManager>(() =>
      _i113.StoreSubscriptionsFinanceStateManager(
          get<_i88.SubscriptionService>()));
  gh.factory<_i114.SubOrdersScreen>(
      () => _i114.SubOrdersScreen(get<_i87.SubOrdersStateManager>()));
  gh.factory<_i115.SubscriptionBalanceStateManager>(() =>
      _i115.SubscriptionBalanceStateManager(
          get<_i88.SubscriptionService>(),
          get<_i62.ProfileService>(),
          get<_i28.AuthService>(),
          get<_i34.ImageUploadService>()));
  gh.factory<_i116.UpdateBranchScreen>(
      () => _i116.UpdateBranchScreen(get<_i89.UpdateBranchStateManager>()));
  gh.factory<_i117.UpdateOrderScreen>(
      () => _i117.UpdateOrderScreen(get<_i90.UpdateOrderStateManager>()));
  gh.factory<_i118.BranchesModule>(() => _i118.BranchesModule(
      get<_i97.BranchesListScreen>(),
      get<_i116.UpdateBranchScreen>(),
      get<_i102.InitBranchesScreen>()));
  gh.factory<_i119.CompanyInfoScreen>(
      () => _i119.CompanyInfoScreen(get<_i99.CompanyInfoStateManager>()));
  gh.factory<_i120.HiddenOrdersScreen>(
      () => _i120.HiddenOrdersScreen(get<_i100.HiddenOrdersStateManager>()));
  gh.factory<_i121.InitSubscriptionScreen>(() =>
      _i121.InitSubscriptionScreen(get<_i103.InitSubscriptionStateManager>()));
  gh.factory<_i122.MyNotificationsScreen>(() =>
      _i122.MyNotificationsScreen(get<_i104.MyNotificationsStateManager>()));
  gh.factory<_i123.NewOrderLinkScreen>(
      () => _i123.NewOrderLinkScreen(get<_i105.NewOrderLinkStateManager>()));
  gh.factory<_i124.NewOrderScreen>(
      () => _i124.NewOrderScreen(get<_i106.NewOrderStateManager>()));
  gh.factory<_i125.OrderDetailsScreen>(
      () => _i125.OrderDetailsScreen(get<_i109.OrderStatusStateManager>()));
  gh.factory<_i126.OrderLogsScreen>(
      () => _i126.OrderLogsScreen(get<_i107.OrderLogsStateManager>()));
  gh.factory<_i127.OrderRecyclingScreen>(() =>
      _i127.OrderRecyclingScreen(get<_i108.OrderRecyclingStateManager>()));
  gh.factory<_i128.OrderTimeLineScreen>(
      () => _i128.OrderTimeLineScreen(get<_i110.OrderTimeLineStateManager>()));
  gh.factory<_i129.OrdersModule>(() => _i129.OrdersModule(
      get<_i124.NewOrderScreen>(),
      get<_i125.OrderDetailsScreen>(),
      get<_i111.OwnerOrdersScreen>(),
      get<_i114.SubOrdersScreen>(),
      get<_i123.NewOrderLinkScreen>(),
      get<_i128.OrderTimeLineScreen>(),
      get<_i126.OrderLogsScreen>(),
      get<_i120.HiddenOrdersScreen>(),
      get<_i127.OrderRecyclingScreen>(),
      get<_i117.UpdateOrderScreen>()));
  gh.factory<_i130.StoreSubscriptionsFinanceScreen>(() =>
      _i130.StoreSubscriptionsFinanceScreen(
          get<_i113.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i131.SubscriptionBalanceScreen>(() =>
      _i131.SubscriptionBalanceScreen(
          get<_i115.SubscriptionBalanceStateManager>()));
  gh.factory<_i132.SubscriptionsModule>(() => _i132.SubscriptionsModule(
      get<_i121.InitSubscriptionScreen>(),
      get<_i131.SubscriptionBalanceScreen>(),
      get<_i130.StoreSubscriptionsFinanceScreen>(),
      get<_i17.StoreSubscriptionsFinanceDetailsScreen>()));
  gh.factory<_i133.AboutModule>(() => _i133.AboutModule(
      get<_i92.AboutScreen>(), get<_i119.CompanyInfoScreen>()));
  gh.factory<_i134.MyNotificationsModule>(() => _i134.MyNotificationsModule(
      get<_i122.MyNotificationsScreen>(), get<_i91.UpdateScreen>()));
  gh.factory<_i135.MyApp>(() => _i135.MyApp(
      get<_i129.OrdersModule>(),
      get<_i22.AppThemeDataService>(),
      get<_i11.LocalizationService>(),
      get<_i53.FireNotificationService>(),
      get<_i9.LocalNotificationService>(),
      get<_i65.SplashModule>(),
      get<_i71.AuthorizationModule>(),
      get<_i98.ChatModule>(),
      get<_i86.SettingsModule>(),
      get<_i133.AboutModule>(),
      get<_i112.ProfileModule>(),
      get<_i118.BranchesModule>(),
      get<_i132.SubscriptionsModule>(),
      get<_i134.MyNotificationsModule>(),
      get<_i96.BidOrdersModule>()));
  gh.singleton<_i136.GlobalStateManager>(_i136.GlobalStateManager());
  return get;
}

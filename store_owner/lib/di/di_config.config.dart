// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i134;
import '../module_about/about_module.dart' as _i132;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i43;
import '../module_about/repository/about_repository.dart' as _i26;
import '../module_about/service/about_service/about_service.dart' as _i44;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i67;
import '../module_about/state_manager/company_info_state_manager.dart' as _i98;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i91;
import '../module_about/ui/screen/company_info/company_info_screen.dart'
    as _i118;
import '../module_auth/authoriazation_module.dart' as _i70;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i27;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i5;
import '../module_auth/repository/auth/auth_repository.dart' as _i23;
import '../module_auth/service/auth_service/auth_service.dart' as _i28;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i32;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i34;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i40;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i53;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i54;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i62;
import '../module_bidorder/bid_orders_module.dart' as _i95;
import '../module_bidorder/manager/bidorder_manager.dart' as _i45;
import '../module_bidorder/repository/bidorder_repoesitory.dart' as _i29;
import '../module_bidorder/service/bidorder_service.dart' as _i46;
import '../module_bidorder/state_manager/add_bidorder_state_manager.dart'
    as _i69;
import '../module_bidorder/state_manager/bidorder_details/bidorder_status.state_manager.dart'
    as _i47;
import '../module_bidorder/state_manager/bidorder_details/order_offer_state_manager.dart'
    as _i58;
import '../module_bidorder/state_manager/bidorder_logs_state_manager.dart'
    as _i72;
import '../module_bidorder/state_manager/open_order_state_manager.dart' as _i57;
import '../module_bidorder/ui/screens/add_bidorder_screen.dart' as _i93;
import '../module_bidorder/ui/screens/bidorder_details/bidorder_details_screen.dart'
    as _i71;
import '../module_bidorder/ui/screens/bidorder_details/order_offer_details_screen.dart'
    as _i81;
import '../module_bidorder/ui/screens/bidorder_logs_screen.dart' as _i94;
import '../module_bidorder/ui/screens/open_bidorder_screen.dart' as _i79;
import '../module_branches/branches_module.dart' as _i117;
import '../module_branches/manager/branches_manager.dart' as _i48;
import '../module_branches/repository/branches_repository.dart' as _i30;
import '../module_branches/service/branches_list_service.dart' as _i73;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i74;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i78;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i88;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i96;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i101;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i115;
import '../module_chat/chat_module.dart' as _i97;
import '../module_chat/manager/chat/chat_manager.dart' as _i49;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i31;
import '../module_chat/service/chat/char_service.dart' as _i50;
import '../module_chat/state_manager/chat_state_manager.dart' as _i51;
import '../module_chat/state_manager/order_chat_list_state_manager.dart'
    as _i59;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i75;
import '../module_chat/ui/screens/chat_rooms_screen.dart' as _i80;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i11;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i55;
import '../module_my_notifications/my_notifications_module.dart' as _i133;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i35;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i56;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i103;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i66;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i121;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i90;
import '../module_network/http_client/http_client.dart' as _i21;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import '../module_notifications/repository/notification_repo.dart' as _i36;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i52;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import '../module_orders/hive/order_hive_helper.dart' as _i14;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i38;
import '../module_orders/orders_module.dart' as _i128;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i37;
import '../module_orders/service/orders/orders.service.dart' as _i82;
import '../module_orders/state_manager/hidden_orders_state_manager.dart'
    as _i99;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i105;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i89;
import '../module_orders/state_manager/new_order_link_state_manager.dart'
    as _i104;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i106;
import '../module_orders/state_manager/order_recycling_state_manager.dart'
    as _i107;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i108;
import '../module_orders/state_manager/order_time_line_state_manager.dart'
    as _i109;
import '../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i83;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i86;
import '../module_orders/ui/screens/hidden_orders_screen.dart' as _i119;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i123;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i116;
import '../module_orders/ui/screens/new_order_link.dart' as _i122;
import '../module_orders/ui/screens/order_details/order_details_screen.dart'
    as _i124;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i125;
import '../module_orders/ui/screens/order_recylcing_screen.dart' as _i126;
import '../module_orders/ui/screens/order_time_line_screen.dart' as _i127;
import '../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i110;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i113;
import '../module_profile/manager/profile/profile.manager.dart' as _i60;
import '../module_profile/module_profile.dart' as _i111;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i16;
import '../module_profile/repository/profile/profile.repository.dart' as _i39;
import '../module_profile/service/profile/profile.service.dart' as _i61;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i68;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i76;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i77;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i92;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i84;
import '../module_profile/ui/screen/init_account_screen.dart' as _i100;
import '../module_settings/settings_module.dart' as _i85;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i15;
import '../module_settings/ui/screen/terms_of_use.dart' as _i18;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i24;
import '../module_settings/ui/settings_page/copy_map_link.dart' as _i7;
import '../module_settings/ui/settings_page/settings_page.dart' as _i63;
import '../module_splash/splash_module.dart' as _i64;
import '../module_splash/ui/screen/splash_screen.dart' as _i41;
import '../module_subscription/manager/subscription_manager.dart' as _i65;
import '../module_subscription/repository/subscription_repository.dart' as _i42;
import '../module_subscription/service/subscription_service.dart' as _i87;
import '../module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i102;
import '../module_subscription/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i112;
import '../module_subscription/state_manager/subscription_balance_state_manager.dart'
    as _i114;
import '../module_subscription/subscriptions_module.dart' as _i131;
import '../module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i120;
import '../module_subscription/ui/screens/store_subscriptions_details_screen.dart'
    as _i17;
import '../module_subscription/ui/screens/store_subscriptions_screen.dart'
    as _i129;
import '../module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart'
    as _i130;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i19;
import '../module_theme/service/theme_service/theme_service.dart' as _i22;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i25;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i20;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i33;
import '../utils/global/global_state_manager.dart' as _i135;
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
  gh.factory<_i32.ForgotPassStateManager>(
      () => _i32.ForgotPassStateManager(get<_i28.AuthService>()));
  gh.factory<_i33.ImageUploadService>(
      () => _i33.ImageUploadService(get<_i25.UploadManager>()));
  gh.factory<_i34.LoginStateManager>(
      () => _i34.LoginStateManager(get<_i28.AuthService>()));
  gh.factory<_i35.MyNotificationsRepository>(() =>
      _i35.MyNotificationsRepository(
          get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i36.NotificationRepo>(() =>
      _i36.NotificationRepo(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i37.OrderRepository>(() =>
      _i37.OrderRepository(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i38.OrdersManager>(
      () => _i38.OrdersManager(get<_i37.OrderRepository>()));
  gh.factory<_i39.ProfileRepository>(() =>
      _i39.ProfileRepository(get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i40.RegisterStateManager>(
      () => _i40.RegisterStateManager(get<_i28.AuthService>()));
  gh.factory<_i41.SplashScreen>(
      () => _i41.SplashScreen(get<_i28.AuthService>()));
  gh.factory<_i42.SubscriptionsRepository>(() => _i42.SubscriptionsRepository(
      get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i43.AboutManager>(
      () => _i43.AboutManager(get<_i26.AboutRepository>()));
  gh.factory<_i44.AboutService>(
      () => _i44.AboutService(get<_i43.AboutManager>()));
  gh.factory<_i45.BidOrderManager>(
      () => _i45.BidOrderManager(get<_i29.BidOrderRepository>()));
  gh.factory<_i46.BidOrderService>(
      () => _i46.BidOrderService(get<_i45.BidOrderManager>()));
  gh.factory<_i47.BidOrderStatusStateManager>(() =>
      _i47.BidOrderStatusStateManager(
          get<_i46.BidOrderService>(), get<_i28.AuthService>()));
  gh.factory<_i48.BranchesManager>(
      () => _i48.BranchesManager(get<_i30.BranchesRepository>()));
  gh.factory<_i49.ChatManager>(
      () => _i49.ChatManager(get<_i31.ChatRepository>()));
  gh.factory<_i50.ChatService>(() => _i50.ChatService(get<_i49.ChatManager>()));
  gh.factory<_i51.ChatStateManager>(
      () => _i51.ChatStateManager(get<_i50.ChatService>()));
  gh.factory<_i52.FireNotificationService>(() => _i52.FireNotificationService(
      get<_i13.NotificationsPrefHelper>(), get<_i36.NotificationRepo>()));
  gh.factory<_i53.ForgotPassScreen>(
      () => _i53.ForgotPassScreen(get<_i32.ForgotPassStateManager>()));
  gh.factory<_i54.LoginScreen>(
      () => _i54.LoginScreen(get<_i34.LoginStateManager>()));
  gh.factory<_i55.MyNotificationsManager>(
      () => _i55.MyNotificationsManager(get<_i35.MyNotificationsRepository>()));
  gh.factory<_i56.MyNotificationsService>(
      () => _i56.MyNotificationsService(get<_i55.MyNotificationsManager>()));
  gh.factory<_i57.OpenBidOrderStateManager>(
      () => _i57.OpenBidOrderStateManager(get<_i46.BidOrderService>()));
  gh.factory<_i58.OrderOffersDetailsStateManager>(
      () => _i58.OrderOffersDetailsStateManager(get<_i46.BidOrderService>()));
  gh.factory<_i59.OrdersChatListStateManager>(() =>
      _i59.OrdersChatListStateManager(
          get<_i50.ChatService>(), get<_i28.AuthService>()));
  gh.factory<_i60.ProfileManager>(
      () => _i60.ProfileManager(get<_i39.ProfileRepository>()));
  gh.factory<_i61.ProfileService>(() => _i61.ProfileService(
      get<_i60.ProfileManager>(),
      get<_i16.ProfilePreferencesHelper>(),
      get<_i28.AuthService>()));
  gh.factory<_i62.RegisterScreen>(
      () => _i62.RegisterScreen(get<_i40.RegisterStateManager>()));
  gh.factory<_i63.SettingsScreen>(() => _i63.SettingsScreen(
      get<_i28.AuthService>(),
      get<_i11.LocalizationService>(),
      get<_i22.AppThemeDataService>(),
      get<_i52.FireNotificationService>()));
  gh.factory<_i64.SplashModule>(
      () => _i64.SplashModule(get<_i41.SplashScreen>()));
  gh.factory<_i65.SubscriptionsManager>(
      () => _i65.SubscriptionsManager(get<_i42.SubscriptionsRepository>()));
  gh.factory<_i66.UpdatesStateManager>(() => _i66.UpdatesStateManager(
      get<_i56.MyNotificationsService>(), get<_i28.AuthService>()));
  gh.factory<_i67.AboutScreenStateManager>(() => _i67.AboutScreenStateManager(
      get<_i11.LocalizationService>(), get<_i44.AboutService>()));
  gh.factory<_i68.AccountBalanceStateManager>(() =>
      _i68.AccountBalanceStateManager(get<_i61.ProfileService>(),
          get<_i28.AuthService>(), get<_i33.ImageUploadService>()));
  gh.factory<_i69.AddBidOrderStateManager>(
      () => _i69.AddBidOrderStateManager(get<_i46.BidOrderService>()));
  gh.factory<_i70.AuthorizationModule>(() => _i70.AuthorizationModule(
      get<_i54.LoginScreen>(),
      get<_i62.RegisterScreen>(),
      get<_i53.ForgotPassScreen>()));
  gh.factory<_i71.BidOrderDetailsScreen>(
      () => _i71.BidOrderDetailsScreen(get<_i47.BidOrderStatusStateManager>()));
  gh.factory<_i72.BidOrderLogsStateManager>(
      () => _i72.BidOrderLogsStateManager(get<_i46.BidOrderService>()));
  gh.factory<_i73.BranchesListService>(() => _i73.BranchesListService(
      get<_i48.BranchesManager>(), get<_i16.ProfilePreferencesHelper>()));
  gh.factory<_i74.BranchesListStateManager>(
      () => _i74.BranchesListStateManager(get<_i73.BranchesListService>()));
  gh.factory<_i75.ChatPage>(() => _i75.ChatPage(
      get<_i51.ChatStateManager>(),
      get<_i33.ImageUploadService>(),
      get<_i28.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i76.EditProfileStateManager>(() => _i76.EditProfileStateManager(
      get<_i33.ImageUploadService>(),
      get<_i61.ProfileService>(),
      get<_i28.AuthService>()));
  gh.factory<_i77.InitAccountStateManager>(() => _i77.InitAccountStateManager(
      get<_i61.ProfileService>(),
      get<_i28.AuthService>(),
      get<_i33.ImageUploadService>()));
  gh.factory<_i78.InitBranchesStateManager>(
      () => _i78.InitBranchesStateManager(get<_i73.BranchesListService>()));
  gh.factory<_i79.OpenBidOrderScreen>(
      () => _i79.OpenBidOrderScreen(get<_i57.OpenBidOrderStateManager>()));
  gh.factory<_i80.OrderChatRoomsScreen>(
      () => _i80.OrderChatRoomsScreen(get<_i59.OrdersChatListStateManager>()));
  gh.factory<_i81.OrderOfferDetailsScreen>(() =>
      _i81.OrderOfferDetailsScreen(get<_i58.OrderOffersDetailsStateManager>()));
  gh.factory<_i82.OrdersService>(() => _i82.OrdersService(
      get<_i38.OrdersManager>(), get<_i61.ProfileService>()));
  gh.factory<_i83.OwnerOrdersStateManager>(() => _i83.OwnerOrdersStateManager(
      get<_i82.OrdersService>(),
      get<_i28.AuthService>(),
      get<_i61.ProfileService>()));
  gh.factory<_i84.ProfileScreen>(
      () => _i84.ProfileScreen(get<_i76.EditProfileStateManager>()));
  gh.factory<_i85.SettingsModule>(() => _i85.SettingsModule(
      get<_i63.SettingsScreen>(),
      get<_i24.ChooseLocalScreen>(),
      get<_i7.CopyMapLinkScreen>(),
      get<_i15.PrivecyPolicy>(),
      get<_i18.TermsOfUse>()));
  gh.factory<_i86.SubOrdersStateManager>(() => _i86.SubOrdersStateManager(
      get<_i82.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i87.SubscriptionService>(
      () => _i87.SubscriptionService(get<_i65.SubscriptionsManager>()));
  gh.factory<_i88.UpdateBranchStateManager>(
      () => _i88.UpdateBranchStateManager(get<_i73.BranchesListService>()));
  gh.factory<_i89.UpdateOrderStateManager>(
      () => _i89.UpdateOrderStateManager(get<_i82.OrdersService>()));
  gh.factory<_i90.UpdateScreen>(
      () => _i90.UpdateScreen(get<_i66.UpdatesStateManager>()));
  gh.factory<_i91.AboutScreen>(
      () => _i91.AboutScreen(get<_i67.AboutScreenStateManager>()));
  gh.factory<_i92.AccountBalanceScreen>(
      () => _i92.AccountBalanceScreen(get<_i68.AccountBalanceStateManager>()));
  gh.factory<_i93.AddBidOrderScreen>(
      () => _i93.AddBidOrderScreen(get<_i69.AddBidOrderStateManager>()));
  gh.factory<_i94.BidOrderLogsScreen>(
      () => _i94.BidOrderLogsScreen(get<_i72.BidOrderLogsStateManager>()));
  gh.factory<_i95.BidOrdersModule>(() => _i95.BidOrdersModule(
      get<_i79.OpenBidOrderScreen>(),
      get<_i93.AddBidOrderScreen>(),
      get<_i81.OrderOfferDetailsScreen>(),
      get<_i94.BidOrderLogsScreen>(),
      get<_i71.BidOrderDetailsScreen>()));
  gh.factory<_i96.BranchesListScreen>(
      () => _i96.BranchesListScreen(get<_i74.BranchesListStateManager>()));
  gh.factory<_i97.ChatModule>(() =>
      _i97.ChatModule(get<_i75.ChatPage>(), get<_i80.OrderChatRoomsScreen>()));
  gh.factory<_i98.CompanyInfoStateManager>(() => _i98.CompanyInfoStateManager(
      get<_i82.OrdersService>(),
      get<_i28.AuthService>(),
      get<_i61.ProfileService>()));
  gh.factory<_i99.HiddenOrdersStateManager>(
      () => _i99.HiddenOrdersStateManager(get<_i82.OrdersService>()));
  gh.factory<_i100.InitAccountScreen>(
      () => _i100.InitAccountScreen(get<_i77.InitAccountStateManager>()));
  gh.factory<_i101.InitBranchesScreen>(
      () => _i101.InitBranchesScreen(get<_i78.InitBranchesStateManager>()));
  gh.factory<_i102.InitSubscriptionStateManager>(() =>
      _i102.InitSubscriptionStateManager(
          get<_i87.SubscriptionService>(),
          get<_i61.ProfileService>(),
          get<_i28.AuthService>(),
          get<_i33.ImageUploadService>()));
  gh.factory<_i103.MyNotificationsStateManager>(() =>
      _i103.MyNotificationsStateManager(get<_i56.MyNotificationsService>(),
          get<_i82.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i104.NewOrderLinkStateManager>(
      () => _i104.NewOrderLinkStateManager(get<_i82.OrdersService>()));
  gh.factory<_i105.NewOrderStateManager>(
      () => _i105.NewOrderStateManager(get<_i82.OrdersService>()));
  gh.factory<_i106.OrderLogsStateManager>(
      () => _i106.OrderLogsStateManager(get<_i82.OrdersService>()));
  gh.factory<_i107.OrderRecyclingStateManager>(() =>
      _i107.OrderRecyclingStateManager(
          get<_i82.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i108.OrderStatusStateManager>(() => _i108.OrderStatusStateManager(
      get<_i82.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i109.OrderTimeLineStateManager>(() =>
      _i109.OrderTimeLineStateManager(
          get<_i82.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i110.OwnerOrdersScreen>(() => _i110.OwnerOrdersScreen(
      get<_i83.OwnerOrdersStateManager>(), get<_i105.NewOrderStateManager>()));
  gh.factory<_i111.ProfileModule>(() => _i111.ProfileModule(
      get<_i84.ProfileScreen>(),
      get<_i100.InitAccountScreen>(),
      get<_i92.AccountBalanceScreen>()));
  gh.factory<_i112.StoreSubscriptionsFinanceStateManager>(() =>
      _i112.StoreSubscriptionsFinanceStateManager(
          get<_i87.SubscriptionService>()));
  gh.factory<_i113.SubOrdersScreen>(
      () => _i113.SubOrdersScreen(get<_i86.SubOrdersStateManager>()));
  gh.factory<_i114.SubscriptionBalanceStateManager>(() =>
      _i114.SubscriptionBalanceStateManager(
          get<_i87.SubscriptionService>(),
          get<_i61.ProfileService>(),
          get<_i28.AuthService>(),
          get<_i33.ImageUploadService>()));
  gh.factory<_i115.UpdateBranchScreen>(
      () => _i115.UpdateBranchScreen(get<_i88.UpdateBranchStateManager>()));
  gh.factory<_i116.UpdateOrderScreen>(
      () => _i116.UpdateOrderScreen(get<_i89.UpdateOrderStateManager>()));
  gh.factory<_i117.BranchesModule>(() => _i117.BranchesModule(
      get<_i96.BranchesListScreen>(),
      get<_i115.UpdateBranchScreen>(),
      get<_i101.InitBranchesScreen>()));
  gh.factory<_i118.CompanyInfoScreen>(
      () => _i118.CompanyInfoScreen(get<_i98.CompanyInfoStateManager>()));
  gh.factory<_i119.HiddenOrdersScreen>(
      () => _i119.HiddenOrdersScreen(get<_i99.HiddenOrdersStateManager>()));
  gh.factory<_i120.InitSubscriptionScreen>(() =>
      _i120.InitSubscriptionScreen(get<_i102.InitSubscriptionStateManager>()));
  gh.factory<_i121.MyNotificationsScreen>(() =>
      _i121.MyNotificationsScreen(get<_i103.MyNotificationsStateManager>()));
  gh.factory<_i122.NewOrderLinkScreen>(
      () => _i122.NewOrderLinkScreen(get<_i104.NewOrderLinkStateManager>()));
  gh.factory<_i123.NewOrderScreen>(
      () => _i123.NewOrderScreen(get<_i105.NewOrderStateManager>()));
  gh.factory<_i124.OrderDetailsScreen>(
      () => _i124.OrderDetailsScreen(get<_i108.OrderStatusStateManager>()));
  gh.factory<_i125.OrderLogsScreen>(
      () => _i125.OrderLogsScreen(get<_i106.OrderLogsStateManager>()));
  gh.factory<_i126.OrderRecyclingScreen>(() =>
      _i126.OrderRecyclingScreen(get<_i107.OrderRecyclingStateManager>()));
  gh.factory<_i127.OrderTimeLineScreen>(
      () => _i127.OrderTimeLineScreen(get<_i109.OrderTimeLineStateManager>()));
  gh.factory<_i128.OrdersModule>(() => _i128.OrdersModule(
      get<_i123.NewOrderScreen>(),
      get<_i124.OrderDetailsScreen>(),
      get<_i110.OwnerOrdersScreen>(),
      get<_i113.SubOrdersScreen>(),
      get<_i122.NewOrderLinkScreen>(),
      get<_i127.OrderTimeLineScreen>(),
      get<_i125.OrderLogsScreen>(),
      get<_i119.HiddenOrdersScreen>(),
      get<_i126.OrderRecyclingScreen>(),
      get<_i116.UpdateOrderScreen>()));
  gh.factory<_i129.StoreSubscriptionsFinanceScreen>(() =>
      _i129.StoreSubscriptionsFinanceScreen(
          get<_i112.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i130.SubscriptionBalanceScreen>(() =>
      _i130.SubscriptionBalanceScreen(
          get<_i114.SubscriptionBalanceStateManager>()));
  gh.factory<_i131.SubscriptionsModule>(() => _i131.SubscriptionsModule(
      get<_i120.InitSubscriptionScreen>(),
      get<_i130.SubscriptionBalanceScreen>(),
      get<_i129.StoreSubscriptionsFinanceScreen>(),
      get<_i17.StoreSubscriptionsFinanceDetailsScreen>()));
  gh.factory<_i132.AboutModule>(() => _i132.AboutModule(
      get<_i91.AboutScreen>(), get<_i118.CompanyInfoScreen>()));
  gh.factory<_i133.MyNotificationsModule>(() => _i133.MyNotificationsModule(
      get<_i121.MyNotificationsScreen>(), get<_i90.UpdateScreen>()));
  gh.factory<_i134.MyApp>(() => _i134.MyApp(
      get<_i128.OrdersModule>(),
      get<_i22.AppThemeDataService>(),
      get<_i11.LocalizationService>(),
      get<_i52.FireNotificationService>(),
      get<_i9.LocalNotificationService>(),
      get<_i64.SplashModule>(),
      get<_i70.AuthorizationModule>(),
      get<_i97.ChatModule>(),
      get<_i85.SettingsModule>(),
      get<_i132.AboutModule>(),
      get<_i111.ProfileModule>(),
      get<_i117.BranchesModule>(),
      get<_i131.SubscriptionsModule>(),
      get<_i133.MyNotificationsModule>(),
      get<_i95.BidOrdersModule>()));
  gh.singleton<_i135.GlobalStateManager>(_i135.GlobalStateManager());
  return get;
}

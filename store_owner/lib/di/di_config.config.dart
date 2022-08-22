// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i141;
import '../module_about/about_module.dart' as _i139;
import '../module_about/hive/about_hive_helper.dart' as _i3;
import '../module_about/manager/about_manager.dart' as _i45;
import '../module_about/repository/about_repository.dart' as _i26;
import '../module_about/service/about_service/about_service.dart' as _i46;
import '../module_about/state_manager/about_screen_state_manager.dart' as _i71;
import '../module_about/state_manager/company_info_state_manager.dart' as _i103;
import '../module_about/ui/screen/about_screen/about_screen.dart' as _i96;
import '../module_about/ui/screen/company_info/company_info_screen.dart'
    as _i124;
import '../module_auth/authoriazation_module.dart' as _i74;
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
import '../module_auth/state_manager/reset_state_manager/reset_password_state_manager.dart'
    as _i42;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i55;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i56;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i65;
import '../module_auth/ui/screen/reset_password_screen/reset_password_screen.dart'
    as _i66;
import '../module_bidorder/bid_orders_module.dart' as _i100;
import '../module_bidorder/manager/bidorder_manager.dart' as _i47;
import '../module_bidorder/repository/bidorder_repoesitory.dart' as _i29;
import '../module_bidorder/service/bidorder_service.dart' as _i48;
import '../module_bidorder/state_manager/add_bidorder_state_manager.dart'
    as _i73;
import '../module_bidorder/state_manager/bidorder_details/bidorder_status.state_manager.dart'
    as _i49;
import '../module_bidorder/state_manager/bidorder_details/order_offer_state_manager.dart'
    as _i61;
import '../module_bidorder/state_manager/bidorder_logs_state_manager.dart'
    as _i76;
import '../module_bidorder/state_manager/open_order_state_manager.dart' as _i60;
import '../module_bidorder/ui/screens/add_bidorder_screen.dart' as _i98;
import '../module_bidorder/ui/screens/bidorder_details/bidorder_details_screen.dart'
    as _i75;
import '../module_bidorder/ui/screens/bidorder_details/order_offer_details_screen.dart'
    as _i86;
import '../module_bidorder/ui/screens/bidorder_logs_screen.dart' as _i99;
import '../module_bidorder/ui/screens/open_bidorder_screen.dart' as _i84;
import '../module_branches/branches_module.dart' as _i123;
import '../module_branches/manager/branches_manager.dart' as _i50;
import '../module_branches/repository/branches_repository.dart' as _i30;
import '../module_branches/service/branches_list_service.dart' as _i77;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i78;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i82;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i93;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i101;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i106;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i121;
import '../module_chat/chat_module.dart' as _i102;
import '../module_chat/manager/chat/chat_manager.dart' as _i51;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i31;
import '../module_chat/service/chat/char_service.dart' as _i52;
import '../module_chat/state_manager/chat_state_manager.dart' as _i53;
import '../module_chat/state_manager/ongoing_order_chat_state_manager.dart'
    as _i59;
import '../module_chat/state_manager/order_chat_list_state_manager.dart'
    as _i62;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i79;
import '../module_chat/ui/screens/chat_rooms_screen.dart' as _i85;
import '../module_chat/ui/screens/ongoing_chat_rooms_screen.dart' as _i83;
import '../module_deep_links/repository/deep_link_repository.dart' as _i32;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i11;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i57;
import '../module_my_notifications/my_notifications_module.dart' as _i140;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i36;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i58;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i108;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i70;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i127;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i95;
import '../module_network/http_client/http_client.dart' as _i21;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import '../module_notifications/repository/notification_repo.dart' as _i37;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i54;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import '../module_orders/hive/order_hive_helper.dart' as _i14;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i39;
import '../module_orders/orders_module.dart' as _i135;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i38;
import '../module_orders/service/orders/orders.service.dart' as _i87;
import '../module_orders/state_manager/hidden_orders_state_manager.dart'
    as _i104;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i110;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i94;
import '../module_orders/state_manager/new_order_link_state_manager.dart'
    as _i109;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i111;
import '../module_orders/state_manager/order_recycling_state_manager.dart'
    as _i112;
import '../module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i113;
import '../module_orders/state_manager/order_time_line_state_manager.dart'
    as _i114;
import '../module_orders/state_manager/orders_cash_state_manager.dart' as _i115;
import '../module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i88;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i91;
import '../module_orders/ui/screens/hidden_orders_screen.dart' as _i125;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i129;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i122;
import '../module_orders/ui/screens/new_order_link.dart' as _i128;
import '../module_orders/ui/screens/order_details/order_details_screen.dart'
    as _i130;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i131;
import '../module_orders/ui/screens/order_recylcing_screen.dart' as _i132;
import '../module_orders/ui/screens/order_time_line_screen.dart' as _i133;
import '../module_orders/ui/screens/orders/owner_orders_screen.dart' as _i116;
import '../module_orders/ui/screens/orders_cash_screen.dart' as _i134;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i119;
import '../module_profile/manager/profile/profile.manager.dart' as _i63;
import '../module_profile/module_profile.dart' as _i117;
import '../module_profile/prefs_helper/profile_prefs_helper.dart' as _i16;
import '../module_profile/repository/profile/profile.repository.dart' as _i40;
import '../module_profile/service/profile/profile.service.dart' as _i64;
import '../module_profile/state_manager/account_balance_state_manager.dart'
    as _i72;
import '../module_profile/state_manager/edit_profile/edit_profile.dart' as _i80;
import '../module_profile/state_manager/init_account.state_manager.dart'
    as _i81;
import '../module_profile/ui/screen/account_balance_screen.dart' as _i97;
import '../module_profile/ui/screen/edit_profile/edit_profile.dart' as _i89;
import '../module_profile/ui/screen/init_account_screen.dart' as _i105;
import '../module_settings/settings_module.dart' as _i90;
import '../module_settings/ui/screen/about.dart' as _i4;
import '../module_settings/ui/screen/privecy_policy.dart' as _i15;
import '../module_settings/ui/screen/terms_of_use.dart' as _i18;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i24;
import '../module_settings/ui/settings_page/copy_map_link.dart' as _i7;
import '../module_settings/ui/settings_page/settings_page.dart' as _i67;
import '../module_splash/splash_module.dart' as _i68;
import '../module_splash/ui/screen/splash_screen.dart' as _i43;
import '../module_subscription/manager/subscription_manager.dart' as _i69;
import '../module_subscription/repository/subscription_repository.dart' as _i44;
import '../module_subscription/service/subscription_service.dart' as _i92;
import '../module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i107;
import '../module_subscription/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i118;
import '../module_subscription/state_manager/subscription_balance_state_manager.dart'
    as _i120;
import '../module_subscription/subscriptions_module.dart' as _i138;
import '../module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i126;
import '../module_subscription/ui/screens/store_subscriptions_details_screen.dart'
    as _i17;
import '../module_subscription/ui/screens/store_subscriptions_screen.dart'
    as _i136;
import '../module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart'
    as _i137;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i19;
import '../module_theme/service/theme_service/theme_service.dart' as _i22;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i25;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i20;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i34;
import '../utils/global/global_state_manager.dart' as _i142;
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
  gh.factory<_i42.ResetPasswordStateManager>(
      () => _i42.ResetPasswordStateManager(get<_i28.AuthService>()));
  gh.factory<_i43.SplashScreen>(
      () => _i43.SplashScreen(get<_i28.AuthService>()));
  gh.factory<_i44.SubscriptionsRepository>(() => _i44.SubscriptionsRepository(
      get<_i21.ApiClient>(), get<_i28.AuthService>()));
  gh.factory<_i45.AboutManager>(
      () => _i45.AboutManager(get<_i26.AboutRepository>()));
  gh.factory<_i46.AboutService>(
      () => _i46.AboutService(get<_i45.AboutManager>()));
  gh.factory<_i47.BidOrderManager>(
      () => _i47.BidOrderManager(get<_i29.BidOrderRepository>()));
  gh.factory<_i48.BidOrderService>(
      () => _i48.BidOrderService(get<_i47.BidOrderManager>()));
  gh.factory<_i49.BidOrderStatusStateManager>(() =>
      _i49.BidOrderStatusStateManager(
          get<_i48.BidOrderService>(), get<_i28.AuthService>()));
  gh.factory<_i50.BranchesManager>(
      () => _i50.BranchesManager(get<_i30.BranchesRepository>()));
  gh.factory<_i51.ChatManager>(
      () => _i51.ChatManager(get<_i31.ChatRepository>()));
  gh.factory<_i52.ChatService>(() => _i52.ChatService(get<_i51.ChatManager>()));
  gh.factory<_i53.ChatStateManager>(
      () => _i53.ChatStateManager(get<_i52.ChatService>()));
  gh.factory<_i54.FireNotificationService>(() => _i54.FireNotificationService(
      get<_i13.NotificationsPrefHelper>(), get<_i37.NotificationRepo>()));
  gh.factory<_i55.ForgotPassScreen>(
      () => _i55.ForgotPassScreen(get<_i33.ForgotPassStateManager>()));
  gh.factory<_i56.LoginScreen>(
      () => _i56.LoginScreen(get<_i35.LoginStateManager>()));
  gh.factory<_i57.MyNotificationsManager>(
      () => _i57.MyNotificationsManager(get<_i36.MyNotificationsRepository>()));
  gh.factory<_i58.MyNotificationsService>(
      () => _i58.MyNotificationsService(get<_i57.MyNotificationsManager>()));
  gh.factory<_i59.OngoingOrderChatStateManager>(() =>
      _i59.OngoingOrderChatStateManager(
          get<_i52.ChatService>(), get<_i28.AuthService>()));
  gh.factory<_i60.OpenBidOrderStateManager>(
      () => _i60.OpenBidOrderStateManager(get<_i48.BidOrderService>()));
  gh.factory<_i61.OrderOffersDetailsStateManager>(
      () => _i61.OrderOffersDetailsStateManager(get<_i48.BidOrderService>()));
  gh.factory<_i62.OrdersChatListStateManager>(() =>
      _i62.OrdersChatListStateManager(
          get<_i52.ChatService>(), get<_i28.AuthService>()));
  gh.factory<_i63.ProfileManager>(
      () => _i63.ProfileManager(get<_i40.ProfileRepository>()));
  gh.factory<_i64.ProfileService>(() => _i64.ProfileService(
      get<_i63.ProfileManager>(),
      get<_i16.ProfilePreferencesHelper>(),
      get<_i28.AuthService>()));
  gh.factory<_i65.RegisterScreen>(
      () => _i65.RegisterScreen(get<_i41.RegisterStateManager>()));
  gh.factory<_i66.ResetPasswordScreen>(
      () => _i66.ResetPasswordScreen(get<_i42.ResetPasswordStateManager>()));
  gh.factory<_i67.SettingsScreen>(() => _i67.SettingsScreen(
      get<_i28.AuthService>(),
      get<_i11.LocalizationService>(),
      get<_i22.AppThemeDataService>(),
      get<_i54.FireNotificationService>()));
  gh.factory<_i68.SplashModule>(
      () => _i68.SplashModule(get<_i43.SplashScreen>()));
  gh.factory<_i69.SubscriptionsManager>(
      () => _i69.SubscriptionsManager(get<_i44.SubscriptionsRepository>()));
  gh.factory<_i70.UpdatesStateManager>(() => _i70.UpdatesStateManager(
      get<_i58.MyNotificationsService>(), get<_i28.AuthService>()));
  gh.factory<_i71.AboutScreenStateManager>(() => _i71.AboutScreenStateManager(
      get<_i11.LocalizationService>(), get<_i46.AboutService>()));
  gh.factory<_i72.AccountBalanceStateManager>(() =>
      _i72.AccountBalanceStateManager(get<_i64.ProfileService>(),
          get<_i28.AuthService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i73.AddBidOrderStateManager>(
      () => _i73.AddBidOrderStateManager(get<_i48.BidOrderService>()));
  gh.factory<_i74.AuthorizationModule>(() => _i74.AuthorizationModule(
      get<_i56.LoginScreen>(),
      get<_i65.RegisterScreen>(),
      get<_i66.ResetPasswordScreen>(),
      get<_i55.ForgotPassScreen>()));
  gh.factory<_i75.BidOrderDetailsScreen>(
      () => _i75.BidOrderDetailsScreen(get<_i49.BidOrderStatusStateManager>()));
  gh.factory<_i76.BidOrderLogsStateManager>(
      () => _i76.BidOrderLogsStateManager(get<_i48.BidOrderService>()));
  gh.factory<_i77.BranchesListService>(() => _i77.BranchesListService(
      get<_i50.BranchesManager>(), get<_i16.ProfilePreferencesHelper>()));
  gh.factory<_i78.BranchesListStateManager>(
      () => _i78.BranchesListStateManager(get<_i77.BranchesListService>()));
  gh.factory<_i79.ChatPage>(() => _i79.ChatPage(
      get<_i53.ChatStateManager>(),
      get<_i34.ImageUploadService>(),
      get<_i28.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i80.EditProfileStateManager>(() => _i80.EditProfileStateManager(
      get<_i34.ImageUploadService>(),
      get<_i64.ProfileService>(),
      get<_i28.AuthService>()));
  gh.factory<_i81.InitAccountStateManager>(() => _i81.InitAccountStateManager(
      get<_i64.ProfileService>(),
      get<_i28.AuthService>(),
      get<_i34.ImageUploadService>()));
  gh.factory<_i82.InitBranchesStateManager>(
      () => _i82.InitBranchesStateManager(get<_i77.BranchesListService>()));
  gh.factory<_i83.OngoingOrderChatScreen>(() =>
      _i83.OngoingOrderChatScreen(get<_i59.OngoingOrderChatStateManager>()));
  gh.factory<_i84.OpenBidOrderScreen>(
      () => _i84.OpenBidOrderScreen(get<_i60.OpenBidOrderStateManager>()));
  gh.factory<_i85.OrderChatRoomsScreen>(
      () => _i85.OrderChatRoomsScreen(get<_i62.OrdersChatListStateManager>()));
  gh.factory<_i86.OrderOfferDetailsScreen>(() =>
      _i86.OrderOfferDetailsScreen(get<_i61.OrderOffersDetailsStateManager>()));
  gh.factory<_i87.OrdersService>(() => _i87.OrdersService(
      get<_i39.OrdersManager>(), get<_i64.ProfileService>()));
  gh.factory<_i88.OwnerOrdersStateManager>(() => _i88.OwnerOrdersStateManager(
      get<_i87.OrdersService>(),
      get<_i28.AuthService>(),
      get<_i64.ProfileService>()));
  gh.factory<_i89.ProfileScreen>(
      () => _i89.ProfileScreen(get<_i80.EditProfileStateManager>()));
  gh.factory<_i90.SettingsModule>(() => _i90.SettingsModule(
      get<_i67.SettingsScreen>(),
      get<_i24.ChooseLocalScreen>(),
      get<_i7.CopyMapLinkScreen>(),
      get<_i15.PrivecyPolicy>(),
      get<_i18.TermsOfUse>()));
  gh.factory<_i91.SubOrdersStateManager>(() => _i91.SubOrdersStateManager(
      get<_i87.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i92.SubscriptionService>(
      () => _i92.SubscriptionService(get<_i69.SubscriptionsManager>()));
  gh.factory<_i93.UpdateBranchStateManager>(
      () => _i93.UpdateBranchStateManager(get<_i77.BranchesListService>()));
  gh.factory<_i94.UpdateOrderStateManager>(
      () => _i94.UpdateOrderStateManager(get<_i87.OrdersService>()));
  gh.factory<_i95.UpdateScreen>(
      () => _i95.UpdateScreen(get<_i70.UpdatesStateManager>()));
  gh.factory<_i96.AboutScreen>(
      () => _i96.AboutScreen(get<_i71.AboutScreenStateManager>()));
  gh.factory<_i97.AccountBalanceScreen>(
      () => _i97.AccountBalanceScreen(get<_i72.AccountBalanceStateManager>()));
  gh.factory<_i98.AddBidOrderScreen>(
      () => _i98.AddBidOrderScreen(get<_i73.AddBidOrderStateManager>()));
  gh.factory<_i99.BidOrderLogsScreen>(
      () => _i99.BidOrderLogsScreen(get<_i76.BidOrderLogsStateManager>()));
  gh.factory<_i100.BidOrdersModule>(() => _i100.BidOrdersModule(
      get<_i84.OpenBidOrderScreen>(),
      get<_i98.AddBidOrderScreen>(),
      get<_i86.OrderOfferDetailsScreen>(),
      get<_i99.BidOrderLogsScreen>(),
      get<_i75.BidOrderDetailsScreen>()));
  gh.factory<_i101.BranchesListScreen>(
      () => _i101.BranchesListScreen(get<_i78.BranchesListStateManager>()));
  gh.factory<_i102.ChatModule>(() =>
      _i102.ChatModule(get<_i79.ChatPage>(), get<_i85.OrderChatRoomsScreen>()));
  gh.factory<_i103.CompanyInfoStateManager>(() => _i103.CompanyInfoStateManager(
      get<_i87.OrdersService>(),
      get<_i28.AuthService>(),
      get<_i64.ProfileService>()));
  gh.factory<_i104.HiddenOrdersStateManager>(
      () => _i104.HiddenOrdersStateManager(get<_i87.OrdersService>()));
  gh.factory<_i105.InitAccountScreen>(
      () => _i105.InitAccountScreen(get<_i81.InitAccountStateManager>()));
  gh.factory<_i106.InitBranchesScreen>(
      () => _i106.InitBranchesScreen(get<_i82.InitBranchesStateManager>()));
  gh.factory<_i107.InitSubscriptionStateManager>(() =>
      _i107.InitSubscriptionStateManager(
          get<_i92.SubscriptionService>(),
          get<_i64.ProfileService>(),
          get<_i28.AuthService>(),
          get<_i34.ImageUploadService>()));
  gh.factory<_i108.MyNotificationsStateManager>(() =>
      _i108.MyNotificationsStateManager(get<_i58.MyNotificationsService>(),
          get<_i87.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i109.NewOrderLinkStateManager>(
      () => _i109.NewOrderLinkStateManager(get<_i87.OrdersService>()));
  gh.factory<_i110.NewOrderStateManager>(
      () => _i110.NewOrderStateManager(get<_i87.OrdersService>()));
  gh.factory<_i111.OrderLogsStateManager>(
      () => _i111.OrderLogsStateManager(get<_i87.OrdersService>()));
  gh.factory<_i112.OrderRecyclingStateManager>(() =>
      _i112.OrderRecyclingStateManager(
          get<_i87.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i113.OrderStatusStateManager>(() => _i113.OrderStatusStateManager(
      get<_i87.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i114.OrderTimeLineStateManager>(() =>
      _i114.OrderTimeLineStateManager(
          get<_i87.OrdersService>(), get<_i28.AuthService>()));
  gh.factory<_i115.OrdersCashStateManager>(
      () => _i115.OrdersCashStateManager(get<_i87.OrdersService>()));
  gh.factory<_i116.OwnerOrdersScreen>(() => _i116.OwnerOrdersScreen(
      get<_i88.OwnerOrdersStateManager>(), get<_i110.NewOrderStateManager>()));
  gh.factory<_i117.ProfileModule>(() => _i117.ProfileModule(
      get<_i89.ProfileScreen>(),
      get<_i105.InitAccountScreen>(),
      get<_i97.AccountBalanceScreen>()));
  gh.factory<_i118.StoreSubscriptionsFinanceStateManager>(() =>
      _i118.StoreSubscriptionsFinanceStateManager(
          get<_i92.SubscriptionService>()));
  gh.factory<_i119.SubOrdersScreen>(
      () => _i119.SubOrdersScreen(get<_i91.SubOrdersStateManager>()));
  gh.factory<_i120.SubscriptionBalanceStateManager>(() =>
      _i120.SubscriptionBalanceStateManager(
          get<_i92.SubscriptionService>(),
          get<_i64.ProfileService>(),
          get<_i28.AuthService>(),
          get<_i34.ImageUploadService>()));
  gh.factory<_i121.UpdateBranchScreen>(
      () => _i121.UpdateBranchScreen(get<_i93.UpdateBranchStateManager>()));
  gh.factory<_i122.UpdateOrderScreen>(
      () => _i122.UpdateOrderScreen(get<_i94.UpdateOrderStateManager>()));
  gh.factory<_i123.BranchesModule>(() => _i123.BranchesModule(
      get<_i101.BranchesListScreen>(),
      get<_i121.UpdateBranchScreen>(),
      get<_i106.InitBranchesScreen>()));
  gh.factory<_i124.CompanyInfoScreen>(
      () => _i124.CompanyInfoScreen(get<_i103.CompanyInfoStateManager>()));
  gh.factory<_i125.HiddenOrdersScreen>(
      () => _i125.HiddenOrdersScreen(get<_i104.HiddenOrdersStateManager>()));
  gh.factory<_i126.InitSubscriptionScreen>(() =>
      _i126.InitSubscriptionScreen(get<_i107.InitSubscriptionStateManager>()));
  gh.factory<_i127.MyNotificationsScreen>(() =>
      _i127.MyNotificationsScreen(get<_i108.MyNotificationsStateManager>()));
  gh.factory<_i128.NewOrderLinkScreen>(
      () => _i128.NewOrderLinkScreen(get<_i109.NewOrderLinkStateManager>()));
  gh.factory<_i129.NewOrderScreen>(
      () => _i129.NewOrderScreen(get<_i110.NewOrderStateManager>()));
  gh.factory<_i130.OrderDetailsScreen>(
      () => _i130.OrderDetailsScreen(get<_i113.OrderStatusStateManager>()));
  gh.factory<_i131.OrderLogsScreen>(
      () => _i131.OrderLogsScreen(get<_i111.OrderLogsStateManager>()));
  gh.factory<_i132.OrderRecyclingScreen>(() =>
      _i132.OrderRecyclingScreen(get<_i112.OrderRecyclingStateManager>()));
  gh.factory<_i133.OrderTimeLineScreen>(
      () => _i133.OrderTimeLineScreen(get<_i114.OrderTimeLineStateManager>()));
  gh.factory<_i134.OrdersCashScreen>(
      () => _i134.OrdersCashScreen(get<_i115.OrdersCashStateManager>()));
  gh.factory<_i135.OrdersModule>(() => _i135.OrdersModule(
      get<_i129.NewOrderScreen>(),
      get<_i130.OrderDetailsScreen>(),
      get<_i116.OwnerOrdersScreen>(),
      get<_i119.SubOrdersScreen>(),
      get<_i128.NewOrderLinkScreen>(),
      get<_i133.OrderTimeLineScreen>(),
      get<_i131.OrderLogsScreen>(),
      get<_i125.HiddenOrdersScreen>(),
      get<_i132.OrderRecyclingScreen>(),
      get<_i122.UpdateOrderScreen>(),
      get<_i134.OrdersCashScreen>()));
  gh.factory<_i136.StoreSubscriptionsFinanceScreen>(() =>
      _i136.StoreSubscriptionsFinanceScreen(
          get<_i118.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i137.SubscriptionBalanceScreen>(() =>
      _i137.SubscriptionBalanceScreen(
          get<_i120.SubscriptionBalanceStateManager>()));
  gh.factory<_i138.SubscriptionsModule>(() => _i138.SubscriptionsModule(
      get<_i126.InitSubscriptionScreen>(),
      get<_i137.SubscriptionBalanceScreen>(),
      get<_i136.StoreSubscriptionsFinanceScreen>(),
      get<_i17.StoreSubscriptionsFinanceDetailsScreen>()));
  gh.factory<_i139.AboutModule>(() => _i139.AboutModule(
      get<_i96.AboutScreen>(), get<_i124.CompanyInfoScreen>()));
  gh.factory<_i140.MyNotificationsModule>(() => _i140.MyNotificationsModule(
      get<_i127.MyNotificationsScreen>(), get<_i95.UpdateScreen>()));
  gh.factory<_i141.MyApp>(() => _i141.MyApp(
      get<_i135.OrdersModule>(),
      get<_i22.AppThemeDataService>(),
      get<_i11.LocalizationService>(),
      get<_i54.FireNotificationService>(),
      get<_i9.LocalNotificationService>(),
      get<_i68.SplashModule>(),
      get<_i74.AuthorizationModule>(),
      get<_i102.ChatModule>(),
      get<_i90.SettingsModule>(),
      get<_i139.AboutModule>(),
      get<_i117.ProfileModule>(),
      get<_i123.BranchesModule>(),
      get<_i138.SubscriptionsModule>(),
      get<_i140.MyNotificationsModule>(),
      get<_i100.BidOrdersModule>()));
  gh.singleton<_i142.GlobalStateManager>(_i142.GlobalStateManager());
  return get;
}

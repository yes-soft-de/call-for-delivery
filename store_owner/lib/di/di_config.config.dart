// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:c4d/main.dart' as _i143;
import 'package:c4d/module_about/about_module.dart' as _i141;
import 'package:c4d/module_about/hive/about_hive_helper.dart' as _i3;
import 'package:c4d/module_about/manager/about_manager.dart' as _i47;
import 'package:c4d/module_about/repository/about_repository.dart' as _i28;
import 'package:c4d/module_about/service/about_service/about_service.dart'
    as _i48;
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart'
    as _i73;
import 'package:c4d/module_about/state_manager/company_info_state_manager.dart'
    as _i105;
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart'
    as _i98;
import 'package:c4d/module_about/ui/screen/company_info/company_info_screen.dart'
    as _i126;
import 'package:c4d/module_auth/authoriazation_module.dart' as _i76;
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart' as _i29;
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart' as _i5;
import 'package:c4d/module_auth/repository/auth/auth_repository.dart' as _i25;
import 'package:c4d/module_auth/service/auth_service/auth_service.dart' as _i30;
import 'package:c4d/module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i35;
import 'package:c4d/module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i37;
import 'package:c4d/module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i43;
import 'package:c4d/module_auth/state_manager/reset_state_manager/reset_password_state_manager.dart'
    as _i44;
import 'package:c4d/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i57;
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart'
    as _i58;
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart'
    as _i67;
import 'package:c4d/module_auth/ui/screen/reset_password_screen/reset_password_screen.dart'
    as _i68;
import 'package:c4d/module_bidorder/bid_orders_module.dart' as _i102;
import 'package:c4d/module_bidorder/manager/bidorder_manager.dart' as _i49;
import 'package:c4d/module_bidorder/repository/bidorder_repoesitory.dart'
    as _i31;
import 'package:c4d/module_bidorder/service/bidorder_service.dart' as _i50;
import 'package:c4d/module_bidorder/state_manager/add_bidorder_state_manager.dart'
    as _i75;
import 'package:c4d/module_bidorder/state_manager/bidorder_details/bidorder_status.state_manager.dart'
    as _i51;
import 'package:c4d/module_bidorder/state_manager/bidorder_details/order_offer_state_manager.dart'
    as _i63;
import 'package:c4d/module_bidorder/state_manager/bidorder_logs_state_manager.dart'
    as _i78;
import 'package:c4d/module_bidorder/state_manager/open_order_state_manager.dart'
    as _i62;
import 'package:c4d/module_bidorder/ui/screens/add_bidorder_screen.dart'
    as _i100;
import 'package:c4d/module_bidorder/ui/screens/bidorder_details/bidorder_details_screen.dart'
    as _i77;
import 'package:c4d/module_bidorder/ui/screens/bidorder_details/order_offer_details_screen.dart'
    as _i88;
import 'package:c4d/module_bidorder/ui/screens/bidorder_logs_screen.dart'
    as _i101;
import 'package:c4d/module_bidorder/ui/screens/open_bidorder_screen.dart'
    as _i86;
import 'package:c4d/module_branches/branches_module.dart' as _i125;
import 'package:c4d/module_branches/manager/branches_manager.dart' as _i52;
import 'package:c4d/module_branches/repository/branches_repository.dart'
    as _i32;
import 'package:c4d/module_branches/service/branches_list_service.dart' as _i79;
import 'package:c4d/module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i80;
import 'package:c4d/module_branches/state_manager/init_branches_state_manager.dart'
    as _i84;
import 'package:c4d/module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i95;
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i103;
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i108;
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i123;
import 'package:c4d/module_chat/chat_module.dart' as _i104;
import 'package:c4d/module_chat/manager/chat/chat_manager.dart' as _i53;
import 'package:c4d/module_chat/presistance/chat_hive_helper.dart' as _i6;
import 'package:c4d/module_chat/repository/chat/chat_repository.dart' as _i33;
import 'package:c4d/module_chat/service/chat/char_service.dart' as _i54;
import 'package:c4d/module_chat/state_manager/chat_state_manager.dart' as _i55;
import 'package:c4d/module_chat/state_manager/ongoing_order_chat_state_manager.dart'
    as _i61;
import 'package:c4d/module_chat/state_manager/order_chat_list_state_manager.dart'
    as _i64;
import 'package:c4d/module_chat/ui/screens/chat_page/chat_page.dart' as _i81;
import 'package:c4d/module_chat/ui/screens/chat_rooms_screen.dart' as _i87;
import 'package:c4d/module_chat/ui/screens/ongoing_chat_rooms_screen.dart'
    as _i85;
import 'package:c4d/module_deep_links/repository/deep_link_repository.dart'
    as _i34;
import 'package:c4d/module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i11;
import 'package:c4d/module_localization/service/localization_service/localization_service.dart'
    as _i12;
import 'package:c4d/module_my_notifications/manager/my_notifications_manager.dart'
    as _i59;
import 'package:c4d/module_my_notifications/my_notifications_module.dart'
    as _i142;
import 'package:c4d/module_my_notifications/presistance/my_notification_hive_helper.dart'
    as _i14;
import 'package:c4d/module_my_notifications/repository/my_notifications_repository.dart'
    as _i38;
import 'package:c4d/module_my_notifications/service/my_notification_service.dart'
    as _i60;
import 'package:c4d/module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i110;
import 'package:c4d/module_my_notifications/state_manager/update_state_manager.dart'
    as _i72;
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i129;
import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart'
    as _i97;
import 'package:c4d/module_network/http_client/http_client.dart' as _i23;
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i15;
import 'package:c4d/module_notifications/repository/notification_repo.dart'
    as _i39;
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i56;
import 'package:c4d/module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i10;
import 'package:c4d/module_orders/hive/order_hive_helper.dart' as _i16;
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart'
    as _i41;
import 'package:c4d/module_orders/orders_module.dart' as _i137;
import 'package:c4d/module_orders/repository/order_repository/order_repository.dart'
    as _i40;
import 'package:c4d/module_orders/service/orders/orders.service.dart' as _i89;
import 'package:c4d/module_orders/state_manager/hidden_orders_state_manager.dart'
    as _i106;
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i112;
import 'package:c4d/module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i96;
import 'package:c4d/module_orders/state_manager/new_order_link_state_manager.dart'
    as _i111;
import 'package:c4d/module_orders/state_manager/order_logs_state_manager.dart'
    as _i113;
import 'package:c4d/module_orders/state_manager/order_recycling_state_manager.dart'
    as _i114;
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i115;
import 'package:c4d/module_orders/state_manager/order_time_line_state_manager.dart'
    as _i116;
import 'package:c4d/module_orders/state_manager/orders_cash_state_manager.dart'
    as _i117;
import 'package:c4d/module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i90;
import 'package:c4d/module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i93;
import 'package:c4d/module_orders/ui/screens/hidden_orders_screen.dart'
    as _i127;
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart'
    as _i131;
import 'package:c4d/module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i124;
import 'package:c4d/module_orders/ui/screens/new_order_link.dart' as _i130;
import 'package:c4d/module_orders/ui/screens/order_details/order_details_screen.dart'
    as _i132;
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart' as _i133;
import 'package:c4d/module_orders/ui/screens/order_recylcing_screen.dart'
    as _i134;
import 'package:c4d/module_orders/ui/screens/order_time_line_screen.dart'
    as _i135;
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart'
    as _i118;
import 'package:c4d/module_orders/ui/screens/orders_cash_screen.dart' as _i136;
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart' as _i121;
import 'package:c4d/module_profile/manager/profile/profile.manager.dart'
    as _i65;
import 'package:c4d/module_profile/module_profile.dart' as _i119;
import 'package:c4d/module_profile/prefs_helper/profile_prefs_helper.dart'
    as _i18;
import 'package:c4d/module_profile/repository/profile/profile.repository.dart'
    as _i42;
import 'package:c4d/module_profile/service/profile/profile.service.dart'
    as _i66;
import 'package:c4d/module_profile/state_manager/account_balance_state_manager.dart'
    as _i74;
import 'package:c4d/module_profile/state_manager/edit_profile/edit_profile.dart'
    as _i82;
import 'package:c4d/module_profile/state_manager/init_account.state_manager.dart'
    as _i83;
import 'package:c4d/module_profile/ui/screen/account_balance_screen.dart'
    as _i99;
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart'
    as _i91;
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart' as _i107;
import 'package:c4d/module_settings/settings_module.dart' as _i92;
import 'package:c4d/module_settings/ui/screen/about.dart' as _i4;
import 'package:c4d/module_settings/ui/screen/privecy_policy.dart' as _i17;
import 'package:c4d/module_settings/ui/screen/terms_of_use.dart' as _i20;
import 'package:c4d/module_settings/ui/settings_page/choose_local_page.dart'
    as _i26;
import 'package:c4d/module_settings/ui/settings_page/copy_map_link.dart' as _i7;
import 'package:c4d/module_settings/ui/settings_page/settings_page.dart'
    as _i69;
import 'package:c4d/module_splash/splash_module.dart' as _i70;
import 'package:c4d/module_splash/ui/screen/splash_screen.dart' as _i45;
import 'package:c4d/module_subscription/manager/subscription_manager.dart'
    as _i71;
import 'package:c4d/module_subscription/repository/subscription_repository.dart'
    as _i46;
import 'package:c4d/module_subscription/service/subscription_service.dart'
    as _i94;
import 'package:c4d/module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i109;
import 'package:c4d/module_subscription/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i120;
import 'package:c4d/module_subscription/state_manager/subscription_balance_state_manager.dart'
    as _i122;
import 'package:c4d/module_subscription/subscriptions_module.dart' as _i140;
import 'package:c4d/module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i128;
import 'package:c4d/module_subscription/ui/screens/store_subscriptions_details_screen.dart'
    as _i19;
import 'package:c4d/module_subscription/ui/screens/store_subscriptions_screen.dart'
    as _i138;
import 'package:c4d/module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart'
    as _i139;
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart'
    as _i21;
import 'package:c4d/module_theme/service/theme_service/theme_service.dart'
    as _i24;
import 'package:c4d/module_upload/manager/upload_manager/upload_manager.dart'
    as _i27;
import 'package:c4d/module_upload/repository/upload_repository/upload_repository.dart'
    as _i22;
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart'
    as _i36;
import 'package:c4d/utils/global/global_state_manager.dart' as _i9;
import 'package:c4d/utils/helpers/firestore_helper.dart' as _i8;
import 'package:c4d/utils/logger/logger.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
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
  gh.factory<_i5.AuthPrefsHelper>(() => _i5.AuthPrefsHelper());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
  gh.factory<_i7.CopyMapLinkScreen>(() => _i7.CopyMapLinkScreen());
  gh.factory<_i8.FireStoreHelper>(() => _i8.FireStoreHelper());
  gh.singleton<_i9.GlobalStateManager>(_i9.GlobalStateManager());
  gh.factory<_i10.LocalNotificationService>(
      () => _i10.LocalNotificationService());
  gh.factory<_i11.LocalizationPreferencesHelper>(
      () => _i11.LocalizationPreferencesHelper());
  gh.factory<_i12.LocalizationService>(
      () => _i12.LocalizationService(gh<_i11.LocalizationPreferencesHelper>()));
  gh.factory<_i13.Logger>(() => _i13.Logger());
  gh.factory<_i14.MyNotificationHiveHelper>(
      () => _i14.MyNotificationHiveHelper());
  gh.factory<_i15.NotificationsPrefHelper>(
      () => _i15.NotificationsPrefHelper());
  gh.factory<_i16.OrderHiveHelper>(() => _i16.OrderHiveHelper());
  gh.factory<_i17.PrivecyPolicy>(() => _i17.PrivecyPolicy());
  gh.factory<_i18.ProfilePreferencesHelper>(
      () => _i18.ProfilePreferencesHelper());
  gh.factory<_i19.StoreSubscriptionsFinanceDetailsScreen>(
      () => _i19.StoreSubscriptionsFinanceDetailsScreen());
  gh.factory<_i20.TermsOfUse>(() => _i20.TermsOfUse());
  gh.factory<_i21.ThemePreferencesHelper>(() => _i21.ThemePreferencesHelper());
  gh.factory<_i22.UploadRepository>(() => _i22.UploadRepository());
  gh.factory<_i23.ApiClient>(() => _i23.ApiClient(gh<_i13.Logger>()));
  gh.factory<_i24.AppThemeDataService>(
      () => _i24.AppThemeDataService(gh<_i21.ThemePreferencesHelper>()));
  gh.factory<_i25.AuthRepository>(() => _i25.AuthRepository(
        gh<_i23.ApiClient>(),
        gh<_i13.Logger>(),
      ));
  gh.factory<_i26.ChooseLocalScreen>(
      () => _i26.ChooseLocalScreen(gh<_i12.LocalizationService>()));
  gh.factory<_i27.UploadManager>(
      () => _i27.UploadManager(gh<_i22.UploadRepository>()));
  gh.factory<_i28.AboutRepository>(
      () => _i28.AboutRepository(gh<_i23.ApiClient>()));
  gh.factory<_i29.AuthManager>(
      () => _i29.AuthManager(gh<_i25.AuthRepository>()));
  gh.factory<_i30.AuthService>(() => _i30.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i29.AuthManager>(),
      ));
  gh.factory<_i31.BidOrderRepository>(() => _i31.BidOrderRepository(
        gh<_i23.ApiClient>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i32.BranchesRepository>(() => _i32.BranchesRepository(
        gh<_i23.ApiClient>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i33.ChatRepository>(() => _i33.ChatRepository(
        gh<_i23.ApiClient>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i34.DeepLinkRepository>(() => _i34.DeepLinkRepository(
        gh<_i23.ApiClient>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i35.ForgotPassStateManager>(
      () => _i35.ForgotPassStateManager(gh<_i30.AuthService>()));
  gh.factory<_i36.ImageUploadService>(
      () => _i36.ImageUploadService(gh<_i27.UploadManager>()));
  gh.factory<_i37.LoginStateManager>(
      () => _i37.LoginStateManager(gh<_i30.AuthService>()));
  gh.factory<_i38.MyNotificationsRepository>(
      () => _i38.MyNotificationsRepository(
            gh<_i23.ApiClient>(),
            gh<_i30.AuthService>(),
          ));
  gh.factory<_i39.NotificationRepo>(() => _i39.NotificationRepo(
        gh<_i23.ApiClient>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i40.OrderRepository>(() => _i40.OrderRepository(
        gh<_i23.ApiClient>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i41.OrdersManager>(
      () => _i41.OrdersManager(gh<_i40.OrderRepository>()));
  gh.factory<_i42.ProfileRepository>(() => _i42.ProfileRepository(
        gh<_i23.ApiClient>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i43.RegisterStateManager>(
      () => _i43.RegisterStateManager(gh<_i30.AuthService>()));
  gh.factory<_i44.ResetPasswordStateManager>(
      () => _i44.ResetPasswordStateManager(gh<_i30.AuthService>()));
  gh.factory<_i45.SplashScreen>(
      () => _i45.SplashScreen(gh<_i30.AuthService>()));
  gh.factory<_i46.SubscriptionsRepository>(() => _i46.SubscriptionsRepository(
        gh<_i23.ApiClient>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i47.AboutManager>(
      () => _i47.AboutManager(gh<_i28.AboutRepository>()));
  gh.factory<_i48.AboutService>(
      () => _i48.AboutService(gh<_i47.AboutManager>()));
  gh.factory<_i49.BidOrderManager>(
      () => _i49.BidOrderManager(gh<_i31.BidOrderRepository>()));
  gh.factory<_i50.BidOrderService>(
      () => _i50.BidOrderService(gh<_i49.BidOrderManager>()));
  gh.factory<_i51.BidOrderStatusStateManager>(
      () => _i51.BidOrderStatusStateManager(
            gh<_i50.BidOrderService>(),
            gh<_i30.AuthService>(),
          ));
  gh.factory<_i52.BranchesManager>(
      () => _i52.BranchesManager(gh<_i32.BranchesRepository>()));
  gh.factory<_i53.ChatManager>(
      () => _i53.ChatManager(gh<_i33.ChatRepository>()));
  gh.factory<_i54.ChatService>(() => _i54.ChatService(gh<_i53.ChatManager>()));
  gh.factory<_i55.ChatStateManager>(
      () => _i55.ChatStateManager(gh<_i54.ChatService>()));
  gh.factory<_i56.FireNotificationService>(() => _i56.FireNotificationService(
        gh<_i15.NotificationsPrefHelper>(),
        gh<_i39.NotificationRepo>(),
      ));
  gh.factory<_i57.ForgotPassScreen>(
      () => _i57.ForgotPassScreen(gh<_i35.ForgotPassStateManager>()));
  gh.factory<_i58.LoginScreen>(
      () => _i58.LoginScreen(gh<_i37.LoginStateManager>()));
  gh.factory<_i59.MyNotificationsManager>(
      () => _i59.MyNotificationsManager(gh<_i38.MyNotificationsRepository>()));
  gh.factory<_i60.MyNotificationsService>(
      () => _i60.MyNotificationsService(gh<_i59.MyNotificationsManager>()));
  gh.factory<_i61.OngoingOrderChatStateManager>(
      () => _i61.OngoingOrderChatStateManager(
            gh<_i54.ChatService>(),
            gh<_i30.AuthService>(),
          ));
  gh.factory<_i62.OpenBidOrderStateManager>(
      () => _i62.OpenBidOrderStateManager(gh<_i50.BidOrderService>()));
  gh.factory<_i63.OrderOffersDetailsStateManager>(
      () => _i63.OrderOffersDetailsStateManager(gh<_i50.BidOrderService>()));
  gh.factory<_i64.OrdersChatListStateManager>(
      () => _i64.OrdersChatListStateManager(
            gh<_i54.ChatService>(),
            gh<_i30.AuthService>(),
          ));
  gh.factory<_i65.ProfileManager>(
      () => _i65.ProfileManager(gh<_i42.ProfileRepository>()));
  gh.factory<_i66.ProfileService>(() => _i66.ProfileService(
        gh<_i65.ProfileManager>(),
        gh<_i18.ProfilePreferencesHelper>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i67.RegisterScreen>(
      () => _i67.RegisterScreen(gh<_i43.RegisterStateManager>()));
  gh.factory<_i68.ResetPasswordScreen>(
      () => _i68.ResetPasswordScreen(gh<_i44.ResetPasswordStateManager>()));
  gh.factory<_i69.SettingsScreen>(() => _i69.SettingsScreen(
        gh<_i30.AuthService>(),
        gh<_i12.LocalizationService>(),
        gh<_i24.AppThemeDataService>(),
        gh<_i56.FireNotificationService>(),
      ));
  gh.factory<_i70.SplashModule>(
      () => _i70.SplashModule(gh<_i45.SplashScreen>()));
  gh.factory<_i71.SubscriptionsManager>(
      () => _i71.SubscriptionsManager(gh<_i46.SubscriptionsRepository>()));
  gh.factory<_i72.UpdatesStateManager>(() => _i72.UpdatesStateManager(
        gh<_i60.MyNotificationsService>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i73.AboutScreenStateManager>(() => _i73.AboutScreenStateManager(
        gh<_i12.LocalizationService>(),
        gh<_i48.AboutService>(),
      ));
  gh.factory<_i74.AccountBalanceStateManager>(
      () => _i74.AccountBalanceStateManager(
            gh<_i66.ProfileService>(),
            gh<_i30.AuthService>(),
            gh<_i36.ImageUploadService>(),
          ));
  gh.factory<_i75.AddBidOrderStateManager>(
      () => _i75.AddBidOrderStateManager(gh<_i50.BidOrderService>()));
  gh.factory<_i76.AuthorizationModule>(() => _i76.AuthorizationModule(
        gh<_i58.LoginScreen>(),
        gh<_i67.RegisterScreen>(),
        gh<_i68.ResetPasswordScreen>(),
        gh<_i57.ForgotPassScreen>(),
      ));
  gh.factory<_i77.BidOrderDetailsScreen>(
      () => _i77.BidOrderDetailsScreen(gh<_i51.BidOrderStatusStateManager>()));
  gh.factory<_i78.BidOrderLogsStateManager>(
      () => _i78.BidOrderLogsStateManager(gh<_i50.BidOrderService>()));
  gh.factory<_i79.BranchesListService>(() => _i79.BranchesListService(
        gh<_i52.BranchesManager>(),
        gh<_i18.ProfilePreferencesHelper>(),
      ));
  gh.factory<_i80.BranchesListStateManager>(
      () => _i80.BranchesListStateManager(gh<_i79.BranchesListService>()));
  gh.factory<_i81.ChatPage>(() => _i81.ChatPage(
        gh<_i55.ChatStateManager>(),
        gh<_i36.ImageUploadService>(),
        gh<_i30.AuthService>(),
        gh<_i6.ChatHiveHelper>(),
      ));
  gh.factory<_i82.EditProfileStateManager>(() => _i82.EditProfileStateManager(
        gh<_i36.ImageUploadService>(),
        gh<_i66.ProfileService>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i83.InitAccountStateManager>(() => _i83.InitAccountStateManager(
        gh<_i66.ProfileService>(),
        gh<_i30.AuthService>(),
        gh<_i36.ImageUploadService>(),
      ));
  gh.factory<_i84.InitBranchesStateManager>(() => _i84.InitBranchesStateManager(
        gh<_i79.BranchesListService>(),
        gh<_i66.ProfileService>(),
      ));
  gh.factory<_i85.OngoingOrderChatScreen>(() =>
      _i85.OngoingOrderChatScreen(gh<_i61.OngoingOrderChatStateManager>()));
  gh.factory<_i86.OpenBidOrderScreen>(
      () => _i86.OpenBidOrderScreen(gh<_i62.OpenBidOrderStateManager>()));
  gh.factory<_i87.OrderChatRoomsScreen>(
      () => _i87.OrderChatRoomsScreen(gh<_i64.OrdersChatListStateManager>()));
  gh.factory<_i88.OrderOfferDetailsScreen>(() =>
      _i88.OrderOfferDetailsScreen(gh<_i63.OrderOffersDetailsStateManager>()));
  gh.factory<_i89.OrdersService>(() => _i89.OrdersService(
        gh<_i41.OrdersManager>(),
        gh<_i66.ProfileService>(),
      ));
  gh.factory<_i90.OwnerOrdersStateManager>(() => _i90.OwnerOrdersStateManager(
        gh<_i89.OrdersService>(),
        gh<_i30.AuthService>(),
        gh<_i66.ProfileService>(),
      ));
  gh.factory<_i91.ProfileScreen>(
      () => _i91.ProfileScreen(gh<_i82.EditProfileStateManager>()));
  gh.factory<_i92.SettingsModule>(() => _i92.SettingsModule(
        gh<_i69.SettingsScreen>(),
        gh<_i26.ChooseLocalScreen>(),
        gh<_i7.CopyMapLinkScreen>(),
        gh<_i17.PrivecyPolicy>(),
        gh<_i20.TermsOfUse>(),
      ));
  gh.factory<_i93.SubOrdersStateManager>(() => _i93.SubOrdersStateManager(
        gh<_i89.OrdersService>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i94.SubscriptionService>(
      () => _i94.SubscriptionService(gh<_i71.SubscriptionsManager>()));
  gh.factory<_i95.UpdateBranchStateManager>(
      () => _i95.UpdateBranchStateManager(gh<_i79.BranchesListService>()));
  gh.factory<_i96.UpdateOrderStateManager>(
      () => _i96.UpdateOrderStateManager(gh<_i89.OrdersService>()));
  gh.factory<_i97.UpdateScreen>(
      () => _i97.UpdateScreen(gh<_i72.UpdatesStateManager>()));
  gh.factory<_i98.AboutScreen>(
      () => _i98.AboutScreen(gh<_i73.AboutScreenStateManager>()));
  gh.factory<_i99.AccountBalanceScreen>(
      () => _i99.AccountBalanceScreen(gh<_i74.AccountBalanceStateManager>()));
  gh.factory<_i100.AddBidOrderScreen>(
      () => _i100.AddBidOrderScreen(gh<_i75.AddBidOrderStateManager>()));
  gh.factory<_i101.BidOrderLogsScreen>(
      () => _i101.BidOrderLogsScreen(gh<_i78.BidOrderLogsStateManager>()));
  gh.factory<_i102.BidOrdersModule>(() => _i102.BidOrdersModule(
        gh<_i86.OpenBidOrderScreen>(),
        gh<_i100.AddBidOrderScreen>(),
        gh<_i88.OrderOfferDetailsScreen>(),
        gh<_i101.BidOrderLogsScreen>(),
        gh<_i77.BidOrderDetailsScreen>(),
      ));
  gh.factory<_i103.BranchesListScreen>(
      () => _i103.BranchesListScreen(gh<_i80.BranchesListStateManager>()));
  gh.factory<_i104.ChatModule>(() => _i104.ChatModule(
        gh<_i81.ChatPage>(),
        gh<_i87.OrderChatRoomsScreen>(),
      ));
  gh.factory<_i105.CompanyInfoStateManager>(() => _i105.CompanyInfoStateManager(
        gh<_i89.OrdersService>(),
        gh<_i30.AuthService>(),
        gh<_i66.ProfileService>(),
      ));
  gh.factory<_i106.HiddenOrdersStateManager>(
      () => _i106.HiddenOrdersStateManager(gh<_i89.OrdersService>()));
  gh.factory<_i107.InitAccountScreen>(
      () => _i107.InitAccountScreen(gh<_i83.InitAccountStateManager>()));
  gh.factory<_i108.InitBranchesScreen>(
      () => _i108.InitBranchesScreen(gh<_i84.InitBranchesStateManager>()));
  gh.factory<_i109.InitSubscriptionStateManager>(
      () => _i109.InitSubscriptionStateManager(
            gh<_i94.SubscriptionService>(),
            gh<_i66.ProfileService>(),
            gh<_i30.AuthService>(),
            gh<_i36.ImageUploadService>(),
          ));
  gh.factory<_i110.MyNotificationsStateManager>(
      () => _i110.MyNotificationsStateManager(
            gh<_i60.MyNotificationsService>(),
            gh<_i89.OrdersService>(),
            gh<_i30.AuthService>(),
          ));
  gh.factory<_i111.NewOrderLinkStateManager>(
      () => _i111.NewOrderLinkStateManager(gh<_i89.OrdersService>()));
  gh.factory<_i112.NewOrderStateManager>(
      () => _i112.NewOrderStateManager(gh<_i89.OrdersService>()));
  gh.factory<_i113.OrderLogsStateManager>(
      () => _i113.OrderLogsStateManager(gh<_i89.OrdersService>()));
  gh.factory<_i114.OrderRecyclingStateManager>(
      () => _i114.OrderRecyclingStateManager(
            gh<_i89.OrdersService>(),
            gh<_i30.AuthService>(),
          ));
  gh.factory<_i115.OrderStatusStateManager>(() => _i115.OrderStatusStateManager(
        gh<_i89.OrdersService>(),
        gh<_i30.AuthService>(),
      ));
  gh.factory<_i116.OrderTimeLineStateManager>(
      () => _i116.OrderTimeLineStateManager(
            gh<_i89.OrdersService>(),
            gh<_i30.AuthService>(),
          ));
  gh.factory<_i117.OrdersCashStateManager>(
      () => _i117.OrdersCashStateManager(gh<_i89.OrdersService>()));
  gh.factory<_i118.OwnerOrdersScreen>(() => _i118.OwnerOrdersScreen(
        gh<_i90.OwnerOrdersStateManager>(),
        gh<_i112.NewOrderStateManager>(),
      ));
  gh.factory<_i119.ProfileModule>(() => _i119.ProfileModule(
        gh<_i91.ProfileScreen>(),
        gh<_i107.InitAccountScreen>(),
        gh<_i99.AccountBalanceScreen>(),
      ));
  gh.factory<_i120.StoreSubscriptionsFinanceStateManager>(() =>
      _i120.StoreSubscriptionsFinanceStateManager(
          gh<_i94.SubscriptionService>()));
  gh.factory<_i121.SubOrdersScreen>(
      () => _i121.SubOrdersScreen(gh<_i93.SubOrdersStateManager>()));
  gh.factory<_i122.SubscriptionBalanceStateManager>(
      () => _i122.SubscriptionBalanceStateManager(
            gh<_i94.SubscriptionService>(),
            gh<_i66.ProfileService>(),
            gh<_i30.AuthService>(),
            gh<_i36.ImageUploadService>(),
          ));
  gh.factory<_i123.UpdateBranchScreen>(
      () => _i123.UpdateBranchScreen(gh<_i95.UpdateBranchStateManager>()));
  gh.factory<_i124.UpdateOrderScreen>(
      () => _i124.UpdateOrderScreen(gh<_i96.UpdateOrderStateManager>()));
  gh.factory<_i125.BranchesModule>(() => _i125.BranchesModule(
        gh<_i103.BranchesListScreen>(),
        gh<_i123.UpdateBranchScreen>(),
        gh<_i108.InitBranchesScreen>(),
      ));
  gh.factory<_i126.CompanyInfoScreen>(
      () => _i126.CompanyInfoScreen(gh<_i105.CompanyInfoStateManager>()));
  gh.factory<_i127.HiddenOrdersScreen>(
      () => _i127.HiddenOrdersScreen(gh<_i106.HiddenOrdersStateManager>()));
  gh.factory<_i128.InitSubscriptionScreen>(() =>
      _i128.InitSubscriptionScreen(gh<_i109.InitSubscriptionStateManager>()));
  gh.factory<_i129.MyNotificationsScreen>(() =>
      _i129.MyNotificationsScreen(gh<_i110.MyNotificationsStateManager>()));
  gh.factory<_i130.NewOrderLinkScreen>(
      () => _i130.NewOrderLinkScreen(gh<_i111.NewOrderLinkStateManager>()));
  gh.factory<_i131.NewOrderScreen>(
      () => _i131.NewOrderScreen(gh<_i112.NewOrderStateManager>()));
  gh.factory<_i132.OrderDetailsScreen>(
      () => _i132.OrderDetailsScreen(gh<_i115.OrderStatusStateManager>()));
  gh.factory<_i133.OrderLogsScreen>(
      () => _i133.OrderLogsScreen(gh<_i113.OrderLogsStateManager>()));
  gh.factory<_i134.OrderRecyclingScreen>(
      () => _i134.OrderRecyclingScreen(gh<_i114.OrderRecyclingStateManager>()));
  gh.factory<_i135.OrderTimeLineScreen>(
      () => _i135.OrderTimeLineScreen(gh<_i116.OrderTimeLineStateManager>()));
  gh.factory<_i136.OrdersCashScreen>(
      () => _i136.OrdersCashScreen(gh<_i117.OrdersCashStateManager>()));
  gh.factory<_i137.OrdersModule>(() => _i137.OrdersModule(
        gh<_i131.NewOrderScreen>(),
        gh<_i132.OrderDetailsScreen>(),
        gh<_i118.OwnerOrdersScreen>(),
        gh<_i121.SubOrdersScreen>(),
        gh<_i130.NewOrderLinkScreen>(),
        gh<_i135.OrderTimeLineScreen>(),
        gh<_i133.OrderLogsScreen>(),
        gh<_i127.HiddenOrdersScreen>(),
        gh<_i134.OrderRecyclingScreen>(),
        gh<_i124.UpdateOrderScreen>(),
        gh<_i136.OrdersCashScreen>(),
      ));
  gh.factory<_i138.StoreSubscriptionsFinanceScreen>(() =>
      _i138.StoreSubscriptionsFinanceScreen(
          gh<_i120.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i139.SubscriptionBalanceScreen>(() =>
      _i139.SubscriptionBalanceScreen(
          gh<_i122.SubscriptionBalanceStateManager>()));
  gh.factory<_i140.SubscriptionsModule>(() => _i140.SubscriptionsModule(
        gh<_i128.InitSubscriptionScreen>(),
        gh<_i139.SubscriptionBalanceScreen>(),
        gh<_i138.StoreSubscriptionsFinanceScreen>(),
        gh<_i19.StoreSubscriptionsFinanceDetailsScreen>(),
      ));
  gh.factory<_i141.AboutModule>(() => _i141.AboutModule(
        gh<_i98.AboutScreen>(),
        gh<_i126.CompanyInfoScreen>(),
      ));
  gh.factory<_i142.MyNotificationsModule>(() => _i142.MyNotificationsModule(
        gh<_i129.MyNotificationsScreen>(),
        gh<_i97.UpdateScreen>(),
      ));
  gh.factory<_i143.MyApp>(() => _i143.MyApp(
        gh<_i137.OrdersModule>(),
        gh<_i24.AppThemeDataService>(),
        gh<_i12.LocalizationService>(),
        gh<_i56.FireNotificationService>(),
        gh<_i10.LocalNotificationService>(),
        gh<_i70.SplashModule>(),
        gh<_i76.AuthorizationModule>(),
        gh<_i104.ChatModule>(),
        gh<_i92.SettingsModule>(),
        gh<_i141.AboutModule>(),
        gh<_i119.ProfileModule>(),
        gh<_i125.BranchesModule>(),
        gh<_i140.SubscriptionsModule>(),
        gh<_i142.MyNotificationsModule>(),
        gh<_i102.BidOrdersModule>(),
      ));
  return getIt;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:c4d/main.dart' as _i152;
import 'package:c4d/module_about/about_module.dart' as _i150;
import 'package:c4d/module_about/hive/about_hive_helper.dart' as _i3;
import 'package:c4d/module_about/manager/about_manager.dart' as _i51;
import 'package:c4d/module_about/repository/about_repository.dart' as _i31;
import 'package:c4d/module_about/service/about_service/about_service.dart'
    as _i52;
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart'
    as _i80;
import 'package:c4d/module_about/state_manager/company_info_state_manager.dart'
    as _i112;
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart'
    as _i105;
import 'package:c4d/module_about/ui/screen/company_info/company_info_screen.dart'
    as _i134;
import 'package:c4d/module_auth/authoriazation_module.dart' as _i83;
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart' as _i32;
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart' as _i5;
import 'package:c4d/module_auth/repository/auth/auth_repository.dart' as _i28;
import 'package:c4d/module_auth/service/auth_service/auth_service.dart' as _i33;
import 'package:c4d/module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i38;
import 'package:c4d/module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i40;
import 'package:c4d/module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i46;
import 'package:c4d/module_auth/state_manager/reset_state_manager/reset_password_state_manager.dart'
    as _i48;
import 'package:c4d/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i61;
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart'
    as _i62;
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart'
    as _i71;
import 'package:c4d/module_auth/ui/screen/reset_password_screen/reset_password_screen.dart'
    as _i75;
import 'package:c4d/module_bidorder/bid_orders_module.dart' as _i109;
import 'package:c4d/module_bidorder/manager/bidorder_manager.dart' as _i53;
import 'package:c4d/module_bidorder/repository/bidorder_repoesitory.dart'
    as _i34;
import 'package:c4d/module_bidorder/service/bidorder_service.dart' as _i54;
import 'package:c4d/module_bidorder/state_manager/add_bidorder_state_manager.dart'
    as _i82;
import 'package:c4d/module_bidorder/state_manager/bidorder_details/bidorder_status.state_manager.dart'
    as _i55;
import 'package:c4d/module_bidorder/state_manager/bidorder_details/order_offer_state_manager.dart'
    as _i67;
import 'package:c4d/module_bidorder/state_manager/bidorder_logs_state_manager.dart'
    as _i85;
import 'package:c4d/module_bidorder/state_manager/open_order_state_manager.dart'
    as _i66;
import 'package:c4d/module_bidorder/ui/screens/add_bidorder_screen.dart'
    as _i107;
import 'package:c4d/module_bidorder/ui/screens/bidorder_details/bidorder_details_screen.dart'
    as _i84;
import 'package:c4d/module_bidorder/ui/screens/bidorder_details/order_offer_details_screen.dart'
    as _i95;
import 'package:c4d/module_bidorder/ui/screens/bidorder_logs_screen.dart'
    as _i108;
import 'package:c4d/module_bidorder/ui/screens/open_bidorder_screen.dart'
    as _i93;
import 'package:c4d/module_branches/branches_module.dart' as _i133;
import 'package:c4d/module_branches/manager/branches_manager.dart' as _i56;
import 'package:c4d/module_branches/repository/branches_repository.dart'
    as _i35;
import 'package:c4d/module_branches/service/branches_list_service.dart' as _i86;
import 'package:c4d/module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i87;
import 'package:c4d/module_branches/state_manager/init_branches_state_manager.dart'
    as _i91;
import 'package:c4d/module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i102;
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i110;
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i115;
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i131;
import 'package:c4d/module_chat/chat_module.dart' as _i111;
import 'package:c4d/module_chat/manager/chat/chat_manager.dart' as _i57;
import 'package:c4d/module_chat/presistance/chat_hive_helper.dart' as _i6;
import 'package:c4d/module_chat/repository/chat/chat_repository.dart' as _i36;
import 'package:c4d/module_chat/service/chat/char_service.dart' as _i58;
import 'package:c4d/module_chat/state_manager/chat_state_manager.dart' as _i59;
import 'package:c4d/module_chat/state_manager/ongoing_order_chat_state_manager.dart'
    as _i65;
import 'package:c4d/module_chat/state_manager/order_chat_list_state_manager.dart'
    as _i68;
import 'package:c4d/module_chat/ui/screens/chat_page/chat_page.dart' as _i88;
import 'package:c4d/module_chat/ui/screens/chat_rooms_screen.dart' as _i94;
import 'package:c4d/module_chat/ui/screens/ongoing_chat_rooms_screen.dart'
    as _i92;
import 'package:c4d/module_deep_links/repository/deep_link_repository.dart'
    as _i37;
import 'package:c4d/module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i11;
import 'package:c4d/module_localization/service/localization_service/localization_service.dart'
    as _i12;
import 'package:c4d/module_my_notifications/manager/my_notifications_manager.dart'
    as _i63;
import 'package:c4d/module_my_notifications/my_notifications_module.dart'
    as _i151;
import 'package:c4d/module_my_notifications/presistance/my_notification_hive_helper.dart'
    as _i14;
import 'package:c4d/module_my_notifications/repository/my_notifications_repository.dart'
    as _i41;
import 'package:c4d/module_my_notifications/service/my_notification_service.dart'
    as _i64;
import 'package:c4d/module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i117;
import 'package:c4d/module_my_notifications/state_manager/update_state_manager.dart'
    as _i79;
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i137;
import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart'
    as _i104;
import 'package:c4d/module_network/http_client/http_client.dart' as _i26;
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i15;
import 'package:c4d/module_notifications/repository/notification_repo.dart'
    as _i42;
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i60;
import 'package:c4d/module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i10;
import 'package:c4d/module_orders/hive/order_hive_helper.dart' as _i16;
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart'
    as _i44;
import 'package:c4d/module_orders/orders_module.dart' as _i146;
import 'package:c4d/module_orders/repository/order_repository/order_repository.dart'
    as _i43;
import 'package:c4d/module_orders/service/orders/orders.service.dart' as _i96;
import 'package:c4d/module_orders/state_manager/hidden_orders_state_manager.dart'
    as _i113;
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i119;
import 'package:c4d/module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i103;
import 'package:c4d/module_orders/state_manager/new_order_link_state_manager.dart'
    as _i118;
import 'package:c4d/module_orders/state_manager/order_logs_state_manager.dart'
    as _i121;
import 'package:c4d/module_orders/state_manager/order_recycling_state_manager.dart'
    as _i122;
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart'
    as _i123;
import 'package:c4d/module_orders/state_manager/order_time_line_state_manager.dart'
    as _i124;
import 'package:c4d/module_orders/state_manager/orders_cash_state_manager.dart'
    as _i125;
import 'package:c4d/module_orders/state_manager/owner_orders/owner_orders.state_manager.dart'
    as _i97;
import 'package:c4d/module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i100;
import 'package:c4d/module_orders/ui/screens/hidden_orders_screen.dart'
    as _i135;
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart'
    as _i139;
import 'package:c4d/module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i132;
import 'package:c4d/module_orders/ui/screens/new_order_link.dart' as _i138;
import 'package:c4d/module_orders/ui/screens/order_details/order_details_screen.dart'
    as _i141;
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart' as _i142;
import 'package:c4d/module_orders/ui/screens/order_recylcing_screen.dart'
    as _i143;
import 'package:c4d/module_orders/ui/screens/order_time_line_screen.dart'
    as _i144;
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart'
    as _i126;
import 'package:c4d/module_orders/ui/screens/orders_cash_screen.dart' as _i145;
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart' as _i129;
import 'package:c4d/module_profile/manager/profile/profile.manager.dart'
    as _i69;
import 'package:c4d/module_profile/module_profile.dart' as _i127;
import 'package:c4d/module_profile/prefs_helper/profile_prefs_helper.dart'
    as _i19;
import 'package:c4d/module_profile/repository/profile/profile.repository.dart'
    as _i45;
import 'package:c4d/module_profile/service/profile/profile.service.dart'
    as _i70;
import 'package:c4d/module_profile/state_manager/account_balance_state_manager.dart'
    as _i81;
import 'package:c4d/module_profile/state_manager/edit_profile/edit_profile_state_manager.dart'
    as _i89;
import 'package:c4d/module_profile/state_manager/init_account.state_manager.dart'
    as _i90;
import 'package:c4d/module_profile/ui/screen/account_balance_screen.dart'
    as _i106;
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart'
    as _i98;
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart' as _i114;
import 'package:c4d/module_releases_tracker/manager/releases_tracker_manager.dart'
    as _i72;
import 'package:c4d/module_releases_tracker/releases_tracker_module.dart'
    as _i20;
import 'package:c4d/module_releases_tracker/repository/releases_tracker_repository.dart'
    as _i47;
import 'package:c4d/module_releases_tracker/service/releases_racker.dart'
    as _i73;
import 'package:c4d/module_releases_tracker/state_manager/releases_tracker_state_manager.dart'
    as _i74;
import 'package:c4d/module_settings/settings_module.dart' as _i99;
import 'package:c4d/module_settings/ui/screen/about.dart' as _i4;
import 'package:c4d/module_settings/ui/screen/privecy_policy.dart' as _i18;
import 'package:c4d/module_settings/ui/screen/terms_of_use.dart' as _i23;
import 'package:c4d/module_settings/ui/settings_page/choose_local_page.dart'
    as _i29;
import 'package:c4d/module_settings/ui/settings_page/copy_map_link.dart' as _i7;
import 'package:c4d/module_settings/ui/settings_page/settings_page.dart'
    as _i76;
import 'package:c4d/module_splash/splash_module.dart' as _i77;
import 'package:c4d/module_splash/ui/screen/splash_screen.dart' as _i49;
import 'package:c4d/module_subscription/hive/subscription_pref.dart' as _i22;
import 'package:c4d/module_subscription/manager/subscription_manager.dart'
    as _i78;
import 'package:c4d/module_subscription/repository/subscription_repository.dart'
    as _i50;
import 'package:c4d/module_subscription/service/subscription_service.dart'
    as _i101;
import 'package:c4d/module_subscription/state_manager/init_subscription_state_manager.dart'
    as _i116;
import 'package:c4d/module_subscription/state_manager/new_subscription_balance_state_manager.dart'
    as _i120;
import 'package:c4d/module_subscription/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i128;
import 'package:c4d/module_subscription/state_manager/subscription_balance_state_manager.dart'
    as _i130;
import 'package:c4d/module_subscription/subscriptions_module.dart' as _i149;
import 'package:c4d/module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart'
    as _i136;
import 'package:c4d/module_subscription/ui/screens/new_subscription_balance_screen/new_subscription_balance_screen.dart'
    as _i140;
import 'package:c4d/module_subscription/ui/screens/store_subscriptions_details_screen.dart'
    as _i21;
import 'package:c4d/module_subscription/ui/screens/store_subscriptions_screen.dart'
    as _i147;
import 'package:c4d/module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart'
    as _i148;
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart'
    as _i24;
import 'package:c4d/module_theme/service/theme_service/theme_service.dart'
    as _i27;
import 'package:c4d/module_upload/manager/upload_manager/upload_manager.dart'
    as _i30;
import 'package:c4d/module_upload/repository/upload_repository/upload_repository.dart'
    as _i25;
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart'
    as _i39;
import 'package:c4d/utils/global/global_state_manager.dart' as _i9;
import 'package:c4d/utils/helpers/firestore_helper.dart' as _i8;
import 'package:c4d/utils/helpers/payment_gateway.dart' as _i17;
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
  gh.factory<_i17.PaymentHiveHelper>(() => _i17.PaymentHiveHelper());
  gh.factory<_i18.PrivecyPolicy>(() => _i18.PrivecyPolicy());
  gh.factory<_i19.ProfilePreferencesHelper>(
      () => _i19.ProfilePreferencesHelper());
  gh.factory<_i20.ReleasesTrackerModule>(() => _i20.ReleasesTrackerModule());
  gh.factory<_i21.StoreSubscriptionsFinanceDetailsScreen>(
      () => _i21.StoreSubscriptionsFinanceDetailsScreen());
  gh.factory<_i22.SubscriptionPref>(() => _i22.SubscriptionPref());
  gh.factory<_i23.TermsOfUse>(() => _i23.TermsOfUse());
  gh.factory<_i24.ThemePreferencesHelper>(() => _i24.ThemePreferencesHelper());
  gh.factory<_i25.UploadRepository>(() => _i25.UploadRepository());
  gh.factory<_i26.ApiClient>(() => _i26.ApiClient(gh<_i13.Logger>()));
  gh.factory<_i27.AppThemeDataService>(
      () => _i27.AppThemeDataService(gh<_i24.ThemePreferencesHelper>()));
  gh.factory<_i28.AuthRepository>(() => _i28.AuthRepository(
        gh<_i26.ApiClient>(),
        gh<_i13.Logger>(),
      ));
  gh.factory<_i29.ChooseLocalScreen>(
      () => _i29.ChooseLocalScreen(gh<_i12.LocalizationService>()));
  gh.factory<_i30.UploadManager>(
      () => _i30.UploadManager(gh<_i25.UploadRepository>()));
  gh.factory<_i31.AboutRepository>(
      () => _i31.AboutRepository(gh<_i26.ApiClient>()));
  gh.factory<_i32.AuthManager>(
      () => _i32.AuthManager(gh<_i28.AuthRepository>()));
  gh.factory<_i33.AuthService>(() => _i33.AuthService(
        gh<_i5.AuthPrefsHelper>(),
        gh<_i32.AuthManager>(),
      ));
  gh.factory<_i34.BidOrderRepository>(() => _i34.BidOrderRepository(
        gh<_i26.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i35.BranchesRepository>(() => _i35.BranchesRepository(
        gh<_i26.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i36.ChatRepository>(() => _i36.ChatRepository(
        gh<_i26.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i37.DeepLinkRepository>(() => _i37.DeepLinkRepository(
        gh<_i26.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i38.ForgotPassStateManager>(
      () => _i38.ForgotPassStateManager(gh<_i33.AuthService>()));
  gh.factory<_i39.ImageUploadService>(
      () => _i39.ImageUploadService(gh<_i30.UploadManager>()));
  gh.factory<_i40.LoginStateManager>(
      () => _i40.LoginStateManager(gh<_i33.AuthService>()));
  gh.factory<_i41.MyNotificationsRepository>(
      () => _i41.MyNotificationsRepository(
            gh<_i26.ApiClient>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i42.NotificationRepo>(() => _i42.NotificationRepo(
        gh<_i26.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i43.OrderRepository>(() => _i43.OrderRepository(
        gh<_i26.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i44.OrdersManager>(
      () => _i44.OrdersManager(gh<_i43.OrderRepository>()));
  gh.factory<_i45.ProfileRepository>(() => _i45.ProfileRepository(
        gh<_i26.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i46.RegisterStateManager>(
      () => _i46.RegisterStateManager(gh<_i33.AuthService>()));
  gh.factory<_i47.ReleasesTrackerRepository>(
      () => _i47.ReleasesTrackerRepository(
            gh<_i26.ApiClient>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i48.ResetPasswordStateManager>(
      () => _i48.ResetPasswordStateManager(gh<_i33.AuthService>()));
  gh.factory<_i49.SplashScreen>(
      () => _i49.SplashScreen(gh<_i33.AuthService>()));
  gh.factory<_i50.SubscriptionsRepository>(() => _i50.SubscriptionsRepository(
        gh<_i26.ApiClient>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i51.AboutManager>(
      () => _i51.AboutManager(gh<_i31.AboutRepository>()));
  gh.factory<_i52.AboutService>(
      () => _i52.AboutService(gh<_i51.AboutManager>()));
  gh.factory<_i53.BidOrderManager>(
      () => _i53.BidOrderManager(gh<_i34.BidOrderRepository>()));
  gh.factory<_i54.BidOrderService>(
      () => _i54.BidOrderService(gh<_i53.BidOrderManager>()));
  gh.factory<_i55.BidOrderStatusStateManager>(
      () => _i55.BidOrderStatusStateManager(
            gh<_i54.BidOrderService>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i56.BranchesManager>(
      () => _i56.BranchesManager(gh<_i35.BranchesRepository>()));
  gh.factory<_i57.ChatManager>(
      () => _i57.ChatManager(gh<_i36.ChatRepository>()));
  gh.factory<_i58.ChatService>(() => _i58.ChatService(gh<_i57.ChatManager>()));
  gh.factory<_i59.ChatStateManager>(
      () => _i59.ChatStateManager(gh<_i58.ChatService>()));
  gh.factory<_i60.FireNotificationService>(() => _i60.FireNotificationService(
        gh<_i15.NotificationsPrefHelper>(),
        gh<_i42.NotificationRepo>(),
      ));
  gh.factory<_i61.ForgotPassScreen>(
      () => _i61.ForgotPassScreen(gh<_i38.ForgotPassStateManager>()));
  gh.factory<_i62.LoginScreen>(
      () => _i62.LoginScreen(gh<_i40.LoginStateManager>()));
  gh.factory<_i63.MyNotificationsManager>(
      () => _i63.MyNotificationsManager(gh<_i41.MyNotificationsRepository>()));
  gh.factory<_i64.MyNotificationsService>(
      () => _i64.MyNotificationsService(gh<_i63.MyNotificationsManager>()));
  gh.factory<_i65.OngoingOrderChatStateManager>(
      () => _i65.OngoingOrderChatStateManager(
            gh<_i58.ChatService>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i66.OpenBidOrderStateManager>(
      () => _i66.OpenBidOrderStateManager(gh<_i54.BidOrderService>()));
  gh.factory<_i67.OrderOffersDetailsStateManager>(
      () => _i67.OrderOffersDetailsStateManager(gh<_i54.BidOrderService>()));
  gh.factory<_i68.OrdersChatListStateManager>(
      () => _i68.OrdersChatListStateManager(
            gh<_i58.ChatService>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i69.ProfileManager>(
      () => _i69.ProfileManager(gh<_i45.ProfileRepository>()));
  gh.factory<_i70.ProfileService>(() => _i70.ProfileService(
        gh<_i69.ProfileManager>(),
        gh<_i19.ProfilePreferencesHelper>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i71.RegisterScreen>(
      () => _i71.RegisterScreen(gh<_i46.RegisterStateManager>()));
  gh.factory<_i72.ReleasesTrackerManager>(
      () => _i72.ReleasesTrackerManager(gh<_i47.ReleasesTrackerRepository>()));
  gh.factory<_i73.ReleasesTrackerService>(
      () => _i73.ReleasesTrackerService(gh<_i72.ReleasesTrackerManager>()));
  gh.factory<_i74.ReleasesTrackerStateManager>(() =>
      _i74.ReleasesTrackerStateManager(gh<_i73.ReleasesTrackerService>()));
  gh.factory<_i75.ResetPasswordScreen>(
      () => _i75.ResetPasswordScreen(gh<_i48.ResetPasswordStateManager>()));
  gh.factory<_i76.SettingsScreen>(() => _i76.SettingsScreen(
        gh<_i33.AuthService>(),
        gh<_i12.LocalizationService>(),
        gh<_i27.AppThemeDataService>(),
        gh<_i60.FireNotificationService>(),
      ));
  gh.factory<_i77.SplashModule>(
      () => _i77.SplashModule(gh<_i49.SplashScreen>()));
  gh.factory<_i78.SubscriptionsManager>(
      () => _i78.SubscriptionsManager(gh<_i50.SubscriptionsRepository>()));
  gh.factory<_i79.UpdatesStateManager>(() => _i79.UpdatesStateManager(
        gh<_i64.MyNotificationsService>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i80.AboutScreenStateManager>(() => _i80.AboutScreenStateManager(
        gh<_i12.LocalizationService>(),
        gh<_i52.AboutService>(),
      ));
  gh.factory<_i81.AccountBalanceStateManager>(
      () => _i81.AccountBalanceStateManager(
            gh<_i70.ProfileService>(),
            gh<_i33.AuthService>(),
            gh<_i39.ImageUploadService>(),
          ));
  gh.factory<_i82.AddBidOrderStateManager>(
      () => _i82.AddBidOrderStateManager(gh<_i54.BidOrderService>()));
  gh.factory<_i83.AuthorizationModule>(() => _i83.AuthorizationModule(
        gh<_i62.LoginScreen>(),
        gh<_i71.RegisterScreen>(),
        gh<_i75.ResetPasswordScreen>(),
        gh<_i61.ForgotPassScreen>(),
      ));
  gh.factory<_i84.BidOrderDetailsScreen>(
      () => _i84.BidOrderDetailsScreen(gh<_i55.BidOrderStatusStateManager>()));
  gh.factory<_i85.BidOrderLogsStateManager>(
      () => _i85.BidOrderLogsStateManager(gh<_i54.BidOrderService>()));
  gh.factory<_i86.BranchesListService>(() => _i86.BranchesListService(
        gh<_i56.BranchesManager>(),
        gh<_i19.ProfilePreferencesHelper>(),
      ));
  gh.factory<_i87.BranchesListStateManager>(
      () => _i87.BranchesListStateManager(gh<_i86.BranchesListService>()));
  gh.factory<_i88.ChatPage>(() => _i88.ChatPage(
        gh<_i59.ChatStateManager>(),
        gh<_i39.ImageUploadService>(),
        gh<_i33.AuthService>(),
        gh<_i6.ChatHiveHelper>(),
      ));
  gh.factory<_i89.EditProfileStateManager>(() => _i89.EditProfileStateManager(
        gh<_i39.ImageUploadService>(),
        gh<_i70.ProfileService>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i90.InitAccountStateManager>(() => _i90.InitAccountStateManager(
        gh<_i70.ProfileService>(),
        gh<_i33.AuthService>(),
        gh<_i39.ImageUploadService>(),
      ));
  gh.factory<_i91.InitBranchesStateManager>(() => _i91.InitBranchesStateManager(
        gh<_i86.BranchesListService>(),
        gh<_i70.ProfileService>(),
      ));
  gh.factory<_i92.OngoingOrderChatScreen>(() =>
      _i92.OngoingOrderChatScreen(gh<_i65.OngoingOrderChatStateManager>()));
  gh.factory<_i93.OpenBidOrderScreen>(
      () => _i93.OpenBidOrderScreen(gh<_i66.OpenBidOrderStateManager>()));
  gh.factory<_i94.OrderChatRoomsScreen>(
      () => _i94.OrderChatRoomsScreen(gh<_i68.OrdersChatListStateManager>()));
  gh.factory<_i95.OrderOfferDetailsScreen>(() =>
      _i95.OrderOfferDetailsScreen(gh<_i67.OrderOffersDetailsStateManager>()));
  gh.factory<_i96.OrdersService>(() => _i96.OrdersService(
        gh<_i44.OrdersManager>(),
        gh<_i70.ProfileService>(),
        gh<_i5.AuthPrefsHelper>(),
      ));
  gh.factory<_i97.OwnerOrdersStateManager>(() => _i97.OwnerOrdersStateManager(
        gh<_i96.OrdersService>(),
        gh<_i33.AuthService>(),
        gh<_i70.ProfileService>(),
      ));
  gh.factory<_i98.ProfileScreen>(
      () => _i98.ProfileScreen(gh<_i89.EditProfileStateManager>()));
  gh.factory<_i99.SettingsModule>(() => _i99.SettingsModule(
        gh<_i76.SettingsScreen>(),
        gh<_i29.ChooseLocalScreen>(),
        gh<_i7.CopyMapLinkScreen>(),
        gh<_i18.PrivecyPolicy>(),
        gh<_i23.TermsOfUse>(),
      ));
  gh.factory<_i100.SubOrdersStateManager>(() => _i100.SubOrdersStateManager(
        gh<_i96.OrdersService>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i101.SubscriptionService>(
      () => _i101.SubscriptionService(gh<_i78.SubscriptionsManager>()));
  gh.factory<_i102.UpdateBranchStateManager>(
      () => _i102.UpdateBranchStateManager(gh<_i86.BranchesListService>()));
  gh.factory<_i103.UpdateOrderStateManager>(
      () => _i103.UpdateOrderStateManager(gh<_i96.OrdersService>()));
  gh.factory<_i104.UpdateScreen>(
      () => _i104.UpdateScreen(gh<_i79.UpdatesStateManager>()));
  gh.factory<_i105.AboutScreen>(
      () => _i105.AboutScreen(gh<_i80.AboutScreenStateManager>()));
  gh.factory<_i106.AccountBalanceScreen>(
      () => _i106.AccountBalanceScreen(gh<_i81.AccountBalanceStateManager>()));
  gh.factory<_i107.AddBidOrderScreen>(
      () => _i107.AddBidOrderScreen(gh<_i82.AddBidOrderStateManager>()));
  gh.factory<_i108.BidOrderLogsScreen>(
      () => _i108.BidOrderLogsScreen(gh<_i85.BidOrderLogsStateManager>()));
  gh.factory<_i109.BidOrdersModule>(() => _i109.BidOrdersModule(
        gh<_i93.OpenBidOrderScreen>(),
        gh<_i107.AddBidOrderScreen>(),
        gh<_i95.OrderOfferDetailsScreen>(),
        gh<_i108.BidOrderLogsScreen>(),
        gh<_i84.BidOrderDetailsScreen>(),
      ));
  gh.factory<_i110.BranchesListScreen>(
      () => _i110.BranchesListScreen(gh<_i87.BranchesListStateManager>()));
  gh.factory<_i111.ChatModule>(() => _i111.ChatModule(
        gh<_i88.ChatPage>(),
        gh<_i94.OrderChatRoomsScreen>(),
      ));
  gh.factory<_i112.CompanyInfoStateManager>(() => _i112.CompanyInfoStateManager(
        gh<_i96.OrdersService>(),
        gh<_i33.AuthService>(),
        gh<_i70.ProfileService>(),
      ));
  gh.factory<_i113.HiddenOrdersStateManager>(
      () => _i113.HiddenOrdersStateManager(gh<_i96.OrdersService>()));
  gh.factory<_i114.InitAccountScreen>(
      () => _i114.InitAccountScreen(gh<_i90.InitAccountStateManager>()));
  gh.factory<_i115.InitBranchesScreen>(
      () => _i115.InitBranchesScreen(gh<_i91.InitBranchesStateManager>()));
  gh.factory<_i116.InitSubscriptionStateManager>(
      () => _i116.InitSubscriptionStateManager(
            gh<_i101.SubscriptionService>(),
            gh<_i70.ProfileService>(),
            gh<_i33.AuthService>(),
            gh<_i39.ImageUploadService>(),
          ));
  gh.factory<_i117.MyNotificationsStateManager>(
      () => _i117.MyNotificationsStateManager(
            gh<_i64.MyNotificationsService>(),
            gh<_i96.OrdersService>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i118.NewOrderLinkStateManager>(
      () => _i118.NewOrderLinkStateManager(gh<_i96.OrdersService>()));
  gh.factory<_i119.NewOrderStateManager>(
      () => _i119.NewOrderStateManager(gh<_i96.OrdersService>()));
  gh.factory<_i120.NewSubscriptionBalanceStateManager>(
      () => _i120.NewSubscriptionBalanceStateManager(
            gh<_i101.SubscriptionService>(),
            gh<_i96.OrdersService>(),
          ));
  gh.factory<_i121.OrderLogsStateManager>(
      () => _i121.OrderLogsStateManager(gh<_i96.OrdersService>()));
  gh.factory<_i122.OrderRecyclingStateManager>(
      () => _i122.OrderRecyclingStateManager(
            gh<_i96.OrdersService>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i123.OrderStatusStateManager>(() => _i123.OrderStatusStateManager(
        gh<_i96.OrdersService>(),
        gh<_i33.AuthService>(),
      ));
  gh.factory<_i124.OrderTimeLineStateManager>(
      () => _i124.OrderTimeLineStateManager(
            gh<_i96.OrdersService>(),
            gh<_i33.AuthService>(),
          ));
  gh.factory<_i125.OrdersCashStateManager>(
      () => _i125.OrdersCashStateManager(gh<_i96.OrdersService>()));
  gh.factory<_i126.OwnerOrdersScreen>(() => _i126.OwnerOrdersScreen(
        gh<_i97.OwnerOrdersStateManager>(),
        gh<_i119.NewOrderStateManager>(),
      ));
  gh.factory<_i127.ProfileModule>(() => _i127.ProfileModule(
        gh<_i98.ProfileScreen>(),
        gh<_i114.InitAccountScreen>(),
        gh<_i106.AccountBalanceScreen>(),
      ));
  gh.factory<_i128.StoreSubscriptionsFinanceStateManager>(() =>
      _i128.StoreSubscriptionsFinanceStateManager(
          gh<_i101.SubscriptionService>()));
  gh.factory<_i129.SubOrdersScreen>(
      () => _i129.SubOrdersScreen(gh<_i100.SubOrdersStateManager>()));
  gh.factory<_i130.SubscriptionBalanceStateManager>(
      () => _i130.SubscriptionBalanceStateManager(
            gh<_i101.SubscriptionService>(),
            gh<_i70.ProfileService>(),
            gh<_i33.AuthService>(),
            gh<_i39.ImageUploadService>(),
          ));
  gh.factory<_i131.UpdateBranchScreen>(
      () => _i131.UpdateBranchScreen(gh<_i102.UpdateBranchStateManager>()));
  gh.factory<_i132.UpdateOrderScreen>(
      () => _i132.UpdateOrderScreen(gh<_i103.UpdateOrderStateManager>()));
  gh.factory<_i133.BranchesModule>(() => _i133.BranchesModule(
        gh<_i110.BranchesListScreen>(),
        gh<_i131.UpdateBranchScreen>(),
        gh<_i115.InitBranchesScreen>(),
      ));
  gh.factory<_i134.CompanyInfoScreen>(
      () => _i134.CompanyInfoScreen(gh<_i112.CompanyInfoStateManager>()));
  gh.factory<_i135.HiddenOrdersScreen>(
      () => _i135.HiddenOrdersScreen(gh<_i113.HiddenOrdersStateManager>()));
  gh.factory<_i136.InitSubscriptionScreen>(() =>
      _i136.InitSubscriptionScreen(gh<_i116.InitSubscriptionStateManager>()));
  gh.factory<_i137.MyNotificationsScreen>(() =>
      _i137.MyNotificationsScreen(gh<_i117.MyNotificationsStateManager>()));
  gh.factory<_i138.NewOrderLinkScreen>(
      () => _i138.NewOrderLinkScreen(gh<_i118.NewOrderLinkStateManager>()));
  gh.factory<_i139.NewOrderScreen>(
      () => _i139.NewOrderScreen(gh<_i119.NewOrderStateManager>()));
  gh.factory<_i140.NewSubscriptionBalanceScreen>(() =>
      _i140.NewSubscriptionBalanceScreen(
          gh<_i120.NewSubscriptionBalanceStateManager>()));
  gh.factory<_i141.OrderDetailsScreen>(
      () => _i141.OrderDetailsScreen(gh<_i123.OrderStatusStateManager>()));
  gh.factory<_i142.OrderLogsScreen>(
      () => _i142.OrderLogsScreen(gh<_i121.OrderLogsStateManager>()));
  gh.factory<_i143.OrderRecyclingScreen>(
      () => _i143.OrderRecyclingScreen(gh<_i122.OrderRecyclingStateManager>()));
  gh.factory<_i144.OrderTimeLineScreen>(
      () => _i144.OrderTimeLineScreen(gh<_i124.OrderTimeLineStateManager>()));
  gh.factory<_i145.OrdersCashScreen>(
      () => _i145.OrdersCashScreen(gh<_i125.OrdersCashStateManager>()));
  gh.factory<_i146.OrdersModule>(() => _i146.OrdersModule(
        gh<_i139.NewOrderScreen>(),
        gh<_i141.OrderDetailsScreen>(),
        gh<_i126.OwnerOrdersScreen>(),
        gh<_i129.SubOrdersScreen>(),
        gh<_i138.NewOrderLinkScreen>(),
        gh<_i144.OrderTimeLineScreen>(),
        gh<_i142.OrderLogsScreen>(),
        gh<_i135.HiddenOrdersScreen>(),
        gh<_i143.OrderRecyclingScreen>(),
        gh<_i132.UpdateOrderScreen>(),
        gh<_i145.OrdersCashScreen>(),
      ));
  gh.factory<_i147.StoreSubscriptionsFinanceScreen>(() =>
      _i147.StoreSubscriptionsFinanceScreen(
          gh<_i128.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i148.SubscriptionBalanceScreen>(() =>
      _i148.SubscriptionBalanceScreen(
          gh<_i130.SubscriptionBalanceStateManager>()));
  gh.factory<_i149.SubscriptionsModule>(() => _i149.SubscriptionsModule(
        gh<_i136.InitSubscriptionScreen>(),
        gh<_i148.SubscriptionBalanceScreen>(),
        gh<_i147.StoreSubscriptionsFinanceScreen>(),
        gh<_i21.StoreSubscriptionsFinanceDetailsScreen>(),
        gh<_i140.NewSubscriptionBalanceScreen>(),
      ));
  gh.factory<_i150.AboutModule>(() => _i150.AboutModule(
        gh<_i105.AboutScreen>(),
        gh<_i134.CompanyInfoScreen>(),
      ));
  gh.factory<_i151.MyNotificationsModule>(() => _i151.MyNotificationsModule(
        gh<_i137.MyNotificationsScreen>(),
        gh<_i104.UpdateScreen>(),
      ));
  gh.factory<_i152.MyApp>(() => _i152.MyApp(
        gh<_i146.OrdersModule>(),
        gh<_i27.AppThemeDataService>(),
        gh<_i12.LocalizationService>(),
        gh<_i60.FireNotificationService>(),
        gh<_i10.LocalNotificationService>(),
        gh<_i77.SplashModule>(),
        gh<_i83.AuthorizationModule>(),
        gh<_i111.ChatModule>(),
        gh<_i99.SettingsModule>(),
        gh<_i150.AboutModule>(),
        gh<_i127.ProfileModule>(),
        gh<_i133.BranchesModule>(),
        gh<_i149.SubscriptionsModule>(),
        gh<_i151.MyNotificationsModule>(),
        gh<_i109.BidOrdersModule>(),
      ));
  return getIt;
}

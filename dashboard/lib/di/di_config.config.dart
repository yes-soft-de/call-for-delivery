// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hive/util/argument_hive_helper.dart' as _i3;
import '../main.dart' as _i248;
import '../module_auth/authoriazation_module.dart' as _i128;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i23;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i20;
import '../module_auth/service/auth_service/auth_service.dart' as _i24;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i33;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i36;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i45;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i75;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i80;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i107;
import '../module_bid_order/bid_order_module.dart' as _i130;
import '../module_bid_order/manager/bid_order_manager.dart' as _i55;
import '../module_bid_order/repository/bid_order_repository.dart' as _i25;
import '../module_bid_order/service/bid_order_service.dart' as _i56;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i57;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i58;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i129;
import '../module_branches/branches_module.dart' as _i243;
import '../module_branches/manager/branches_manager.dart' as _i59;
import '../module_branches/repository/branches_repository.dart' as _i26;
import '../module_branches/service/branches_list_service.dart' as _i131;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i132;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i159;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i199;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i201;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i222;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i242;
import '../module_captain/captains_module.dart' as _i244;
import '../module_captain/hive/captain_hive_helper.dart' as _i5;
import '../module_captain/manager/captains_manager.dart' as _i60;
import '../module_captain/repository/captains_repository.dart' as _i27;
import '../module_captain/service/captains_service.dart' as _i61;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i127;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i134;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i144;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i139;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i140;
import '../module_captain/state_manager/captain_list.dart' as _i62;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i145;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i141;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i135;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i143;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i146;
import '../module_captain/state_manager/captin_rating_details_state_manager.dart'
    as _i63;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i79;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i105;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i133;
import '../module_captain/ui/screen/captain_activity_details_screen.dart'
    as _i202;
import '../module_captain/ui/screen/captain_activity_model.dart' as _i210;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i207;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i208;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i211;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i209;
import '../module_captain/ui/screen/captain_rating_screen.dart' as _i212;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i203;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i147;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i142;
import '../module_captain/ui/screen/captin_rating_details_state.dart' as _i148;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i180;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i157;
import '../module_categories/categories_module.dart' as _i214;
import '../module_categories/manager/categories_manager.dart' as _i67;
import '../module_categories/repository/categories_repository.dart' as _i29;
import '../module_categories/service/store_categories_service.dart' as _i68;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i100;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i101;
import '../module_categories/ui/screen/categories_screen.dart' as _i150;
import '../module_categories/ui/screen/packages_screen.dart' as _i178;
import '../module_chat/chat_module.dart' as _i215;
import '../module_chat/manager/chat/chat_manager.dart' as _i69;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i30;
import '../module_chat/service/chat/char_service.dart' as _i70;
import '../module_chat/state_manager/chat_state_manager.dart' as _i71;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i151;
import '../module_company/company_module.dart' as _i245;
import '../module_company/manager/company_manager.dart' as _i72;
import '../module_company/repository/company_repository.dart' as _i31;
import '../module_company/service/company_service.dart' as _i73;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i152;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i153;
import '../module_company/ui/screen/company_finance_screen.dart' as _i216;
import '../module_company/ui/screen/company_profile_screen.dart' as _i217;
import '../module_deep_links/repository/deep_link_repository.dart' as _i32;
import '../module_delivary_car/cars_module.dart' as _i213;
import '../module_delivary_car/manager/cars_manager.dart' as _i64;
import '../module_delivary_car/repository/cars_repository.dart' as _i28;
import '../module_delivary_car/service/cars_service.dart' as _i65;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i66;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i149;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i11;
import '../module_main/main_module.dart' as _i223;
import '../module_main/manager/home_manager.dart' as _i76;
import '../module_main/repository/home_repository.dart' as _i34;
import '../module_main/sceen/home_screen.dart' as _i156;
import '../module_main/sceen/main_screen.dart' as _i161;
import '../module_main/service/home_service.dart' as _i77;
import '../module_main/state_manager/home_state_manager.dart' as _i78;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i81;
import '../module_my_notifications/my_notifications_module.dart' as _i224;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i37;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i82;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i83;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i126;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i162;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i200;
import '../module_network/http_client/http_client.dart' as _i18;
import '../module_notice/manager/notice_manager.dart' as _i86;
import '../module_notice/notice_module.dart' as _i225;
import '../module_notice/repository/notice_repository.dart' as _i38;
import '../module_notice/service/notice_service.dart' as _i87;
import '../module_notice/state_manager/notice_state_manager.dart' as _i88;
import '../module_notice/ui/screen/notice_screen.dart' as _i165;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import '../module_notifications/repository/notification_repo.dart' as _i39;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i74;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import '../module_orders/hive/order_hive_helper.dart' as _i14;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i41;
import '../module_orders/orders_module.dart' as _i230;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i40;
import '../module_orders/service/orders/orders.service.dart' as _i42;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i85;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i84;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i54;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i89;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i90;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i91;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i97;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i92;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i93;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i94;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i98;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i95;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i44;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i46;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i49;
import '../module_orders/ui/screens/new_order/new_order_link.dart' as _i163;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i164;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i125;
import '../module_orders/ui/screens/order_actions_log_screen.dart' as _i166;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i96;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i175;
import '../module_orders/ui/screens/order_conflict_distance_screen.dart'
    as _i169;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i170;
import '../module_orders/ui/screens/order_pending_screen.dart' as _i172;
import '../module_orders/ui/screens/orders_captain_screen.dart' as _i167;
import '../module_orders/ui/screens/orders_receive_cash_screen.dart' as _i176;
import '../module_orders/ui/screens/orders_without_distance_screen.dart'
    as _i99;
import '../module_orders/ui/screens/recycle_order/recycle_order_screen.dart'
    as _i106;
import '../module_orders/ui/screens/search_for_order_screen.dart' as _i108;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i115;
import '../module_payments/manager/payments_manager.dart' as _i102;
import '../module_payments/payments_module.dart' as _i231;
import '../module_payments/repository/payments_repository.dart' as _i43;
import '../module_payments/service/payments_service.dart' as _i103;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i136;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i137;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i138;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i104;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i111;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i205;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i204;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i206;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i179;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i182;
import '../module_settings/settings_module.dart' as _i181;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i21;
import '../module_settings/ui/settings_page/settings_page.dart' as _i109;
import '../module_splash/splash_module.dart' as _i110;
import '../module_splash/ui/screen/splash_screen.dart' as _i47;
import '../module_stores/hive/store_hive_helper.dart' as _i15;
import '../module_stores/manager/stores_manager.dart' as _i112;
import '../module_stores/repository/stores_repository.dart' as _i48;
import '../module_stores/service/store_service.dart' as _i113;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i155;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i168;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i171;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i173;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i174;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i184;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i189;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i190;
import '../module_stores/state_manager/stores_state_manager.dart' as _i114;
import '../module_stores/state_manager/top_active_store.dart' as _i123;
import '../module_stores/stores_module.dart' as _i246;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i226;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i227;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i228;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i229;
import '../module_stores/ui/screen/order/order_top_active_store.dart' as _i177;
import '../module_stores/ui/screen/store_info_screen.dart' as _i232;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i235;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i236;
import '../module_stores/ui/screen/stores_screen.dart' as _i191;
import '../module_stores/ui/screen/top_active_store_screen.dart' as _i124;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i116;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i50;
import '../module_subscriptions/service/subscriptions_service.dart' as _i117;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i154;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i160;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i183;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i185;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i186;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i188;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i193;
import '../module_subscriptions/subscriptions_module.dart' as _i237;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i220;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i218;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i187;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i233;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i234;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i219;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i192;
import '../module_supplier/manager/supplier_manager.dart' as _i53;
import '../module_supplier/repository/supplier_repository.dart' as _i52;
import '../module_supplier/service/supplier_service.dart' as _i121;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i158;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i194;
import '../module_supplier/state_manager/supplier_list.dart' as _i122;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i196;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i197;
import '../module_supplier/supplier_module.dart' as _i247;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i221;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i238;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i198;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i240;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i241;
import '../module_supplier_categories/categories_supplier_module.dart' as _i239;
import '../module_supplier_categories/manager/categories_manager.dart' as _i118;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i51;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i119;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i120;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i195;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i16;
import '../module_theme/service/theme_service/theme_service.dart' as _i19;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i22;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i17;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i35;
import '../utils/global/global_state_manager.dart' as _i8;
import '../utils/helpers/firestore_helper.dart' as _i7;
import '../utils/logger/logger.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.ArgumentHiveHelper>(() => _i3.ArgumentHiveHelper());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.CaptainsHiveHelper>(() => _i5.CaptainsHiveHelper());
  gh.factory<_i6.ChatHiveHelper>(() => _i6.ChatHiveHelper());
  gh.factory<_i7.FireStoreHelper>(() => _i7.FireStoreHelper());
  gh.singleton<_i8.GlobalStateManager>(_i8.GlobalStateManager());
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
  gh.factory<_i15.StoresHiveHelper>(() => _i15.StoresHiveHelper());
  gh.factory<_i16.ThemePreferencesHelper>(() => _i16.ThemePreferencesHelper());
  gh.factory<_i17.UploadRepository>(() => _i17.UploadRepository());
  gh.factory<_i18.ApiClient>(() => _i18.ApiClient(get<_i12.Logger>()));
  gh.factory<_i19.AppThemeDataService>(
      () => _i19.AppThemeDataService(get<_i16.ThemePreferencesHelper>()));
  gh.factory<_i20.AuthRepository>(() => _i20.AuthRepository(
        get<_i18.ApiClient>(),
        get<_i12.Logger>(),
      ));
  gh.factory<_i21.ChooseLocalScreen>(
      () => _i21.ChooseLocalScreen(get<_i11.LocalizationService>()));
  gh.factory<_i22.UploadManager>(
      () => _i22.UploadManager(get<_i17.UploadRepository>()));
  gh.factory<_i23.AuthManager>(
      () => _i23.AuthManager(get<_i20.AuthRepository>()));
  gh.factory<_i24.AuthService>(() => _i24.AuthService(
        get<_i4.AuthPrefsHelper>(),
        get<_i23.AuthManager>(),
      ));
  gh.factory<_i25.BidOrderRepository>(() => _i25.BidOrderRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i26.BranchesRepository>(() => _i26.BranchesRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i27.CaptainsRepository>(() => _i27.CaptainsRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i28.CarsRepository>(() => _i28.CarsRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i29.CategoriesRepository>(() => _i29.CategoriesRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i30.ChatRepository>(() => _i30.ChatRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i31.CompanyRepository>(() => _i31.CompanyRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i32.DeepLinkRepository>(() => _i32.DeepLinkRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i33.ForgotPassStateManager>(
      () => _i33.ForgotPassStateManager(get<_i24.AuthService>()));
  gh.factory<_i34.HomeRepository>(() => _i34.HomeRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i35.ImageUploadService>(
      () => _i35.ImageUploadService(get<_i22.UploadManager>()));
  gh.factory<_i36.LoginStateManager>(
      () => _i36.LoginStateManager(get<_i24.AuthService>()));
  gh.factory<_i37.MyNotificationsRepository>(
      () => _i37.MyNotificationsRepository(
            get<_i18.ApiClient>(),
            get<_i24.AuthService>(),
          ));
  gh.factory<_i38.NoticeRepository>(() => _i38.NoticeRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i39.NotificationRepo>(() => _i39.NotificationRepo(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i40.OrderRepository>(() => _i40.OrderRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i41.OrdersManager>(
      () => _i41.OrdersManager(get<_i40.OrderRepository>()));
  gh.factory<_i42.OrdersService>(
      () => _i42.OrdersService(get<_i41.OrdersManager>()));
  gh.factory<_i43.PaymentsRepository>(() => _i43.PaymentsRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i44.RecycleOrderStateManager>(
      () => _i44.RecycleOrderStateManager(get<_i42.OrdersService>()));
  gh.factory<_i45.RegisterStateManager>(
      () => _i45.RegisterStateManager(get<_i24.AuthService>()));
  gh.factory<_i46.SearchForOrderStateManager>(
      () => _i46.SearchForOrderStateManager(get<_i42.OrdersService>()));
  gh.factory<_i47.SplashScreen>(
      () => _i47.SplashScreen(get<_i24.AuthService>()));
  gh.factory<_i48.StoresRepository>(() => _i48.StoresRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i49.SubOrdersStateManager>(() => _i49.SubOrdersStateManager(
        get<_i42.OrdersService>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i50.SubscriptionsRepository>(() => _i50.SubscriptionsRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i51.SupplierCategoriesRepository>(
      () => _i51.SupplierCategoriesRepository(
            get<_i18.ApiClient>(),
            get<_i24.AuthService>(),
          ));
  gh.factory<_i52.SupplierRepository>(() => _i52.SupplierRepository(
        get<_i18.ApiClient>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i53.SuppliersManager>(
      () => _i53.SuppliersManager(get<_i52.SupplierRepository>()));
  gh.factory<_i54.UpdateOrderStateManager>(
      () => _i54.UpdateOrderStateManager(get<_i42.OrdersService>()));
  gh.factory<_i55.BidOrderManager>(
      () => _i55.BidOrderManager(get<_i25.BidOrderRepository>()));
  gh.factory<_i56.BidOrderService>(
      () => _i56.BidOrderService(get<_i55.BidOrderManager>()));
  gh.factory<_i57.BidOrderStateManager>(
      () => _i57.BidOrderStateManager(get<_i56.BidOrderService>()));
  gh.factory<_i58.BidOrdersScreen>(
      () => _i58.BidOrdersScreen(get<_i57.BidOrderStateManager>()));
  gh.factory<_i59.BranchesManager>(
      () => _i59.BranchesManager(get<_i26.BranchesRepository>()));
  gh.factory<_i60.CaptainsManager>(
      () => _i60.CaptainsManager(get<_i27.CaptainsRepository>()));
  gh.factory<_i61.CaptainsService>(
      () => _i61.CaptainsService(get<_i60.CaptainsManager>()));
  gh.factory<_i62.CaptainsStateManager>(
      () => _i62.CaptainsStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i63.CaptinRatingDetailsStateManager>(
      () => _i63.CaptinRatingDetailsStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i64.CarsManager>(
      () => _i64.CarsManager(get<_i28.CarsRepository>()));
  gh.factory<_i65.CarsService>(() => _i65.CarsService(get<_i64.CarsManager>()));
  gh.factory<_i66.CarsStateManager>(
      () => _i66.CarsStateManager(get<_i65.CarsService>()));
  gh.factory<_i67.CategoriesManager>(
      () => _i67.CategoriesManager(get<_i29.CategoriesRepository>()));
  gh.factory<_i68.CategoriesService>(
      () => _i68.CategoriesService(get<_i67.CategoriesManager>()));
  gh.factory<_i69.ChatManager>(
      () => _i69.ChatManager(get<_i30.ChatRepository>()));
  gh.factory<_i70.ChatService>(() => _i70.ChatService(get<_i69.ChatManager>()));
  gh.factory<_i71.ChatStateManager>(
      () => _i71.ChatStateManager(get<_i70.ChatService>()));
  gh.factory<_i72.CompanyManager>(
      () => _i72.CompanyManager(get<_i31.CompanyRepository>()));
  gh.factory<_i73.CompanyService>(
      () => _i73.CompanyService(get<_i72.CompanyManager>()));
  gh.factory<_i74.FireNotificationService>(() => _i74.FireNotificationService(
        get<_i13.NotificationsPrefHelper>(),
        get<_i39.NotificationRepo>(),
      ));
  gh.factory<_i75.ForgotPassScreen>(
      () => _i75.ForgotPassScreen(get<_i33.ForgotPassStateManager>()));
  gh.factory<_i76.HomeManager>(
      () => _i76.HomeManager(get<_i34.HomeRepository>()));
  gh.factory<_i77.HomeService>(() => _i77.HomeService(get<_i76.HomeManager>()));
  gh.factory<_i78.HomeStateManager>(
      () => _i78.HomeStateManager(get<_i77.HomeService>()));
  gh.factory<_i79.InActiveCaptainsStateManager>(
      () => _i79.InActiveCaptainsStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i80.LoginScreen>(
      () => _i80.LoginScreen(get<_i36.LoginStateManager>()));
  gh.factory<_i81.MyNotificationsManager>(
      () => _i81.MyNotificationsManager(get<_i37.MyNotificationsRepository>()));
  gh.factory<_i82.MyNotificationsService>(
      () => _i82.MyNotificationsService(get<_i81.MyNotificationsManager>()));
  gh.factory<_i83.MyNotificationsStateManager>(
      () => _i83.MyNotificationsStateManager(
            get<_i82.MyNotificationsService>(),
            get<_i42.OrdersService>(),
            get<_i24.AuthService>(),
          ));
  gh.factory<_i84.NewOrderLinkStateManager>(
      () => _i84.NewOrderLinkStateManager(get<_i42.OrdersService>()));
  gh.factory<_i85.NewOrderStateManager>(
      () => _i85.NewOrderStateManager(get<_i42.OrdersService>()));
  gh.factory<_i86.NoticeManager>(
      () => _i86.NoticeManager(get<_i38.NoticeRepository>()));
  gh.factory<_i87.NoticeService>(
      () => _i87.NoticeService(get<_i86.NoticeManager>()));
  gh.factory<_i88.NoticeStateManager>(
      () => _i88.NoticeStateManager(get<_i87.NoticeService>()));
  gh.factory<_i89.OrderActionLogsStateManager>(
      () => _i89.OrderActionLogsStateManager(get<_i42.OrdersService>()));
  gh.factory<_i90.OrderCaptainLogsStateManager>(
      () => _i90.OrderCaptainLogsStateManager(get<_i42.OrdersService>()));
  gh.factory<_i91.OrderCashCaptainStateManager>(
      () => _i91.OrderCashCaptainStateManager(get<_i42.OrdersService>()));
  gh.factory<_i92.OrderDistanceConflictStateManager>(
      () => _i92.OrderDistanceConflictStateManager(get<_i42.OrdersService>()));
  gh.factory<_i93.OrderLogsStateManager>(
      () => _i93.OrderLogsStateManager(get<_i42.OrdersService>()));
  gh.factory<_i94.OrderPendingStateManager>(
      () => _i94.OrderPendingStateManager(get<_i42.OrdersService>()));
  gh.factory<_i95.OrderWithoutDistanceStateManager>(
      () => _i95.OrderWithoutDistanceStateManager(get<_i42.OrdersService>()));
  gh.factory<_i96.OrdersCashCaptainScreen>(() =>
      _i96.OrdersCashCaptainScreen(get<_i91.OrderCashCaptainStateManager>()));
  gh.factory<_i97.OrdersCashStoreStateManager>(
      () => _i97.OrdersCashStoreStateManager(get<_i42.OrdersService>()));
  gh.factory<_i98.OrdersReceiveCashStateManager>(
      () => _i98.OrdersReceiveCashStateManager(get<_i42.OrdersService>()));
  gh.factory<_i99.OrdersWithoutDistanceScreen>(() =>
      _i99.OrdersWithoutDistanceScreen(
          get<_i95.OrderWithoutDistanceStateManager>()));
  gh.factory<_i100.PackageCategoriesStateManager>(
      () => _i100.PackageCategoriesStateManager(
            get<_i68.CategoriesService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i101.PackagesStateManager>(() => _i101.PackagesStateManager(
        get<_i68.CategoriesService>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i102.PaymentsManager>(
      () => _i102.PaymentsManager(get<_i43.PaymentsRepository>()));
  gh.factory<_i103.PaymentsService>(
      () => _i103.PaymentsService(get<_i102.PaymentsManager>()));
  gh.factory<_i104.PaymentsToCaptainStateManager>(
      () => _i104.PaymentsToCaptainStateManager(get<_i103.PaymentsService>()));
  gh.factory<_i105.PlanScreenStateManager>(
      () => _i105.PlanScreenStateManager(get<_i103.PaymentsService>()));
  gh.factory<_i106.RecycleOrderScreen>(
      () => _i106.RecycleOrderScreen(get<_i44.RecycleOrderStateManager>()));
  gh.factory<_i107.RegisterScreen>(
      () => _i107.RegisterScreen(get<_i45.RegisterStateManager>()));
  gh.factory<_i108.SearchForOrderScreen>(
      () => _i108.SearchForOrderScreen(get<_i46.SearchForOrderStateManager>()));
  gh.factory<_i109.SettingsScreen>(() => _i109.SettingsScreen(
        get<_i24.AuthService>(),
        get<_i11.LocalizationService>(),
        get<_i19.AppThemeDataService>(),
        get<_i74.FireNotificationService>(),
      ));
  gh.factory<_i110.SplashModule>(
      () => _i110.SplashModule(get<_i47.SplashScreen>()));
  gh.factory<_i111.StoreBalanceStateManager>(
      () => _i111.StoreBalanceStateManager(get<_i103.PaymentsService>()));
  gh.factory<_i112.StoreManager>(
      () => _i112.StoreManager(get<_i48.StoresRepository>()));
  gh.factory<_i113.StoresService>(() => _i113.StoresService(
        get<_i112.StoreManager>(),
        get<_i41.OrdersManager>(),
      ));
  gh.factory<_i114.StoresStateManager>(() => _i114.StoresStateManager(
        get<_i113.StoresService>(),
        get<_i24.AuthService>(),
        get<_i35.ImageUploadService>(),
      ));
  gh.factory<_i115.SubOrdersScreen>(
      () => _i115.SubOrdersScreen(get<_i49.SubOrdersStateManager>()));
  gh.factory<_i116.SubscriptionsManager>(
      () => _i116.SubscriptionsManager(get<_i50.SubscriptionsRepository>()));
  gh.factory<_i117.SubscriptionsService>(
      () => _i117.SubscriptionsService(get<_i116.SubscriptionsManager>()));
  gh.factory<_i118.SupplierCategoriesManager>(() =>
      _i118.SupplierCategoriesManager(
          get<_i51.SupplierCategoriesRepository>()));
  gh.factory<_i119.SupplierCategoriesService>(() =>
      _i119.SupplierCategoriesService(get<_i118.SupplierCategoriesManager>()));
  gh.factory<_i120.SupplierCategoriesStateManager>(
      () => _i120.SupplierCategoriesStateManager(
            get<_i119.SupplierCategoriesService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i121.SupplierService>(
      () => _i121.SupplierService(get<_i53.SuppliersManager>()));
  gh.factory<_i122.SuppliersStateManager>(
      () => _i122.SuppliersStateManager(get<_i121.SupplierService>()));
  gh.factory<_i123.TopActiveStateManagment>(
      () => _i123.TopActiveStateManagment(get<_i113.StoresService>()));
  gh.factory<_i124.TopActiveStoreScreen>(
      () => _i124.TopActiveStoreScreen(get<_i123.TopActiveStateManagment>()));
  gh.factory<_i125.UpdateOrderScreen>(
      () => _i125.UpdateOrderScreen(get<_i54.UpdateOrderStateManager>()));
  gh.factory<_i126.UpdatesStateManager>(() => _i126.UpdatesStateManager(
        get<_i82.MyNotificationsService>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i127.AccountBalanceStateManager>(
      () => _i127.AccountBalanceStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i128.AuthorizationModule>(() => _i128.AuthorizationModule(
        get<_i80.LoginScreen>(),
        get<_i107.RegisterScreen>(),
        get<_i75.ForgotPassScreen>(),
      ));
  gh.factory<_i129.BidOrderDetailsScreen>(
      () => _i129.BidOrderDetailsScreen(get<_i57.BidOrderStateManager>()));
  gh.factory<_i130.BidOrderModule>(
      () => _i130.BidOrderModule(get<_i58.BidOrdersScreen>()));
  gh.factory<_i131.BranchesListService>(
      () => _i131.BranchesListService(get<_i59.BranchesManager>()));
  gh.factory<_i132.BranchesListStateManager>(
      () => _i132.BranchesListStateManager(get<_i131.BranchesListService>()));
  gh.factory<_i133.CaptainAccountBalanceScreen>(() =>
      _i133.CaptainAccountBalanceScreen(
          get<_i127.AccountBalanceStateManager>()));
  gh.factory<_i134.CaptainActivityDetailsStateManager>(() =>
      _i134.CaptainActivityDetailsStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i135.CaptainAssignOrderStateManager>(
      () => _i135.CaptainAssignOrderStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i136.CaptainFinanceByHoursStateManager>(() =>
      _i136.CaptainFinanceByHoursStateManager(get<_i103.PaymentsService>()));
  gh.factory<_i137.CaptainFinanceByOrderCountStateManager>(() =>
      _i137.CaptainFinanceByOrderCountStateManager(
          get<_i103.PaymentsService>()));
  gh.factory<_i138.CaptainFinanceByOrderStateManager>(() =>
      _i138.CaptainFinanceByOrderStateManager(get<_i103.PaymentsService>()));
  gh.factory<_i139.CaptainFinancialDuesDetailsStateManager>(
      () => _i139.CaptainFinancialDuesDetailsStateManager(
            get<_i103.PaymentsService>(),
            get<_i61.CaptainsService>(),
          ));
  gh.factory<_i140.CaptainFinancialDuesStateManager>(() =>
      _i140.CaptainFinancialDuesStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i141.CaptainOfferStateManager>(
      () => _i141.CaptainOfferStateManager(
            get<_i61.CaptainsService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i142.CaptainOffersScreen>(
      () => _i142.CaptainOffersScreen(get<_i141.CaptainOfferStateManager>()));
  gh.factory<_i143.CaptainProfileStateManager>(
      () => _i143.CaptainProfileStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i144.CaptainsActivityStateManager>(
      () => _i144.CaptainsActivityStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i145.CaptainsNeedsSupportStateManager>(() =>
      _i145.CaptainsNeedsSupportStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i146.CaptainsRatingStateManager>(
      () => _i146.CaptainsRatingStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i147.CaptainsScreen>(
      () => _i147.CaptainsScreen(get<_i62.CaptainsStateManager>()));
  gh.factory<_i148.CaptinRatingDetailsScreen>(() =>
      _i148.CaptinRatingDetailsScreen(
          get<_i63.CaptinRatingDetailsStateManager>()));
  gh.factory<_i149.CarsScreen>(
      () => _i149.CarsScreen(get<_i66.CarsStateManager>()));
  gh.factory<_i150.CategoriesScreen>(
      () => _i150.CategoriesScreen(get<_i100.PackageCategoriesStateManager>()));
  gh.factory<_i151.ChatPage>(() => _i151.ChatPage(
        get<_i71.ChatStateManager>(),
        get<_i35.ImageUploadService>(),
        get<_i24.AuthService>(),
        get<_i6.ChatHiveHelper>(),
      ));
  gh.factory<_i152.CompanyFinanceStateManager>(
      () => _i152.CompanyFinanceStateManager(
            get<_i24.AuthService>(),
            get<_i73.CompanyService>(),
          ));
  gh.factory<_i153.CompanyProfileStateManager>(
      () => _i153.CompanyProfileStateManager(
            get<_i24.AuthService>(),
            get<_i73.CompanyService>(),
          ));
  gh.factory<_i154.EditSubscriptionStateManager>(() =>
      _i154.EditSubscriptionStateManager(get<_i117.SubscriptionsService>()));
  gh.factory<_i155.FilterOrderTopStateManager>(
      () => _i155.FilterOrderTopStateManager(get<_i113.StoresService>()));
  gh.factory<_i156.HomeScreen>(
      () => _i156.HomeScreen(get<_i78.HomeStateManager>()));
  gh.factory<_i157.InActiveCaptainsScreen>(() =>
      _i157.InActiveCaptainsScreen(get<_i79.InActiveCaptainsStateManager>()));
  gh.factory<_i158.InActiveSupplierStateManager>(
      () => _i158.InActiveSupplierStateManager(get<_i121.SupplierService>()));
  gh.factory<_i159.InitBranchesStateManager>(
      () => _i159.InitBranchesStateManager(get<_i131.BranchesListService>()));
  gh.factory<_i160.InitSubscriptionStateManager>(() =>
      _i160.InitSubscriptionStateManager(get<_i117.SubscriptionsService>()));
  gh.factory<_i161.MainScreen>(() => _i161.MainScreen(get<_i156.HomeScreen>()));
  gh.factory<_i162.MyNotificationsScreen>(() =>
      _i162.MyNotificationsScreen(get<_i83.MyNotificationsStateManager>()));
  gh.factory<_i163.NewOrderLinkScreen>(
      () => _i163.NewOrderLinkScreen(get<_i84.NewOrderLinkStateManager>()));
  gh.factory<_i164.NewOrderScreen>(
      () => _i164.NewOrderScreen(get<_i85.NewOrderStateManager>()));
  gh.factory<_i165.NoticeScreen>(
      () => _i165.NoticeScreen(get<_i88.NoticeStateManager>()));
  gh.factory<_i166.OrderActionLogsScreen>(() =>
      _i166.OrderActionLogsScreen(get<_i89.OrderActionLogsStateManager>()));
  gh.factory<_i167.OrderCaptainLogsScreen>(() =>
      _i167.OrderCaptainLogsScreen(get<_i90.OrderCaptainLogsStateManager>()));
  gh.factory<_i168.OrderCaptainNotArrivedStateManager>(() =>
      _i168.OrderCaptainNotArrivedStateManager(get<_i113.StoresService>()));
  gh.factory<_i169.OrderDistanceConflictScreen>(() =>
      _i169.OrderDistanceConflictScreen(
          get<_i92.OrderDistanceConflictStateManager>()));
  gh.factory<_i170.OrderLogsScreen>(
      () => _i170.OrderLogsScreen(get<_i93.OrderLogsStateManager>()));
  gh.factory<_i171.OrderLogsStateManager>(
      () => _i171.OrderLogsStateManager(get<_i113.StoresService>()));
  gh.factory<_i172.OrderPendingScreen>(
      () => _i172.OrderPendingScreen(get<_i94.OrderPendingStateManager>()));
  gh.factory<_i173.OrderStatusStateManager>(() => _i173.OrderStatusStateManager(
        get<_i113.StoresService>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i174.OrderTimeLineStateManager>(
      () => _i174.OrderTimeLineStateManager(
            get<_i113.StoresService>(),
            get<_i24.AuthService>(),
          ));
  gh.factory<_i175.OrdersCashStoreScreen>(() =>
      _i175.OrdersCashStoreScreen(get<_i97.OrdersCashStoreStateManager>()));
  gh.factory<_i176.OrdersReceiveCashScreen>(() =>
      _i176.OrdersReceiveCashScreen(get<_i98.OrdersReceiveCashStateManager>()));
  gh.factory<_i177.OrdersTopActiveStoreScreen>(() =>
      _i177.OrdersTopActiveStoreScreen(
          get<_i155.FilterOrderTopStateManager>()));
  gh.factory<_i178.PackagesScreen>(
      () => _i178.PackagesScreen(get<_i101.PackagesStateManager>()));
  gh.factory<_i179.PaymentsToCaptainScreen>(() => _i179.PaymentsToCaptainScreen(
      get<_i104.PaymentsToCaptainStateManager>()));
  gh.factory<_i180.PlanScreen>(
      () => _i180.PlanScreen(get<_i105.PlanScreenStateManager>()));
  gh.factory<_i181.SettingsModule>(() => _i181.SettingsModule(
        get<_i109.SettingsScreen>(),
        get<_i21.ChooseLocalScreen>(),
      ));
  gh.factory<_i182.StoreBalanceScreen>(
      () => _i182.StoreBalanceScreen(get<_i111.StoreBalanceStateManager>()));
  gh.factory<_i183.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i183.StoreFinancialSubscriptionsDuesDetailsStateManager(
            get<_i103.PaymentsService>(),
            get<_i117.SubscriptionsService>(),
          ));
  gh.factory<_i184.StoreProfileStateManager>(
      () => _i184.StoreProfileStateManager(
            get<_i113.StoresService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i185.StoreSubscriptionManagementStateManager>(() =>
      _i185.StoreSubscriptionManagementStateManager(
          get<_i117.SubscriptionsService>()));
  gh.factory<_i186.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i186.StoreSubscriptionsExpiredFinanceStateManager(
          get<_i117.SubscriptionsService>()));
  gh.factory<_i187.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i187.StoreSubscriptionsFinanceDetailsScreen(
          get<_i183.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i188.StoreSubscriptionsFinanceStateManager>(() =>
      _i188.StoreSubscriptionsFinanceStateManager(
          get<_i117.SubscriptionsService>()));
  gh.factory<_i189.StoresInActiveStateManager>(
      () => _i189.StoresInActiveStateManager(
            get<_i113.StoresService>(),
            get<_i24.AuthService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i190.StoresNeedsSupportStateManager>(
      () => _i190.StoresNeedsSupportStateManager(get<_i113.StoresService>()));
  gh.factory<_i191.StoresScreen>(
      () => _i191.StoresScreen(get<_i114.StoresStateManager>()));
  gh.factory<_i192.SubscriptionManagementScreen>(() =>
      _i192.SubscriptionManagementScreen(
          get<_i185.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i193.SubscriptionToCaptainOfferStateManager>(() =>
      _i193.SubscriptionToCaptainOfferStateManager(
          get<_i117.SubscriptionsService>()));
  gh.factory<_i194.SupplierAdsStateManager>(
      () => _i194.SupplierAdsStateManager(get<_i121.SupplierService>()));
  gh.factory<_i195.SupplierCategoriesScreen>(() =>
      _i195.SupplierCategoriesScreen(
          get<_i120.SupplierCategoriesStateManager>()));
  gh.factory<_i196.SupplierNeedsSupportStateManager>(() =>
      _i196.SupplierNeedsSupportStateManager(get<_i121.SupplierService>()));
  gh.factory<_i197.SupplierProfileStateManager>(
      () => _i197.SupplierProfileStateManager(get<_i121.SupplierService>()));
  gh.factory<_i198.SuppliersScreen>(
      () => _i198.SuppliersScreen(get<_i122.SuppliersStateManager>()));
  gh.factory<_i199.UpdateBranchStateManager>(
      () => _i199.UpdateBranchStateManager(get<_i131.BranchesListService>()));
  gh.factory<_i200.UpdateScreen>(
      () => _i200.UpdateScreen(get<_i126.UpdatesStateManager>()));
  gh.factory<_i201.BranchesListScreen>(
      () => _i201.BranchesListScreen(get<_i132.BranchesListStateManager>()));
  gh.factory<_i202.CaptainActivityDetailsScreen>(() =>
      _i202.CaptainActivityDetailsScreen(
          get<_i134.CaptainActivityDetailsStateManager>()));
  gh.factory<_i203.CaptainAssignOrderScreen>(() =>
      _i203.CaptainAssignOrderScreen(
          get<_i135.CaptainAssignOrderStateManager>()));
  gh.factory<_i204.CaptainFinanceByCountOrderScreen>(() =>
      _i204.CaptainFinanceByCountOrderScreen(
          get<_i137.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i205.CaptainFinanceByHoursScreen>(() =>
      _i205.CaptainFinanceByHoursScreen(
          get<_i136.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i206.CaptainFinanceByOrderScreen>(() =>
      _i206.CaptainFinanceByOrderScreen(
          get<_i138.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i207.CaptainFinancialDuesDetailsScreen>(() =>
      _i207.CaptainFinancialDuesDetailsScreen(
          get<_i139.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i208.CaptainFinancialDuesScreen>(() =>
      _i208.CaptainFinancialDuesScreen(
          get<_i140.CaptainFinancialDuesStateManager>()));
  gh.factory<_i209.CaptainProfileScreen>(() =>
      _i209.CaptainProfileScreen(get<_i143.CaptainProfileStateManager>()));
  gh.factory<_i210.CaptainsActivityScreen>(() =>
      _i210.CaptainsActivityScreen(get<_i144.CaptainsActivityStateManager>()));
  gh.factory<_i211.CaptainsNeedsSupportScreen>(() =>
      _i211.CaptainsNeedsSupportScreen(
          get<_i145.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i212.CaptainsRatingScreen>(() =>
      _i212.CaptainsRatingScreen(get<_i146.CaptainsRatingStateManager>()));
  gh.factory<_i213.CarsModule>(() => _i213.CarsModule(get<_i149.CarsScreen>()));
  gh.factory<_i214.CategoriesModule>(() => _i214.CategoriesModule(
        get<_i150.CategoriesScreen>(),
        get<_i178.PackagesScreen>(),
      ));
  gh.factory<_i215.ChatModule>(() => _i215.ChatModule(
        get<_i151.ChatPage>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i216.CompanyFinanceScreen>(() =>
      _i216.CompanyFinanceScreen(get<_i152.CompanyFinanceStateManager>()));
  gh.factory<_i217.CompanyProfileScreen>(() =>
      _i217.CompanyProfileScreen(get<_i153.CompanyProfileStateManager>()));
  gh.factory<_i218.CreateSubscriptionScreen>(() =>
      _i218.CreateSubscriptionScreen(
          get<_i160.InitSubscriptionStateManager>()));
  gh.factory<_i219.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i219.CreateSubscriptionToCaptainOfferScreen(
          get<_i193.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i220.EditSubscriptionScreen>(() =>
      _i220.EditSubscriptionScreen(get<_i154.EditSubscriptionStateManager>()));
  gh.factory<_i221.InActiveSupplierScreen>(() =>
      _i221.InActiveSupplierScreen(get<_i158.InActiveSupplierStateManager>()));
  gh.factory<_i222.InitBranchesScreen>(
      () => _i222.InitBranchesScreen(get<_i159.InitBranchesStateManager>()));
  gh.factory<_i223.MainModule>(() => _i223.MainModule(
        get<_i161.MainScreen>(),
        get<_i156.HomeScreen>(),
      ));
  gh.factory<_i224.MyNotificationsModule>(() => _i224.MyNotificationsModule(
        get<_i162.MyNotificationsScreen>(),
        get<_i200.UpdateScreen>(),
      ));
  gh.factory<_i225.NoticeModule>(
      () => _i225.NoticeModule(get<_i165.NoticeScreen>()));
  gh.factory<_i226.OrderCaptainNotArrivedScreen>(() =>
      _i226.OrderCaptainNotArrivedScreen(
          get<_i168.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i227.OrderDetailsScreen>(
      () => _i227.OrderDetailsScreen(get<_i173.OrderStatusStateManager>()));
  gh.factory<_i228.OrderLogsScreen>(
      () => _i228.OrderLogsScreen(get<_i171.OrderLogsStateManager>()));
  gh.factory<_i229.OrderTimeLineScreen>(
      () => _i229.OrderTimeLineScreen(get<_i174.OrderTimeLineStateManager>()));
  gh.factory<_i230.OrdersModule>(() => _i230.OrdersModule(
        get<_i170.OrderLogsScreen>(),
        get<_i96.OrdersCashCaptainScreen>(),
        get<_i175.OrdersCashStoreScreen>(),
        get<_i125.UpdateOrderScreen>(),
        get<_i172.OrderPendingScreen>(),
        get<_i164.NewOrderScreen>(),
        get<_i167.OrderCaptainLogsScreen>(),
        get<_i166.OrderActionLogsScreen>(),
        get<_i99.OrdersWithoutDistanceScreen>(),
        get<_i176.OrdersReceiveCashScreen>(),
        get<_i115.SubOrdersScreen>(),
        get<_i163.NewOrderLinkScreen>(),
        get<_i108.SearchForOrderScreen>(),
        get<_i106.RecycleOrderScreen>(),
        get<_i169.OrderDistanceConflictScreen>(),
      ));
  gh.factory<_i231.PaymentsModule>(() => _i231.PaymentsModule(
        get<_i204.CaptainFinanceByCountOrderScreen>(),
        get<_i205.CaptainFinanceByHoursScreen>(),
        get<_i206.CaptainFinanceByOrderScreen>(),
        get<_i179.PaymentsToCaptainScreen>(),
        get<_i182.StoreBalanceScreen>(),
      ));
  gh.factory<_i232.StoreInfoScreen>(
      () => _i232.StoreInfoScreen(get<_i184.StoreProfileStateManager>()));
  gh.factory<_i233.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i233.StoreSubscriptionsExpiredFinanceScreen(
          get<_i186.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i234.StoreSubscriptionsFinanceScreen>(() =>
      _i234.StoreSubscriptionsFinanceScreen(
          get<_i188.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i235.StoresInActiveScreen>(() =>
      _i235.StoresInActiveScreen(get<_i189.StoresInActiveStateManager>()));
  gh.factory<_i236.StoresNeedsSupportScreen>(() =>
      _i236.StoresNeedsSupportScreen(
          get<_i190.StoresNeedsSupportStateManager>()));
  gh.factory<_i237.SubscriptionsModule>(() => _i237.SubscriptionsModule(
        get<_i187.StoreSubscriptionsFinanceDetailsScreen>(),
        get<_i234.StoreSubscriptionsFinanceScreen>(),
        get<_i192.SubscriptionManagementScreen>(),
        get<_i233.StoreSubscriptionsExpiredFinanceScreen>(),
        get<_i218.CreateSubscriptionScreen>(),
        get<_i219.CreateSubscriptionToCaptainOfferScreen>(),
        get<_i220.EditSubscriptionScreen>(),
      ));
  gh.factory<_i238.SupplierAdsScreen>(
      () => _i238.SupplierAdsScreen(get<_i194.SupplierAdsStateManager>()));
  gh.factory<_i239.SupplierCategoriesModule>(() =>
      _i239.SupplierCategoriesModule(get<_i195.SupplierCategoriesScreen>()));
  gh.factory<_i240.SupplierNeedsSupportScreen>(() =>
      _i240.SupplierNeedsSupportScreen(
          get<_i196.SupplierNeedsSupportStateManager>()));
  gh.factory<_i241.SupplierProfileScreen>(() =>
      _i241.SupplierProfileScreen(get<_i197.SupplierProfileStateManager>()));
  gh.factory<_i242.UpdateBranchScreen>(
      () => _i242.UpdateBranchScreen(get<_i199.UpdateBranchStateManager>()));
  gh.factory<_i243.BranchesModule>(() => _i243.BranchesModule(
        get<_i201.BranchesListScreen>(),
        get<_i242.UpdateBranchScreen>(),
        get<_i222.InitBranchesScreen>(),
      ));
  gh.factory<_i244.CaptainsModule>(() => _i244.CaptainsModule(
        get<_i142.CaptainOffersScreen>(),
        get<_i157.InActiveCaptainsScreen>(),
        get<_i147.CaptainsScreen>(),
        get<_i209.CaptainProfileScreen>(),
        get<_i211.CaptainsNeedsSupportScreen>(),
        get<_i133.CaptainAccountBalanceScreen>(),
        get<_i207.CaptainFinancialDuesDetailsScreen>(),
        get<_i208.CaptainFinancialDuesScreen>(),
        get<_i180.PlanScreen>(),
        get<_i203.CaptainAssignOrderScreen>(),
        get<_i212.CaptainsRatingScreen>(),
        get<_i148.CaptinRatingDetailsScreen>(),
        get<_i210.CaptainsActivityScreen>(),
        get<_i202.CaptainActivityDetailsScreen>(),
      ));
  gh.factory<_i245.CompanyModule>(() => _i245.CompanyModule(
        get<_i217.CompanyProfileScreen>(),
        get<_i216.CompanyFinanceScreen>(),
      ));
  gh.factory<_i246.StoresModule>(() => _i246.StoresModule(
        get<_i191.StoresScreen>(),
        get<_i232.StoreInfoScreen>(),
        get<_i235.StoresInActiveScreen>(),
        get<_i182.StoreBalanceScreen>(),
        get<_i236.StoresNeedsSupportScreen>(),
        get<_i227.OrderDetailsScreen>(),
        get<_i228.OrderLogsScreen>(),
        get<_i226.OrderCaptainNotArrivedScreen>(),
        get<_i229.OrderTimeLineScreen>(),
        get<_i124.TopActiveStoreScreen>(),
        get<_i177.OrdersTopActiveStoreScreen>(),
      ));
  gh.factory<_i247.SupplierModule>(() => _i247.SupplierModule(
        get<_i221.InActiveSupplierScreen>(),
        get<_i198.SuppliersScreen>(),
        get<_i241.SupplierProfileScreen>(),
        get<_i240.SupplierNeedsSupportScreen>(),
        get<_i238.SupplierAdsScreen>(),
      ));
  gh.factory<_i248.MyApp>(() => _i248.MyApp(
        get<_i19.AppThemeDataService>(),
        get<_i11.LocalizationService>(),
        get<_i74.FireNotificationService>(),
        get<_i9.LocalNotificationService>(),
        get<_i110.SplashModule>(),
        get<_i128.AuthorizationModule>(),
        get<_i215.ChatModule>(),
        get<_i181.SettingsModule>(),
        get<_i223.MainModule>(),
        get<_i246.StoresModule>(),
        get<_i214.CategoriesModule>(),
        get<_i245.CompanyModule>(),
        get<_i243.BranchesModule>(),
        get<_i225.NoticeModule>(),
        get<_i244.CaptainsModule>(),
        get<_i231.PaymentsModule>(),
        get<_i239.SupplierCategoriesModule>(),
        get<_i247.SupplierModule>(),
        get<_i213.CarsModule>(),
        get<_i130.BidOrderModule>(),
        get<_i230.OrdersModule>(),
        get<_i237.SubscriptionsModule>(),
        get<_i224.MyNotificationsModule>(),
      ));
  return get;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:c4d/module_stores/ui/screen/order/order_top_active_store.dart';
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hive/util/argument_hive_helper.dart' as _i3;
import '../main.dart' as _i246;
import '../module_auth/authoriazation_module.dart' as _i127;
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
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i106;
import '../module_bid_order/bid_order_module.dart' as _i129;
import '../module_bid_order/manager/bid_order_manager.dart' as _i55;
import '../module_bid_order/repository/bid_order_repository.dart' as _i25;
import '../module_bid_order/service/bid_order_service.dart' as _i56;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i57;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i58;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i128;
import '../module_branches/branches_module.dart' as _i241;
import '../module_branches/manager/branches_manager.dart' as _i59;
import '../module_branches/repository/branches_repository.dart' as _i26;
import '../module_branches/service/branches_list_service.dart' as _i130;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i131;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i158;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i197;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i199;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i220;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i240;
import '../module_captain/captains_module.dart' as _i242;
import '../module_captain/hive/captain_hive_helper.dart' as _i5;
import '../module_captain/manager/captains_manager.dart' as _i60;
import '../module_captain/repository/captains_repository.dart' as _i27;
import '../module_captain/service/captains_service.dart' as _i61;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i126;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i133;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i143;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i138;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i139;
import '../module_captain/state_manager/captain_list.dart' as _i62;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i144;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i140;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i134;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i142;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i145;
import '../module_captain/state_manager/captin_rating_details_state_manager.dart'
    as _i63;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i79;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i104;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i132;
import '../module_captain/ui/screen/captain_activity_details_screen.dart'
    as _i200;
import '../module_captain/ui/screen/captain_activity_model.dart' as _i208;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i205;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i206;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i209;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i207;
import '../module_captain/ui/screen/captain_rating_screen.dart' as _i210;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i201;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i146;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i141;
import '../module_captain/ui/screen/captin_rating_details_state.dart' as _i147;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i178;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i156;
import '../module_categories/categories_module.dart' as _i212;
import '../module_categories/manager/categories_manager.dart' as _i67;
import '../module_categories/repository/categories_repository.dart' as _i29;
import '../module_categories/service/store_categories_service.dart' as _i68;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i99;
import '../module_categories/state_manager/packages_state_manager.dart'
    as _i100;
import '../module_categories/ui/screen/categories_screen.dart' as _i149;
import '../module_categories/ui/screen/packages_screen.dart' as _i176;
import '../module_chat/chat_module.dart' as _i213;
import '../module_chat/manager/chat/chat_manager.dart' as _i69;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i30;
import '../module_chat/service/chat/char_service.dart' as _i70;
import '../module_chat/state_manager/chat_state_manager.dart' as _i71;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i150;
import '../module_company/company_module.dart' as _i243;
import '../module_company/manager/company_manager.dart' as _i72;
import '../module_company/repository/company_repository.dart' as _i31;
import '../module_company/service/company_service.dart' as _i73;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i151;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i152;
import '../module_company/ui/screen/company_finance_screen.dart' as _i214;
import '../module_company/ui/screen/company_profile_screen.dart' as _i215;
import '../module_deep_links/repository/deep_link_repository.dart' as _i32;
import '../module_delivary_car/cars_module.dart' as _i211;
import '../module_delivary_car/manager/cars_manager.dart' as _i64;
import '../module_delivary_car/repository/cars_repository.dart' as _i28;
import '../module_delivary_car/service/cars_service.dart' as _i65;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i66;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i148;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i10;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i11;
import '../module_main/main_module.dart' as _i221;
import '../module_main/manager/home_manager.dart' as _i76;
import '../module_main/repository/home_repository.dart' as _i34;
import '../module_main/sceen/home_screen.dart' as _i155;
import '../module_main/sceen/main_screen.dart' as _i160;
import '../module_main/service/home_service.dart' as _i77;
import '../module_main/state_manager/home_state_manager.dart' as _i78;
import '../module_my_notifications/manager/my_notifications_manager.dart'
    as _i81;
import '../module_my_notifications/my_notifications_module.dart' as _i222;
import '../module_my_notifications/repository/my_notifications_repository.dart'
    as _i37;
import '../module_my_notifications/service/my_notification_service.dart'
    as _i82;
import '../module_my_notifications/state_manager/my_notifications_state_manager.dart'
    as _i83;
import '../module_my_notifications/state_manager/update_state_manager.dart'
    as _i125;
import '../module_my_notifications/ui/screen/my_notifications_screen.dart'
    as _i161;
import '../module_my_notifications/ui/screen/update_screen.dart' as _i198;
import '../module_network/http_client/http_client.dart' as _i18;
import '../module_notice/manager/notice_manager.dart' as _i86;
import '../module_notice/notice_module.dart' as _i223;
import '../module_notice/repository/notice_repository.dart' as _i38;
import '../module_notice/service/notice_service.dart' as _i87;
import '../module_notice/state_manager/notice_state_manager.dart' as _i88;
import '../module_notice/ui/screen/notice_screen.dart' as _i164;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i13;
import '../module_notifications/repository/notification_repo.dart' as _i39;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i74;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i9;
import '../module_orders/hive/order_hive_helper.dart' as _i14;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i41;
import '../module_orders/orders_module.dart' as _i228;
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
    as _i96;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i92;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i93;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i97;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i94;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i44;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i46;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i49;
import '../module_orders/ui/screens/new_order/new_order_link.dart' as _i162;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i163;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i124;
import '../module_orders/ui/screens/order_actions_log_screen.dart' as _i165;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i95;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i173;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i168;
import '../module_orders/ui/screens/order_pending_screen.dart' as _i170;
import '../module_orders/ui/screens/orders_captain_screen.dart' as _i166;
import '../module_orders/ui/screens/orders_receive_cash_screen.dart' as _i174;
import '../module_orders/ui/screens/orders_without_distance_screen.dart'
    as _i98;
import '../module_orders/ui/screens/recycle_order/recycle_order_screen.dart'
    as _i105;
import '../module_orders/ui/screens/search_for_order_screen.dart' as _i107;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i114;
import '../module_payments/manager/payments_manager.dart' as _i101;
import '../module_payments/payments_module.dart' as _i229;
import '../module_payments/repository/payments_repository.dart' as _i43;
import '../module_payments/service/payments_service.dart' as _i102;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i135;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i136;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i137;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i103;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i110;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i203;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i202;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i204;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i177;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i180;
import '../module_settings/settings_module.dart' as _i179;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i21;
import '../module_settings/ui/settings_page/settings_page.dart' as _i108;
import '../module_splash/splash_module.dart' as _i109;
import '../module_splash/ui/screen/splash_screen.dart' as _i47;
import '../module_stores/hive/store_hive_helper.dart' as _i15;
import '../module_stores/manager/stores_manager.dart' as _i111;
import '../module_stores/repository/stores_repository.dart' as _i48;
import '../module_stores/service/store_service.dart' as _i112;
import '../module_stores/state_manager/order/filter_orders_top_active_state_manager.dart'
    as _i154;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i167;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i169;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i171;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i172;
import '../module_stores/ui/screen/order/order_top_active_store.dart' as _i175;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i182;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i187;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i188;
import '../module_stores/state_manager/stores_state_manager.dart' as _i113;
import '../module_stores/state_manager/top_active_store.dart' as _i122;
import '../module_stores/stores_module.dart' as _i244;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i224;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i225;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i226;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i227;
import '../module_stores/ui/screen/store_info_screen.dart' as _i230;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i233;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i234;
import '../module_stores/ui/screen/stores_screen.dart' as _i189;
import '../module_stores/ui/screen/top_active_store_screen.dart' as _i123;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i115;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i50;
import '../module_subscriptions/service/subscriptions_service.dart' as _i116;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i153;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i159;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i181;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i183;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i184;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i186;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i191;
import '../module_subscriptions/subscriptions_module.dart' as _i235;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i218;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i216;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i185;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i231;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i232;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i217;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i190;
import '../module_supplier/manager/supplier_manager.dart' as _i53;
import '../module_supplier/repository/supplier_repository.dart' as _i52;
import '../module_supplier/service/supplier_service.dart' as _i120;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i157;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i192;
import '../module_supplier/state_manager/supplier_list.dart' as _i121;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i194;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i195;
import '../module_supplier/supplier_module.dart' as _i245;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i219;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i236;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i196;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i238;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i239;
import '../module_supplier_categories/categories_supplier_module.dart' as _i237;
import '../module_supplier_categories/manager/categories_manager.dart' as _i117;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i51;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i118;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i119;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i193;
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
  gh.factory<_i92.OrderLogsStateManager>(
      () => _i92.OrderLogsStateManager(get<_i42.OrdersService>()));
  gh.factory<_i93.OrderPendingStateManager>(
      () => _i93.OrderPendingStateManager(get<_i42.OrdersService>()));
  gh.factory<_i94.OrderWithoutDistanceStateManager>(
      () => _i94.OrderWithoutDistanceStateManager(get<_i42.OrdersService>()));
  gh.factory<_i95.OrdersCashCaptainScreen>(() =>
      _i95.OrdersCashCaptainScreen(get<_i91.OrderCashCaptainStateManager>()));
  gh.factory<_i96.OrdersCashStoreStateManager>(
      () => _i96.OrdersCashStoreStateManager(get<_i42.OrdersService>()));
  gh.factory<_i97.OrdersReceiveCashStateManager>(
      () => _i97.OrdersReceiveCashStateManager(get<_i42.OrdersService>()));
  gh.factory<_i98.OrdersWithoutDistanceScreen>(() =>
      _i98.OrdersWithoutDistanceScreen(
          get<_i94.OrderWithoutDistanceStateManager>()));
  gh.factory<_i99.PackageCategoriesStateManager>(
      () => _i99.PackageCategoriesStateManager(
            get<_i68.CategoriesService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i100.PackagesStateManager>(() => _i100.PackagesStateManager(
        get<_i68.CategoriesService>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i101.PaymentsManager>(
      () => _i101.PaymentsManager(get<_i43.PaymentsRepository>()));
  gh.factory<_i102.PaymentsService>(
      () => _i102.PaymentsService(get<_i101.PaymentsManager>()));
  gh.factory<_i103.PaymentsToCaptainStateManager>(
      () => _i103.PaymentsToCaptainStateManager(get<_i102.PaymentsService>()));
  gh.factory<_i104.PlanScreenStateManager>(
      () => _i104.PlanScreenStateManager(get<_i102.PaymentsService>()));
  gh.factory<_i105.RecycleOrderScreen>(
      () => _i105.RecycleOrderScreen(get<_i44.RecycleOrderStateManager>()));
  gh.factory<_i106.RegisterScreen>(
      () => _i106.RegisterScreen(get<_i45.RegisterStateManager>()));
  gh.factory<_i107.SearchForOrderScreen>(
      () => _i107.SearchForOrderScreen(get<_i46.SearchForOrderStateManager>()));
  gh.factory<_i108.SettingsScreen>(() => _i108.SettingsScreen(
        get<_i24.AuthService>(),
        get<_i11.LocalizationService>(),
        get<_i19.AppThemeDataService>(),
        get<_i74.FireNotificationService>(),
      ));
  gh.factory<_i109.SplashModule>(
      () => _i109.SplashModule(get<_i47.SplashScreen>()));
  gh.factory<_i110.StoreBalanceStateManager>(
      () => _i110.StoreBalanceStateManager(get<_i102.PaymentsService>()));
  gh.factory<_i111.StoreManager>(
      () => _i111.StoreManager(get<_i48.StoresRepository>()));
  gh.factory<_i112.StoresService>(() => _i112.StoresService(
        get<_i111.StoreManager>(),
        get<_i41.OrdersManager>(),
      ));
  gh.factory<_i113.StoresStateManager>(() => _i113.StoresStateManager(
        get<_i112.StoresService>(),
        get<_i24.AuthService>(),
        get<_i35.ImageUploadService>(),
      ));
  gh.factory<_i114.SubOrdersScreen>(
      () => _i114.SubOrdersScreen(get<_i49.SubOrdersStateManager>()));
  gh.factory<_i115.SubscriptionsManager>(
      () => _i115.SubscriptionsManager(get<_i50.SubscriptionsRepository>()));
  gh.factory<_i116.SubscriptionsService>(
      () => _i116.SubscriptionsService(get<_i115.SubscriptionsManager>()));
  gh.factory<_i117.SupplierCategoriesManager>(() =>
      _i117.SupplierCategoriesManager(
          get<_i51.SupplierCategoriesRepository>()));
  gh.factory<_i118.SupplierCategoriesService>(() =>
      _i118.SupplierCategoriesService(get<_i117.SupplierCategoriesManager>()));
  gh.factory<_i119.SupplierCategoriesStateManager>(
      () => _i119.SupplierCategoriesStateManager(
            get<_i118.SupplierCategoriesService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i120.SupplierService>(
      () => _i120.SupplierService(get<_i53.SuppliersManager>()));
  gh.factory<_i121.SuppliersStateManager>(
      () => _i121.SuppliersStateManager(get<_i120.SupplierService>()));
  gh.factory<_i122.TopActiveStateManagment>(
      () => _i122.TopActiveStateManagment(get<_i112.StoresService>()));
  gh.factory<_i123.TopActiveStoreScreen>(
      () => _i123.TopActiveStoreScreen(get<_i122.TopActiveStateManagment>()));
  gh.factory<_i124.UpdateOrderScreen>(
      () => _i124.UpdateOrderScreen(get<_i54.UpdateOrderStateManager>()));
  gh.factory<_i125.UpdatesStateManager>(() => _i125.UpdatesStateManager(
        get<_i82.MyNotificationsService>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i126.AccountBalanceStateManager>(
      () => _i126.AccountBalanceStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i127.AuthorizationModule>(() => _i127.AuthorizationModule(
        get<_i80.LoginScreen>(),
        get<_i106.RegisterScreen>(),
        get<_i75.ForgotPassScreen>(),
      ));
  gh.factory<_i128.BidOrderDetailsScreen>(
      () => _i128.BidOrderDetailsScreen(get<_i57.BidOrderStateManager>()));
  gh.factory<_i129.BidOrderModule>(
      () => _i129.BidOrderModule(get<_i58.BidOrdersScreen>()));
  gh.factory<_i130.BranchesListService>(
      () => _i130.BranchesListService(get<_i59.BranchesManager>()));
  gh.factory<_i131.BranchesListStateManager>(
      () => _i131.BranchesListStateManager(get<_i130.BranchesListService>()));
  gh.factory<_i132.CaptainAccountBalanceScreen>(() =>
      _i132.CaptainAccountBalanceScreen(
          get<_i126.AccountBalanceStateManager>()));
  gh.factory<_i133.CaptainActivityDetailsStateManager>(() =>
      _i133.CaptainActivityDetailsStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i134.CaptainAssignOrderStateManager>(
      () => _i134.CaptainAssignOrderStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i135.CaptainFinanceByHoursStateManager>(() =>
      _i135.CaptainFinanceByHoursStateManager(get<_i102.PaymentsService>()));
  gh.factory<_i136.CaptainFinanceByOrderCountStateManager>(() =>
      _i136.CaptainFinanceByOrderCountStateManager(
          get<_i102.PaymentsService>()));
  gh.factory<_i137.CaptainFinanceByOrderStateManager>(() =>
      _i137.CaptainFinanceByOrderStateManager(get<_i102.PaymentsService>()));
  gh.factory<_i138.CaptainFinancialDuesDetailsStateManager>(
      () => _i138.CaptainFinancialDuesDetailsStateManager(
            get<_i102.PaymentsService>(),
            get<_i61.CaptainsService>(),
          ));
  gh.factory<_i139.CaptainFinancialDuesStateManager>(() =>
      _i139.CaptainFinancialDuesStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i140.CaptainOfferStateManager>(
      () => _i140.CaptainOfferStateManager(
            get<_i61.CaptainsService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i141.CaptainOffersScreen>(
      () => _i141.CaptainOffersScreen(get<_i140.CaptainOfferStateManager>()));
  gh.factory<_i142.CaptainProfileStateManager>(
      () => _i142.CaptainProfileStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i143.CaptainsActivityStateManager>(
      () => _i143.CaptainsActivityStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i144.CaptainsNeedsSupportStateManager>(() =>
      _i144.CaptainsNeedsSupportStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i145.CaptainsRatingStateManager>(
      () => _i145.CaptainsRatingStateManager(get<_i61.CaptainsService>()));
  gh.factory<_i146.CaptainsScreen>(
      () => _i146.CaptainsScreen(get<_i62.CaptainsStateManager>()));
  gh.factory<_i147.CaptinRatingDetailsScreen>(() =>
      _i147.CaptinRatingDetailsScreen(
          get<_i63.CaptinRatingDetailsStateManager>()));
  gh.factory<_i148.CarsScreen>(
      () => _i148.CarsScreen(get<_i66.CarsStateManager>()));
  gh.factory<_i149.CategoriesScreen>(
      () => _i149.CategoriesScreen(get<_i99.PackageCategoriesStateManager>()));
  gh.factory<_i150.ChatPage>(() => _i150.ChatPage(
        get<_i71.ChatStateManager>(),
        get<_i35.ImageUploadService>(),
        get<_i24.AuthService>(),
        get<_i6.ChatHiveHelper>(),
      ));
  gh.factory<_i151.CompanyFinanceStateManager>(
      () => _i151.CompanyFinanceStateManager(
            get<_i24.AuthService>(),
            get<_i73.CompanyService>(),
          ));
  gh.factory<_i152.CompanyProfileStateManager>(
      () => _i152.CompanyProfileStateManager(
            get<_i24.AuthService>(),
            get<_i73.CompanyService>(),
          ));
  gh.factory<_i153.EditSubscriptionStateManager>(() =>
      _i153.EditSubscriptionStateManager(get<_i116.SubscriptionsService>()));
  gh.factory<_i154.FilterOrderTopStateManager>(
      () => _i154.FilterOrderTopStateManager(get<_i112.StoresService>()));
  gh.factory<_i155.HomeScreen>(
      () => _i155.HomeScreen(get<_i78.HomeStateManager>()));
  gh.factory<_i156.InActiveCaptainsScreen>(() =>
      _i156.InActiveCaptainsScreen(get<_i79.InActiveCaptainsStateManager>()));
  gh.factory<_i157.InActiveSupplierStateManager>(
      () => _i157.InActiveSupplierStateManager(get<_i120.SupplierService>()));
  gh.factory<_i158.InitBranchesStateManager>(
      () => _i158.InitBranchesStateManager(get<_i130.BranchesListService>()));
  gh.factory<_i159.InitSubscriptionStateManager>(() =>
      _i159.InitSubscriptionStateManager(get<_i116.SubscriptionsService>()));
  gh.factory<_i160.MainScreen>(() => _i160.MainScreen(get<_i155.HomeScreen>()));
  gh.factory<_i161.MyNotificationsScreen>(() =>
      _i161.MyNotificationsScreen(get<_i83.MyNotificationsStateManager>()));
  gh.factory<_i162.NewOrderLinkScreen>(
      () => _i162.NewOrderLinkScreen(get<_i84.NewOrderLinkStateManager>()));
  gh.factory<_i163.NewOrderScreen>(
      () => _i163.NewOrderScreen(get<_i85.NewOrderStateManager>()));
  gh.factory<_i164.NoticeScreen>(
      () => _i164.NoticeScreen(get<_i88.NoticeStateManager>()));
  gh.factory<_i165.OrderActionLogsScreen>(() =>
      _i165.OrderActionLogsScreen(get<_i89.OrderActionLogsStateManager>()));
  gh.factory<_i166.OrderCaptainLogsScreen>(() =>
      _i166.OrderCaptainLogsScreen(get<_i90.OrderCaptainLogsStateManager>()));
  gh.factory<_i167.OrderCaptainNotArrivedStateManager>(() =>
      _i167.OrderCaptainNotArrivedStateManager(get<_i112.StoresService>()));
  gh.factory<_i168.OrderLogsScreen>(
      () => _i168.OrderLogsScreen(get<_i92.OrderLogsStateManager>()));
  gh.factory<_i169.OrderLogsStateManager>(
      () => _i169.OrderLogsStateManager(get<_i112.StoresService>()));
  gh.factory<_i170.OrderPendingScreen>(
      () => _i170.OrderPendingScreen(get<_i93.OrderPendingStateManager>()));
  gh.factory<_i171.OrderStatusStateManager>(() => _i171.OrderStatusStateManager(
        get<_i112.StoresService>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i172.OrderTimeLineStateManager>(
      () => _i172.OrderTimeLineStateManager(
            get<_i112.StoresService>(),
            get<_i24.AuthService>(),
          ));
  gh.factory<_i173.OrdersCashStoreScreen>(() =>
      _i173.OrdersCashStoreScreen(get<_i96.OrdersCashStoreStateManager>()));
  gh.factory<_i174.OrdersReceiveCashScreen>(() =>
      _i174.OrdersReceiveCashScreen(get<_i97.OrdersReceiveCashStateManager>()));
  gh.factory<_i175.OrdersTopActiveStoreScreen>(() =>
      _i175.OrdersTopActiveStoreScreen(
          get<_i154.FilterOrderTopStateManager>()));
  gh.factory<_i176.PackagesScreen>(
      () => _i176.PackagesScreen(get<_i100.PackagesStateManager>()));
  gh.factory<_i177.PaymentsToCaptainScreen>(() => _i177.PaymentsToCaptainScreen(
      get<_i103.PaymentsToCaptainStateManager>()));
  gh.factory<_i178.PlanScreen>(
      () => _i178.PlanScreen(get<_i104.PlanScreenStateManager>()));
  gh.factory<_i179.SettingsModule>(() => _i179.SettingsModule(
        get<_i108.SettingsScreen>(),
        get<_i21.ChooseLocalScreen>(),
      ));
  gh.factory<_i180.StoreBalanceScreen>(
      () => _i180.StoreBalanceScreen(get<_i110.StoreBalanceStateManager>()));
  gh.factory<_i181.StoreFinancialSubscriptionsDuesDetailsStateManager>(
      () => _i181.StoreFinancialSubscriptionsDuesDetailsStateManager(
            get<_i102.PaymentsService>(),
            get<_i116.SubscriptionsService>(),
          ));
  gh.factory<_i182.StoreProfileStateManager>(
      () => _i182.StoreProfileStateManager(
            get<_i112.StoresService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i183.StoreSubscriptionManagementStateManager>(() =>
      _i183.StoreSubscriptionManagementStateManager(
          get<_i116.SubscriptionsService>()));
  gh.factory<_i184.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i184.StoreSubscriptionsExpiredFinanceStateManager(
          get<_i116.SubscriptionsService>()));
  gh.factory<_i185.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i185.StoreSubscriptionsFinanceDetailsScreen(
          get<_i181.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i186.StoreSubscriptionsFinanceStateManager>(() =>
      _i186.StoreSubscriptionsFinanceStateManager(
          get<_i116.SubscriptionsService>()));
  gh.factory<_i187.StoresInActiveStateManager>(
      () => _i187.StoresInActiveStateManager(
            get<_i112.StoresService>(),
            get<_i24.AuthService>(),
            get<_i35.ImageUploadService>(),
          ));
  gh.factory<_i188.StoresNeedsSupportStateManager>(
      () => _i188.StoresNeedsSupportStateManager(get<_i112.StoresService>()));
  gh.factory<_i189.StoresScreen>(
      () => _i189.StoresScreen(get<_i113.StoresStateManager>()));
  gh.factory<_i190.SubscriptionManagementScreen>(() =>
      _i190.SubscriptionManagementScreen(
          get<_i183.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i191.SubscriptionToCaptainOfferStateManager>(() =>
      _i191.SubscriptionToCaptainOfferStateManager(
          get<_i116.SubscriptionsService>()));
  gh.factory<_i192.SupplierAdsStateManager>(
      () => _i192.SupplierAdsStateManager(get<_i120.SupplierService>()));
  gh.factory<_i193.SupplierCategoriesScreen>(() =>
      _i193.SupplierCategoriesScreen(
          get<_i119.SupplierCategoriesStateManager>()));
  gh.factory<_i194.SupplierNeedsSupportStateManager>(() =>
      _i194.SupplierNeedsSupportStateManager(get<_i120.SupplierService>()));
  gh.factory<_i195.SupplierProfileStateManager>(
      () => _i195.SupplierProfileStateManager(get<_i120.SupplierService>()));
  gh.factory<_i196.SuppliersScreen>(
      () => _i196.SuppliersScreen(get<_i121.SuppliersStateManager>()));
  gh.factory<_i197.UpdateBranchStateManager>(
      () => _i197.UpdateBranchStateManager(get<_i130.BranchesListService>()));
  gh.factory<_i198.UpdateScreen>(
      () => _i198.UpdateScreen(get<_i125.UpdatesStateManager>()));
  gh.factory<_i199.BranchesListScreen>(
      () => _i199.BranchesListScreen(get<_i131.BranchesListStateManager>()));
  gh.factory<_i200.CaptainActivityDetailsScreen>(() =>
      _i200.CaptainActivityDetailsScreen(
          get<_i133.CaptainActivityDetailsStateManager>()));
  gh.factory<_i201.CaptainAssignOrderScreen>(() =>
      _i201.CaptainAssignOrderScreen(
          get<_i134.CaptainAssignOrderStateManager>()));
  gh.factory<_i202.CaptainFinanceByCountOrderScreen>(() =>
      _i202.CaptainFinanceByCountOrderScreen(
          get<_i136.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i203.CaptainFinanceByHoursScreen>(() =>
      _i203.CaptainFinanceByHoursScreen(
          get<_i135.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i204.CaptainFinanceByOrderScreen>(() =>
      _i204.CaptainFinanceByOrderScreen(
          get<_i137.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i205.CaptainFinancialDuesDetailsScreen>(() =>
      _i205.CaptainFinancialDuesDetailsScreen(
          get<_i138.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i206.CaptainFinancialDuesScreen>(() =>
      _i206.CaptainFinancialDuesScreen(
          get<_i139.CaptainFinancialDuesStateManager>()));
  gh.factory<_i207.CaptainProfileScreen>(() =>
      _i207.CaptainProfileScreen(get<_i142.CaptainProfileStateManager>()));
  gh.factory<_i208.CaptainsActivityScreen>(() =>
      _i208.CaptainsActivityScreen(get<_i143.CaptainsActivityStateManager>()));
  gh.factory<_i209.CaptainsNeedsSupportScreen>(() =>
      _i209.CaptainsNeedsSupportScreen(
          get<_i144.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i210.CaptainsRatingScreen>(() =>
      _i210.CaptainsRatingScreen(get<_i145.CaptainsRatingStateManager>()));
  gh.factory<_i211.CarsModule>(() => _i211.CarsModule(get<_i148.CarsScreen>()));
  gh.factory<_i212.CategoriesModule>(() => _i212.CategoriesModule(
        get<_i149.CategoriesScreen>(),
        get<_i176.PackagesScreen>(),
      ));
  gh.factory<_i213.ChatModule>(() => _i213.ChatModule(
        get<_i150.ChatPage>(),
        get<_i24.AuthService>(),
      ));
  gh.factory<_i214.CompanyFinanceScreen>(() =>
      _i214.CompanyFinanceScreen(get<_i151.CompanyFinanceStateManager>()));
  gh.factory<_i215.CompanyProfileScreen>(() =>
      _i215.CompanyProfileScreen(get<_i152.CompanyProfileStateManager>()));
  gh.factory<_i216.CreateSubscriptionScreen>(() =>
      _i216.CreateSubscriptionScreen(
          get<_i159.InitSubscriptionStateManager>()));
  gh.factory<_i217.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i217.CreateSubscriptionToCaptainOfferScreen(
          get<_i191.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i218.EditSubscriptionScreen>(() =>
      _i218.EditSubscriptionScreen(get<_i153.EditSubscriptionStateManager>()));
  gh.factory<_i219.InActiveSupplierScreen>(() =>
      _i219.InActiveSupplierScreen(get<_i157.InActiveSupplierStateManager>()));
  gh.factory<_i220.InitBranchesScreen>(
      () => _i220.InitBranchesScreen(get<_i158.InitBranchesStateManager>()));
  gh.factory<_i221.MainModule>(() => _i221.MainModule(
        get<_i160.MainScreen>(),
        get<_i155.HomeScreen>(),
      ));
  gh.factory<_i222.MyNotificationsModule>(() => _i222.MyNotificationsModule(
        get<_i161.MyNotificationsScreen>(),
        get<_i198.UpdateScreen>(),
      ));
  gh.factory<_i223.NoticeModule>(
      () => _i223.NoticeModule(get<_i164.NoticeScreen>()));
  gh.factory<_i224.OrderCaptainNotArrivedScreen>(() =>
      _i224.OrderCaptainNotArrivedScreen(
          get<_i167.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i225.OrderDetailsScreen>(
      () => _i225.OrderDetailsScreen(get<_i171.OrderStatusStateManager>()));
  gh.factory<_i226.OrderLogsScreen>(
      () => _i226.OrderLogsScreen(get<_i169.OrderLogsStateManager>()));
  gh.factory<_i227.OrderTimeLineScreen>(
      () => _i227.OrderTimeLineScreen(get<_i172.OrderTimeLineStateManager>()));
  gh.factory<_i228.OrdersModule>(() => _i228.OrdersModule(
        get<_i168.OrderLogsScreen>(),
        get<_i95.OrdersCashCaptainScreen>(),
        get<_i173.OrdersCashStoreScreen>(),
        get<_i124.UpdateOrderScreen>(),
        get<_i170.OrderPendingScreen>(),
        get<_i163.NewOrderScreen>(),
        get<_i166.OrderCaptainLogsScreen>(),
        get<_i165.OrderActionLogsScreen>(),
        get<_i98.OrdersWithoutDistanceScreen>(),
        get<_i174.OrdersReceiveCashScreen>(),
        get<_i114.SubOrdersScreen>(),
        get<_i162.NewOrderLinkScreen>(),
        get<_i107.SearchForOrderScreen>(),
        get<_i105.RecycleOrderScreen>(),
      ));
  gh.factory<_i229.PaymentsModule>(() => _i229.PaymentsModule(
        get<_i202.CaptainFinanceByCountOrderScreen>(),
        get<_i203.CaptainFinanceByHoursScreen>(),
        get<_i204.CaptainFinanceByOrderScreen>(),
        get<_i177.PaymentsToCaptainScreen>(),
        get<_i180.StoreBalanceScreen>(),
      ));
  gh.factory<_i230.StoreInfoScreen>(
      () => _i230.StoreInfoScreen(get<_i182.StoreProfileStateManager>()));
  gh.factory<_i231.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i231.StoreSubscriptionsExpiredFinanceScreen(
          get<_i184.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i232.StoreSubscriptionsFinanceScreen>(() =>
      _i232.StoreSubscriptionsFinanceScreen(
          get<_i186.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i233.StoresInActiveScreen>(() =>
      _i233.StoresInActiveScreen(get<_i187.StoresInActiveStateManager>()));
  gh.factory<_i234.StoresNeedsSupportScreen>(() =>
      _i234.StoresNeedsSupportScreen(
          get<_i188.StoresNeedsSupportStateManager>()));
  gh.factory<_i235.SubscriptionsModule>(() => _i235.SubscriptionsModule(
        get<_i185.StoreSubscriptionsFinanceDetailsScreen>(),
        get<_i232.StoreSubscriptionsFinanceScreen>(),
        get<_i190.SubscriptionManagementScreen>(),
        get<_i231.StoreSubscriptionsExpiredFinanceScreen>(),
        get<_i216.CreateSubscriptionScreen>(),
        get<_i217.CreateSubscriptionToCaptainOfferScreen>(),
        get<_i218.EditSubscriptionScreen>(),
      ));
  gh.factory<_i236.SupplierAdsScreen>(
      () => _i236.SupplierAdsScreen(get<_i192.SupplierAdsStateManager>()));
  gh.factory<_i237.SupplierCategoriesModule>(() =>
      _i237.SupplierCategoriesModule(get<_i193.SupplierCategoriesScreen>()));
  gh.factory<_i238.SupplierNeedsSupportScreen>(() =>
      _i238.SupplierNeedsSupportScreen(
          get<_i194.SupplierNeedsSupportStateManager>()));
  gh.factory<_i239.SupplierProfileScreen>(() =>
      _i239.SupplierProfileScreen(get<_i195.SupplierProfileStateManager>()));
  gh.factory<_i240.UpdateBranchScreen>(
      () => _i240.UpdateBranchScreen(get<_i197.UpdateBranchStateManager>()));
  gh.factory<_i241.BranchesModule>(() => _i241.BranchesModule(
        get<_i199.BranchesListScreen>(),
        get<_i240.UpdateBranchScreen>(),
        get<_i220.InitBranchesScreen>(),
      ));
  gh.factory<_i242.CaptainsModule>(() => _i242.CaptainsModule(
        get<_i141.CaptainOffersScreen>(),
        get<_i156.InActiveCaptainsScreen>(),
        get<_i146.CaptainsScreen>(),
        get<_i207.CaptainProfileScreen>(),
        get<_i209.CaptainsNeedsSupportScreen>(),
        get<_i132.CaptainAccountBalanceScreen>(),
        get<_i205.CaptainFinancialDuesDetailsScreen>(),
        get<_i206.CaptainFinancialDuesScreen>(),
        get<_i178.PlanScreen>(),
        get<_i201.CaptainAssignOrderScreen>(),
        get<_i210.CaptainsRatingScreen>(),
        get<_i147.CaptinRatingDetailsScreen>(),
        get<_i208.CaptainsActivityScreen>(),
        get<_i200.CaptainActivityDetailsScreen>(),
      ));
  gh.factory<_i243.CompanyModule>(() => _i243.CompanyModule(
        get<_i215.CompanyProfileScreen>(),
        get<_i214.CompanyFinanceScreen>(),
      ));
  gh.factory<_i244.StoresModule>(() => _i244.StoresModule(
        get<_i189.StoresScreen>(),
        get<_i230.StoreInfoScreen>(),
        get<_i233.StoresInActiveScreen>(),
        get<_i180.StoreBalanceScreen>(),
        get<_i234.StoresNeedsSupportScreen>(),
        get<_i225.OrderDetailsScreen>(),
        get<_i226.OrderLogsScreen>(),
        get<_i224.OrderCaptainNotArrivedScreen>(),
        get<_i227.OrderTimeLineScreen>(),
        get<_i123.TopActiveStoreScreen>(),
        get<OrdersTopActiveStoreScreen>(),
      ));
  gh.factory<_i245.SupplierModule>(() => _i245.SupplierModule(
        get<_i219.InActiveSupplierScreen>(),
        get<_i196.SuppliersScreen>(),
        get<_i239.SupplierProfileScreen>(),
        get<_i238.SupplierNeedsSupportScreen>(),
        get<_i236.SupplierAdsScreen>(),
      ));
  gh.factory<_i246.MyApp>(() => _i246.MyApp(
        get<_i19.AppThemeDataService>(),
        get<_i11.LocalizationService>(),
        get<_i74.FireNotificationService>(),
        get<_i9.LocalNotificationService>(),
        get<_i109.SplashModule>(),
        get<_i127.AuthorizationModule>(),
        get<_i213.ChatModule>(),
        get<_i179.SettingsModule>(),
        get<_i221.MainModule>(),
        get<_i244.StoresModule>(),
        get<_i212.CategoriesModule>(),
        get<_i243.CompanyModule>(),
        get<_i241.BranchesModule>(),
        get<_i223.NoticeModule>(),
        get<_i242.CaptainsModule>(),
        get<_i229.PaymentsModule>(),
        get<_i237.SupplierCategoriesModule>(),
        get<_i245.SupplierModule>(),
        get<_i211.CarsModule>(),
        get<_i129.BidOrderModule>(),
        get<_i228.OrdersModule>(),
        get<_i235.SubscriptionsModule>(),
        get<_i222.MyNotificationsModule>(),
      ));
  return get;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hive/util/argument_hive_helper.dart' as _i3;
import '../main.dart' as _i237;
import '../module_auth/authoriazation_module.dart' as _i122;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i22;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../module_auth/service/auth_service/auth_service.dart' as _i23;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i32;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i35;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i43;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i73;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i78;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i102;
import '../module_bid_order/bid_order_module.dart' as _i124;
import '../module_bid_order/manager/bid_order_manager.dart' as _i53;
import '../module_bid_order/repository/bid_order_repository.dart' as _i24;
import '../module_bid_order/service/bid_order_service.dart' as _i54;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i55;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i56;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i123;
import '../module_branches/branches_module.dart' as _i232;
import '../module_branches/manager/branches_manager.dart' as _i57;
import '../module_branches/repository/branches_repository.dart' as _i25;
import '../module_branches/service/branches_list_service.dart' as _i125;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i126;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i152;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i190;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i191;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i212;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i231;
import '../module_captain/captains_module.dart' as _i233;
import '../module_captain/hive/captain_hive_helper.dart' as _i5;
import '../module_captain/manager/captains_manager.dart' as _i58;
import '../module_captain/repository/captains_repository.dart' as _i26;
import '../module_captain/service/captains_service.dart' as _i59;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i121;
import '../module_captain/state_manager/captain_activity_details_state_manager.dart'
    as _i128;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i138;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i133;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i134;
import '../module_captain/state_manager/captain_list.dart' as _i60;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i139;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i135;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i129;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i137;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i140;
import '../module_captain/state_manager/captin_rating_details_state_manager.dart'
    as _i61;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i77;
import '../module_captain/state_manager/plan_screen_state_manager.dart'
    as _i100;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i127;
import '../module_captain/ui/screen/captain_activity_details_screen.dart'
    as _i192;
import '../module_captain/ui/screen/captain_activity_model.dart' as _i200;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i197;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i198;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i201;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i199;
import '../module_captain/ui/screen/captain_rating_screen.dart' as _i202;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i193;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i141;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i136;
import '../module_captain/ui/screen/captin_rating_details_state.dart' as _i142;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i171;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i150;
import '../module_categories/categories_module.dart' as _i204;
import '../module_categories/manager/categories_manager.dart' as _i65;
import '../module_categories/repository/categories_repository.dart' as _i28;
import '../module_categories/service/store_categories_service.dart' as _i66;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i95;
import '../module_categories/state_manager/packages_state_manager.dart' as _i96;
import '../module_categories/ui/screen/categories_screen.dart' as _i144;
import '../module_categories/ui/screen/packages_screen.dart' as _i169;
import '../module_chat/chat_module.dart' as _i205;
import '../module_chat/manager/chat/chat_manager.dart' as _i67;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i29;
import '../module_chat/service/chat/char_service.dart' as _i68;
import '../module_chat/state_manager/chat_state_manager.dart' as _i69;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i145;
import '../module_company/company_module.dart' as _i234;
import '../module_company/manager/company_manager.dart' as _i70;
import '../module_company/repository/company_repository.dart' as _i30;
import '../module_company/service/company_service.dart' as _i71;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i146;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i147;
import '../module_company/ui/screen/company_finance_screen.dart' as _i206;
import '../module_company/ui/screen/company_profile_screen.dart' as _i207;
import '../module_deep_links/repository/deep_link_repository.dart' as _i31;
import '../module_delivary_car/cars_module.dart' as _i203;
import '../module_delivary_car/manager/cars_manager.dart' as _i62;
import '../module_delivary_car/repository/cars_repository.dart' as _i27;
import '../module_delivary_car/service/cars_service.dart' as _i63;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i64;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i143;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main/main_module.dart' as _i213;
import '../module_main/manager/home_manager.dart' as _i74;
import '../module_main/repository/home_repository.dart' as _i33;
import '../module_main/sceen/home_screen.dart' as _i149;
import '../module_main/sceen/main_screen.dart' as _i154;
import '../module_main/service/home_service.dart' as _i75;
import '../module_main/state_manager/home_state_manager.dart' as _i76;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notice/manager/notice_manager.dart' as _i81;
import '../module_notice/notice_module.dart' as _i214;
import '../module_notice/repository/notice_repository.dart' as _i36;
import '../module_notice/service/notice_service.dart' as _i82;
import '../module_notice/state_manager/notice_state_manager.dart' as _i83;
import '../module_notice/ui/screen/notice_screen.dart' as _i157;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i37;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i72;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/hive/order_hive_helper.dart' as _i13;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i39;
import '../module_orders/orders_module.dart' as _i219;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i38;
import '../module_orders/service/orders/orders.service.dart' as _i40;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i80;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i79;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i52;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i84;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i85;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i86;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i92;
import '../module_orders/state_manager/order_distance_conflict_state_manager.dart'
    as _i87;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i88;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i89;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i93;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i90;
import '../module_orders/state_manager/recycle_order/recycle_order_state_manager.dart'
    as _i42;
import '../module_orders/state_manager/search_for_order_state_manager.dart'
    as _i44;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i47;
import '../module_orders/ui/screens/new_order/new_order_link.dart' as _i155;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i156;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i120;
import '../module_orders/ui/screens/order_actions_log_screen.dart' as _i158;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i91;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i167;
import '../module_orders/ui/screens/order_conflict_distance_screen.dart'
    as _i161;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i162;
import '../module_orders/ui/screens/order_pending_screen.dart' as _i164;
import '../module_orders/ui/screens/orders_captain_screen.dart' as _i159;
import '../module_orders/ui/screens/orders_receive_cash_screen.dart' as _i168;
import '../module_orders/ui/screens/orders_without_distance_screen.dart'
    as _i94;
import '../module_orders/ui/screens/recycle_order/recycle_order_screen.dart'
    as _i101;
import '../module_orders/ui/screens/search_for_order_screen.dart' as _i103;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i110;
import '../module_payments/manager/payments_manager.dart' as _i97;
import '../module_payments/payments_module.dart' as _i220;
import '../module_payments/repository/payments_repository.dart' as _i41;
import '../module_payments/service/payments_service.dart' as _i98;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i130;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i131;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i132;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i99;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i106;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i195;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i194;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i196;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i170;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i173;
import '../module_settings/settings_module.dart' as _i172;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/settings_page.dart' as _i104;
import '../module_splash/splash_module.dart' as _i105;
import '../module_splash/ui/screen/splash_screen.dart' as _i45;
import '../module_stores/hive/store_hive_helper.dart' as _i14;
import '../module_stores/manager/stores_manager.dart' as _i107;
import '../module_stores/repository/stores_repository.dart' as _i46;
import '../module_stores/service/store_service.dart' as _i108;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i160;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i163;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i165;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i166;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i175;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i180;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i181;
import '../module_stores/state_manager/stores_state_manager.dart' as _i109;
import '../module_stores/state_manager/top_active_store.dart' as _i118;
import '../module_stores/stores_module.dart' as _i235;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i215;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i216;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i217;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i218;
import '../module_stores/ui/screen/store_info_screen.dart' as _i221;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i224;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i225;
import '../module_stores/ui/screen/stores_screen.dart' as _i182;
import '../module_stores/ui/screen/top_active_store_screen.dart' as _i119;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i111;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i48;
import '../module_subscriptions/service/subscriptions_service.dart' as _i112;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i148;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i153;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i174;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i176;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i177;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i179;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i184;
import '../module_subscriptions/subscriptions_module.dart' as _i226;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i210;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i208;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i178;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i222;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i223;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i209;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i183;
import '../module_supplier/manager/supplier_manager.dart' as _i51;
import '../module_supplier/repository/supplier_repository.dart' as _i50;
import '../module_supplier/service/supplier_service.dart' as _i116;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i151;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i185;
import '../module_supplier/state_manager/supplier_list.dart' as _i117;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i187;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i188;
import '../module_supplier/supplier_module.dart' as _i236;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i211;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i227;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i189;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i229;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i230;
import '../module_supplier_categories/categories_supplier_module.dart' as _i228;
import '../module_supplier_categories/manager/categories_manager.dart' as _i113;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i49;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i114;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i115;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i186;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i34;
import '../utils/global/global_state_manager.dart' as _i238;
import '../utils/helpers/firestore_helper.dart' as _i7;
import '../utils/logger/logger.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ArgumentHiveHelper>(() => _i3.ArgumentHiveHelper());
  gh.factory<_i4.AuthPrefsHelper>(() => _i4.AuthPrefsHelper());
  gh.factory<_i5.CaptainsHiveHelper>(() => _i5.CaptainsHiveHelper());
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
  gh.factory<_i14.StoresHiveHelper>(() => _i14.StoresHiveHelper());
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
      _i23.AuthService(get<_i4.AuthPrefsHelper>(), get<_i22.AuthManager>()));
  gh.factory<_i24.BidOrderRepository>(() =>
      _i24.BidOrderRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i25.BranchesRepository>(() =>
      _i25.BranchesRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i26.CaptainsRepository>(() =>
      _i26.CaptainsRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i27.CarsRepository>(() =>
      _i27.CarsRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i28.CategoriesRepository>(() => _i28.CategoriesRepository(
      get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i29.ChatRepository>(() =>
      _i29.ChatRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i30.CompanyRepository>(() =>
      _i30.CompanyRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i31.DeepLinkRepository>(() =>
      _i31.DeepLinkRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i32.ForgotPassStateManager>(
      () => _i32.ForgotPassStateManager(get<_i23.AuthService>()));
  gh.factory<_i33.HomeRepository>(() =>
      _i33.HomeRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i34.ImageUploadService>(
      () => _i34.ImageUploadService(get<_i21.UploadManager>()));
  gh.factory<_i35.LoginStateManager>(
      () => _i35.LoginStateManager(get<_i23.AuthService>()));
  gh.factory<_i36.NoticeRepository>(() =>
      _i36.NoticeRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i37.NotificationRepo>(() =>
      _i37.NotificationRepo(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i38.OrderRepository>(() =>
      _i38.OrderRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i39.OrdersManager>(
      () => _i39.OrdersManager(get<_i38.OrderRepository>()));
  gh.factory<_i40.OrdersService>(
      () => _i40.OrdersService(get<_i39.OrdersManager>()));
  gh.factory<_i41.PaymentsRepository>(() =>
      _i41.PaymentsRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i42.RecycleOrderStateManager>(
      () => _i42.RecycleOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i43.RegisterStateManager>(
      () => _i43.RegisterStateManager(get<_i23.AuthService>()));
  gh.factory<_i44.SearchForOrderStateManager>(
      () => _i44.SearchForOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i45.SplashScreen>(
      () => _i45.SplashScreen(get<_i23.AuthService>()));
  gh.factory<_i46.StoresRepository>(() =>
      _i46.StoresRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i47.SubOrdersStateManager>(() => _i47.SubOrdersStateManager(
      get<_i40.OrdersService>(), get<_i23.AuthService>()));
  gh.factory<_i48.SubscriptionsRepository>(() => _i48.SubscriptionsRepository(
      get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i49.SupplierCategoriesRepository>(() =>
      _i49.SupplierCategoriesRepository(
          get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i50.SupplierRepository>(() =>
      _i50.SupplierRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i51.SuppliersManager>(
      () => _i51.SuppliersManager(get<_i50.SupplierRepository>()));
  gh.factory<_i52.UpdateOrderStateManager>(
      () => _i52.UpdateOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i53.BidOrderManager>(
      () => _i53.BidOrderManager(get<_i24.BidOrderRepository>()));
  gh.factory<_i54.BidOrderService>(
      () => _i54.BidOrderService(get<_i53.BidOrderManager>()));
  gh.factory<_i55.BidOrderStateManager>(
      () => _i55.BidOrderStateManager(get<_i54.BidOrderService>()));
  gh.factory<_i56.BidOrdersScreen>(
      () => _i56.BidOrdersScreen(get<_i55.BidOrderStateManager>()));
  gh.factory<_i57.BranchesManager>(
      () => _i57.BranchesManager(get<_i25.BranchesRepository>()));
  gh.factory<_i58.CaptainsManager>(
      () => _i58.CaptainsManager(get<_i26.CaptainsRepository>()));
  gh.factory<_i59.CaptainsService>(
      () => _i59.CaptainsService(get<_i58.CaptainsManager>()));
  gh.factory<_i60.CaptainsStateManager>(
      () => _i60.CaptainsStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i61.CaptinRatingDetailsStateManager>(
      () => _i61.CaptinRatingDetailsStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i62.CarsManager>(
      () => _i62.CarsManager(get<_i27.CarsRepository>()));
  gh.factory<_i63.CarsService>(() => _i63.CarsService(get<_i62.CarsManager>()));
  gh.factory<_i64.CarsStateManager>(
      () => _i64.CarsStateManager(get<_i63.CarsService>()));
  gh.factory<_i65.CategoriesManager>(
      () => _i65.CategoriesManager(get<_i28.CategoriesRepository>()));
  gh.factory<_i66.CategoriesService>(
      () => _i66.CategoriesService(get<_i65.CategoriesManager>()));
  gh.factory<_i67.ChatManager>(
      () => _i67.ChatManager(get<_i29.ChatRepository>()));
  gh.factory<_i68.ChatService>(() => _i68.ChatService(get<_i67.ChatManager>()));
  gh.factory<_i69.ChatStateManager>(
      () => _i69.ChatStateManager(get<_i68.ChatService>()));
  gh.factory<_i70.CompanyManager>(
      () => _i70.CompanyManager(get<_i30.CompanyRepository>()));
  gh.factory<_i71.CompanyService>(
      () => _i71.CompanyService(get<_i70.CompanyManager>()));
  gh.factory<_i72.FireNotificationService>(() => _i72.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i37.NotificationRepo>()));
  gh.factory<_i73.ForgotPassScreen>(
      () => _i73.ForgotPassScreen(get<_i32.ForgotPassStateManager>()));
  gh.factory<_i74.HomeManager>(
      () => _i74.HomeManager(get<_i33.HomeRepository>()));
  gh.factory<_i75.HomeService>(() => _i75.HomeService(get<_i74.HomeManager>()));
  gh.factory<_i76.HomeStateManager>(
      () => _i76.HomeStateManager(get<_i75.HomeService>()));
  gh.factory<_i77.InActiveCaptainsStateManager>(
      () => _i77.InActiveCaptainsStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i78.LoginScreen>(
      () => _i78.LoginScreen(get<_i35.LoginStateManager>()));
  gh.factory<_i79.NewOrderLinkStateManager>(
      () => _i79.NewOrderLinkStateManager(get<_i40.OrdersService>()));
  gh.factory<_i80.NewOrderStateManager>(
      () => _i80.NewOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i81.NoticeManager>(
      () => _i81.NoticeManager(get<_i36.NoticeRepository>()));
  gh.factory<_i82.NoticeService>(
      () => _i82.NoticeService(get<_i81.NoticeManager>()));
  gh.factory<_i83.NoticeStateManager>(
      () => _i83.NoticeStateManager(get<_i82.NoticeService>()));
  gh.factory<_i84.OrderActionLogsStateManager>(
      () => _i84.OrderActionLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i85.OrderCaptainLogsStateManager>(
      () => _i85.OrderCaptainLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i86.OrderCashCaptainStateManager>(
      () => _i86.OrderCashCaptainStateManager(get<_i40.OrdersService>()));
  gh.factory<_i87.OrderDistanceConflictStateManager>(
      () => _i87.OrderDistanceConflictStateManager(get<_i40.OrdersService>()));
  gh.factory<_i88.OrderLogsStateManager>(
      () => _i88.OrderLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i89.OrderPendingStateManager>(
      () => _i89.OrderPendingStateManager(get<_i40.OrdersService>()));
  gh.factory<_i90.OrderWithoutDistanceStateManager>(
      () => _i90.OrderWithoutDistanceStateManager(get<_i40.OrdersService>()));
  gh.factory<_i91.OrdersCashCaptainScreen>(() =>
      _i91.OrdersCashCaptainScreen(get<_i86.OrderCashCaptainStateManager>()));
  gh.factory<_i92.OrdersCashStoreStateManager>(
      () => _i92.OrdersCashStoreStateManager(get<_i40.OrdersService>()));
  gh.factory<_i93.OrdersReceiveCashStateManager>(
      () => _i93.OrdersReceiveCashStateManager(get<_i40.OrdersService>()));
  gh.factory<_i94.OrdersWithoutDistanceScreen>(() =>
      _i94.OrdersWithoutDistanceScreen(
          get<_i90.OrderWithoutDistanceStateManager>()));
  gh.factory<_i95.PackageCategoriesStateManager>(() =>
      _i95.PackageCategoriesStateManager(
          get<_i66.CategoriesService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i96.PackagesStateManager>(() => _i96.PackagesStateManager(
      get<_i66.CategoriesService>(), get<_i23.AuthService>()));
  gh.factory<_i97.PaymentsManager>(
      () => _i97.PaymentsManager(get<_i41.PaymentsRepository>()));
  gh.factory<_i98.PaymentsService>(
      () => _i98.PaymentsService(get<_i97.PaymentsManager>()));
  gh.factory<_i99.PaymentsToCaptainStateManager>(
      () => _i99.PaymentsToCaptainStateManager(get<_i98.PaymentsService>()));
  gh.factory<_i100.PlanScreenStateManager>(
      () => _i100.PlanScreenStateManager(get<_i98.PaymentsService>()));
  gh.factory<_i101.RecycleOrderScreen>(
      () => _i101.RecycleOrderScreen(get<_i42.RecycleOrderStateManager>()));
  gh.factory<_i102.RegisterScreen>(
      () => _i102.RegisterScreen(get<_i43.RegisterStateManager>()));
  gh.factory<_i103.SearchForOrderScreen>(
      () => _i103.SearchForOrderScreen(get<_i44.SearchForOrderStateManager>()));
  gh.factory<_i104.SettingsScreen>(() => _i104.SettingsScreen(
      get<_i23.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i18.AppThemeDataService>(),
      get<_i72.FireNotificationService>()));
  gh.factory<_i105.SplashModule>(
      () => _i105.SplashModule(get<_i45.SplashScreen>()));
  gh.factory<_i106.StoreBalanceStateManager>(
      () => _i106.StoreBalanceStateManager(get<_i98.PaymentsService>()));
  gh.factory<_i107.StoreManager>(
      () => _i107.StoreManager(get<_i46.StoresRepository>()));
  gh.factory<_i108.StoresService>(() => _i108.StoresService(
      get<_i107.StoreManager>(), get<_i39.OrdersManager>()));
  gh.factory<_i109.StoresStateManager>(() => _i109.StoresStateManager(
      get<_i108.StoresService>(),
      get<_i23.AuthService>(),
      get<_i34.ImageUploadService>()));
  gh.factory<_i110.SubOrdersScreen>(
      () => _i110.SubOrdersScreen(get<_i47.SubOrdersStateManager>()));
  gh.factory<_i111.SubscriptionsManager>(
      () => _i111.SubscriptionsManager(get<_i48.SubscriptionsRepository>()));
  gh.factory<_i112.SubscriptionsService>(
      () => _i112.SubscriptionsService(get<_i111.SubscriptionsManager>()));
  gh.factory<_i113.SupplierCategoriesManager>(() =>
      _i113.SupplierCategoriesManager(
          get<_i49.SupplierCategoriesRepository>()));
  gh.factory<_i114.SupplierCategoriesService>(() =>
      _i114.SupplierCategoriesService(get<_i113.SupplierCategoriesManager>()));
  gh.factory<_i115.SupplierCategoriesStateManager>(() =>
      _i115.SupplierCategoriesStateManager(
          get<_i114.SupplierCategoriesService>(),
          get<_i34.ImageUploadService>()));
  gh.factory<_i116.SupplierService>(
      () => _i116.SupplierService(get<_i51.SuppliersManager>()));
  gh.factory<_i117.SuppliersStateManager>(
      () => _i117.SuppliersStateManager(get<_i116.SupplierService>()));
  gh.factory<_i118.TopActiveStateManagment>(
      () => _i118.TopActiveStateManagment(get<_i108.StoresService>()));
  gh.factory<_i119.TopActiveStoreScreen>(
      () => _i119.TopActiveStoreScreen(get<_i118.TopActiveStateManagment>()));
  gh.factory<_i120.UpdateOrderScreen>(
      () => _i120.UpdateOrderScreen(get<_i52.UpdateOrderStateManager>()));
  gh.factory<_i121.AccountBalanceStateManager>(
      () => _i121.AccountBalanceStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i122.AuthorizationModule>(() => _i122.AuthorizationModule(
      get<_i78.LoginScreen>(),
      get<_i102.RegisterScreen>(),
      get<_i73.ForgotPassScreen>()));
  gh.factory<_i123.BidOrderDetailsScreen>(
      () => _i123.BidOrderDetailsScreen(get<_i55.BidOrderStateManager>()));
  gh.factory<_i124.BidOrderModule>(
      () => _i124.BidOrderModule(get<_i56.BidOrdersScreen>()));
  gh.factory<_i125.BranchesListService>(
      () => _i125.BranchesListService(get<_i57.BranchesManager>()));
  gh.factory<_i126.BranchesListStateManager>(
      () => _i126.BranchesListStateManager(get<_i125.BranchesListService>()));
  gh.factory<_i127.CaptainAccountBalanceScreen>(() =>
      _i127.CaptainAccountBalanceScreen(
          get<_i121.AccountBalanceStateManager>()));
  gh.factory<_i128.CaptainActivityDetailsStateManager>(() =>
      _i128.CaptainActivityDetailsStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i129.CaptainAssignOrderStateManager>(
      () => _i129.CaptainAssignOrderStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i130.CaptainFinanceByHoursStateManager>(() =>
      _i130.CaptainFinanceByHoursStateManager(get<_i98.PaymentsService>()));
  gh.factory<_i131.CaptainFinanceByOrderCountStateManager>(() =>
      _i131.CaptainFinanceByOrderCountStateManager(
          get<_i98.PaymentsService>()));
  gh.factory<_i132.CaptainFinanceByOrderStateManager>(() =>
      _i132.CaptainFinanceByOrderStateManager(get<_i98.PaymentsService>()));
  gh.factory<_i133.CaptainFinancialDuesDetailsStateManager>(() =>
      _i133.CaptainFinancialDuesDetailsStateManager(
          get<_i98.PaymentsService>(), get<_i59.CaptainsService>()));
  gh.factory<_i134.CaptainFinancialDuesStateManager>(() =>
      _i134.CaptainFinancialDuesStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i135.CaptainOfferStateManager>(() =>
      _i135.CaptainOfferStateManager(
          get<_i59.CaptainsService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i136.CaptainOffersScreen>(
      () => _i136.CaptainOffersScreen(get<_i135.CaptainOfferStateManager>()));
  gh.factory<_i137.CaptainProfileStateManager>(
      () => _i137.CaptainProfileStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i138.CaptainsActivityStateManager>(
      () => _i138.CaptainsActivityStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i139.CaptainsNeedsSupportStateManager>(() =>
      _i139.CaptainsNeedsSupportStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i140.CaptainsRatingStateManager>(
      () => _i140.CaptainsRatingStateManager(get<_i59.CaptainsService>()));
  gh.factory<_i141.CaptainsScreen>(
      () => _i141.CaptainsScreen(get<_i60.CaptainsStateManager>()));
  gh.factory<_i142.CaptinRatingDetailsScreen>(() =>
      _i142.CaptinRatingDetailsScreen(
          get<_i61.CaptinRatingDetailsStateManager>()));
  gh.factory<_i143.CarsScreen>(
      () => _i143.CarsScreen(get<_i64.CarsStateManager>()));
  gh.factory<_i144.CategoriesScreen>(
      () => _i144.CategoriesScreen(get<_i95.PackageCategoriesStateManager>()));
  gh.factory<_i145.ChatPage>(() => _i145.ChatPage(
      get<_i69.ChatStateManager>(),
      get<_i34.ImageUploadService>(),
      get<_i23.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i146.CompanyFinanceStateManager>(() =>
      _i146.CompanyFinanceStateManager(
          get<_i23.AuthService>(), get<_i71.CompanyService>()));
  gh.factory<_i147.CompanyProfileStateManager>(() =>
      _i147.CompanyProfileStateManager(
          get<_i23.AuthService>(), get<_i71.CompanyService>()));
  gh.factory<_i148.EditSubscriptionStateManager>(() =>
      _i148.EditSubscriptionStateManager(get<_i112.SubscriptionsService>()));
  gh.factory<_i149.HomeScreen>(
      () => _i149.HomeScreen(get<_i76.HomeStateManager>()));
  gh.factory<_i150.InActiveCaptainsScreen>(() =>
      _i150.InActiveCaptainsScreen(get<_i77.InActiveCaptainsStateManager>()));
  gh.factory<_i151.InActiveSupplierStateManager>(
      () => _i151.InActiveSupplierStateManager(get<_i116.SupplierService>()));
  gh.factory<_i152.InitBranchesStateManager>(
      () => _i152.InitBranchesStateManager(get<_i125.BranchesListService>()));
  gh.factory<_i153.InitSubscriptionStateManager>(() =>
      _i153.InitSubscriptionStateManager(get<_i112.SubscriptionsService>()));
  gh.factory<_i154.MainScreen>(() => _i154.MainScreen(get<_i149.HomeScreen>()));
  gh.factory<_i155.NewOrderLinkScreen>(
      () => _i155.NewOrderLinkScreen(get<_i79.NewOrderLinkStateManager>()));
  gh.factory<_i156.NewOrderScreen>(
      () => _i156.NewOrderScreen(get<_i80.NewOrderStateManager>()));
  gh.factory<_i157.NoticeScreen>(
      () => _i157.NoticeScreen(get<_i83.NoticeStateManager>()));
  gh.factory<_i158.OrderActionLogsScreen>(() =>
      _i158.OrderActionLogsScreen(get<_i84.OrderActionLogsStateManager>()));
  gh.factory<_i159.OrderCaptainLogsScreen>(() =>
      _i159.OrderCaptainLogsScreen(get<_i85.OrderCaptainLogsStateManager>()));
  gh.factory<_i160.OrderCaptainNotArrivedStateManager>(() =>
      _i160.OrderCaptainNotArrivedStateManager(get<_i108.StoresService>()));
  gh.factory<_i161.OrderDistanceConflictScreen>(() =>
      _i161.OrderDistanceConflictScreen(
          get<_i87.OrderDistanceConflictStateManager>()));
  gh.factory<_i162.OrderLogsScreen>(
      () => _i162.OrderLogsScreen(get<_i88.OrderLogsStateManager>()));
  gh.factory<_i163.OrderLogsStateManager>(
      () => _i163.OrderLogsStateManager(get<_i108.StoresService>()));
  gh.factory<_i164.OrderPendingScreen>(
      () => _i164.OrderPendingScreen(get<_i89.OrderPendingStateManager>()));
  gh.factory<_i165.OrderStatusStateManager>(() => _i165.OrderStatusStateManager(
      get<_i108.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i166.OrderTimeLineStateManager>(() =>
      _i166.OrderTimeLineStateManager(
          get<_i108.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i167.OrdersCashStoreScreen>(() =>
      _i167.OrdersCashStoreScreen(get<_i92.OrdersCashStoreStateManager>()));
  gh.factory<_i168.OrdersReceiveCashScreen>(() =>
      _i168.OrdersReceiveCashScreen(get<_i93.OrdersReceiveCashStateManager>()));
  gh.factory<_i169.PackagesScreen>(
      () => _i169.PackagesScreen(get<_i96.PackagesStateManager>()));
  gh.factory<_i170.PaymentsToCaptainScreen>(() =>
      _i170.PaymentsToCaptainScreen(get<_i99.PaymentsToCaptainStateManager>()));
  gh.factory<_i171.PlanScreen>(
      () => _i171.PlanScreen(get<_i100.PlanScreenStateManager>()));
  gh.factory<_i172.SettingsModule>(() => _i172.SettingsModule(
      get<_i104.SettingsScreen>(), get<_i20.ChooseLocalScreen>()));
  gh.factory<_i173.StoreBalanceScreen>(
      () => _i173.StoreBalanceScreen(get<_i106.StoreBalanceStateManager>()));
  gh.factory<_i174.StoreFinancialSubscriptionsDuesDetailsStateManager>(() =>
      _i174.StoreFinancialSubscriptionsDuesDetailsStateManager(
          get<_i98.PaymentsService>(), get<_i112.SubscriptionsService>()));
  gh.factory<_i175.StoreProfileStateManager>(() =>
      _i175.StoreProfileStateManager(
          get<_i108.StoresService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i176.StoreSubscriptionManagementStateManager>(() =>
      _i176.StoreSubscriptionManagementStateManager(
          get<_i112.SubscriptionsService>()));
  gh.factory<_i177.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i177.StoreSubscriptionsExpiredFinanceStateManager(
          get<_i112.SubscriptionsService>()));
  gh.factory<_i178.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i178.StoreSubscriptionsFinanceDetailsScreen(
          get<_i174.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i179.StoreSubscriptionsFinanceStateManager>(() =>
      _i179.StoreSubscriptionsFinanceStateManager(
          get<_i112.SubscriptionsService>()));
  gh.factory<_i180.StoresInActiveStateManager>(() =>
      _i180.StoresInActiveStateManager(get<_i108.StoresService>(),
          get<_i23.AuthService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i181.StoresNeedsSupportStateManager>(
      () => _i181.StoresNeedsSupportStateManager(get<_i108.StoresService>()));
  gh.factory<_i182.StoresScreen>(
      () => _i182.StoresScreen(get<_i109.StoresStateManager>()));
  gh.factory<_i183.SubscriptionManagementScreen>(() =>
      _i183.SubscriptionManagementScreen(
          get<_i176.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i184.SubscriptionToCaptainOfferStateManager>(() =>
      _i184.SubscriptionToCaptainOfferStateManager(
          get<_i112.SubscriptionsService>()));
  gh.factory<_i185.SupplierAdsStateManager>(
      () => _i185.SupplierAdsStateManager(get<_i116.SupplierService>()));
  gh.factory<_i186.SupplierCategoriesScreen>(() =>
      _i186.SupplierCategoriesScreen(
          get<_i115.SupplierCategoriesStateManager>()));
  gh.factory<_i187.SupplierNeedsSupportStateManager>(() =>
      _i187.SupplierNeedsSupportStateManager(get<_i116.SupplierService>()));
  gh.factory<_i188.SupplierProfileStateManager>(
      () => _i188.SupplierProfileStateManager(get<_i116.SupplierService>()));
  gh.factory<_i189.SuppliersScreen>(
      () => _i189.SuppliersScreen(get<_i117.SuppliersStateManager>()));
  gh.factory<_i190.UpdateBranchStateManager>(
      () => _i190.UpdateBranchStateManager(get<_i125.BranchesListService>()));
  gh.factory<_i191.BranchesListScreen>(
      () => _i191.BranchesListScreen(get<_i126.BranchesListStateManager>()));
  gh.factory<_i192.CaptainActivityDetailsScreen>(() =>
      _i192.CaptainActivityDetailsScreen(
          get<_i128.CaptainActivityDetailsStateManager>()));
  gh.factory<_i193.CaptainAssignOrderScreen>(() =>
      _i193.CaptainAssignOrderScreen(
          get<_i129.CaptainAssignOrderStateManager>()));
  gh.factory<_i194.CaptainFinanceByCountOrderScreen>(() =>
      _i194.CaptainFinanceByCountOrderScreen(
          get<_i131.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i195.CaptainFinanceByHoursScreen>(() =>
      _i195.CaptainFinanceByHoursScreen(
          get<_i130.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i196.CaptainFinanceByOrderScreen>(() =>
      _i196.CaptainFinanceByOrderScreen(
          get<_i132.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i197.CaptainFinancialDuesDetailsScreen>(() =>
      _i197.CaptainFinancialDuesDetailsScreen(
          get<_i133.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i198.CaptainFinancialDuesScreen>(() =>
      _i198.CaptainFinancialDuesScreen(
          get<_i134.CaptainFinancialDuesStateManager>()));
  gh.factory<_i199.CaptainProfileScreen>(() =>
      _i199.CaptainProfileScreen(get<_i137.CaptainProfileStateManager>()));
  gh.factory<_i200.CaptainsActivityScreen>(() =>
      _i200.CaptainsActivityScreen(get<_i138.CaptainsActivityStateManager>()));
  gh.factory<_i201.CaptainsNeedsSupportScreen>(() =>
      _i201.CaptainsNeedsSupportScreen(
          get<_i139.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i202.CaptainsRatingScreen>(() =>
      _i202.CaptainsRatingScreen(get<_i140.CaptainsRatingStateManager>()));
  gh.factory<_i203.CarsModule>(() => _i203.CarsModule(get<_i143.CarsScreen>()));
  gh.factory<_i204.CategoriesModule>(() => _i204.CategoriesModule(
      get<_i144.CategoriesScreen>(), get<_i169.PackagesScreen>()));
  gh.factory<_i205.ChatModule>(
      () => _i205.ChatModule(get<_i145.ChatPage>(), get<_i23.AuthService>()));
  gh.factory<_i206.CompanyFinanceScreen>(() =>
      _i206.CompanyFinanceScreen(get<_i146.CompanyFinanceStateManager>()));
  gh.factory<_i207.CompanyProfileScreen>(() =>
      _i207.CompanyProfileScreen(get<_i147.CompanyProfileStateManager>()));
  gh.factory<_i208.CreateSubscriptionScreen>(() =>
      _i208.CreateSubscriptionScreen(
          get<_i153.InitSubscriptionStateManager>()));
  gh.factory<_i209.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i209.CreateSubscriptionToCaptainOfferScreen(
          get<_i184.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i210.EditSubscriptionScreen>(() =>
      _i210.EditSubscriptionScreen(get<_i148.EditSubscriptionStateManager>()));
  gh.factory<_i211.InActiveSupplierScreen>(() =>
      _i211.InActiveSupplierScreen(get<_i151.InActiveSupplierStateManager>()));
  gh.factory<_i212.InitBranchesScreen>(
      () => _i212.InitBranchesScreen(get<_i152.InitBranchesStateManager>()));
  gh.factory<_i213.MainModule>(
      () => _i213.MainModule(get<_i154.MainScreen>(), get<_i149.HomeScreen>()));
  gh.factory<_i214.NoticeModule>(
      () => _i214.NoticeModule(get<_i157.NoticeScreen>()));
  gh.factory<_i215.OrderCaptainNotArrivedScreen>(() =>
      _i215.OrderCaptainNotArrivedScreen(
          get<_i160.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i216.OrderDetailsScreen>(
      () => _i216.OrderDetailsScreen(get<_i165.OrderStatusStateManager>()));
  gh.factory<_i217.OrderLogsScreen>(
      () => _i217.OrderLogsScreen(get<_i163.OrderLogsStateManager>()));
  gh.factory<_i218.OrderTimeLineScreen>(
      () => _i218.OrderTimeLineScreen(get<_i166.OrderTimeLineStateManager>()));
  gh.factory<_i219.OrdersModule>(() => _i219.OrdersModule(
      get<_i162.OrderLogsScreen>(),
      get<_i91.OrdersCashCaptainScreen>(),
      get<_i167.OrdersCashStoreScreen>(),
      get<_i120.UpdateOrderScreen>(),
      get<_i164.OrderPendingScreen>(),
      get<_i156.NewOrderScreen>(),
      get<_i159.OrderCaptainLogsScreen>(),
      get<_i158.OrderActionLogsScreen>(),
      get<_i94.OrdersWithoutDistanceScreen>(),
      get<_i168.OrdersReceiveCashScreen>(),
      get<_i110.SubOrdersScreen>(),
      get<_i155.NewOrderLinkScreen>(),
      get<_i103.SearchForOrderScreen>(),
      get<_i101.RecycleOrderScreen>(),
      get<_i161.OrderDistanceConflictScreen>()));
  gh.factory<_i220.PaymentsModule>(() => _i220.PaymentsModule(
      get<_i194.CaptainFinanceByCountOrderScreen>(),
      get<_i195.CaptainFinanceByHoursScreen>(),
      get<_i196.CaptainFinanceByOrderScreen>(),
      get<_i170.PaymentsToCaptainScreen>(),
      get<_i173.StoreBalanceScreen>()));
  gh.factory<_i221.StoreInfoScreen>(
      () => _i221.StoreInfoScreen(get<_i175.StoreProfileStateManager>()));
  gh.factory<_i222.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i222.StoreSubscriptionsExpiredFinanceScreen(
          get<_i177.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i223.StoreSubscriptionsFinanceScreen>(() =>
      _i223.StoreSubscriptionsFinanceScreen(
          get<_i179.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i224.StoresInActiveScreen>(() =>
      _i224.StoresInActiveScreen(get<_i180.StoresInActiveStateManager>()));
  gh.factory<_i225.StoresNeedsSupportScreen>(() =>
      _i225.StoresNeedsSupportScreen(
          get<_i181.StoresNeedsSupportStateManager>()));
  gh.factory<_i226.SubscriptionsModule>(() => _i226.SubscriptionsModule(
      get<_i178.StoreSubscriptionsFinanceDetailsScreen>(),
      get<_i223.StoreSubscriptionsFinanceScreen>(),
      get<_i183.SubscriptionManagementScreen>(),
      get<_i222.StoreSubscriptionsExpiredFinanceScreen>(),
      get<_i208.CreateSubscriptionScreen>(),
      get<_i209.CreateSubscriptionToCaptainOfferScreen>(),
      get<_i210.EditSubscriptionScreen>()));
  gh.factory<_i227.SupplierAdsScreen>(
      () => _i227.SupplierAdsScreen(get<_i185.SupplierAdsStateManager>()));
  gh.factory<_i228.SupplierCategoriesModule>(() =>
      _i228.SupplierCategoriesModule(get<_i186.SupplierCategoriesScreen>()));
  gh.factory<_i229.SupplierNeedsSupportScreen>(() =>
      _i229.SupplierNeedsSupportScreen(
          get<_i187.SupplierNeedsSupportStateManager>()));
  gh.factory<_i230.SupplierProfileScreen>(() =>
      _i230.SupplierProfileScreen(get<_i188.SupplierProfileStateManager>()));
  gh.factory<_i231.UpdateBranchScreen>(
      () => _i231.UpdateBranchScreen(get<_i190.UpdateBranchStateManager>()));
  gh.factory<_i232.BranchesModule>(() => _i232.BranchesModule(
      get<_i191.BranchesListScreen>(),
      get<_i231.UpdateBranchScreen>(),
      get<_i212.InitBranchesScreen>()));
  gh.factory<_i233.CaptainsModule>(() => _i233.CaptainsModule(
      get<_i136.CaptainOffersScreen>(),
      get<_i150.InActiveCaptainsScreen>(),
      get<_i141.CaptainsScreen>(),
      get<_i199.CaptainProfileScreen>(),
      get<_i201.CaptainsNeedsSupportScreen>(),
      get<_i127.CaptainAccountBalanceScreen>(),
      get<_i197.CaptainFinancialDuesDetailsScreen>(),
      get<_i198.CaptainFinancialDuesScreen>(),
      get<_i171.PlanScreen>(),
      get<_i193.CaptainAssignOrderScreen>(),
      get<_i202.CaptainsRatingScreen>(),
      get<_i142.CaptinRatingDetailsScreen>(),
      get<_i200.CaptainsActivityScreen>(),
      get<_i192.CaptainActivityDetailsScreen>()));
  gh.factory<_i234.CompanyModule>(() => _i234.CompanyModule(
      get<_i207.CompanyProfileScreen>(), get<_i206.CompanyFinanceScreen>()));
  gh.factory<_i235.StoresModule>(() => _i235.StoresModule(
      get<_i182.StoresScreen>(),
      get<_i221.StoreInfoScreen>(),
      get<_i224.StoresInActiveScreen>(),
      get<_i173.StoreBalanceScreen>(),
      get<_i225.StoresNeedsSupportScreen>(),
      get<_i216.OrderDetailsScreen>(),
      get<_i217.OrderLogsScreen>(),
      get<_i215.OrderCaptainNotArrivedScreen>(),
      get<_i218.OrderTimeLineScreen>(),
      get<_i119.TopActiveStoreScreen>()));
  gh.factory<_i236.SupplierModule>(() => _i236.SupplierModule(
      get<_i211.InActiveSupplierScreen>(),
      get<_i189.SuppliersScreen>(),
      get<_i230.SupplierProfileScreen>(),
      get<_i229.SupplierNeedsSupportScreen>(),
      get<_i227.SupplierAdsScreen>()));
  gh.factory<_i237.MyApp>(() => _i237.MyApp(
      get<_i18.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i72.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i105.SplashModule>(),
      get<_i122.AuthorizationModule>(),
      get<_i205.ChatModule>(),
      get<_i172.SettingsModule>(),
      get<_i213.MainModule>(),
      get<_i235.StoresModule>(),
      get<_i204.CategoriesModule>(),
      get<_i234.CompanyModule>(),
      get<_i232.BranchesModule>(),
      get<_i214.NoticeModule>(),
      get<_i233.CaptainsModule>(),
      get<_i220.PaymentsModule>(),
      get<_i228.SupplierCategoriesModule>(),
      get<_i236.SupplierModule>(),
      get<_i203.CarsModule>(),
      get<_i124.BidOrderModule>(),
      get<_i219.OrdersModule>(),
      get<_i226.SubscriptionsModule>()));
  gh.singleton<_i238.GlobalStateManager>(_i238.GlobalStateManager());
  return get;
}

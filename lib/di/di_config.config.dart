// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hive/util/argument_hive_helper.dart' as _i3;
import '../main.dart' as _i225;
import '../module_auth/authoriazation_module.dart' as _i114;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i22;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../module_auth/service/auth_service/auth_service.dart' as _i23;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i32;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i35;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i42;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i70;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i75;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i97;
import '../module_bid_order/bid_order_module.dart' as _i116;
import '../module_bid_order/manager/bid_order_manager.dart' as _i51;
import '../module_bid_order/repository/bid_order_repository.dart' as _i24;
import '../module_bid_order/service/bid_order_service.dart' as _i52;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i53;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i54;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i115;
import '../module_branches/branches_module.dart' as _i220;
import '../module_branches/manager/branches_manager.dart' as _i55;
import '../module_branches/repository/branches_repository.dart' as _i25;
import '../module_branches/service/branches_list_service.dart' as _i117;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i118;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i142;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i179;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i180;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i200;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i219;
import '../module_captain/captains_module.dart' as _i221;
import '../module_captain/hive/captain_hive_helper.dart' as _i5;
import '../module_captain/manager/captains_manager.dart' as _i56;
import '../module_captain/repository/captains_repository.dart' as _i26;
import '../module_captain/service/captains_service.dart' as _i57;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i113;
import '../module_captain/state_manager/captain_activity_state_manager.dart'
    as _i129;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i124;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i125;
import '../module_captain/state_manager/captain_list.dart' as _i58;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i130;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i126;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i120;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i128;
import '../module_captain/state_manager/captain_rating_state_manager.dart'
    as _i131;
import '../module_captain/state_manager/captin_rating_details_state_manager.dart'
    as _i1331;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i74;
import '../module_captain/state_manager/plan_screen_state_manager.dart' as _i96;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i119;
import '../module_captain/ui/screen/captain_activity_model.dart' as _i188;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i185;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i186;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i189;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i187;
import '../module_captain/ui/screen/captain_rating_screen.dart' as _i190;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i181;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i132;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i127;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i160;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i140;
import '../module_categories/categories_module.dart' as _i192;
import '../module_categories/manager/categories_manager.dart' as _i62;
import '../module_categories/repository/categories_repository.dart' as _i28;
import '../module_categories/service/store_categories_service.dart' as _i63;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i91;
import '../module_categories/state_manager/packages_state_manager.dart' as _i92;
import '../module_categories/ui/screen/categories_screen.dart' as _i134;
import '../module_categories/ui/screen/packages_screen.dart' as _i158;
import '../module_chat/chat_module.dart' as _i193;
import '../module_chat/manager/chat/chat_manager.dart' as _i64;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i29;
import '../module_chat/service/chat/char_service.dart' as _i65;
import '../module_chat/state_manager/chat_state_manager.dart' as _i66;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i135;
import '../module_company/company_module.dart' as _i222;
import '../module_company/manager/company_manager.dart' as _i67;
import '../module_company/repository/company_repository.dart' as _i30;
import '../module_company/service/company_service.dart' as _i68;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i136;
import '../module_captain/ui/screen/captin_rating_details_state.dart' as _i1980;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i137;
import '../module_company/ui/screen/company_finance_screen.dart' as _i194;
import '../module_company/ui/screen/company_profile_screen.dart' as _i195;
import '../module_deep_links/repository/deep_link_repository.dart' as _i31;
import '../module_delivary_car/cars_module.dart' as _i191;
import '../module_delivary_car/manager/cars_manager.dart' as _i59;
import '../module_delivary_car/repository/cars_repository.dart' as _i27;
import '../module_delivary_car/service/cars_service.dart' as _i60;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i61;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i133;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main/main_module.dart' as _i201;
import '../module_main/manager/home_manager.dart' as _i71;
import '../module_main/repository/home_repository.dart' as _i33;
import '../module_main/sceen/home_screen.dart' as _i139;
import '../module_main/sceen/main_screen.dart' as _i144;
import '../module_main/service/home_service.dart' as _i72;
import '../module_main/state_manager/home_state_manager.dart' as _i73;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notice/manager/notice_manager.dart' as _i78;
import '../module_notice/notice_module.dart' as _i202;
import '../module_notice/repository/notice_repository.dart' as _i36;
import '../module_notice/service/notice_service.dart' as _i79;
import '../module_notice/state_manager/notice_state_manager.dart' as _i80;
import '../module_notice/ui/screen/notice_screen.dart' as _i147;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i37;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i69;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/hive/order_hive_helper.dart' as _i13;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i39;
import '../module_orders/orders_module.dart' as _i207;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i38;
import '../module_orders/service/orders/orders.service.dart' as _i40;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i77;
import '../module_orders/state_manager/new_order/new_order_link_state_manager.dart'
    as _i76;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i50;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i81;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i82;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i83;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i88;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i84;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i85;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i89;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i86;
import '../module_orders/state_manager/sub_orders_list_state_manager.dart'
    as _i45;
import '../module_orders/ui/screens/new_order/new_order_link.dart' as _i145;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i146;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i112;
import '../module_orders/ui/screens/order_actions_log_screen.dart' as _i148;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i87;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i156;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i151;
import '../module_orders/ui/screens/order_pending_screen.dart' as _i153;
import '../module_orders/ui/screens/orders_captain_screen.dart' as _i149;
import '../module_orders/ui/screens/orders_receive_cash_screen.dart' as _i157;
import '../module_orders/ui/screens/orders_without_distance_screen.dart'
    as _i90;
import '../module_orders/ui/screens/sub_orders_screen.dart' as _i104;
import '../module_payments/manager/payments_manager.dart' as _i93;
import '../module_payments/payments_module.dart' as _i208;
import '../module_payments/repository/payments_repository.dart' as _i41;
import '../module_payments/service/payments_service.dart' as _i94;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i121;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i122;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i123;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i95;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i100;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i183;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i182;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i184;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i159;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i162;
import '../module_settings/settings_module.dart' as _i161;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/settings_page.dart' as _i98;
import '../module_splash/splash_module.dart' as _i99;
import '../module_splash/ui/screen/splash_screen.dart' as _i43;
import '../module_stores/hive/store_hive_helper.dart' as _i14;
import '../module_stores/manager/stores_manager.dart' as _i101;
import '../module_stores/repository/stores_repository.dart' as _i44;
import '../module_stores/service/store_service.dart' as _i102;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i150;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i152;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i154;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i155;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i164;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i169;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i170;
import '../module_stores/state_manager/stores_state_manager.dart' as _i103;
import '../module_stores/stores_module.dart' as _i223;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i203;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i204;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i205;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i206;
import '../module_stores/ui/screen/store_info_screen.dart' as _i209;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i212;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i213;
import '../module_stores/ui/screen/stores_screen.dart' as _i171;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i105;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i46;
import '../module_subscriptions/service/subscriptions_service.dart' as _i106;
import '../module_subscriptions/state_manager/edit_subscription_state_manager.dart'
    as _i138;
import '../module_subscriptions/state_manager/init_subscription_state_manager.dart'
    as _i143;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i163;
import '../module_subscriptions/state_manager/store_subscription_management_state_manager.dart'
    as _i165;
import '../module_subscriptions/state_manager/store_subscriptions_expired_finance_state_manager.dart'
    as _i166;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i168;
import '../module_subscriptions/state_manager/subscription_to_captain_offer_state_manager.dart'
    as _i173;
import '../module_subscriptions/subscriptions_module.dart' as _i214;
import '../module_subscriptions/ui/screen/edit_subscription_screen.dart'
    as _i198;
import '../module_subscriptions/ui/screen/init_subscription_screen.dart'
    as _i196;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i167;
import '../module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart'
    as _i210;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i211;
import '../module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart'
    as _i197;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i172;
import '../module_supplier/manager/supplier_manager.dart' as _i49;
import '../module_supplier/repository/supplier_repository.dart' as _i48;
import '../module_supplier/service/supplier_service.dart' as _i110;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i141;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i174;
import '../module_supplier/state_manager/supplier_list.dart' as _i111;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i176;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i177;
import '../module_supplier/supplier_module.dart' as _i224;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i199;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i215;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i178;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i217;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i218;
import '../module_supplier_categories/categories_supplier_module.dart' as _i216;
import '../module_supplier_categories/manager/categories_manager.dart' as _i107;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i47;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i108;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i109;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i175;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i34;
import '../utils/global/global_state_manager.dart' as _i226;
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
  gh.factory<_i42.RegisterStateManager>(
      () => _i42.RegisterStateManager(get<_i23.AuthService>()));
  gh.factory<_i43.SplashScreen>(
      () => _i43.SplashScreen(get<_i23.AuthService>()));
  gh.factory<_i44.StoresRepository>(() =>
      _i44.StoresRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i45.SubOrdersStateManager>(() => _i45.SubOrdersStateManager(
      get<_i40.OrdersService>(), get<_i23.AuthService>()));
  gh.factory<_i46.SubscriptionsRepository>(() => _i46.SubscriptionsRepository(
      get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i47.SupplierCategoriesRepository>(() =>
      _i47.SupplierCategoriesRepository(
          get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i48.SupplierRepository>(() =>
      _i48.SupplierRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i49.SuppliersManager>(
      () => _i49.SuppliersManager(get<_i48.SupplierRepository>()));
  gh.factory<_i50.UpdateOrderStateManager>(
      () => _i50.UpdateOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i51.BidOrderManager>(
      () => _i51.BidOrderManager(get<_i24.BidOrderRepository>()));
  gh.factory<_i52.BidOrderService>(
      () => _i52.BidOrderService(get<_i51.BidOrderManager>()));
  gh.factory<_i53.BidOrderStateManager>(
      () => _i53.BidOrderStateManager(get<_i52.BidOrderService>()));
  gh.factory<_i54.BidOrdersScreen>(
      () => _i54.BidOrdersScreen(get<_i53.BidOrderStateManager>()));
  gh.factory<_i55.BranchesManager>(
      () => _i55.BranchesManager(get<_i25.BranchesRepository>()));
  gh.factory<_i56.CaptainsManager>(
      () => _i56.CaptainsManager(get<_i26.CaptainsRepository>()));
  gh.factory<_i57.CaptainsService>(
      () => _i57.CaptainsService(get<_i56.CaptainsManager>()));
  gh.factory<_i58.CaptainsStateManager>(
      () => _i58.CaptainsStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i59.CarsManager>(
      () => _i59.CarsManager(get<_i27.CarsRepository>()));
  gh.factory<_i60.CarsService>(() => _i60.CarsService(get<_i59.CarsManager>()));
  gh.factory<_i61.CarsStateManager>(
      () => _i61.CarsStateManager(get<_i60.CarsService>()));
  gh.factory<_i62.CategoriesManager>(
      () => _i62.CategoriesManager(get<_i28.CategoriesRepository>()));
  gh.factory<_i63.CategoriesService>(
      () => _i63.CategoriesService(get<_i62.CategoriesManager>()));
  gh.factory<_i64.ChatManager>(
      () => _i64.ChatManager(get<_i29.ChatRepository>()));
  gh.factory<_i65.ChatService>(() => _i65.ChatService(get<_i64.ChatManager>()));
  gh.factory<_i66.ChatStateManager>(
      () => _i66.ChatStateManager(get<_i65.ChatService>()));
  gh.factory<_i67.CompanyManager>(
      () => _i67.CompanyManager(get<_i30.CompanyRepository>()));
  gh.factory<_i68.CompanyService>(
      () => _i68.CompanyService(get<_i67.CompanyManager>()));
  gh.factory<_i69.FireNotificationService>(() => _i69.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i37.NotificationRepo>()));
  gh.factory<_i70.ForgotPassScreen>(
      () => _i70.ForgotPassScreen(get<_i32.ForgotPassStateManager>()));
  gh.factory<_i71.HomeManager>(
      () => _i71.HomeManager(get<_i33.HomeRepository>()));
  gh.factory<_i72.HomeService>(() => _i72.HomeService(get<_i71.HomeManager>()));
  gh.factory<_i73.HomeStateManager>(
      () => _i73.HomeStateManager(get<_i72.HomeService>()));
  gh.factory<_i74.InActiveCaptainsStateManager>(
      () => _i74.InActiveCaptainsStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i75.LoginScreen>(
      () => _i75.LoginScreen(get<_i35.LoginStateManager>()));
  gh.factory<_i76.NewOrderLinkStateManager>(
      () => _i76.NewOrderLinkStateManager(get<_i40.OrdersService>()));
  gh.factory<_i77.NewOrderStateManager>(
      () => _i77.NewOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i78.NoticeManager>(
      () => _i78.NoticeManager(get<_i36.NoticeRepository>()));
  gh.factory<_i79.NoticeService>(
      () => _i79.NoticeService(get<_i78.NoticeManager>()));
  gh.factory<_i80.NoticeStateManager>(
      () => _i80.NoticeStateManager(get<_i79.NoticeService>()));
  gh.factory<_i81.OrderActionLogsStateManager>(
      () => _i81.OrderActionLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i82.OrderCaptainLogsStateManager>(
      () => _i82.OrderCaptainLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i83.OrderCashCaptainStateManager>(
      () => _i83.OrderCashCaptainStateManager(get<_i40.OrdersService>()));
  gh.factory<_i84.OrderLogsStateManager>(
      () => _i84.OrderLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i85.OrderPendingStateManager>(
      () => _i85.OrderPendingStateManager(get<_i40.OrdersService>()));
  gh.factory<_i86.OrderWithoutDistanceStateManager>(
      () => _i86.OrderWithoutDistanceStateManager(get<_i40.OrdersService>()));
  gh.factory<_i87.OrdersCashCaptainScreen>(() =>
      _i87.OrdersCashCaptainScreen(get<_i83.OrderCashCaptainStateManager>()));
  gh.factory<_i88.OrdersCashStoreStateManager>(
      () => _i88.OrdersCashStoreStateManager(get<_i40.OrdersService>()));
  gh.factory<_i89.OrdersReceiveCashStateManager>(
      () => _i89.OrdersReceiveCashStateManager(get<_i40.OrdersService>()));
  gh.factory<_i90.OrdersWithoutDistanceScreen>(() =>
      _i90.OrdersWithoutDistanceScreen(
          get<_i86.OrderWithoutDistanceStateManager>()));
  gh.factory<_i91.PackageCategoriesStateManager>(() =>
      _i91.PackageCategoriesStateManager(
          get<_i63.CategoriesService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i92.PackagesStateManager>(() => _i92.PackagesStateManager(
      get<_i63.CategoriesService>(), get<_i23.AuthService>()));
  gh.factory<_i93.PaymentsManager>(
      () => _i93.PaymentsManager(get<_i41.PaymentsRepository>()));
  gh.factory<_i94.PaymentsService>(
      () => _i94.PaymentsService(get<_i93.PaymentsManager>()));
  gh.factory<_i95.PaymentsToCaptainStateManager>(
      () => _i95.PaymentsToCaptainStateManager(get<_i94.PaymentsService>()));
  gh.factory<_i96.PlanScreenStateManager>(
      () => _i96.PlanScreenStateManager(get<_i94.PaymentsService>()));
  gh.factory<_i97.RegisterScreen>(
      () => _i97.RegisterScreen(get<_i42.RegisterStateManager>()));
  gh.factory<_i98.SettingsScreen>(() => _i98.SettingsScreen(
      get<_i23.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i18.AppThemeDataService>(),
      get<_i69.FireNotificationService>()));
  gh.factory<_i99.SplashModule>(
      () => _i99.SplashModule(get<_i43.SplashScreen>()));
  gh.factory<_i100.StoreBalanceStateManager>(
      () => _i100.StoreBalanceStateManager(get<_i94.PaymentsService>()));
  gh.factory<_i101.StoreManager>(
      () => _i101.StoreManager(get<_i44.StoresRepository>()));
  gh.factory<_i102.StoresService>(() => _i102.StoresService(
      get<_i101.StoreManager>(), get<_i39.OrdersManager>()));
  gh.factory<_i103.StoresStateManager>(() => _i103.StoresStateManager(
      get<_i102.StoresService>(),
      get<_i23.AuthService>(),
      get<_i34.ImageUploadService>()));
  gh.factory<_i104.SubOrdersScreen>(
      () => _i104.SubOrdersScreen(get<_i45.SubOrdersStateManager>()));
  gh.factory<_i105.SubscriptionsManager>(
      () => _i105.SubscriptionsManager(get<_i46.SubscriptionsRepository>()));
  gh.factory<_i106.SubscriptionsService>(
      () => _i106.SubscriptionsService(get<_i105.SubscriptionsManager>()));
  gh.factory<_i107.SupplierCategoriesManager>(() =>
      _i107.SupplierCategoriesManager(
          get<_i47.SupplierCategoriesRepository>()));
  gh.factory<_i108.SupplierCategoriesService>(() =>
      _i108.SupplierCategoriesService(get<_i107.SupplierCategoriesManager>()));
  gh.factory<_i109.SupplierCategoriesStateManager>(() =>
      _i109.SupplierCategoriesStateManager(
          get<_i108.SupplierCategoriesService>(),
          get<_i34.ImageUploadService>()));
  gh.factory<_i110.SupplierService>(
      () => _i110.SupplierService(get<_i49.SuppliersManager>()));
  gh.factory<_i111.SuppliersStateManager>(
      () => _i111.SuppliersStateManager(get<_i110.SupplierService>()));
  gh.factory<_i112.UpdateOrderScreen>(
      () => _i112.UpdateOrderScreen(get<_i50.UpdateOrderStateManager>()));
  gh.factory<_i113.AccountBalanceStateManager>(
      () => _i113.AccountBalanceStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i114.AuthorizationModule>(() => _i114.AuthorizationModule(
      get<_i75.LoginScreen>(),
      get<_i97.RegisterScreen>(),
      get<_i70.ForgotPassScreen>()));
  gh.factory<_i115.BidOrderDetailsScreen>(
      () => _i115.BidOrderDetailsScreen(get<_i53.BidOrderStateManager>()));
  gh.factory<_i116.BidOrderModule>(
      () => _i116.BidOrderModule(get<_i54.BidOrdersScreen>()));
  gh.factory<_i117.BranchesListService>(
      () => _i117.BranchesListService(get<_i55.BranchesManager>()));
  gh.factory<_i118.BranchesListStateManager>(
      () => _i118.BranchesListStateManager(get<_i117.BranchesListService>()));
  gh.factory<_i119.CaptainAccountBalanceScreen>(() =>
      _i119.CaptainAccountBalanceScreen(
          get<_i113.AccountBalanceStateManager>()));
  gh.factory<_i120.CaptainAssignOrderStateManager>(
      () => _i120.CaptainAssignOrderStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i121.CaptainFinanceByHoursStateManager>(() =>
      _i121.CaptainFinanceByHoursStateManager(get<_i94.PaymentsService>()));
  gh.factory<_i122.CaptainFinanceByOrderCountStateManager>(() =>
      _i122.CaptainFinanceByOrderCountStateManager(
          get<_i94.PaymentsService>()));
  gh.factory<_i123.CaptainFinanceByOrderStateManager>(() =>
      _i123.CaptainFinanceByOrderStateManager(get<_i94.PaymentsService>()));
  gh.factory<_i124.CaptainFinancialDuesDetailsStateManager>(() =>
      _i124.CaptainFinancialDuesDetailsStateManager(
          get<_i94.PaymentsService>(), get<_i57.CaptainsService>()));
  gh.factory<_i125.CaptainFinancialDuesStateManager>(() =>
      _i125.CaptainFinancialDuesStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i126.CaptainOfferStateManager>(() =>
      _i126.CaptainOfferStateManager(
          get<_i57.CaptainsService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i127.CaptainOffersScreen>(
      () => _i127.CaptainOffersScreen(get<_i126.CaptainOfferStateManager>()));
  gh.factory<_i128.CaptainProfileStateManager>(
      () => _i128.CaptainProfileStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i129.CaptainsActivityStateManager>(
      () => _i129.CaptainsActivityStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i130.CaptainsNeedsSupportStateManager>(() =>
      _i130.CaptainsNeedsSupportStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i131.CaptainsRatingStateManager>(
      () => _i131.CaptainsRatingStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i1331.CaptinRatingDetailsStateManager>(() =>
      _i1331.CaptinRatingDetailsStateManager(get<_i57.CaptainsService>()));
  gh.factory<_i132.CaptainsScreen>(
      () => _i132.CaptainsScreen(get<_i58.CaptainsStateManager>()));
  gh.factory<_i133.CarsScreen>(
      () => _i133.CarsScreen(get<_i61.CarsStateManager>()));
  gh.factory<_i134.CategoriesScreen>(
      () => _i134.CategoriesScreen(get<_i91.PackageCategoriesStateManager>()));
  gh.factory<_i135.ChatPage>(() => _i135.ChatPage(
      get<_i66.ChatStateManager>(),
      get<_i34.ImageUploadService>(),
      get<_i23.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i136.CompanyFinanceStateManager>(() =>
      _i136.CompanyFinanceStateManager(
          get<_i23.AuthService>(), get<_i68.CompanyService>()));
  gh.factory<_i137.CompanyProfileStateManager>(() =>
      _i137.CompanyProfileStateManager(
          get<_i23.AuthService>(), get<_i68.CompanyService>()));
  gh.factory<_i138.EditSubscriptionStateManager>(() =>
      _i138.EditSubscriptionStateManager(get<_i106.SubscriptionsService>()));
  gh.factory<_i139.HomeScreen>(
      () => _i139.HomeScreen(get<_i73.HomeStateManager>()));
  gh.factory<_i140.InActiveCaptainsScreen>(() =>
      _i140.InActiveCaptainsScreen(get<_i74.InActiveCaptainsStateManager>()));
  gh.factory<_i141.InActiveSupplierStateManager>(
      () => _i141.InActiveSupplierStateManager(get<_i110.SupplierService>()));
  gh.factory<_i142.InitBranchesStateManager>(
      () => _i142.InitBranchesStateManager(get<_i117.BranchesListService>()));
  gh.factory<_i143.InitSubscriptionStateManager>(() =>
      _i143.InitSubscriptionStateManager(get<_i106.SubscriptionsService>()));
  gh.factory<_i144.MainScreen>(() => _i144.MainScreen(get<_i139.HomeScreen>()));
  gh.factory<_i145.NewOrderLinkScreen>(
      () => _i145.NewOrderLinkScreen(get<_i76.NewOrderLinkStateManager>()));
  gh.factory<_i146.NewOrderScreen>(
      () => _i146.NewOrderScreen(get<_i77.NewOrderStateManager>()));
  gh.factory<_i147.NoticeScreen>(
      () => _i147.NoticeScreen(get<_i80.NoticeStateManager>()));
  gh.factory<_i148.OrderActionLogsScreen>(() =>
      _i148.OrderActionLogsScreen(get<_i81.OrderActionLogsStateManager>()));
  gh.factory<_i149.OrderCaptainLogsScreen>(() =>
      _i149.OrderCaptainLogsScreen(get<_i82.OrderCaptainLogsStateManager>()));
  gh.factory<_i150.OrderCaptainNotArrivedStateManager>(() =>
      _i150.OrderCaptainNotArrivedStateManager(get<_i102.StoresService>()));
  gh.factory<_i151.OrderLogsScreen>(
      () => _i151.OrderLogsScreen(get<_i84.OrderLogsStateManager>()));
  gh.factory<_i152.OrderLogsStateManager>(
      () => _i152.OrderLogsStateManager(get<_i102.StoresService>()));
  gh.factory<_i153.OrderPendingScreen>(
      () => _i153.OrderPendingScreen(get<_i85.OrderPendingStateManager>()));
  gh.factory<_i154.OrderStatusStateManager>(() => _i154.OrderStatusStateManager(
      get<_i102.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i155.OrderTimeLineStateManager>(() =>
      _i155.OrderTimeLineStateManager(
          get<_i102.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i156.OrdersCashStoreScreen>(() =>
      _i156.OrdersCashStoreScreen(get<_i88.OrdersCashStoreStateManager>()));
  gh.factory<_i157.OrdersReceiveCashScreen>(() =>
      _i157.OrdersReceiveCashScreen(get<_i89.OrdersReceiveCashStateManager>()));
  gh.factory<_i158.PackagesScreen>(
      () => _i158.PackagesScreen(get<_i92.PackagesStateManager>()));
  gh.factory<_i159.PaymentsToCaptainScreen>(() =>
      _i159.PaymentsToCaptainScreen(get<_i95.PaymentsToCaptainStateManager>()));
  gh.factory<_i160.PlanScreen>(
      () => _i160.PlanScreen(get<_i96.PlanScreenStateManager>()));
  gh.factory<_i161.SettingsModule>(() => _i161.SettingsModule(
      get<_i98.SettingsScreen>(), get<_i20.ChooseLocalScreen>()));
  gh.factory<_i162.StoreBalanceScreen>(
      () => _i162.StoreBalanceScreen(get<_i100.StoreBalanceStateManager>()));
  gh.factory<_i163.StoreFinancialSubscriptionsDuesDetailsStateManager>(() =>
      _i163.StoreFinancialSubscriptionsDuesDetailsStateManager(
          get<_i94.PaymentsService>(), get<_i106.SubscriptionsService>()));
  gh.factory<_i164.StoreProfileStateManager>(() =>
      _i164.StoreProfileStateManager(
          get<_i102.StoresService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i165.StoreSubscriptionManagementStateManager>(() =>
      _i165.StoreSubscriptionManagementStateManager(
          get<_i106.SubscriptionsService>()));
  gh.factory<_i166.StoreSubscriptionsExpiredFinanceStateManager>(() =>
      _i166.StoreSubscriptionsExpiredFinanceStateManager(
          get<_i106.SubscriptionsService>()));
  gh.factory<_i167.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i167.StoreSubscriptionsFinanceDetailsScreen(
          get<_i163.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i168.StoreSubscriptionsFinanceStateManager>(() =>
      _i168.StoreSubscriptionsFinanceStateManager(
          get<_i106.SubscriptionsService>()));
  gh.factory<_i169.StoresInActiveStateManager>(() =>
      _i169.StoresInActiveStateManager(get<_i102.StoresService>(),
          get<_i23.AuthService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i170.StoresNeedsSupportStateManager>(
      () => _i170.StoresNeedsSupportStateManager(get<_i102.StoresService>()));
  gh.factory<_i171.StoresScreen>(
      () => _i171.StoresScreen(get<_i103.StoresStateManager>()));
  gh.factory<_i172.SubscriptionManagementScreen>(() =>
      _i172.SubscriptionManagementScreen(
          get<_i165.StoreSubscriptionManagementStateManager>()));
  gh.factory<_i173.SubscriptionToCaptainOfferStateManager>(() =>
      _i173.SubscriptionToCaptainOfferStateManager(
          get<_i106.SubscriptionsService>()));
  gh.factory<_i174.SupplierAdsStateManager>(
      () => _i174.SupplierAdsStateManager(get<_i110.SupplierService>()));
  gh.factory<_i175.SupplierCategoriesScreen>(() =>
      _i175.SupplierCategoriesScreen(
          get<_i109.SupplierCategoriesStateManager>()));
  gh.factory<_i176.SupplierNeedsSupportStateManager>(() =>
      _i176.SupplierNeedsSupportStateManager(get<_i110.SupplierService>()));
  gh.factory<_i177.SupplierProfileStateManager>(
      () => _i177.SupplierProfileStateManager(get<_i110.SupplierService>()));
  gh.factory<_i178.SuppliersScreen>(
      () => _i178.SuppliersScreen(get<_i111.SuppliersStateManager>()));
  gh.factory<_i179.UpdateBranchStateManager>(
      () => _i179.UpdateBranchStateManager(get<_i117.BranchesListService>()));
  gh.factory<_i180.BranchesListScreen>(
      () => _i180.BranchesListScreen(get<_i118.BranchesListStateManager>()));
  gh.factory<_i181.CaptainAssignOrderScreen>(() =>
      _i181.CaptainAssignOrderScreen(
          get<_i120.CaptainAssignOrderStateManager>()));
  gh.factory<_i182.CaptainFinanceByCountOrderScreen>(() =>
      _i182.CaptainFinanceByCountOrderScreen(
          get<_i122.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i183.CaptainFinanceByHoursScreen>(() =>
      _i183.CaptainFinanceByHoursScreen(
          get<_i121.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i184.CaptainFinanceByOrderScreen>(() =>
      _i184.CaptainFinanceByOrderScreen(
          get<_i123.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i185.CaptainFinancialDuesDetailsScreen>(() =>
      _i185.CaptainFinancialDuesDetailsScreen(
          get<_i124.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i186.CaptainFinancialDuesScreen>(() =>
      _i186.CaptainFinancialDuesScreen(
          get<_i125.CaptainFinancialDuesStateManager>()));
  gh.factory<_i187.CaptainProfileScreen>(() =>
      _i187.CaptainProfileScreen(get<_i128.CaptainProfileStateManager>()));
  gh.factory<_i188.CaptainsActivityScreen>(() =>
      _i188.CaptainsActivityScreen(get<_i129.CaptainsActivityStateManager>()));
  gh.factory<_i189.CaptainsNeedsSupportScreen>(() =>
      _i189.CaptainsNeedsSupportScreen(
          get<_i130.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i190.CaptainsRatingScreen>(() =>
      _i190.CaptainsRatingScreen(get<_i131.CaptainsRatingStateManager>()));
  gh.factory<_i1980.CaptinRatingDetailsScreen>(() =>
      _i1980.CaptinRatingDetailsScreen(
          get<_i1331.CaptinRatingDetailsStateManager>()));
  gh.factory<_i191.CarsModule>(() => _i191.CarsModule(get<_i133.CarsScreen>()));
  gh.factory<_i192.CategoriesModule>(() => _i192.CategoriesModule(
      get<_i134.CategoriesScreen>(), get<_i158.PackagesScreen>()));
  gh.factory<_i193.ChatModule>(
      () => _i193.ChatModule(get<_i135.ChatPage>(), get<_i23.AuthService>()));
  gh.factory<_i194.CompanyFinanceScreen>(() =>
      _i194.CompanyFinanceScreen(get<_i136.CompanyFinanceStateManager>()));
  gh.factory<_i195.CompanyProfileScreen>(() =>
      _i195.CompanyProfileScreen(get<_i137.CompanyProfileStateManager>()));
  gh.factory<_i196.CreateSubscriptionScreen>(() =>
      _i196.CreateSubscriptionScreen(
          get<_i143.InitSubscriptionStateManager>()));
  gh.factory<_i197.CreateSubscriptionToCaptainOfferScreen>(() =>
      _i197.CreateSubscriptionToCaptainOfferScreen(
          get<_i173.SubscriptionToCaptainOfferStateManager>()));
  gh.factory<_i198.EditSubscriptionScreen>(() =>
      _i198.EditSubscriptionScreen(get<_i138.EditSubscriptionStateManager>()));
  gh.factory<_i199.InActiveSupplierScreen>(() =>
      _i199.InActiveSupplierScreen(get<_i141.InActiveSupplierStateManager>()));
  gh.factory<_i200.InitBranchesScreen>(
      () => _i200.InitBranchesScreen(get<_i142.InitBranchesStateManager>()));
  gh.factory<_i201.MainModule>(
      () => _i201.MainModule(get<_i144.MainScreen>(), get<_i139.HomeScreen>()));
  gh.factory<_i202.NoticeModule>(
      () => _i202.NoticeModule(get<_i147.NoticeScreen>()));
  gh.factory<_i203.OrderCaptainNotArrivedScreen>(() =>
      _i203.OrderCaptainNotArrivedScreen(
          get<_i150.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i204.OrderDetailsScreen>(
      () => _i204.OrderDetailsScreen(get<_i154.OrderStatusStateManager>()));
  gh.factory<_i205.OrderLogsScreen>(
      () => _i205.OrderLogsScreen(get<_i152.OrderLogsStateManager>()));
  gh.factory<_i206.OrderTimeLineScreen>(
      () => _i206.OrderTimeLineScreen(get<_i155.OrderTimeLineStateManager>()));
  gh.factory<_i207.OrdersModule>(() => _i207.OrdersModule(
      get<_i151.OrderLogsScreen>(),
      get<_i87.OrdersCashCaptainScreen>(),
      get<_i156.OrdersCashStoreScreen>(),
      get<_i112.UpdateOrderScreen>(),
      get<_i153.OrderPendingScreen>(),
      get<_i146.NewOrderScreen>(),
      get<_i149.OrderCaptainLogsScreen>(),
      get<_i148.OrderActionLogsScreen>(),
      get<_i90.OrdersWithoutDistanceScreen>(),
      get<_i157.OrdersReceiveCashScreen>(),
      get<_i104.SubOrdersScreen>(),
      get<_i145.NewOrderLinkScreen>()));
  gh.factory<_i208.PaymentsModule>(() => _i208.PaymentsModule(
      get<_i182.CaptainFinanceByCountOrderScreen>(),
      get<_i183.CaptainFinanceByHoursScreen>(),
      get<_i184.CaptainFinanceByOrderScreen>(),
      get<_i159.PaymentsToCaptainScreen>(),
      get<_i162.StoreBalanceScreen>()));
  gh.factory<_i209.StoreInfoScreen>(
      () => _i209.StoreInfoScreen(get<_i164.StoreProfileStateManager>()));
  gh.factory<_i210.StoreSubscriptionsExpiredFinanceScreen>(() =>
      _i210.StoreSubscriptionsExpiredFinanceScreen(
          get<_i166.StoreSubscriptionsExpiredFinanceStateManager>()));
  gh.factory<_i211.StoreSubscriptionsFinanceScreen>(() =>
      _i211.StoreSubscriptionsFinanceScreen(
          get<_i168.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i212.StoresInActiveScreen>(() =>
      _i212.StoresInActiveScreen(get<_i169.StoresInActiveStateManager>()));
  gh.factory<_i213.StoresNeedsSupportScreen>(() =>
      _i213.StoresNeedsSupportScreen(
          get<_i170.StoresNeedsSupportStateManager>()));
  gh.factory<_i214.SubscriptionsModule>(() => _i214.SubscriptionsModule(
      get<_i167.StoreSubscriptionsFinanceDetailsScreen>(),
      get<_i211.StoreSubscriptionsFinanceScreen>(),
      get<_i172.SubscriptionManagementScreen>(),
      get<_i210.StoreSubscriptionsExpiredFinanceScreen>(),
      get<_i196.CreateSubscriptionScreen>(),
      get<_i197.CreateSubscriptionToCaptainOfferScreen>(),
      get<_i198.EditSubscriptionScreen>()));
  gh.factory<_i215.SupplierAdsScreen>(
      () => _i215.SupplierAdsScreen(get<_i174.SupplierAdsStateManager>()));
  gh.factory<_i216.SupplierCategoriesModule>(() =>
      _i216.SupplierCategoriesModule(get<_i175.SupplierCategoriesScreen>()));
  gh.factory<_i217.SupplierNeedsSupportScreen>(() =>
      _i217.SupplierNeedsSupportScreen(
          get<_i176.SupplierNeedsSupportStateManager>()));
  gh.factory<_i218.SupplierProfileScreen>(() =>
      _i218.SupplierProfileScreen(get<_i177.SupplierProfileStateManager>()));
  gh.factory<_i219.UpdateBranchScreen>(
      () => _i219.UpdateBranchScreen(get<_i179.UpdateBranchStateManager>()));
  gh.factory<_i220.BranchesModule>(() => _i220.BranchesModule(
      get<_i180.BranchesListScreen>(),
      get<_i219.UpdateBranchScreen>(),
      get<_i200.InitBranchesScreen>()));
  gh.factory<_i221.CaptainsModule>(
    () => _i221.CaptainsModule(
      get<_i127.CaptainOffersScreen>(),
      get<_i140.InActiveCaptainsScreen>(),
      get<_i132.CaptainsScreen>(),
      get<_i187.CaptainProfileScreen>(),
      get<_i189.CaptainsNeedsSupportScreen>(),
      get<_i119.CaptainAccountBalanceScreen>(),
      get<_i185.CaptainFinancialDuesDetailsScreen>(),
      get<_i186.CaptainFinancialDuesScreen>(),
      get<_i160.PlanScreen>(),
      get<_i181.CaptainAssignOrderScreen>(),
      get<_i190.CaptainsRatingScreen>(),
      get<_i1980.CaptinRatingDetailsScreen>(),
      get<_i188.CaptainsActivityScreen>(),
    ),
  );
  gh.factory<_i222.CompanyModule>(() => _i222.CompanyModule(
      get<_i195.CompanyProfileScreen>(), get<_i194.CompanyFinanceScreen>()));
  gh.factory<_i223.StoresModule>(() => _i223.StoresModule(
      get<_i171.StoresScreen>(),
      get<_i209.StoreInfoScreen>(),
      get<_i212.StoresInActiveScreen>(),
      get<_i162.StoreBalanceScreen>(),
      get<_i213.StoresNeedsSupportScreen>(),
      get<_i204.OrderDetailsScreen>(),
      get<_i205.OrderLogsScreen>(),
      get<_i203.OrderCaptainNotArrivedScreen>(),
      get<_i206.OrderTimeLineScreen>()));
  gh.factory<_i224.SupplierModule>(() => _i224.SupplierModule(
      get<_i199.InActiveSupplierScreen>(),
      get<_i178.SuppliersScreen>(),
      get<_i218.SupplierProfileScreen>(),
      get<_i217.SupplierNeedsSupportScreen>(),
      get<_i215.SupplierAdsScreen>()));
  gh.factory<_i225.MyApp>(() => _i225.MyApp(
      get<_i18.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i69.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i99.SplashModule>(),
      get<_i114.AuthorizationModule>(),
      get<_i193.ChatModule>(),
      get<_i161.SettingsModule>(),
      get<_i201.MainModule>(),
      get<_i223.StoresModule>(),
      get<_i192.CategoriesModule>(),
      get<_i222.CompanyModule>(),
      get<_i220.BranchesModule>(),
      get<_i202.NoticeModule>(),
      get<_i221.CaptainsModule>(),
      get<_i208.PaymentsModule>(),
      get<_i216.SupplierCategoriesModule>(),
      get<_i224.SupplierModule>(),
      get<_i191.CarsModule>(),
      get<_i116.BidOrderModule>(),
      get<_i207.OrdersModule>(),
      get<_i214.SubscriptionsModule>()));
  gh.singleton<_i226.GlobalStateManager>(_i226.GlobalStateManager());
  return get;
}

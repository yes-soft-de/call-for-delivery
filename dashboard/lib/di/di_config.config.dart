// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hive/util/argument_hive_helper.dart' as _i3;
import '../main.dart' as _i209;
import '../module_auth/authoriazation_module.dart' as _i112;
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
    as _i69;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i74;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i95;
import '../module_bid_order/bid_order_module.dart' as _i114;
import '../module_bid_order/manager/bid_order_manager.dart' as _i50;
import '../module_bid_order/repository/bid_order_repository.dart' as _i24;
import '../module_bid_order/service/bid_order_service.dart' as _i51;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i52;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i53;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i113;
import '../module_branches/branches_module.dart' as _i204;
import '../module_branches/manager/branches_manager.dart' as _i54;
import '../module_branches/repository/branches_repository.dart' as _i25;
import '../module_branches/service/branches_list_service.dart' as _i115;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i116;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i137;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i168;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i169;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i184;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i203;
import '../module_captain/captains_module.dart' as _i205;
import '../module_captain/hive/captain_hive_helper.dart' as _i5;
import '../module_captain/manager/captains_manager.dart' as _i55;
import '../module_captain/repository/captains_repository.dart' as _i26;
import '../module_captain/service/captains_service.dart' as _i56;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i111;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i122;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i123;
import '../module_captain/state_manager/captain_list.dart' as _i57;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i127;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i124;
import '../module_captain/state_manager/captain_order_assign_state_manager.dart'
    as _i118;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i126;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i73;
import '../module_captain/state_manager/plan_screen_state_manager.dart' as _i94;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i117;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i174;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i175;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i177;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i176;
import '../module_captain/ui/screen/captains_assign_order_screen.dart' as _i170;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i128;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i125;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i153;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i135;
import '../module_categories/categories_module.dart' as _i179;
import '../module_categories/manager/categories_manager.dart' as _i61;
import '../module_categories/repository/categories_repository.dart' as _i28;
import '../module_categories/service/store_categories_service.dart' as _i62;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i89;
import '../module_categories/state_manager/packages_state_manager.dart' as _i90;
import '../module_categories/ui/screen/categories_screen.dart' as _i130;
import '../module_categories/ui/screen/packages_screen.dart' as _i151;
import '../module_chat/chat_module.dart' as _i180;
import '../module_chat/manager/chat/chat_manager.dart' as _i63;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i29;
import '../module_chat/service/chat/char_service.dart' as _i64;
import '../module_chat/state_manager/chat_state_manager.dart' as _i65;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i131;
import '../module_company/company_module.dart' as _i206;
import '../module_company/manager/company_manager.dart' as _i66;
import '../module_company/repository/company_repository.dart' as _i30;
import '../module_company/service/company_service.dart' as _i67;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i132;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i133;
import '../module_company/ui/screen/company_finance_screen.dart' as _i181;
import '../module_company/ui/screen/company_profile_screen.dart' as _i182;
import '../module_deep_links/repository/deep_link_repository.dart' as _i31;
import '../module_delivary_car/cars_module.dart' as _i178;
import '../module_delivary_car/manager/cars_manager.dart' as _i58;
import '../module_delivary_car/repository/cars_repository.dart' as _i27;
import '../module_delivary_car/service/cars_service.dart' as _i59;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i60;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i129;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main/main_module.dart' as _i185;
import '../module_main/manager/home_manager.dart' as _i70;
import '../module_main/repository/home_repository.dart' as _i33;
import '../module_main/sceen/home_screen.dart' as _i134;
import '../module_main/sceen/main_screen.dart' as _i138;
import '../module_main/service/home_service.dart' as _i71;
import '../module_main/state_manager/home_state_manager.dart' as _i72;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notice/manager/notice_manager.dart' as _i76;
import '../module_notice/notice_module.dart' as _i186;
import '../module_notice/repository/notice_repository.dart' as _i36;
import '../module_notice/service/notice_service.dart' as _i77;
import '../module_notice/state_manager/notice_state_manager.dart' as _i78;
import '../module_notice/ui/screen/notice_screen.dart' as _i140;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i37;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i68;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/hive/order_hive_helper.dart' as _i13;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i39;
import '../module_orders/orders_module.dart' as _i191;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i38;
import '../module_orders/service/orders/orders.service.dart' as _i40;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i75;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i49;
import '../module_orders/state_manager/order_action_logs_state_manager.dart'
    as _i79;
import '../module_orders/state_manager/order_captain_logs_state_manager.dart'
    as _i80;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i81;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i86;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i82;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i83;
import '../module_orders/state_manager/orders_recieve_cash_state_manager.dart'
    as _i87;
import '../module_orders/state_manager/orders_without_distance_state_manager.dart'
    as _i84;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i139;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i110;
import '../module_orders/ui/screens/order_actions_log_screen.dart' as _i141;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i85;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i149;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i144;
import '../module_orders/ui/screens/order_pending_screen.dart' as _i146;
import '../module_orders/ui/screens/orders_captain_screen.dart' as _i142;
import '../module_orders/ui/screens/orders_receive_cash_screen.dart' as _i150;
import '../module_orders/ui/screens/orders_without_distance_screen.dart'
    as _i88;
import '../module_payments/manager/payments_manager.dart' as _i91;
import '../module_payments/payments_module.dart' as _i192;
import '../module_payments/repository/payments_repository.dart' as _i41;
import '../module_payments/service/payments_service.dart' as _i92;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i119;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i120;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i121;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i93;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i98;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i172;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i171;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i173;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i152;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i155;
import '../module_settings/settings_module.dart' as _i154;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/settings_page.dart' as _i96;
import '../module_splash/splash_module.dart' as _i97;
import '../module_splash/ui/screen/splash_screen.dart' as _i43;
import '../module_stores/hive/store_hive_helper.dart' as _i14;
import '../module_stores/manager/stores_manager.dart' as _i99;
import '../module_stores/repository/stores_repository.dart' as _i44;
import '../module_stores/service/store_service.dart' as _i100;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i143;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i145;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i147;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i148;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i157;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i160;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i161;
import '../module_stores/state_manager/stores_state_manager.dart' as _i101;
import '../module_stores/stores_module.dart' as _i207;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i187;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i188;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i189;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i190;
import '../module_stores/ui/screen/store_info_screen.dart' as _i193;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i195;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i196;
import '../module_stores/ui/screen/stores_screen.dart' as _i162;
import '../module_subscriptions/manager/subscriptions_manager.dart' as _i102;
import '../module_subscriptions/repository/subscriptions_repository.dart'
    as _i45;
import '../module_subscriptions/service/store_service.dart' as _i104;
import '../module_subscriptions/service/subscriptions_service.dart' as _i103;
import '../module_subscriptions/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i156;
import '../module_subscriptions/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i159;
import '../module_subscriptions/subscriptions_module.dart' as _i197;
import '../module_subscriptions/ui/screen/store_subscriptions_details_screen.dart'
    as _i158;
import '../module_subscriptions/ui/screen/store_subscriptions_screen.dart'
    as _i194;
import '../module_subscriptions/ui/screen/subscriptions_managment_screen.dart'
    as _i198;
import '../module_supplier/manager/supplier_manager.dart' as _i48;
import '../module_supplier/repository/supplier_repository.dart' as _i47;
import '../module_supplier/service/supplier_service.dart' as _i108;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i136;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i163;
import '../module_supplier/state_manager/supplier_list.dart' as _i109;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i165;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i166;
import '../module_supplier/supplier_module.dart' as _i208;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i183;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i199;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i167;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i201;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i202;
import '../module_supplier_categories/categories_supplier_module.dart' as _i200;
import '../module_supplier_categories/manager/categories_manager.dart' as _i105;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i46;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i106;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i107;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i164;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i34;
import '../utils/global/global_state_manager.dart' as _i210;
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
  gh.factory<_i45.SubscriptionsRepository>(() => _i45.SubscriptionsRepository(
      get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i46.SupplierCategoriesRepository>(() =>
      _i46.SupplierCategoriesRepository(
          get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i47.SupplierRepository>(() =>
      _i47.SupplierRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i48.SuppliersManager>(
      () => _i48.SuppliersManager(get<_i47.SupplierRepository>()));
  gh.factory<_i49.UpdateOrderStateManager>(
      () => _i49.UpdateOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i50.BidOrderManager>(
      () => _i50.BidOrderManager(get<_i24.BidOrderRepository>()));
  gh.factory<_i51.BidOrderService>(
      () => _i51.BidOrderService(get<_i50.BidOrderManager>()));
  gh.factory<_i52.BidOrderStateManager>(
      () => _i52.BidOrderStateManager(get<_i51.BidOrderService>()));
  gh.factory<_i53.BidOrdersScreen>(
      () => _i53.BidOrdersScreen(get<_i52.BidOrderStateManager>()));
  gh.factory<_i54.BranchesManager>(
      () => _i54.BranchesManager(get<_i25.BranchesRepository>()));
  gh.factory<_i55.CaptainsManager>(
      () => _i55.CaptainsManager(get<_i26.CaptainsRepository>()));
  gh.factory<_i56.CaptainsService>(
      () => _i56.CaptainsService(get<_i55.CaptainsManager>()));
  gh.factory<_i57.CaptainsStateManager>(
      () => _i57.CaptainsStateManager(get<_i56.CaptainsService>()));
  gh.factory<_i58.CarsManager>(
      () => _i58.CarsManager(get<_i27.CarsRepository>()));
  gh.factory<_i59.CarsService>(() => _i59.CarsService(get<_i58.CarsManager>()));
  gh.factory<_i60.CarsStateManager>(
      () => _i60.CarsStateManager(get<_i59.CarsService>()));
  gh.factory<_i61.CategoriesManager>(
      () => _i61.CategoriesManager(get<_i28.CategoriesRepository>()));
  gh.factory<_i62.CategoriesService>(
      () => _i62.CategoriesService(get<_i61.CategoriesManager>()));
  gh.factory<_i63.ChatManager>(
      () => _i63.ChatManager(get<_i29.ChatRepository>()));
  gh.factory<_i64.ChatService>(() => _i64.ChatService(get<_i63.ChatManager>()));
  gh.factory<_i65.ChatStateManager>(
      () => _i65.ChatStateManager(get<_i64.ChatService>()));
  gh.factory<_i66.CompanyManager>(
      () => _i66.CompanyManager(get<_i30.CompanyRepository>()));
  gh.factory<_i67.CompanyService>(
      () => _i67.CompanyService(get<_i66.CompanyManager>()));
  gh.factory<_i68.FireNotificationService>(() => _i68.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i37.NotificationRepo>()));
  gh.factory<_i69.ForgotPassScreen>(
      () => _i69.ForgotPassScreen(get<_i32.ForgotPassStateManager>()));
  gh.factory<_i70.HomeManager>(
      () => _i70.HomeManager(get<_i33.HomeRepository>()));
  gh.factory<_i71.HomeService>(() => _i71.HomeService(get<_i70.HomeManager>()));
  gh.factory<_i72.HomeStateManager>(
      () => _i72.HomeStateManager(get<_i71.HomeService>()));
  gh.factory<_i73.InActiveCaptainsStateManager>(
      () => _i73.InActiveCaptainsStateManager(get<_i56.CaptainsService>()));
  gh.factory<_i74.LoginScreen>(
      () => _i74.LoginScreen(get<_i35.LoginStateManager>()));
  gh.factory<_i75.NewOrderStateManager>(
      () => _i75.NewOrderStateManager(get<_i40.OrdersService>()));
  gh.factory<_i76.NoticeManager>(
      () => _i76.NoticeManager(get<_i36.NoticeRepository>()));
  gh.factory<_i77.NoticeService>(
      () => _i77.NoticeService(get<_i76.NoticeManager>()));
  gh.factory<_i78.NoticeStateManager>(
      () => _i78.NoticeStateManager(get<_i77.NoticeService>()));
  gh.factory<_i79.OrderActionLogsStateManager>(
      () => _i79.OrderActionLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i80.OrderCaptainLogsStateManager>(
      () => _i80.OrderCaptainLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i81.OrderCashCaptainStateManager>(
      () => _i81.OrderCashCaptainStateManager(get<_i40.OrdersService>()));
  gh.factory<_i82.OrderLogsStateManager>(
      () => _i82.OrderLogsStateManager(get<_i40.OrdersService>()));
  gh.factory<_i83.OrderPendingStateManager>(
      () => _i83.OrderPendingStateManager(get<_i40.OrdersService>()));
  gh.factory<_i84.OrderWithoutDistanceStateManager>(
      () => _i84.OrderWithoutDistanceStateManager(get<_i40.OrdersService>()));
  gh.factory<_i85.OrdersCashCaptainScreen>(() =>
      _i85.OrdersCashCaptainScreen(get<_i81.OrderCashCaptainStateManager>()));
  gh.factory<_i86.OrdersCashStoreStateManager>(
      () => _i86.OrdersCashStoreStateManager(get<_i40.OrdersService>()));
  gh.factory<_i87.OrdersReceiveCashStateManager>(
      () => _i87.OrdersReceiveCashStateManager(get<_i40.OrdersService>()));
  gh.factory<_i88.OrdersWithoutDistanceScreen>(() =>
      _i88.OrdersWithoutDistanceScreen(
          get<_i84.OrderWithoutDistanceStateManager>()));
  gh.factory<_i89.PackageCategoriesStateManager>(() =>
      _i89.PackageCategoriesStateManager(
          get<_i62.CategoriesService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i90.PackagesStateManager>(() => _i90.PackagesStateManager(
      get<_i62.CategoriesService>(), get<_i23.AuthService>()));
  gh.factory<_i91.PaymentsManager>(
      () => _i91.PaymentsManager(get<_i41.PaymentsRepository>()));
  gh.factory<_i92.PaymentsService>(
      () => _i92.PaymentsService(get<_i91.PaymentsManager>()));
  gh.factory<_i93.PaymentsToCaptainStateManager>(
      () => _i93.PaymentsToCaptainStateManager(get<_i92.PaymentsService>()));
  gh.factory<_i94.PlanScreenStateManager>(
      () => _i94.PlanScreenStateManager(get<_i92.PaymentsService>()));
  gh.factory<_i95.RegisterScreen>(
      () => _i95.RegisterScreen(get<_i42.RegisterStateManager>()));
  gh.factory<_i96.SettingsScreen>(() => _i96.SettingsScreen(
      get<_i23.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i18.AppThemeDataService>(),
      get<_i68.FireNotificationService>()));
  gh.factory<_i97.SplashModule>(
      () => _i97.SplashModule(get<_i43.SplashScreen>()));
  gh.factory<_i98.StoreBalanceStateManager>(
      () => _i98.StoreBalanceStateManager(get<_i92.PaymentsService>()));
  gh.factory<_i99.StoreManager>(
      () => _i99.StoreManager(get<_i44.StoresRepository>()));
  gh.factory<_i100.StoresService>(
      () => _i100.StoresService(get<_i99.StoreManager>()));
  gh.factory<_i101.StoresStateManager>(() => _i101.StoresStateManager(
      get<_i100.StoresService>(),
      get<_i23.AuthService>(),
      get<_i34.ImageUploadService>()));
  gh.factory<_i102.SubscriptionsManager>(
      () => _i102.SubscriptionsManager(get<_i45.SubscriptionsRepository>()));
  gh.factory<_i103.SubscriptionsService>(
      () => _i103.SubscriptionsService(get<_i102.SubscriptionsManager>()));
  gh.factory<_i104.SubscriptionsService>(
      () => _i104.SubscriptionsService(get<_i102.SubscriptionsManager>()));
  gh.factory<_i105.SupplierCategoriesManager>(() =>
      _i105.SupplierCategoriesManager(
          get<_i46.SupplierCategoriesRepository>()));
  gh.factory<_i106.SupplierCategoriesService>(() =>
      _i106.SupplierCategoriesService(get<_i105.SupplierCategoriesManager>()));
  gh.factory<_i107.SupplierCategoriesStateManager>(() =>
      _i107.SupplierCategoriesStateManager(
          get<_i106.SupplierCategoriesService>(),
          get<_i34.ImageUploadService>()));
  gh.factory<_i108.SupplierService>(
      () => _i108.SupplierService(get<_i48.SuppliersManager>()));
  gh.factory<_i109.SuppliersStateManager>(
      () => _i109.SuppliersStateManager(get<_i108.SupplierService>()));
  gh.factory<_i110.UpdateOrderScreen>(
      () => _i110.UpdateOrderScreen(get<_i49.UpdateOrderStateManager>()));
  gh.factory<_i111.AccountBalanceStateManager>(
      () => _i111.AccountBalanceStateManager(get<_i56.CaptainsService>()));
  gh.factory<_i112.AuthorizationModule>(() => _i112.AuthorizationModule(
      get<_i74.LoginScreen>(),
      get<_i95.RegisterScreen>(),
      get<_i69.ForgotPassScreen>()));
  gh.factory<_i113.BidOrderDetailsScreen>(
      () => _i113.BidOrderDetailsScreen(get<_i52.BidOrderStateManager>()));
  gh.factory<_i114.BidOrderModule>(
      () => _i114.BidOrderModule(get<_i53.BidOrdersScreen>()));
  gh.factory<_i115.BranchesListService>(
      () => _i115.BranchesListService(get<_i54.BranchesManager>()));
  gh.factory<_i116.BranchesListStateManager>(
      () => _i116.BranchesListStateManager(get<_i115.BranchesListService>()));
  gh.factory<_i117.CaptainAccountBalanceScreen>(() =>
      _i117.CaptainAccountBalanceScreen(
          get<_i111.AccountBalanceStateManager>()));
  gh.factory<_i118.CaptainAssignOrderStateManager>(
      () => _i118.CaptainAssignOrderStateManager(get<_i56.CaptainsService>()));
  gh.factory<_i119.CaptainFinanceByHoursStateManager>(() =>
      _i119.CaptainFinanceByHoursStateManager(get<_i92.PaymentsService>()));
  gh.factory<_i120.CaptainFinanceByOrderCountStateManager>(() =>
      _i120.CaptainFinanceByOrderCountStateManager(
          get<_i92.PaymentsService>()));
  gh.factory<_i121.CaptainFinanceByOrderStateManager>(() =>
      _i121.CaptainFinanceByOrderStateManager(get<_i92.PaymentsService>()));
  gh.factory<_i122.CaptainFinancialDuesDetailsStateManager>(() =>
      _i122.CaptainFinancialDuesDetailsStateManager(
          get<_i92.PaymentsService>(), get<_i56.CaptainsService>()));
  gh.factory<_i123.CaptainFinancialDuesStateManager>(() =>
      _i123.CaptainFinancialDuesStateManager(get<_i56.CaptainsService>()));
  gh.factory<_i124.CaptainOfferStateManager>(() =>
      _i124.CaptainOfferStateManager(
          get<_i56.CaptainsService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i125.CaptainOffersScreen>(
      () => _i125.CaptainOffersScreen(get<_i124.CaptainOfferStateManager>()));
  gh.factory<_i126.CaptainProfileStateManager>(
      () => _i126.CaptainProfileStateManager(get<_i56.CaptainsService>()));
  gh.factory<_i127.CaptainsNeedsSupportStateManager>(() =>
      _i127.CaptainsNeedsSupportStateManager(get<_i56.CaptainsService>()));
  gh.factory<_i128.CaptainsScreen>(
      () => _i128.CaptainsScreen(get<_i57.CaptainsStateManager>()));
  gh.factory<_i129.CarsScreen>(
      () => _i129.CarsScreen(get<_i60.CarsStateManager>()));
  gh.factory<_i130.CategoriesScreen>(
      () => _i130.CategoriesScreen(get<_i89.PackageCategoriesStateManager>()));
  gh.factory<_i131.ChatPage>(() => _i131.ChatPage(
      get<_i65.ChatStateManager>(),
      get<_i34.ImageUploadService>(),
      get<_i23.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i132.CompanyFinanceStateManager>(() =>
      _i132.CompanyFinanceStateManager(
          get<_i23.AuthService>(), get<_i67.CompanyService>()));
  gh.factory<_i133.CompanyProfileStateManager>(() =>
      _i133.CompanyProfileStateManager(
          get<_i23.AuthService>(), get<_i67.CompanyService>()));
  gh.factory<_i134.HomeScreen>(
      () => _i134.HomeScreen(get<_i72.HomeStateManager>()));
  gh.factory<_i135.InActiveCaptainsScreen>(() =>
      _i135.InActiveCaptainsScreen(get<_i73.InActiveCaptainsStateManager>()));
  gh.factory<_i136.InActiveSupplierStateManager>(
      () => _i136.InActiveSupplierStateManager(get<_i108.SupplierService>()));
  gh.factory<_i137.InitBranchesStateManager>(
      () => _i137.InitBranchesStateManager(get<_i115.BranchesListService>()));
  gh.factory<_i138.MainScreen>(() => _i138.MainScreen(get<_i134.HomeScreen>()));
  gh.factory<_i139.NewOrderScreen>(
      () => _i139.NewOrderScreen(get<_i75.NewOrderStateManager>()));
  gh.factory<_i140.NoticeScreen>(
      () => _i140.NoticeScreen(get<_i78.NoticeStateManager>()));
  gh.factory<_i141.OrderActionLogsScreen>(() =>
      _i141.OrderActionLogsScreen(get<_i79.OrderActionLogsStateManager>()));
  gh.factory<_i142.OrderCaptainLogsScreen>(() =>
      _i142.OrderCaptainLogsScreen(get<_i80.OrderCaptainLogsStateManager>()));
  gh.factory<_i143.OrderCaptainNotArrivedStateManager>(() =>
      _i143.OrderCaptainNotArrivedStateManager(get<_i100.StoresService>()));
  gh.factory<_i144.OrderLogsScreen>(
      () => _i144.OrderLogsScreen(get<_i82.OrderLogsStateManager>()));
  gh.factory<_i145.OrderLogsStateManager>(
      () => _i145.OrderLogsStateManager(get<_i100.StoresService>()));
  gh.factory<_i146.OrderPendingScreen>(
      () => _i146.OrderPendingScreen(get<_i83.OrderPendingStateManager>()));
  gh.factory<_i147.OrderStatusStateManager>(() => _i147.OrderStatusStateManager(
      get<_i100.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i148.OrderTimeLineStateManager>(() =>
      _i148.OrderTimeLineStateManager(
          get<_i100.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i149.OrdersCashStoreScreen>(() =>
      _i149.OrdersCashStoreScreen(get<_i86.OrdersCashStoreStateManager>()));
  gh.factory<_i150.OrdersReceiveCashScreen>(() =>
      _i150.OrdersReceiveCashScreen(get<_i87.OrdersReceiveCashStateManager>()));
  gh.factory<_i151.PackagesScreen>(
      () => _i151.PackagesScreen(get<_i90.PackagesStateManager>()));
  gh.factory<_i152.PaymentsToCaptainScreen>(() =>
      _i152.PaymentsToCaptainScreen(get<_i93.PaymentsToCaptainStateManager>()));
  gh.factory<_i153.PlanScreen>(
      () => _i153.PlanScreen(get<_i94.PlanScreenStateManager>()));
  gh.factory<_i154.SettingsModule>(() => _i154.SettingsModule(
      get<_i96.SettingsScreen>(), get<_i20.ChooseLocalScreen>()));
  gh.factory<_i155.StoreBalanceScreen>(
      () => _i155.StoreBalanceScreen(get<_i98.StoreBalanceStateManager>()));
  gh.factory<_i156.StoreFinancialSubscriptionsDuesDetailsStateManager>(() =>
      _i156.StoreFinancialSubscriptionsDuesDetailsStateManager(
          get<_i92.PaymentsService>(), get<_i103.SubscriptionsService>()));
  gh.factory<_i157.StoreProfileStateManager>(() =>
      _i157.StoreProfileStateManager(
          get<_i100.StoresService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i158.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i158.StoreSubscriptionsFinanceDetailsScreen(
          get<_i156.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i159.StoreSubscriptionsFinanceStateManager>(() =>
      _i159.StoreSubscriptionsFinanceStateManager(
          get<_i103.SubscriptionsService>()));
  gh.factory<_i160.StoresInActiveStateManager>(() =>
      _i160.StoresInActiveStateManager(get<_i100.StoresService>(),
          get<_i23.AuthService>(), get<_i34.ImageUploadService>()));
  gh.factory<_i161.StoresNeedsSupportStateManager>(
      () => _i161.StoresNeedsSupportStateManager(get<_i100.StoresService>()));
  gh.factory<_i162.StoresScreen>(
      () => _i162.StoresScreen(get<_i101.StoresStateManager>()));
  gh.factory<_i163.SupplierAdsStateManager>(
      () => _i163.SupplierAdsStateManager(get<_i108.SupplierService>()));
  gh.factory<_i164.SupplierCategoriesScreen>(() =>
      _i164.SupplierCategoriesScreen(
          get<_i107.SupplierCategoriesStateManager>()));
  gh.factory<_i165.SupplierNeedsSupportStateManager>(() =>
      _i165.SupplierNeedsSupportStateManager(get<_i108.SupplierService>()));
  gh.factory<_i166.SupplierProfileStateManager>(
      () => _i166.SupplierProfileStateManager(get<_i108.SupplierService>()));
  gh.factory<_i167.SuppliersScreen>(
      () => _i167.SuppliersScreen(get<_i109.SuppliersStateManager>()));
  gh.factory<_i168.UpdateBranchStateManager>(
      () => _i168.UpdateBranchStateManager(get<_i115.BranchesListService>()));
  gh.factory<_i169.BranchesListScreen>(
      () => _i169.BranchesListScreen(get<_i116.BranchesListStateManager>()));
  gh.factory<_i170.CaptainAssignOrderScreen>(() =>
      _i170.CaptainAssignOrderScreen(
          get<_i118.CaptainAssignOrderStateManager>()));
  gh.factory<_i171.CaptainFinanceByCountOrderScreen>(() =>
      _i171.CaptainFinanceByCountOrderScreen(
          get<_i120.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i172.CaptainFinanceByHoursScreen>(() =>
      _i172.CaptainFinanceByHoursScreen(
          get<_i119.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i173.CaptainFinanceByOrderScreen>(() =>
      _i173.CaptainFinanceByOrderScreen(
          get<_i121.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i174.CaptainFinancialDuesDetailsScreen>(() =>
      _i174.CaptainFinancialDuesDetailsScreen(
          get<_i122.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i175.CaptainFinancialDuesScreen>(() =>
      _i175.CaptainFinancialDuesScreen(
          get<_i123.CaptainFinancialDuesStateManager>()));
  gh.factory<_i176.CaptainProfileScreen>(() =>
      _i176.CaptainProfileScreen(get<_i126.CaptainProfileStateManager>()));
  gh.factory<_i177.CaptainsNeedsSupportScreen>(() =>
      _i177.CaptainsNeedsSupportScreen(
          get<_i127.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i178.CarsModule>(() => _i178.CarsModule(get<_i129.CarsScreen>()));
  gh.factory<_i179.CategoriesModule>(() => _i179.CategoriesModule(
      get<_i130.CategoriesScreen>(), get<_i151.PackagesScreen>()));
  gh.factory<_i180.ChatModule>(
      () => _i180.ChatModule(get<_i131.ChatPage>(), get<_i23.AuthService>()));
  gh.factory<_i181.CompanyFinanceScreen>(() =>
      _i181.CompanyFinanceScreen(get<_i132.CompanyFinanceStateManager>()));
  gh.factory<_i182.CompanyProfileScreen>(() =>
      _i182.CompanyProfileScreen(get<_i133.CompanyProfileStateManager>()));
  gh.factory<_i183.InActiveSupplierScreen>(() =>
      _i183.InActiveSupplierScreen(get<_i136.InActiveSupplierStateManager>()));
  gh.factory<_i184.InitBranchesScreen>(
      () => _i184.InitBranchesScreen(get<_i137.InitBranchesStateManager>()));
  gh.factory<_i185.MainModule>(
      () => _i185.MainModule(get<_i138.MainScreen>(), get<_i134.HomeScreen>()));
  gh.factory<_i186.NoticeModule>(
      () => _i186.NoticeModule(get<_i140.NoticeScreen>()));
  gh.factory<_i187.OrderCaptainNotArrivedScreen>(() =>
      _i187.OrderCaptainNotArrivedScreen(
          get<_i143.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i188.OrderDetailsScreen>(
      () => _i188.OrderDetailsScreen(get<_i147.OrderStatusStateManager>()));
  gh.factory<_i189.OrderLogsScreen>(
      () => _i189.OrderLogsScreen(get<_i145.OrderLogsStateManager>()));
  gh.factory<_i190.OrderTimeLineScreen>(
      () => _i190.OrderTimeLineScreen(get<_i148.OrderTimeLineStateManager>()));
  gh.factory<_i191.OrdersModule>(() => _i191.OrdersModule(
      get<_i144.OrderLogsScreen>(),
      get<_i85.OrdersCashCaptainScreen>(),
      get<_i149.OrdersCashStoreScreen>(),
      get<_i110.UpdateOrderScreen>(),
      get<_i146.OrderPendingScreen>(),
      get<_i139.NewOrderScreen>(),
      get<_i142.OrderCaptainLogsScreen>(),
      get<_i141.OrderActionLogsScreen>(),
      get<_i88.OrdersWithoutDistanceScreen>(),
      get<_i150.OrdersReceiveCashScreen>()));
  gh.factory<_i192.PaymentsModule>(() => _i192.PaymentsModule(
      get<_i171.CaptainFinanceByCountOrderScreen>(),
      get<_i172.CaptainFinanceByHoursScreen>(),
      get<_i173.CaptainFinanceByOrderScreen>(),
      get<_i152.PaymentsToCaptainScreen>(),
      get<_i155.StoreBalanceScreen>()));
  gh.factory<_i193.StoreInfoScreen>(
      () => _i193.StoreInfoScreen(get<_i157.StoreProfileStateManager>()));
  gh.factory<_i194.StoreSubscriptionsFinanceScreen>(() =>
      _i194.StoreSubscriptionsFinanceScreen(
          get<_i159.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i195.StoresInActiveScreen>(() =>
      _i195.StoresInActiveScreen(get<_i160.StoresInActiveStateManager>()));
  gh.factory<_i196.StoresNeedsSupportScreen>(() =>
      _i196.StoresNeedsSupportScreen(
          get<_i161.StoresNeedsSupportStateManager>()));
  gh.factory<_i197.SubscriptionsModule>(() => _i197.SubscriptionsModule(
      get<_i158.StoreSubscriptionsFinanceDetailsScreen>(),
      get<_i194.StoreSubscriptionsFinanceScreen>(),
      get<_i198.SubscriptionManagementScreen>()));
  gh.factory<_i199.SupplierAdsScreen>(
      () => _i199.SupplierAdsScreen(get<_i163.SupplierAdsStateManager>()));
  gh.factory<_i200.SupplierCategoriesModule>(() =>
      _i200.SupplierCategoriesModule(get<_i164.SupplierCategoriesScreen>()));
  gh.factory<_i201.SupplierNeedsSupportScreen>(() =>
      _i201.SupplierNeedsSupportScreen(
          get<_i165.SupplierNeedsSupportStateManager>()));
  gh.factory<_i202.SupplierProfileScreen>(() =>
      _i202.SupplierProfileScreen(get<_i166.SupplierProfileStateManager>()));
  gh.factory<_i203.UpdateBranchScreen>(
      () => _i203.UpdateBranchScreen(get<_i168.UpdateBranchStateManager>()));
  gh.factory<_i204.BranchesModule>(() => _i204.BranchesModule(
      get<_i169.BranchesListScreen>(),
      get<_i203.UpdateBranchScreen>(),
      get<_i184.InitBranchesScreen>()));
  gh.factory<_i205.CaptainsModule>(() => _i205.CaptainsModule(
      get<_i125.CaptainOffersScreen>(),
      get<_i135.InActiveCaptainsScreen>(),
      get<_i128.CaptainsScreen>(),
      get<_i176.CaptainProfileScreen>(),
      get<_i177.CaptainsNeedsSupportScreen>(),
      get<_i117.CaptainAccountBalanceScreen>(),
      get<_i174.CaptainFinancialDuesDetailsScreen>(),
      get<_i175.CaptainFinancialDuesScreen>(),
      get<_i153.PlanScreen>(),
      get<_i170.CaptainAssignOrderScreen>()));
  gh.factory<_i206.CompanyModule>(() => _i206.CompanyModule(
      get<_i182.CompanyProfileScreen>(), get<_i181.CompanyFinanceScreen>()));
  gh.factory<_i207.StoresModule>(() => _i207.StoresModule(
      get<_i162.StoresScreen>(),
      get<_i193.StoreInfoScreen>(),
      get<_i195.StoresInActiveScreen>(),
      get<_i155.StoreBalanceScreen>(),
      get<_i196.StoresNeedsSupportScreen>(),
      get<_i188.OrderDetailsScreen>(),
      get<_i189.OrderLogsScreen>(),
      get<_i187.OrderCaptainNotArrivedScreen>(),
      get<_i190.OrderTimeLineScreen>()));
  gh.factory<_i208.SupplierModule>(() => _i208.SupplierModule(
      get<_i183.InActiveSupplierScreen>(),
      get<_i167.SuppliersScreen>(),
      get<_i202.SupplierProfileScreen>(),
      get<_i201.SupplierNeedsSupportScreen>(),
      get<_i199.SupplierAdsScreen>()));
  gh.factory<_i209.MyApp>(() => _i209.MyApp(
      get<_i18.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i68.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i97.SplashModule>(),
      get<_i112.AuthorizationModule>(),
      get<_i180.ChatModule>(),
      get<_i154.SettingsModule>(),
      get<_i185.MainModule>(),
      get<_i207.StoresModule>(),
      get<_i179.CategoriesModule>(),
      get<_i206.CompanyModule>(),
      get<_i204.BranchesModule>(),
      get<_i186.NoticeModule>(),
      get<_i205.CaptainsModule>(),
      get<_i192.PaymentsModule>(),
      get<_i200.SupplierCategoriesModule>(),
      get<_i208.SupplierModule>(),
      get<_i178.CarsModule>(),
      get<_i114.BidOrderModule>(),
      get<_i191.OrdersModule>()));
  gh.singleton<_i210.GlobalStateManager>(_i210.GlobalStateManager());
  return get;
}

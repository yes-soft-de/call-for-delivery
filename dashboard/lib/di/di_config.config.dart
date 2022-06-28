// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hive/util/argument_hive_helper.dart' as _i3;
import '../main.dart' as _i192;
import '../module_auth/authoriazation_module.dart' as _i102;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i22;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i4;
import '../module_auth/repository/auth/auth_repository.dart' as _i19;
import '../module_auth/service/auth_service/auth_service.dart' as _i23;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i31;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i34;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i41;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i67;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i72;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i88;
import '../module_bid_order/bid_order_module.dart' as _i104;
import '../module_bid_order/manager/bid_order_manager.dart' as _i48;
import '../module_bid_order/repository/bid_order_repository.dart' as _i24;
import '../module_bid_order/service/bid_order_service.dart' as _i49;
import '../module_bid_order/state_manager/bid_order_state_manager.dart' as _i50;
import '../module_bid_order/ui/screen/bid_orders_screen.dart' as _i51;
import '../module_bid_order/ui/screen/order_details_screen.dart' as _i103;
import '../module_branches/branches_module.dart' as _i187;
import '../module_branches/manager/branches_manager.dart' as _i52;
import '../module_branches/repository/branches_repository.dart' as _i25;
import '../module_branches/service/branches_list_service.dart' as _i105;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i106;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i126;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i155;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i156;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i170;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i186;
import '../module_captain/captains_module.dart' as _i188;
import '../module_captain/hive/captain_hive_helper.dart' as _i5;
import '../module_captain/manager/captains_manager.dart' as _i53;
import '../module_captain/repository/captains_repository.dart' as _i26;
import '../module_captain/service/captains_service.dart' as _i54;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i101;
import '../module_captain/state_manager/captain_financial_dues_details_state_manager.dart'
    as _i111;
import '../module_captain/state_manager/captain_financial_dues_state_manager.dart'
    as _i112;
import '../module_captain/state_manager/captain_list.dart' as _i55;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i116;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i113;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i115;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i71;
import '../module_captain/state_manager/plan_screen_state_manager.dart' as _i87;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i107;
import '../module_captain/ui/screen/captain_financial_details_screen.dart'
    as _i160;
import '../module_captain/ui/screen/captain_financial_dues_screen.dart'
    as _i161;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i163;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i162;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i117;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i114;
import '../module_captain/ui/screen/change_captain_plan_screen.dart' as _i140;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i124;
import '../module_categories/categories_module.dart' as _i165;
import '../module_categories/manager/categories_manager.dart' as _i59;
import '../module_categories/repository/categories_repository.dart' as _i28;
import '../module_categories/service/store_categories_service.dart' as _i60;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i82;
import '../module_categories/state_manager/packages_state_manager.dart' as _i83;
import '../module_categories/ui/screen/categories_screen.dart' as _i119;
import '../module_categories/ui/screen/packages_screen.dart' as _i138;
import '../module_chat/chat_module.dart' as _i166;
import '../module_chat/manager/chat/chat_manager.dart' as _i61;
import '../module_chat/presistance/chat_hive_helper.dart' as _i6;
import '../module_chat/repository/chat/chat_repository.dart' as _i29;
import '../module_chat/service/chat/char_service.dart' as _i62;
import '../module_chat/state_manager/chat_state_manager.dart' as _i63;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i120;
import '../module_company/company_module.dart' as _i189;
import '../module_company/manager/company_manager.dart' as _i64;
import '../module_company/repository/company_repository.dart' as _i30;
import '../module_company/service/company_service.dart' as _i65;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i121;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i122;
import '../module_company/ui/screen/company_finance_screen.dart' as _i167;
import '../module_company/ui/screen/company_profile_screen.dart' as _i168;
import '../module_delivary_car/cars_module.dart' as _i164;
import '../module_delivary_car/manager/cars_manager.dart' as _i56;
import '../module_delivary_car/repository/cars_repository.dart' as _i27;
import '../module_delivary_car/service/cars_service.dart' as _i57;
import '../module_delivary_car/state_manager/cars_state_manager.dart' as _i58;
import '../module_delivary_car/ui/screen/cars_screen.dart' as _i118;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i9;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i10;
import '../module_main/main_module.dart' as _i171;
import '../module_main/manager/home_manager.dart' as _i68;
import '../module_main/repository/home_repository.dart' as _i32;
import '../module_main/sceen/home_screen.dart' as _i123;
import '../module_main/sceen/main_screen.dart' as _i127;
import '../module_main/service/home_service.dart' as _i69;
import '../module_main/state_manager/home_state_manager.dart' as _i70;
import '../module_network/http_client/http_client.dart' as _i17;
import '../module_notice/manager/notice_manager.dart' as _i74;
import '../module_notice/notice_module.dart' as _i172;
import '../module_notice/repository/notice_repository.dart' as _i35;
import '../module_notice/service/notice_service.dart' as _i75;
import '../module_notice/state_manager/notice_state_manager.dart' as _i76;
import '../module_notice/ui/screen/notice_screen.dart' as _i129;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i12;
import '../module_notifications/repository/notification_repo.dart' as _i36;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i66;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i8;
import '../module_orders/hive/order_hive_helper.dart' as _i13;
import '../module_orders/manager/orders_manager/orders_manager.dart' as _i38;
import '../module_orders/orders_module.dart' as _i137;
import '../module_orders/repository/order_repository/order_repository.dart'
    as _i37;
import '../module_orders/service/orders/orders.service.dart' as _i39;
import '../module_orders/state_manager/new_order/new_order.state_manager.dart'
    as _i73;
import '../module_orders/state_manager/new_order/update_order_state_manager.dart'
    as _i47;
import '../module_orders/state_manager/order_cash_captain_state_manager.dart'
    as _i77;
import '../module_orders/state_manager/order_cash_store_state_manager.dart'
    as _i81;
import '../module_orders/state_manager/order_logs_state_manager.dart' as _i78;
import '../module_orders/state_manager/order_pending_state_manager.dart'
    as _i79;
import '../module_orders/ui/screens/new_order/new_order_screen.dart' as _i128;
import '../module_orders/ui/screens/new_order/update_order_screen.dart'
    as _i100;
import '../module_orders/ui/screens/order_cash_captain_screen.dart' as _i80;
import '../module_orders/ui/screens/order_cash_store_screen.dart' as _i136;
import '../module_orders/ui/screens/order_logs_screen.dart' as _i131;
import '../module_orders/ui/screens/order_pending_screen.dart' as _i133;
import '../module_payments/manager/payments_manager.dart' as _i84;
import '../module_payments/payments_module.dart' as _i177;
import '../module_payments/repository/payments_repository.dart' as _i40;
import '../module_payments/service/payments_service.dart' as _i85;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i108;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i109;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i110;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i86;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i91;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i158;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i157;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i159;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i139;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i142;
import '../module_settings/settings_module.dart' as _i141;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i20;
import '../module_settings/ui/settings_page/settings_page.dart' as _i89;
import '../module_splash/splash_module.dart' as _i90;
import '../module_splash/ui/screen/splash_screen.dart' as _i42;
import '../module_stores/hive/store_hive_helper.dart' as _i14;
import '../module_stores/manager/stores_manager.dart' as _i92;
import '../module_stores/repository/stores_repository.dart' as _i43;
import '../module_stores/service/store_service.dart' as _i93;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i130;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i132;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i134;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i135;
import '../module_stores/state_manager/store_financial_subscriptions_details_state_manager.dart'
    as _i143;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i144;
import '../module_stores/state_manager/store_subscriptions_finance_state_manager.dart'
    as _i146;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i147;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i148;
import '../module_stores/state_manager/stores_state_manager.dart' as _i94;
import '../module_stores/stores_module.dart' as _i190;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i173;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i174;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i175;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i176;
import '../module_stores/ui/screen/store_info_screen.dart' as _i178;
import '../module_stores/ui/screen/store_subscriptions_details_screen.dart'
    as _i145;
import '../module_stores/ui/screen/store_subscriptions_screen.dart' as _i179;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i180;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i181;
import '../module_stores/ui/screen/stores_screen.dart' as _i149;
import '../module_supplier/manager/supplier_manager.dart' as _i46;
import '../module_supplier/repository/supplier_repository.dart' as _i45;
import '../module_supplier/service/supplier_service.dart' as _i98;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i125;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i150;
import '../module_supplier/state_manager/supplier_list.dart' as _i99;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i152;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i153;
import '../module_supplier/supplier_module.dart' as _i191;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i169;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i182;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i154;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i184;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i185;
import '../module_supplier_categories/categories_supplier_module.dart' as _i183;
import '../module_supplier_categories/manager/categories_manager.dart' as _i95;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i44;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i96;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i97;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i151;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i15;
import '../module_theme/service/theme_service/theme_service.dart' as _i18;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i21;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i16;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i33;
import '../utils/global/global_state_manager.dart' as _i193;
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
  gh.factory<_i31.ForgotPassStateManager>(
      () => _i31.ForgotPassStateManager(get<_i23.AuthService>()));
  gh.factory<_i32.HomeRepository>(() =>
      _i32.HomeRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i33.ImageUploadService>(
      () => _i33.ImageUploadService(get<_i21.UploadManager>()));
  gh.factory<_i34.LoginStateManager>(
      () => _i34.LoginStateManager(get<_i23.AuthService>()));
  gh.factory<_i35.NoticeRepository>(() =>
      _i35.NoticeRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i36.NotificationRepo>(() =>
      _i36.NotificationRepo(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i37.OrderRepository>(() =>
      _i37.OrderRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i38.OrdersManager>(
      () => _i38.OrdersManager(get<_i37.OrderRepository>()));
  gh.factory<_i39.OrdersService>(
      () => _i39.OrdersService(get<_i38.OrdersManager>()));
  gh.factory<_i40.PaymentsRepository>(() =>
      _i40.PaymentsRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i41.RegisterStateManager>(
      () => _i41.RegisterStateManager(get<_i23.AuthService>()));
  gh.factory<_i42.SplashScreen>(
      () => _i42.SplashScreen(get<_i23.AuthService>()));
  gh.factory<_i43.StoresRepository>(() =>
      _i43.StoresRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i44.SupplierCategoriesRepository>(() =>
      _i44.SupplierCategoriesRepository(
          get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i45.SupplierRepository>(() =>
      _i45.SupplierRepository(get<_i17.ApiClient>(), get<_i23.AuthService>()));
  gh.factory<_i46.SuppliersManager>(
      () => _i46.SuppliersManager(get<_i45.SupplierRepository>()));
  gh.factory<_i47.UpdateOrderStateManager>(
      () => _i47.UpdateOrderStateManager(get<_i39.OrdersService>()));
  gh.factory<_i48.BidOrderManager>(
      () => _i48.BidOrderManager(get<_i24.BidOrderRepository>()));
  gh.factory<_i49.BidOrderService>(
      () => _i49.BidOrderService(get<_i48.BidOrderManager>()));
  gh.factory<_i50.BidOrderStateManager>(
      () => _i50.BidOrderStateManager(get<_i49.BidOrderService>()));
  gh.factory<_i51.BidOrdersScreen>(
      () => _i51.BidOrdersScreen(get<_i50.BidOrderStateManager>()));
  gh.factory<_i52.BranchesManager>(
      () => _i52.BranchesManager(get<_i25.BranchesRepository>()));
  gh.factory<_i53.CaptainsManager>(
      () => _i53.CaptainsManager(get<_i26.CaptainsRepository>()));
  gh.factory<_i54.CaptainsService>(
      () => _i54.CaptainsService(get<_i53.CaptainsManager>()));
  gh.factory<_i55.CaptainsStateManager>(
      () => _i55.CaptainsStateManager(get<_i54.CaptainsService>()));
  gh.factory<_i56.CarsManager>(
      () => _i56.CarsManager(get<_i27.CarsRepository>()));
  gh.factory<_i57.CarsService>(() => _i57.CarsService(get<_i56.CarsManager>()));
  gh.factory<_i58.CarsStateManager>(
      () => _i58.CarsStateManager(get<_i57.CarsService>()));
  gh.factory<_i59.CategoriesManager>(
      () => _i59.CategoriesManager(get<_i28.CategoriesRepository>()));
  gh.factory<_i60.CategoriesService>(
      () => _i60.CategoriesService(get<_i59.CategoriesManager>()));
  gh.factory<_i61.ChatManager>(
      () => _i61.ChatManager(get<_i29.ChatRepository>()));
  gh.factory<_i62.ChatService>(() => _i62.ChatService(get<_i61.ChatManager>()));
  gh.factory<_i63.ChatStateManager>(
      () => _i63.ChatStateManager(get<_i62.ChatService>()));
  gh.factory<_i64.CompanyManager>(
      () => _i64.CompanyManager(get<_i30.CompanyRepository>()));
  gh.factory<_i65.CompanyService>(
      () => _i65.CompanyService(get<_i64.CompanyManager>()));
  gh.factory<_i66.FireNotificationService>(() => _i66.FireNotificationService(
      get<_i12.NotificationsPrefHelper>(), get<_i36.NotificationRepo>()));
  gh.factory<_i67.ForgotPassScreen>(
      () => _i67.ForgotPassScreen(get<_i31.ForgotPassStateManager>()));
  gh.factory<_i68.HomeManager>(
      () => _i68.HomeManager(get<_i32.HomeRepository>()));
  gh.factory<_i69.HomeService>(() => _i69.HomeService(get<_i68.HomeManager>()));
  gh.factory<_i70.HomeStateManager>(
      () => _i70.HomeStateManager(get<_i69.HomeService>()));
  gh.factory<_i71.InActiveCaptainsStateManager>(
      () => _i71.InActiveCaptainsStateManager(get<_i54.CaptainsService>()));
  gh.factory<_i72.LoginScreen>(
      () => _i72.LoginScreen(get<_i34.LoginStateManager>()));
  gh.factory<_i73.NewOrderStateManager>(
      () => _i73.NewOrderStateManager(get<_i39.OrdersService>()));
  gh.factory<_i74.NoticeManager>(
      () => _i74.NoticeManager(get<_i35.NoticeRepository>()));
  gh.factory<_i75.NoticeService>(
      () => _i75.NoticeService(get<_i74.NoticeManager>()));
  gh.factory<_i76.NoticeStateManager>(
      () => _i76.NoticeStateManager(get<_i75.NoticeService>()));
  gh.factory<_i77.OrderCashCaptainStateManager>(
      () => _i77.OrderCashCaptainStateManager(get<_i39.OrdersService>()));
  gh.factory<_i78.OrderLogsStateManager>(
      () => _i78.OrderLogsStateManager(get<_i39.OrdersService>()));
  gh.factory<_i79.OrderPendingStateManager>(
      () => _i79.OrderPendingStateManager(get<_i39.OrdersService>()));
  gh.factory<_i80.OrdersCashCaptainScreen>(() =>
      _i80.OrdersCashCaptainScreen(get<_i77.OrderCashCaptainStateManager>()));
  gh.factory<_i81.OrdersCashStoreStateManager>(
      () => _i81.OrdersCashStoreStateManager(get<_i39.OrdersService>()));
  gh.factory<_i82.PackageCategoriesStateManager>(() =>
      _i82.PackageCategoriesStateManager(
          get<_i60.CategoriesService>(), get<_i33.ImageUploadService>()));
  gh.factory<_i83.PackagesStateManager>(() => _i83.PackagesStateManager(
      get<_i60.CategoriesService>(), get<_i23.AuthService>()));
  gh.factory<_i84.PaymentsManager>(
      () => _i84.PaymentsManager(get<_i40.PaymentsRepository>()));
  gh.factory<_i85.PaymentsService>(
      () => _i85.PaymentsService(get<_i84.PaymentsManager>()));
  gh.factory<_i86.PaymentsToCaptainStateManager>(
      () => _i86.PaymentsToCaptainStateManager(get<_i85.PaymentsService>()));
  gh.factory<_i87.PlanScreenStateManager>(
      () => _i87.PlanScreenStateManager(get<_i85.PaymentsService>()));
  gh.factory<_i88.RegisterScreen>(
      () => _i88.RegisterScreen(get<_i41.RegisterStateManager>()));
  gh.factory<_i89.SettingsScreen>(() => _i89.SettingsScreen(
      get<_i23.AuthService>(),
      get<_i10.LocalizationService>(),
      get<_i18.AppThemeDataService>(),
      get<_i66.FireNotificationService>()));
  gh.factory<_i90.SplashModule>(
      () => _i90.SplashModule(get<_i42.SplashScreen>()));
  gh.factory<_i91.StoreBalanceStateManager>(
      () => _i91.StoreBalanceStateManager(get<_i85.PaymentsService>()));
  gh.factory<_i92.StoreManager>(
      () => _i92.StoreManager(get<_i43.StoresRepository>()));
  gh.factory<_i93.StoresService>(
      () => _i93.StoresService(get<_i92.StoreManager>()));
  gh.factory<_i94.StoresStateManager>(() => _i94.StoresStateManager(
      get<_i93.StoresService>(),
      get<_i23.AuthService>(),
      get<_i33.ImageUploadService>()));
  gh.factory<_i95.SupplierCategoriesManager>(() =>
      _i95.SupplierCategoriesManager(get<_i44.SupplierCategoriesRepository>()));
  gh.factory<_i96.SupplierCategoriesService>(() =>
      _i96.SupplierCategoriesService(get<_i95.SupplierCategoriesManager>()));
  gh.factory<_i97.SupplierCategoriesStateManager>(() =>
      _i97.SupplierCategoriesStateManager(get<_i96.SupplierCategoriesService>(),
          get<_i33.ImageUploadService>()));
  gh.factory<_i98.SupplierService>(
      () => _i98.SupplierService(get<_i46.SuppliersManager>()));
  gh.factory<_i99.SuppliersStateManager>(
      () => _i99.SuppliersStateManager(get<_i98.SupplierService>()));
  gh.factory<_i100.UpdateOrderScreen>(
      () => _i100.UpdateOrderScreen(get<_i47.UpdateOrderStateManager>()));
  gh.factory<_i101.AccountBalanceStateManager>(
      () => _i101.AccountBalanceStateManager(get<_i54.CaptainsService>()));
  gh.factory<_i102.AuthorizationModule>(() => _i102.AuthorizationModule(
      get<_i72.LoginScreen>(),
      get<_i88.RegisterScreen>(),
      get<_i67.ForgotPassScreen>()));
  gh.factory<_i103.BidOrderDetailsScreen>(
      () => _i103.BidOrderDetailsScreen(get<_i50.BidOrderStateManager>()));
  gh.factory<_i104.BidOrderModule>(
      () => _i104.BidOrderModule(get<_i51.BidOrdersScreen>()));
  gh.factory<_i105.BranchesListService>(
      () => _i105.BranchesListService(get<_i52.BranchesManager>()));
  gh.factory<_i106.BranchesListStateManager>(
      () => _i106.BranchesListStateManager(get<_i105.BranchesListService>()));
  gh.factory<_i107.CaptainAccountBalanceScreen>(() =>
      _i107.CaptainAccountBalanceScreen(
          get<_i101.AccountBalanceStateManager>()));
  gh.factory<_i108.CaptainFinanceByHoursStateManager>(() =>
      _i108.CaptainFinanceByHoursStateManager(get<_i85.PaymentsService>()));
  gh.factory<_i109.CaptainFinanceByOrderCountStateManager>(() =>
      _i109.CaptainFinanceByOrderCountStateManager(
          get<_i85.PaymentsService>()));
  gh.factory<_i110.CaptainFinanceByOrderStateManager>(() =>
      _i110.CaptainFinanceByOrderStateManager(get<_i85.PaymentsService>()));
  gh.factory<_i111.CaptainFinancialDuesDetailsStateManager>(() =>
      _i111.CaptainFinancialDuesDetailsStateManager(
          get<_i85.PaymentsService>(), get<_i54.CaptainsService>()));
  gh.factory<_i112.CaptainFinancialDuesStateManager>(() =>
      _i112.CaptainFinancialDuesStateManager(get<_i54.CaptainsService>()));
  gh.factory<_i113.CaptainOfferStateManager>(() =>
      _i113.CaptainOfferStateManager(
          get<_i54.CaptainsService>(), get<_i33.ImageUploadService>()));
  gh.factory<_i114.CaptainOffersScreen>(
      () => _i114.CaptainOffersScreen(get<_i113.CaptainOfferStateManager>()));
  gh.factory<_i115.CaptainProfileStateManager>(
      () => _i115.CaptainProfileStateManager(get<_i54.CaptainsService>()));
  gh.factory<_i116.CaptainsNeedsSupportStateManager>(() =>
      _i116.CaptainsNeedsSupportStateManager(get<_i54.CaptainsService>()));
  gh.factory<_i117.CaptainsScreen>(
      () => _i117.CaptainsScreen(get<_i55.CaptainsStateManager>()));
  gh.factory<_i118.CarsScreen>(
      () => _i118.CarsScreen(get<_i58.CarsStateManager>()));
  gh.factory<_i119.CategoriesScreen>(
      () => _i119.CategoriesScreen(get<_i82.PackageCategoriesStateManager>()));
  gh.factory<_i120.ChatPage>(() => _i120.ChatPage(
      get<_i63.ChatStateManager>(),
      get<_i33.ImageUploadService>(),
      get<_i23.AuthService>(),
      get<_i6.ChatHiveHelper>()));
  gh.factory<_i121.CompanyFinanceStateManager>(() =>
      _i121.CompanyFinanceStateManager(
          get<_i23.AuthService>(), get<_i65.CompanyService>()));
  gh.factory<_i122.CompanyProfileStateManager>(() =>
      _i122.CompanyProfileStateManager(
          get<_i23.AuthService>(), get<_i65.CompanyService>()));
  gh.factory<_i123.HomeScreen>(
      () => _i123.HomeScreen(get<_i70.HomeStateManager>()));
  gh.factory<_i124.InActiveCaptainsScreen>(() =>
      _i124.InActiveCaptainsScreen(get<_i71.InActiveCaptainsStateManager>()));
  gh.factory<_i125.InActiveSupplierStateManager>(
      () => _i125.InActiveSupplierStateManager(get<_i98.SupplierService>()));
  gh.factory<_i126.InitBranchesStateManager>(
      () => _i126.InitBranchesStateManager(get<_i105.BranchesListService>()));
  gh.factory<_i127.MainScreen>(() => _i127.MainScreen(get<_i123.HomeScreen>()));
  gh.factory<_i128.NewOrderScreen>(
      () => _i128.NewOrderScreen(get<_i73.NewOrderStateManager>()));
  gh.factory<_i129.NoticeScreen>(
      () => _i129.NoticeScreen(get<_i76.NoticeStateManager>()));
  gh.factory<_i130.OrderCaptainNotArrivedStateManager>(() =>
      _i130.OrderCaptainNotArrivedStateManager(get<_i93.StoresService>()));
  gh.factory<_i131.OrderLogsScreen>(
      () => _i131.OrderLogsScreen(get<_i78.OrderLogsStateManager>()));
  gh.factory<_i132.OrderLogsStateManager>(
      () => _i132.OrderLogsStateManager(get<_i93.StoresService>()));
  gh.factory<_i133.OrderPendingScreen>(
      () => _i133.OrderPendingScreen(get<_i79.OrderPendingStateManager>()));
  gh.factory<_i134.OrderStatusStateManager>(() => _i134.OrderStatusStateManager(
      get<_i93.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i135.OrderTimeLineStateManager>(() =>
      _i135.OrderTimeLineStateManager(
          get<_i93.StoresService>(), get<_i23.AuthService>()));
  gh.factory<_i136.OrdersCashStoreScreen>(() =>
      _i136.OrdersCashStoreScreen(get<_i81.OrdersCashStoreStateManager>()));
  gh.factory<_i137.OrdersModule>(() => _i137.OrdersModule(
      get<_i131.OrderLogsScreen>(),
      get<_i80.OrdersCashCaptainScreen>(),
      get<_i136.OrdersCashStoreScreen>(),
      get<_i100.UpdateOrderScreen>(),
      get<_i133.OrderPendingScreen>(),
      get<_i128.NewOrderScreen>()));
  gh.factory<_i138.PackagesScreen>(
      () => _i138.PackagesScreen(get<_i83.PackagesStateManager>()));
  gh.factory<_i139.PaymentsToCaptainScreen>(() =>
      _i139.PaymentsToCaptainScreen(get<_i86.PaymentsToCaptainStateManager>()));
  gh.factory<_i140.PlanScreen>(
      () => _i140.PlanScreen(get<_i87.PlanScreenStateManager>()));
  gh.factory<_i141.SettingsModule>(() => _i141.SettingsModule(
      get<_i89.SettingsScreen>(), get<_i20.ChooseLocalScreen>()));
  gh.factory<_i142.StoreBalanceScreen>(
      () => _i142.StoreBalanceScreen(get<_i91.StoreBalanceStateManager>()));
  gh.factory<_i143.StoreFinancialSubscriptionsDuesDetailsStateManager>(() =>
      _i143.StoreFinancialSubscriptionsDuesDetailsStateManager(
          get<_i85.PaymentsService>(), get<_i93.StoresService>()));
  gh.factory<_i144.StoreProfileStateManager>(() =>
      _i144.StoreProfileStateManager(
          get<_i93.StoresService>(), get<_i33.ImageUploadService>()));
  gh.factory<_i145.StoreSubscriptionsFinanceDetailsScreen>(() =>
      _i145.StoreSubscriptionsFinanceDetailsScreen(
          get<_i143.StoreFinancialSubscriptionsDuesDetailsStateManager>()));
  gh.factory<_i146.StoreSubscriptionsFinanceStateManager>(() =>
      _i146.StoreSubscriptionsFinanceStateManager(get<_i93.StoresService>()));
  gh.factory<_i147.StoresInActiveStateManager>(() =>
      _i147.StoresInActiveStateManager(get<_i93.StoresService>(),
          get<_i23.AuthService>(), get<_i33.ImageUploadService>()));
  gh.factory<_i148.StoresNeedsSupportStateManager>(
      () => _i148.StoresNeedsSupportStateManager(get<_i93.StoresService>()));
  gh.factory<_i149.StoresScreen>(
      () => _i149.StoresScreen(get<_i94.StoresStateManager>()));
  gh.factory<_i150.SupplierAdsStateManager>(
      () => _i150.SupplierAdsStateManager(get<_i98.SupplierService>()));
  gh.factory<_i151.SupplierCategoriesScreen>(() =>
      _i151.SupplierCategoriesScreen(
          get<_i97.SupplierCategoriesStateManager>()));
  gh.factory<_i152.SupplierNeedsSupportStateManager>(() =>
      _i152.SupplierNeedsSupportStateManager(get<_i98.SupplierService>()));
  gh.factory<_i153.SupplierProfileStateManager>(
      () => _i153.SupplierProfileStateManager(get<_i98.SupplierService>()));
  gh.factory<_i154.SuppliersScreen>(
      () => _i154.SuppliersScreen(get<_i99.SuppliersStateManager>()));
  gh.factory<_i155.UpdateBranchStateManager>(
      () => _i155.UpdateBranchStateManager(get<_i105.BranchesListService>()));
  gh.factory<_i156.BranchesListScreen>(
      () => _i156.BranchesListScreen(get<_i106.BranchesListStateManager>()));
  gh.factory<_i157.CaptainFinanceByCountOrderScreen>(() =>
      _i157.CaptainFinanceByCountOrderScreen(
          get<_i109.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i158.CaptainFinanceByHoursScreen>(() =>
      _i158.CaptainFinanceByHoursScreen(
          get<_i108.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i159.CaptainFinanceByOrderScreen>(() =>
      _i159.CaptainFinanceByOrderScreen(
          get<_i110.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i160.CaptainFinancialDuesDetailsScreen>(() =>
      _i160.CaptainFinancialDuesDetailsScreen(
          get<_i111.CaptainFinancialDuesDetailsStateManager>()));
  gh.factory<_i161.CaptainFinancialDuesScreen>(() =>
      _i161.CaptainFinancialDuesScreen(
          get<_i112.CaptainFinancialDuesStateManager>()));
  gh.factory<_i162.CaptainProfileScreen>(() =>
      _i162.CaptainProfileScreen(get<_i115.CaptainProfileStateManager>()));
  gh.factory<_i163.CaptainsNeedsSupportScreen>(() =>
      _i163.CaptainsNeedsSupportScreen(
          get<_i116.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i164.CarsModule>(() => _i164.CarsModule(get<_i118.CarsScreen>()));
  gh.factory<_i165.CategoriesModule>(() => _i165.CategoriesModule(
      get<_i119.CategoriesScreen>(), get<_i138.PackagesScreen>()));
  gh.factory<_i166.ChatModule>(
      () => _i166.ChatModule(get<_i120.ChatPage>(), get<_i23.AuthService>()));
  gh.factory<_i167.CompanyFinanceScreen>(() =>
      _i167.CompanyFinanceScreen(get<_i121.CompanyFinanceStateManager>()));
  gh.factory<_i168.CompanyProfileScreen>(() =>
      _i168.CompanyProfileScreen(get<_i122.CompanyProfileStateManager>()));
  gh.factory<_i169.InActiveSupplierScreen>(() =>
      _i169.InActiveSupplierScreen(get<_i125.InActiveSupplierStateManager>()));
  gh.factory<_i170.InitBranchesScreen>(
      () => _i170.InitBranchesScreen(get<_i126.InitBranchesStateManager>()));
  gh.factory<_i171.MainModule>(
      () => _i171.MainModule(get<_i127.MainScreen>(), get<_i123.HomeScreen>()));
  gh.factory<_i172.NoticeModule>(
      () => _i172.NoticeModule(get<_i129.NoticeScreen>()));
  gh.factory<_i173.OrderCaptainNotArrivedScreen>(() =>
      _i173.OrderCaptainNotArrivedScreen(
          get<_i130.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i174.OrderDetailsScreen>(
      () => _i174.OrderDetailsScreen(get<_i134.OrderStatusStateManager>()));
  gh.factory<_i175.OrderLogsScreen>(
      () => _i175.OrderLogsScreen(get<_i132.OrderLogsStateManager>()));
  gh.factory<_i176.OrderTimeLineScreen>(
      () => _i176.OrderTimeLineScreen(get<_i135.OrderTimeLineStateManager>()));
  gh.factory<_i177.PaymentsModule>(() => _i177.PaymentsModule(
      get<_i157.CaptainFinanceByCountOrderScreen>(),
      get<_i158.CaptainFinanceByHoursScreen>(),
      get<_i159.CaptainFinanceByOrderScreen>(),
      get<_i139.PaymentsToCaptainScreen>()));
  gh.factory<_i178.StoreInfoScreen>(
      () => _i178.StoreInfoScreen(get<_i144.StoreProfileStateManager>()));
  gh.factory<_i179.StoreSubscriptionsFinanceScreen>(() =>
      _i179.StoreSubscriptionsFinanceScreen(
          get<_i146.StoreSubscriptionsFinanceStateManager>()));
  gh.factory<_i180.StoresInActiveScreen>(() =>
      _i180.StoresInActiveScreen(get<_i147.StoresInActiveStateManager>()));
  gh.factory<_i181.StoresNeedsSupportScreen>(() =>
      _i181.StoresNeedsSupportScreen(
          get<_i148.StoresNeedsSupportStateManager>()));
  gh.factory<_i182.SupplierAdsScreen>(
      () => _i182.SupplierAdsScreen(get<_i150.SupplierAdsStateManager>()));
  gh.factory<_i183.SupplierCategoriesModule>(() =>
      _i183.SupplierCategoriesModule(get<_i151.SupplierCategoriesScreen>()));
  gh.factory<_i184.SupplierNeedsSupportScreen>(() =>
      _i184.SupplierNeedsSupportScreen(
          get<_i152.SupplierNeedsSupportStateManager>()));
  gh.factory<_i185.SupplierProfileScreen>(() =>
      _i185.SupplierProfileScreen(get<_i153.SupplierProfileStateManager>()));
  gh.factory<_i186.UpdateBranchScreen>(
      () => _i186.UpdateBranchScreen(get<_i155.UpdateBranchStateManager>()));
  gh.factory<_i187.BranchesModule>(() => _i187.BranchesModule(
      get<_i156.BranchesListScreen>(),
      get<_i186.UpdateBranchScreen>(),
      get<_i170.InitBranchesScreen>()));
  gh.factory<_i188.CaptainsModule>(() => _i188.CaptainsModule(
      get<_i114.CaptainOffersScreen>(),
      get<_i124.InActiveCaptainsScreen>(),
      get<_i117.CaptainsScreen>(),
      get<_i162.CaptainProfileScreen>(),
      get<_i163.CaptainsNeedsSupportScreen>(),
      get<_i107.CaptainAccountBalanceScreen>(),
      get<_i160.CaptainFinancialDuesDetailsScreen>(),
      get<_i161.CaptainFinancialDuesScreen>(),
      get<_i140.PlanScreen>()));
  gh.factory<_i189.CompanyModule>(() => _i189.CompanyModule(
      get<_i168.CompanyProfileScreen>(), get<_i167.CompanyFinanceScreen>()));
  gh.factory<_i190.StoresModule>(() => _i190.StoresModule(
      get<_i149.StoresScreen>(),
      get<_i178.StoreInfoScreen>(),
      get<_i180.StoresInActiveScreen>(),
      get<_i142.StoreBalanceScreen>(),
      get<_i181.StoresNeedsSupportScreen>(),
      get<_i174.OrderDetailsScreen>(),
      get<_i175.OrderLogsScreen>(),
      get<_i173.OrderCaptainNotArrivedScreen>(),
      get<_i176.OrderTimeLineScreen>(),
      get<_i145.StoreSubscriptionsFinanceDetailsScreen>(),
      get<_i179.StoreSubscriptionsFinanceScreen>()));
  gh.factory<_i191.SupplierModule>(() => _i191.SupplierModule(
      get<_i169.InActiveSupplierScreen>(),
      get<_i154.SuppliersScreen>(),
      get<_i185.SupplierProfileScreen>(),
      get<_i184.SupplierNeedsSupportScreen>(),
      get<_i182.SupplierAdsScreen>()));
  gh.factory<_i192.MyApp>(() => _i192.MyApp(
      get<_i18.AppThemeDataService>(),
      get<_i10.LocalizationService>(),
      get<_i66.FireNotificationService>(),
      get<_i8.LocalNotificationService>(),
      get<_i90.SplashModule>(),
      get<_i102.AuthorizationModule>(),
      get<_i166.ChatModule>(),
      get<_i141.SettingsModule>(),
      get<_i171.MainModule>(),
      get<_i190.StoresModule>(),
      get<_i165.CategoriesModule>(),
      get<_i189.CompanyModule>(),
      get<_i187.BranchesModule>(),
      get<_i172.NoticeModule>(),
      get<_i188.CaptainsModule>(),
      get<_i177.PaymentsModule>(),
      get<_i183.SupplierCategoriesModule>(),
      get<_i191.SupplierModule>(),
      get<_i164.CarsModule>(),
      get<_i104.BidOrderModule>(),
      get<_i137.OrdersModule>()));
  gh.singleton<_i193.GlobalStateManager>(_i193.GlobalStateManager());
  return get;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i149;
import '../module_auth/authoriazation_module.dart' as _i77;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i18;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i19;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i25;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i28;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i32;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i50;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i55;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i64;
import '../module_branches/branches_module.dart' as _i144;
import '../module_branches/manager/branches_manager.dart' as _i38;
import '../module_branches/repository/branches_repository.dart' as _i20;
import '../module_branches/service/branches_list_service.dart' as _i78;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i79;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i96;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i116;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i117;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i128;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i143;
import '../module_captain/captains_module.dart' as _i145;
import '../module_captain/manager/captains_manager.dart' as _i39;
import '../module_captain/repository/captains_repository.dart' as _i21;
import '../module_captain/service/captains_service.dart' as _i40;
import '../module_captain/state_manager/captain_account_balance_state_manager.dart'
    as _i76;
import '../module_captain/state_manager/captain_list.dart' as _i41;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i87;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i84;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i86;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i54;
import '../module_captain/ui/screen/captain_account_balance_screen.dart'
    as _i80;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i122;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i121;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i88;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i85;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i94;
import '../module_categories/categories_module.dart' as _i123;
import '../module_categories/manager/categories_manager.dart' as _i42;
import '../module_categories/repository/categories_repository.dart' as _i22;
import '../module_categories/service/store_categories_service.dart' as _i43;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i59;
import '../module_categories/state_manager/packages_state_manager.dart' as _i60;
import '../module_categories/ui/screen/categories_screen.dart' as _i89;
import '../module_categories/ui/screen/packages_screen.dart' as _i103;
import '../module_chat/chat_module.dart' as _i124;
import '../module_chat/manager/chat/chat_manager.dart' as _i44;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i23;
import '../module_chat/service/chat/char_service.dart' as _i45;
import '../module_chat/state_manager/chat_state_manager.dart' as _i46;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i90;
import '../module_company/company_module.dart' as _i146;
import '../module_company/manager/company_manager.dart' as _i47;
import '../module_company/repository/company_repository.dart' as _i24;
import '../module_company/service/company_service.dart' as _i48;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i91;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i92;
import '../module_company/ui/screen/company_finance_screen.dart' as _i125;
import '../module_company/ui/screen/company_profile_screen.dart' as _i126;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_main/main_module.dart' as _i129;
import '../module_main/manager/home_manager.dart' as _i51;
import '../module_main/repository/home_repository.dart' as _i26;
import '../module_main/sceen/home_screen.dart' as _i93;
import '../module_main/sceen/main_screen.dart' as _i97;
import '../module_main/service/home_service.dart' as _i52;
import '../module_main/state_manager/home_state_manager.dart' as _i53;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notice/manager/notice_manager.dart' as _i56;
import '../module_notice/notice_module.dart' as _i130;
import '../module_notice/repository/notice_repository.dart' as _i29;
import '../module_notice/service/notice_service.dart' as _i57;
import '../module_notice/state_manager/notice_state_manager.dart' as _i58;
import '../module_notice/ui/screen/notice_screen.dart' as _i98;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i30;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i49;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_payments/manager/payments_manager.dart' as _i61;
import '../module_payments/payments_module.dart' as _i135;
import '../module_payments/repository/payments_repository.dart' as _i31;
import '../module_payments/service/payments_service.dart' as _i62;
import '../module_payments/state_manager/captain_finance_by_hours_state_manager.dart'
    as _i81;
import '../module_payments/state_manager/captain_finance_by_order_count_state_manager.dart'
    as _i82;
import '../module_payments/state_manager/captain_finance_by_order_state_manager.dart'
    as _i83;
import '../module_payments/state_manager/payments_to_state_manager.dart'
    as _i63;
import '../module_payments/state_manager/store_balance_state_manager.dart'
    as _i67;
import '../module_payments/ui/screen/captain_finance_by_hours_screen.dart'
    as _i119;
import '../module_payments/ui/screen/captain_finance_by_order_count_screen.dart'
    as _i118;
import '../module_payments/ui/screen/captain_finance_by_order_screen.dart'
    as _i120;
import '../module_payments/ui/screen/payment_to_captain_screen.dart' as _i104;
import '../module_payments/ui/screen/store_balance_screen.dart' as _i106;
import '../module_settings/settings_module.dart' as _i105;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i65;
import '../module_splash/splash_module.dart' as _i66;
import '../module_splash/ui/screen/splash_screen.dart' as _i33;
import '../module_stores/manager/stores_manager.dart' as _i68;
import '../module_stores/repository/stores_repository.dart' as _i34;
import '../module_stores/service/store_service.dart' as _i69;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i99;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i100;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i101;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i102;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i107;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i108;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i109;
import '../module_stores/state_manager/stores_state_manager.dart' as _i70;
import '../module_stores/stores_module.dart' as _i147;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i131;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i132;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i133;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i134;
import '../module_stores/ui/screen/store_info_screen.dart' as _i136;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i137;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i138;
import '../module_stores/ui/screen/stores_screen.dart' as _i110;
import '../module_supplier/manager/supplier_manager.dart' as _i37;
import '../module_supplier/repository/supplier_repository.dart' as _i36;
import '../module_supplier/service/supplier_service.dart' as _i74;
import '../module_supplier/state_manager/in_active_supplier_state_manager.dart'
    as _i95;
import '../module_supplier/state_manager/supplier_ads_state_manager.dart'
    as _i111;
import '../module_supplier/state_manager/supplier_list.dart' as _i75;
import '../module_supplier/state_manager/supplier_need_support_state_manager.dart'
    as _i113;
import '../module_supplier/state_manager/supplier_profile_state_manager.dart'
    as _i114;
import '../module_supplier/supplier_module.dart' as _i148;
import '../module_supplier/ui/screen/in_active_supplier_screen.dart' as _i127;
import '../module_supplier/ui/screen/supplier_ads_screen.dart' as _i139;
import '../module_supplier/ui/screen/supplier_list_screen.dart' as _i115;
import '../module_supplier/ui/screen/supplier_needs_support_screen.dart'
    as _i141;
import '../module_supplier/ui/screen/supplier_profile_screen.dart' as _i142;
import '../module_supplier_categories/categories_supplier_module.dart' as _i140;
import '../module_supplier_categories/manager/categories_manager.dart' as _i71;
import '../module_supplier_categories/repository/categories_repository.dart'
    as _i35;
import '../module_supplier_categories/service/supplier_categories_service.dart'
    as _i72;
import '../module_supplier_categories/state_manager/categories_state_manager.dart'
    as _i73;
import '../module_supplier_categories/ui/screen/supplier_categories_screen.dart'
    as _i112;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i27;
import '../utils/global/global_state_manager.dart' as _i150;
import '../utils/helpers/firestore_helper.dart' as _i5;
import '../utils/logger/logger.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.factory<_i4.ChatHiveHelper>(() => _i4.ChatHiveHelper());
  gh.factory<_i5.FireStoreHelper>(() => _i5.FireStoreHelper());
  gh.factory<_i6.LocalNotificationService>(
      () => _i6.LocalNotificationService());
  gh.factory<_i7.LocalizationPreferencesHelper>(
      () => _i7.LocalizationPreferencesHelper());
  gh.factory<_i8.LocalizationService>(
      () => _i8.LocalizationService(get<_i7.LocalizationPreferencesHelper>()));
  gh.factory<_i9.Logger>(() => _i9.Logger());
  gh.factory<_i10.NotificationsPrefHelper>(
      () => _i10.NotificationsPrefHelper());
  gh.factory<_i11.ThemePreferencesHelper>(() => _i11.ThemePreferencesHelper());
  gh.factory<_i12.UploadRepository>(() => _i12.UploadRepository());
  gh.factory<_i13.ApiClient>(() => _i13.ApiClient(get<_i9.Logger>()));
  gh.factory<_i14.AppThemeDataService>(
      () => _i14.AppThemeDataService(get<_i11.ThemePreferencesHelper>()));
  gh.factory<_i15.AuthRepository>(
      () => _i15.AuthRepository(get<_i13.ApiClient>(), get<_i9.Logger>()));
  gh.factory<_i16.ChooseLocalScreen>(
      () => _i16.ChooseLocalScreen(get<_i8.LocalizationService>()));
  gh.factory<_i17.UploadManager>(
      () => _i17.UploadManager(get<_i12.UploadRepository>()));
  gh.factory<_i18.AuthManager>(
      () => _i18.AuthManager(get<_i15.AuthRepository>()));
  gh.factory<_i19.AuthService>(() =>
      _i19.AuthService(get<_i3.AuthPrefsHelper>(), get<_i18.AuthManager>()));
  gh.factory<_i20.BranchesRepository>(() =>
      _i20.BranchesRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i21.CaptainsRepository>(() =>
      _i21.CaptainsRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i22.CategoriesRepository>(() => _i22.CategoriesRepository(
      get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i23.ChatRepository>(() =>
      _i23.ChatRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i24.CompanyRepository>(() =>
      _i24.CompanyRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i25.ForgotPassStateManager>(
      () => _i25.ForgotPassStateManager(get<_i19.AuthService>()));
  gh.factory<_i26.HomeRepository>(() =>
      _i26.HomeRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i27.ImageUploadService>(
      () => _i27.ImageUploadService(get<_i17.UploadManager>()));
  gh.factory<_i28.LoginStateManager>(
      () => _i28.LoginStateManager(get<_i19.AuthService>()));
  gh.factory<_i29.NoticeRepository>(() =>
      _i29.NoticeRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i30.NotificationRepo>(() =>
      _i30.NotificationRepo(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i31.PaymentsRepository>(() =>
      _i31.PaymentsRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i32.RegisterStateManager>(
      () => _i32.RegisterStateManager(get<_i19.AuthService>()));
  gh.factory<_i33.SplashScreen>(
      () => _i33.SplashScreen(get<_i19.AuthService>()));
  gh.factory<_i34.StoresRepository>(() =>
      _i34.StoresRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i35.SupplierCategoriesRepository>(() =>
      _i35.SupplierCategoriesRepository(
          get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i36.SupplierRepository>(() =>
      _i36.SupplierRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i37.SuppliersManager>(
      () => _i37.SuppliersManager(get<_i36.SupplierRepository>()));
  gh.factory<_i38.BranchesManager>(
      () => _i38.BranchesManager(get<_i20.BranchesRepository>()));
  gh.factory<_i39.CaptainsManager>(
      () => _i39.CaptainsManager(get<_i21.CaptainsRepository>()));
  gh.factory<_i40.CaptainsService>(
      () => _i40.CaptainsService(get<_i39.CaptainsManager>()));
  gh.factory<_i41.CaptainsStateManager>(
      () => _i41.CaptainsStateManager(get<_i40.CaptainsService>()));
  gh.factory<_i42.CategoriesManager>(
      () => _i42.CategoriesManager(get<_i22.CategoriesRepository>()));
  gh.factory<_i43.CategoriesService>(
      () => _i43.CategoriesService(get<_i42.CategoriesManager>()));
  gh.factory<_i44.ChatManager>(
      () => _i44.ChatManager(get<_i23.ChatRepository>()));
  gh.factory<_i45.ChatService>(() => _i45.ChatService(get<_i44.ChatManager>()));
  gh.factory<_i46.ChatStateManager>(
      () => _i46.ChatStateManager(get<_i45.ChatService>()));
  gh.factory<_i47.CompanyManager>(
      () => _i47.CompanyManager(get<_i24.CompanyRepository>()));
  gh.factory<_i48.CompanyService>(
      () => _i48.CompanyService(get<_i47.CompanyManager>()));
  gh.factory<_i49.FireNotificationService>(() => _i49.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i30.NotificationRepo>()));
  gh.factory<_i50.ForgotPassScreen>(
      () => _i50.ForgotPassScreen(get<_i25.ForgotPassStateManager>()));
  gh.factory<_i51.HomeManager>(
      () => _i51.HomeManager(get<_i26.HomeRepository>()));
  gh.factory<_i52.HomeService>(() => _i52.HomeService(get<_i51.HomeManager>()));
  gh.factory<_i53.HomeStateManager>(
      () => _i53.HomeStateManager(get<_i52.HomeService>()));
  gh.factory<_i54.InActiveCaptainsStateManager>(
      () => _i54.InActiveCaptainsStateManager(get<_i40.CaptainsService>()));
  gh.factory<_i55.LoginScreen>(
      () => _i55.LoginScreen(get<_i28.LoginStateManager>()));
  gh.factory<_i56.NoticeManager>(
      () => _i56.NoticeManager(get<_i29.NoticeRepository>()));
  gh.factory<_i57.NoticeService>(
      () => _i57.NoticeService(get<_i56.NoticeManager>()));
  gh.factory<_i58.NoticeStateManager>(
      () => _i58.NoticeStateManager(get<_i57.NoticeService>()));
  gh.factory<_i59.PackageCategoriesStateManager>(() =>
      _i59.PackageCategoriesStateManager(
          get<_i43.CategoriesService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i60.PackagesStateManager>(() => _i60.PackagesStateManager(
      get<_i43.CategoriesService>(), get<_i19.AuthService>()));
  gh.factory<_i61.PaymentsManager>(
      () => _i61.PaymentsManager(get<_i31.PaymentsRepository>()));
  gh.factory<_i62.PaymentsService>(
      () => _i62.PaymentsService(get<_i61.PaymentsManager>()));
  gh.factory<_i63.PaymentsToCaptainStateManager>(
      () => _i63.PaymentsToCaptainStateManager(get<_i62.PaymentsService>()));
  gh.factory<_i64.RegisterScreen>(
      () => _i64.RegisterScreen(get<_i32.RegisterStateManager>()));
  gh.factory<_i65.SettingsScreen>(() => _i65.SettingsScreen(
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i49.FireNotificationService>()));
  gh.factory<_i66.SplashModule>(
      () => _i66.SplashModule(get<_i33.SplashScreen>()));
  gh.factory<_i67.StoreBalanceStateManager>(
      () => _i67.StoreBalanceStateManager(get<_i62.PaymentsService>()));
  gh.factory<_i68.StoreManager>(
      () => _i68.StoreManager(get<_i34.StoresRepository>()));
  gh.factory<_i69.StoresService>(
      () => _i69.StoresService(get<_i68.StoreManager>()));
  gh.factory<_i70.StoresStateManager>(() => _i70.StoresStateManager(
      get<_i69.StoresService>(),
      get<_i19.AuthService>(),
      get<_i27.ImageUploadService>()));
  gh.factory<_i71.SupplierCategoriesManager>(() =>
      _i71.SupplierCategoriesManager(get<_i35.SupplierCategoriesRepository>()));
  gh.factory<_i72.SupplierCategoriesService>(() =>
      _i72.SupplierCategoriesService(get<_i71.SupplierCategoriesManager>()));
  gh.factory<_i73.SupplierCategoriesStateManager>(() =>
      _i73.SupplierCategoriesStateManager(get<_i72.SupplierCategoriesService>(),
          get<_i27.ImageUploadService>()));
  gh.factory<_i74.SupplierService>(
      () => _i74.SupplierService(get<_i37.SuppliersManager>()));
  gh.factory<_i75.SuppliersStateManager>(
      () => _i75.SuppliersStateManager(get<_i74.SupplierService>()));
  gh.factory<_i76.AccountBalanceStateManager>(
      () => _i76.AccountBalanceStateManager(get<_i40.CaptainsService>()));
  gh.factory<_i77.AuthorizationModule>(() => _i77.AuthorizationModule(
      get<_i55.LoginScreen>(),
      get<_i64.RegisterScreen>(),
      get<_i50.ForgotPassScreen>()));
  gh.factory<_i78.BranchesListService>(
      () => _i78.BranchesListService(get<_i38.BranchesManager>()));
  gh.factory<_i79.BranchesListStateManager>(
      () => _i79.BranchesListStateManager(get<_i78.BranchesListService>()));
  gh.factory<_i80.CaptainAccountBalanceScreen>(() =>
      _i80.CaptainAccountBalanceScreen(get<_i76.AccountBalanceStateManager>()));
  gh.factory<_i81.CaptainFinanceByHoursStateManager>(() =>
      _i81.CaptainFinanceByHoursStateManager(get<_i62.PaymentsService>()));
  gh.factory<_i82.CaptainFinanceByOrderCountStateManager>(() =>
      _i82.CaptainFinanceByOrderCountStateManager(get<_i62.PaymentsService>()));
  gh.factory<_i83.CaptainFinanceByOrderStateManager>(() =>
      _i83.CaptainFinanceByOrderStateManager(get<_i62.PaymentsService>()));
  gh.factory<_i84.CaptainOfferStateManager>(() => _i84.CaptainOfferStateManager(
      get<_i40.CaptainsService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i85.CaptainOffersScreen>(
      () => _i85.CaptainOffersScreen(get<_i84.CaptainOfferStateManager>()));
  gh.factory<_i86.CaptainProfileStateManager>(
      () => _i86.CaptainProfileStateManager(get<_i40.CaptainsService>()));
  gh.factory<_i87.CaptainsNeedsSupportStateManager>(
      () => _i87.CaptainsNeedsSupportStateManager(get<_i40.CaptainsService>()));
  gh.factory<_i88.CaptainsScreen>(
      () => _i88.CaptainsScreen(get<_i41.CaptainsStateManager>()));
  gh.factory<_i89.CategoriesScreen>(
      () => _i89.CategoriesScreen(get<_i59.PackageCategoriesStateManager>()));
  gh.factory<_i90.ChatPage>(() => _i90.ChatPage(
      get<_i46.ChatStateManager>(),
      get<_i27.ImageUploadService>(),
      get<_i19.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i91.CompanyFinanceStateManager>(() =>
      _i91.CompanyFinanceStateManager(
          get<_i19.AuthService>(), get<_i48.CompanyService>()));
  gh.factory<_i92.CompanyProfileStateManager>(() =>
      _i92.CompanyProfileStateManager(
          get<_i19.AuthService>(), get<_i48.CompanyService>()));
  gh.factory<_i93.HomeScreen>(
      () => _i93.HomeScreen(get<_i53.HomeStateManager>()));
  gh.factory<_i94.InActiveCaptainsScreen>(() =>
      _i94.InActiveCaptainsScreen(get<_i54.InActiveCaptainsStateManager>()));
  gh.factory<_i95.InActiveSupplierStateManager>(
      () => _i95.InActiveSupplierStateManager(get<_i74.SupplierService>()));
  gh.factory<_i96.InitBranchesStateManager>(
      () => _i96.InitBranchesStateManager(get<_i78.BranchesListService>()));
  gh.factory<_i97.MainScreen>(() => _i97.MainScreen(get<_i93.HomeScreen>()));
  gh.factory<_i98.NoticeScreen>(
      () => _i98.NoticeScreen(get<_i58.NoticeStateManager>()));
  gh.factory<_i99.OrderCaptainNotArrivedStateManager>(
      () => _i99.OrderCaptainNotArrivedStateManager(get<_i69.StoresService>()));
  gh.factory<_i100.OrderLogsStateManager>(
      () => _i100.OrderLogsStateManager(get<_i69.StoresService>()));
  gh.factory<_i101.OrderStatusStateManager>(() => _i101.OrderStatusStateManager(
      get<_i69.StoresService>(), get<_i19.AuthService>()));
  gh.factory<_i102.OrderTimeLineStateManager>(() =>
      _i102.OrderTimeLineStateManager(
          get<_i69.StoresService>(), get<_i19.AuthService>()));
  gh.factory<_i103.PackagesScreen>(
      () => _i103.PackagesScreen(get<_i60.PackagesStateManager>()));
  gh.factory<_i104.PaymentsToCaptainScreen>(() =>
      _i104.PaymentsToCaptainScreen(get<_i63.PaymentsToCaptainStateManager>()));
  gh.factory<_i105.SettingsModule>(() => _i105.SettingsModule(
      get<_i65.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i106.StoreBalanceScreen>(
      () => _i106.StoreBalanceScreen(get<_i67.StoreBalanceStateManager>()));
  gh.factory<_i107.StoreProfileStateManager>(
      () => _i107.StoreProfileStateManager(get<_i69.StoresService>()));
  gh.factory<_i108.StoresInActiveStateManager>(() =>
      _i108.StoresInActiveStateManager(get<_i69.StoresService>(),
          get<_i19.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i109.StoresNeedsSupportStateManager>(
      () => _i109.StoresNeedsSupportStateManager(get<_i69.StoresService>()));
  gh.factory<_i110.StoresScreen>(
      () => _i110.StoresScreen(get<_i70.StoresStateManager>()));
  gh.factory<_i111.SupplierAdsStateManager>(
      () => _i111.SupplierAdsStateManager(get<_i74.SupplierService>()));
  gh.factory<_i112.SupplierCategoriesScreen>(() =>
      _i112.SupplierCategoriesScreen(
          get<_i73.SupplierCategoriesStateManager>()));
  gh.factory<_i113.SupplierNeedsSupportStateManager>(() =>
      _i113.SupplierNeedsSupportStateManager(get<_i74.SupplierService>()));
  gh.factory<_i114.SupplierProfileStateManager>(
      () => _i114.SupplierProfileStateManager(get<_i74.SupplierService>()));
  gh.factory<_i115.SuppliersScreen>(
      () => _i115.SuppliersScreen(get<_i75.SuppliersStateManager>()));
  gh.factory<_i116.UpdateBranchStateManager>(
      () => _i116.UpdateBranchStateManager(get<_i78.BranchesListService>()));
  gh.factory<_i117.BranchesListScreen>(
      () => _i117.BranchesListScreen(get<_i79.BranchesListStateManager>()));
  gh.factory<_i118.CaptainFinanceByCountOrderScreen>(() =>
      _i118.CaptainFinanceByCountOrderScreen(
          get<_i82.CaptainFinanceByOrderCountStateManager>()));
  gh.factory<_i119.CaptainFinanceByHoursScreen>(() =>
      _i119.CaptainFinanceByHoursScreen(
          get<_i81.CaptainFinanceByHoursStateManager>()));
  gh.factory<_i120.CaptainFinanceByOrderScreen>(() =>
      _i120.CaptainFinanceByOrderScreen(
          get<_i83.CaptainFinanceByOrderStateManager>()));
  gh.factory<_i121.CaptainProfileScreen>(
      () => _i121.CaptainProfileScreen(get<_i86.CaptainProfileStateManager>()));
  gh.factory<_i122.CaptainsNeedsSupportScreen>(() =>
      _i122.CaptainsNeedsSupportScreen(
          get<_i87.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i123.CategoriesModule>(() => _i123.CategoriesModule(
      get<_i89.CategoriesScreen>(), get<_i103.PackagesScreen>()));
  gh.factory<_i124.ChatModule>(
      () => _i124.ChatModule(get<_i90.ChatPage>(), get<_i19.AuthService>()));
  gh.factory<_i125.CompanyFinanceScreen>(
      () => _i125.CompanyFinanceScreen(get<_i91.CompanyFinanceStateManager>()));
  gh.factory<_i126.CompanyProfileScreen>(
      () => _i126.CompanyProfileScreen(get<_i92.CompanyProfileStateManager>()));
  gh.factory<_i127.InActiveSupplierScreen>(() =>
      _i127.InActiveSupplierScreen(get<_i95.InActiveSupplierStateManager>()));
  gh.factory<_i128.InitBranchesScreen>(
      () => _i128.InitBranchesScreen(get<_i96.InitBranchesStateManager>()));
  gh.factory<_i129.MainModule>(
      () => _i129.MainModule(get<_i97.MainScreen>(), get<_i93.HomeScreen>()));
  gh.factory<_i130.NoticeModule>(
      () => _i130.NoticeModule(get<_i98.NoticeScreen>()));
  gh.factory<_i131.OrderCaptainNotArrivedScreen>(() =>
      _i131.OrderCaptainNotArrivedScreen(
          get<_i99.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i132.OrderDetailsScreen>(
      () => _i132.OrderDetailsScreen(get<_i101.OrderStatusStateManager>()));
  gh.factory<_i133.OrderLogsScreen>(
      () => _i133.OrderLogsScreen(get<_i100.OrderLogsStateManager>()));
  gh.factory<_i134.OrderTimeLineScreen>(
      () => _i134.OrderTimeLineScreen(get<_i102.OrderTimeLineStateManager>()));
  gh.factory<_i135.PaymentsModule>(() => _i135.PaymentsModule(
      get<_i118.CaptainFinanceByCountOrderScreen>(),
      get<_i119.CaptainFinanceByHoursScreen>(),
      get<_i120.CaptainFinanceByOrderScreen>(),
      get<_i104.PaymentsToCaptainScreen>()));
  gh.factory<_i136.StoreInfoScreen>(
      () => _i136.StoreInfoScreen(get<_i107.StoreProfileStateManager>()));
  gh.factory<_i137.StoresInActiveScreen>(() =>
      _i137.StoresInActiveScreen(get<_i108.StoresInActiveStateManager>()));
  gh.factory<_i138.StoresNeedsSupportScreen>(() =>
      _i138.StoresNeedsSupportScreen(
          get<_i109.StoresNeedsSupportStateManager>()));
  gh.factory<_i139.SupplierAdsScreen>(
      () => _i139.SupplierAdsScreen(get<_i111.SupplierAdsStateManager>()));
  gh.factory<_i140.SupplierCategoriesModule>(() =>
      _i140.SupplierCategoriesModule(get<_i112.SupplierCategoriesScreen>()));
  gh.factory<_i141.SupplierNeedsSupportScreen>(() =>
      _i141.SupplierNeedsSupportScreen(
          get<_i113.SupplierNeedsSupportStateManager>()));
  gh.factory<_i142.SupplierProfileScreen>(() =>
      _i142.SupplierProfileScreen(get<_i114.SupplierProfileStateManager>()));
  gh.factory<_i143.UpdateBranchScreen>(
      () => _i143.UpdateBranchScreen(get<_i116.UpdateBranchStateManager>()));
  gh.factory<_i144.BranchesModule>(() => _i144.BranchesModule(
      get<_i117.BranchesListScreen>(),
      get<_i143.UpdateBranchScreen>(),
      get<_i128.InitBranchesScreen>()));
  gh.factory<_i145.CaptainsModule>(() => _i145.CaptainsModule(
      get<_i85.CaptainOffersScreen>(),
      get<_i94.InActiveCaptainsScreen>(),
      get<_i88.CaptainsScreen>(),
      get<_i121.CaptainProfileScreen>(),
      get<_i122.CaptainsNeedsSupportScreen>(),
      get<_i80.CaptainAccountBalanceScreen>()));
  gh.factory<_i146.CompanyModule>(() => _i146.CompanyModule(
      get<_i126.CompanyProfileScreen>(), get<_i125.CompanyFinanceScreen>()));
  gh.factory<_i147.StoresModule>(() => _i147.StoresModule(
      get<_i110.StoresScreen>(),
      get<_i136.StoreInfoScreen>(),
      get<_i137.StoresInActiveScreen>(),
      get<_i106.StoreBalanceScreen>(),
      get<_i138.StoresNeedsSupportScreen>(),
      get<_i132.OrderDetailsScreen>(),
      get<_i133.OrderLogsScreen>(),
      get<_i131.OrderCaptainNotArrivedScreen>(),
      get<_i134.OrderTimeLineScreen>()));
  gh.factory<_i148.SupplierModule>(() => _i148.SupplierModule(
      get<_i127.InActiveSupplierScreen>(),
      get<_i115.SuppliersScreen>(),
      get<_i142.SupplierProfileScreen>(),
      get<_i141.SupplierNeedsSupportScreen>(),
      get<_i139.SupplierAdsScreen>()));
  gh.factory<_i149.MyApp>(() => _i149.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i49.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i66.SplashModule>(),
      get<_i77.AuthorizationModule>(),
      get<_i124.ChatModule>(),
      get<_i105.SettingsModule>(),
      get<_i129.MainModule>(),
      get<_i147.StoresModule>(),
      get<_i123.CategoriesModule>(),
      get<_i146.CompanyModule>(),
      get<_i144.BranchesModule>(),
      get<_i130.NoticeModule>(),
      get<_i145.CaptainsModule>(),
      get<_i135.PaymentsModule>(),
      get<_i140.SupplierCategoriesModule>(),
      get<_i148.SupplierModule>()));
  gh.singleton<_i150.GlobalStateManager>(_i150.GlobalStateManager());
  return get;
}

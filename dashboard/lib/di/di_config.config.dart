// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i119;
import '../module_auth/authoriazation_module.dart' as _i68;
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
    as _i47;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i52;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i60;
import '../module_branches/branches_module.dart' as _i115;
import '../module_branches/manager/branches_manager.dart' as _i35;
import '../module_branches/repository/branches_repository.dart' as _i20;
import '../module_branches/service/branches_list_service.dart' as _i69;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i70;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i82;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i96;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i97;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i104;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i114;
import '../module_captain/captains_module.dart' as _i116;
import '../module_captain/manager/captains_manager.dart' as _i36;
import '../module_captain/repository/captains_repository.dart' as _i21;
import '../module_captain/service/captains_service.dart' as _i37;
import '../module_captain/state_manager/captain_list.dart' as _i38;
import '../module_captain/state_manager/captain_need_support_state_manager.dart'
    as _i74;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i71;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i73;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i51;
import '../module_captain/ui/screen/captain_needs_support_screen.dart' as _i99;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i98;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i75;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i72;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i81;
import '../module_categories/categories_module.dart' as _i100;
import '../module_categories/manager/categories_manager.dart' as _i39;
import '../module_categories/repository/categories_repository.dart' as _i22;
import '../module_categories/service/store_categories_service.dart' as _i40;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i56;
import '../module_categories/state_manager/packages_state_manager.dart' as _i57;
import '../module_categories/ui/screen/categories_screen.dart' as _i76;
import '../module_categories/ui/screen/packages_screen.dart' as _i89;
import '../module_chat/chat_module.dart' as _i101;
import '../module_chat/manager/chat/chat_manager.dart' as _i41;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i23;
import '../module_chat/service/chat/char_service.dart' as _i42;
import '../module_chat/state_manager/chat_state_manager.dart' as _i43;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i77;
import '../module_company/company_module.dart' as _i117;
import '../module_company/manager/company_manager.dart' as _i44;
import '../module_company/repository/company_repository.dart' as _i24;
import '../module_company/service/company_service.dart' as _i45;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i78;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i79;
import '../module_company/ui/screen/company_finance_screen.dart' as _i102;
import '../module_company/ui/screen/company_profile_screen.dart' as _i103;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_main/main_module.dart' as _i105;
import '../module_main/manager/home_manager.dart' as _i48;
import '../module_main/repository/home_repository.dart' as _i26;
import '../module_main/sceen/home_screen.dart' as _i80;
import '../module_main/sceen/main_screen.dart' as _i83;
import '../module_main/service/home_service.dart' as _i49;
import '../module_main/state_manager/home_state_manager.dart' as _i50;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notice/manager/notice_manager.dart' as _i53;
import '../module_notice/notice_module.dart' as _i106;
import '../module_notice/repository/notice_repository.dart' as _i29;
import '../module_notice/service/notice_service.dart' as _i54;
import '../module_notice/state_manager/notice_state_manager.dart' as _i55;
import '../module_notice/ui/screen/notice_screen.dart' as _i84;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i30;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i46;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_payments/manager/payments_manager.dart' as _i58;
import '../module_payments/repository/payments_repository.dart' as _i31;
import '../module_payments/service/payments_service.dart' as _i59;
import '../module_settings/settings_module.dart' as _i90;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i61;
import '../module_splash/splash_module.dart' as _i62;
import '../module_splash/ui/screen/splash_screen.dart' as _i33;
import '../module_stores/manager/stores_manager.dart' as _i64;
import '../module_stores/repository/stores_repository.dart' as _i34;
import '../module_stores/service/store_payment.dart' as _i65;
import '../module_stores/service/store_service.dart' as _i66;
import '../module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart'
    as _i85;
import '../module_stores/state_manager/order/order_logs_state_manager.dart'
    as _i86;
import '../module_stores/state_manager/order/order_status.state_manager.dart'
    as _i87;
import '../module_stores/state_manager/order/order_time_line_state_manager.dart'
    as _i88;
import '../module_stores/state_manager/store_balance_state_manager.dart'
    as _i63;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i92;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i93;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i94;
import '../module_stores/state_manager/stores_state_manager.dart' as _i67;
import '../module_stores/stores_module.dart' as _i118;
import '../module_stores/ui/screen/order/order_captain_not_arrived.dart'
    as _i107;
import '../module_stores/ui/screen/order/order_details_screen.dart' as _i108;
import '../module_stores/ui/screen/order/order_logs_screen.dart' as _i109;
import '../module_stores/ui/screen/order/order_time_line_screen.dart' as _i110;
import '../module_stores/ui/screen/store_balance_screen.dart' as _i91;
import '../module_stores/ui/screen/store_info_screen.dart' as _i111;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i112;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i113;
import '../module_stores/ui/screen/stores_screen.dart' as _i95;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i27;
import '../utils/global/global_state_manager.dart' as _i120;
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
  gh.factory<_i35.BranchesManager>(
      () => _i35.BranchesManager(get<_i20.BranchesRepository>()));
  gh.factory<_i36.CaptainsManager>(
      () => _i36.CaptainsManager(get<_i21.CaptainsRepository>()));
  gh.factory<_i37.CaptainsService>(
      () => _i37.CaptainsService(get<_i36.CaptainsManager>()));
  gh.factory<_i38.CaptainsStateManager>(
      () => _i38.CaptainsStateManager(get<_i37.CaptainsService>()));
  gh.factory<_i39.CategoriesManager>(
      () => _i39.CategoriesManager(get<_i22.CategoriesRepository>()));
  gh.factory<_i40.CategoriesService>(
      () => _i40.CategoriesService(get<_i39.CategoriesManager>()));
  gh.factory<_i41.ChatManager>(
      () => _i41.ChatManager(get<_i23.ChatRepository>()));
  gh.factory<_i42.ChatService>(() => _i42.ChatService(get<_i41.ChatManager>()));
  gh.factory<_i43.ChatStateManager>(
      () => _i43.ChatStateManager(get<_i42.ChatService>()));
  gh.factory<_i44.CompanyManager>(
      () => _i44.CompanyManager(get<_i24.CompanyRepository>()));
  gh.factory<_i45.CompanyService>(
      () => _i45.CompanyService(get<_i44.CompanyManager>()));
  gh.factory<_i46.FireNotificationService>(() => _i46.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i30.NotificationRepo>()));
  gh.factory<_i47.ForgotPassScreen>(
      () => _i47.ForgotPassScreen(get<_i25.ForgotPassStateManager>()));
  gh.factory<_i48.HomeManager>(
      () => _i48.HomeManager(get<_i26.HomeRepository>()));
  gh.factory<_i49.HomeService>(() => _i49.HomeService(get<_i48.HomeManager>()));
  gh.factory<_i50.HomeStateManager>(
      () => _i50.HomeStateManager(get<_i49.HomeService>()));
  gh.factory<_i51.InActiveCaptainsStateManager>(
      () => _i51.InActiveCaptainsStateManager(get<_i37.CaptainsService>()));
  gh.factory<_i52.LoginScreen>(
      () => _i52.LoginScreen(get<_i28.LoginStateManager>()));
  gh.factory<_i53.NoticeManager>(
      () => _i53.NoticeManager(get<_i29.NoticeRepository>()));
  gh.factory<_i54.NoticeService>(
      () => _i54.NoticeService(get<_i53.NoticeManager>()));
  gh.factory<_i55.NoticeStateManager>(
      () => _i55.NoticeStateManager(get<_i54.NoticeService>()));
  gh.factory<_i56.PackageCategoriesStateManager>(() =>
      _i56.PackageCategoriesStateManager(
          get<_i40.CategoriesService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i57.PackagesStateManager>(() => _i57.PackagesStateManager(
      get<_i40.CategoriesService>(), get<_i19.AuthService>()));
  gh.factory<_i58.PaymentsManager>(
      () => _i58.PaymentsManager(get<_i31.PaymentsRepository>()));
  gh.factory<_i59.PaymentsService>(
      () => _i59.PaymentsService(get<_i58.PaymentsManager>()));
  gh.factory<_i60.RegisterScreen>(
      () => _i60.RegisterScreen(get<_i32.RegisterStateManager>()));
  gh.factory<_i61.SettingsScreen>(() => _i61.SettingsScreen(
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i46.FireNotificationService>()));
  gh.factory<_i62.SplashModule>(
      () => _i62.SplashModule(get<_i33.SplashScreen>()));
  gh.factory<_i63.StoreBalanceStateManager>(
      () => _i63.StoreBalanceStateManager(get<_i59.PaymentsService>()));
  gh.factory<_i64.StoreManager>(
      () => _i64.StoreManager(get<_i34.StoresRepository>()));
  gh.factory<_i65.StorePaymentsService>(
      () => _i65.StorePaymentsService(get<_i64.StoreManager>()));
  gh.factory<_i66.StoresService>(
      () => _i66.StoresService(get<_i64.StoreManager>()));
  gh.factory<_i67.StoresStateManager>(() => _i67.StoresStateManager(
      get<_i66.StoresService>(),
      get<_i19.AuthService>(),
      get<_i27.ImageUploadService>()));
  gh.factory<_i68.AuthorizationModule>(() => _i68.AuthorizationModule(
      get<_i52.LoginScreen>(),
      get<_i60.RegisterScreen>(),
      get<_i47.ForgotPassScreen>()));
  gh.factory<_i69.BranchesListService>(
      () => _i69.BranchesListService(get<_i35.BranchesManager>()));
  gh.factory<_i70.BranchesListStateManager>(
      () => _i70.BranchesListStateManager(get<_i69.BranchesListService>()));
  gh.factory<_i71.CaptainOfferStateManager>(() => _i71.CaptainOfferStateManager(
      get<_i37.CaptainsService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i72.CaptainOffersScreen>(
      () => _i72.CaptainOffersScreen(get<_i71.CaptainOfferStateManager>()));
  gh.factory<_i73.CaptainProfileStateManager>(
      () => _i73.CaptainProfileStateManager(get<_i37.CaptainsService>()));
  gh.factory<_i74.CaptainsNeedsSupportStateManager>(
      () => _i74.CaptainsNeedsSupportStateManager(get<_i37.CaptainsService>()));
  gh.factory<_i75.CaptainsScreen>(
      () => _i75.CaptainsScreen(get<_i38.CaptainsStateManager>()));
  gh.factory<_i76.CategoriesScreen>(
      () => _i76.CategoriesScreen(get<_i56.PackageCategoriesStateManager>()));
  gh.factory<_i77.ChatPage>(() => _i77.ChatPage(
      get<_i43.ChatStateManager>(),
      get<_i27.ImageUploadService>(),
      get<_i19.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i78.CompanyFinanceStateManager>(() =>
      _i78.CompanyFinanceStateManager(
          get<_i19.AuthService>(), get<_i45.CompanyService>()));
  gh.factory<_i79.CompanyProfileStateManager>(() =>
      _i79.CompanyProfileStateManager(
          get<_i19.AuthService>(), get<_i45.CompanyService>()));
  gh.factory<_i80.HomeScreen>(
      () => _i80.HomeScreen(get<_i50.HomeStateManager>()));
  gh.factory<_i81.InActiveCaptainsScreen>(() =>
      _i81.InActiveCaptainsScreen(get<_i51.InActiveCaptainsStateManager>()));
  gh.factory<_i82.InitBranchesStateManager>(
      () => _i82.InitBranchesStateManager(get<_i69.BranchesListService>()));
  gh.factory<_i83.MainScreen>(() => _i83.MainScreen(get<_i80.HomeScreen>()));
  gh.factory<_i84.NoticeScreen>(
      () => _i84.NoticeScreen(get<_i55.NoticeStateManager>()));
  gh.factory<_i85.OrderCaptainNotArrivedStateManager>(
      () => _i85.OrderCaptainNotArrivedStateManager(get<_i66.StoresService>()));
  gh.factory<_i86.OrderLogsStateManager>(
      () => _i86.OrderLogsStateManager(get<_i66.StoresService>()));
  gh.factory<_i87.OrderStatusStateManager>(() => _i87.OrderStatusStateManager(
      get<_i66.StoresService>(), get<_i19.AuthService>()));
  gh.factory<_i88.OrderTimeLineStateManager>(() =>
      _i88.OrderTimeLineStateManager(
          get<_i66.StoresService>(), get<_i19.AuthService>()));
  gh.factory<_i89.PackagesScreen>(
      () => _i89.PackagesScreen(get<_i57.PackagesStateManager>()));
  gh.factory<_i90.SettingsModule>(() => _i90.SettingsModule(
      get<_i61.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i91.StoreBalanceScreen>(
      () => _i91.StoreBalanceScreen(get<_i63.StoreBalanceStateManager>()));
  gh.factory<_i92.StoreProfileStateManager>(
      () => _i92.StoreProfileStateManager(get<_i66.StoresService>()));
  gh.factory<_i93.StoresInActiveStateManager>(() =>
      _i93.StoresInActiveStateManager(get<_i66.StoresService>(),
          get<_i19.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i94.StoresNeedsSupportStateManager>(
      () => _i94.StoresNeedsSupportStateManager(get<_i66.StoresService>()));
  gh.factory<_i95.StoresScreen>(
      () => _i95.StoresScreen(get<_i67.StoresStateManager>()));
  gh.factory<_i96.UpdateBranchStateManager>(
      () => _i96.UpdateBranchStateManager(get<_i69.BranchesListService>()));
  gh.factory<_i97.BranchesListScreen>(
      () => _i97.BranchesListScreen(get<_i70.BranchesListStateManager>()));
  gh.factory<_i98.CaptainProfileScreen>(
      () => _i98.CaptainProfileScreen(get<_i73.CaptainProfileStateManager>()));
  gh.factory<_i99.CaptainsNeedsSupportScreen>(() =>
      _i99.CaptainsNeedsSupportScreen(
          get<_i74.CaptainsNeedsSupportStateManager>()));
  gh.factory<_i100.CategoriesModule>(() => _i100.CategoriesModule(
      get<_i76.CategoriesScreen>(), get<_i89.PackagesScreen>()));
  gh.factory<_i101.ChatModule>(
      () => _i101.ChatModule(get<_i77.ChatPage>(), get<_i19.AuthService>()));
  gh.factory<_i102.CompanyFinanceScreen>(
      () => _i102.CompanyFinanceScreen(get<_i78.CompanyFinanceStateManager>()));
  gh.factory<_i103.CompanyProfileScreen>(
      () => _i103.CompanyProfileScreen(get<_i79.CompanyProfileStateManager>()));
  gh.factory<_i104.InitBranchesScreen>(
      () => _i104.InitBranchesScreen(get<_i82.InitBranchesStateManager>()));
  gh.factory<_i105.MainModule>(
      () => _i105.MainModule(get<_i83.MainScreen>(), get<_i80.HomeScreen>()));
  gh.factory<_i106.NoticeModule>(
      () => _i106.NoticeModule(get<_i84.NoticeScreen>()));
  gh.factory<_i107.OrderCaptainNotArrivedScreen>(() =>
      _i107.OrderCaptainNotArrivedScreen(
          get<_i85.OrderCaptainNotArrivedStateManager>()));
  gh.factory<_i108.OrderDetailsScreen>(
      () => _i108.OrderDetailsScreen(get<_i87.OrderStatusStateManager>()));
  gh.factory<_i109.OrderLogsScreen>(
      () => _i109.OrderLogsScreen(get<_i86.OrderLogsStateManager>()));
  gh.factory<_i110.OrderTimeLineScreen>(
      () => _i110.OrderTimeLineScreen(get<_i88.OrderTimeLineStateManager>()));
  gh.factory<_i111.StoreInfoScreen>(
      () => _i111.StoreInfoScreen(get<_i92.StoreProfileStateManager>()));
  gh.factory<_i112.StoresInActiveScreen>(
      () => _i112.StoresInActiveScreen(get<_i93.StoresInActiveStateManager>()));
  gh.factory<_i113.StoresNeedsSupportScreen>(() =>
      _i113.StoresNeedsSupportScreen(
          get<_i94.StoresNeedsSupportStateManager>()));
  gh.factory<_i114.UpdateBranchScreen>(
      () => _i114.UpdateBranchScreen(get<_i96.UpdateBranchStateManager>()));
  gh.factory<_i115.BranchesModule>(() => _i115.BranchesModule(
      get<_i97.BranchesListScreen>(),
      get<_i114.UpdateBranchScreen>(),
      get<_i104.InitBranchesScreen>()));
  gh.factory<_i116.CaptainsModule>(() => _i116.CaptainsModule(
      get<_i72.CaptainOffersScreen>(),
      get<_i81.InActiveCaptainsScreen>(),
      get<_i75.CaptainsScreen>(),
      get<_i98.CaptainProfileScreen>(),
      get<_i99.CaptainsNeedsSupportScreen>()));
  gh.factory<_i117.CompanyModule>(() => _i117.CompanyModule(
      get<_i103.CompanyProfileScreen>(), get<_i102.CompanyFinanceScreen>()));
  gh.factory<_i118.StoresModule>(() => _i118.StoresModule(
      get<_i95.StoresScreen>(),
      get<_i111.StoreInfoScreen>(),
      get<_i112.StoresInActiveScreen>(),
      get<_i91.StoreBalanceScreen>(),
      get<_i113.StoresNeedsSupportScreen>(),
      get<_i108.OrderDetailsScreen>(),
      get<_i109.OrderLogsScreen>(),
      get<_i107.OrderCaptainNotArrivedScreen>(),
      get<_i110.OrderTimeLineScreen>()));
  gh.factory<_i119.MyApp>(() => _i119.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i46.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i62.SplashModule>(),
      get<_i68.AuthorizationModule>(),
      get<_i101.ChatModule>(),
      get<_i90.SettingsModule>(),
      get<_i105.MainModule>(),
      get<_i118.StoresModule>(),
      get<_i100.CategoriesModule>(),
      get<_i117.CompanyModule>(),
      get<_i115.BranchesModule>(),
      get<_i106.NoticeModule>(),
      get<_i116.CaptainsModule>()));
  gh.singleton<_i120.GlobalStateManager>(_i120.GlobalStateManager());
  return get;
}

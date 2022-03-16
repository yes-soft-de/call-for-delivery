// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../main.dart' as _i106;
import '../module_auth/authoriazation_module.dart' as _i64;
import '../module_auth/manager/auth_manager/auth_manager.dart' as _i18;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i15;
import '../module_auth/service/auth_service/auth_service.dart' as _i19;
import '../module_auth/state_manager/forget_state_manager/forget_password_state_manager.dart'
    as _i25;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i28;
import '../module_auth/state_manager/register_state_manager/register_state_manager.dart'
    as _i31;
import '../module_auth/ui/screen/forget_password_screen/forget_password_screen.dart'
    as _i46;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i51;
import '../module_auth/ui/screen/register_screen/register_screen.dart' as _i57;
import '../module_branches/branches_module.dart' as _i103;
import '../module_branches/manager/branches_manager.dart' as _i34;
import '../module_branches/repository/branches_repository.dart' as _i20;
import '../module_branches/service/branches_list_service.dart' as _i65;
import '../module_branches/state_manager/branches_list_state_manager/branches_list_state_manager.dart'
    as _i66;
import '../module_branches/state_manager/init_branches_state_manager.dart'
    as _i77;
import '../module_branches/state_manager/update_branches_state_manager/update_branches_state_manager.dart'
    as _i87;
import '../module_branches/ui/screens/branches_list_screen/branches_list_screen.dart'
    as _i88;
import '../module_branches/ui/screens/init_branches/init_branches_screen.dart'
    as _i95;
import '../module_branches/ui/screens/update_branches_screen/update_branches_screen.dart'
    as _i102;
import '../module_captain/captains_module.dart' as _i90;
import '../module_captain/manager/captains_manager.dart' as _i35;
import '../module_captain/repository/captains_repository.dart' as _i21;
import '../module_captain/service/captains_service.dart' as _i36;
import '../module_captain/state_manager/captain_list.dart' as _i37;
import '../module_captain/state_manager/captain_offer_state_manager.dart'
    as _i67;
import '../module_captain/state_manager/captain_profile_state_manager.dart'
    as _i69;
import '../module_captain/state_manager/in_active_captains_state_manager.dart'
    as _i50;
import '../module_captain/ui/screen/captain_profile_screen.dart' as _i89;
import '../module_captain/ui/screen/captains_list_screen.dart' as _i70;
import '../module_captain/ui/screen/captains_offer_screen.dart' as _i68;
import '../module_captain/ui/screen/in_active_captains_screen.dart' as _i76;
import '../module_categories/categories_module.dart' as _i91;
import '../module_categories/manager/categories_manager.dart' as _i38;
import '../module_categories/repository/categories_repository.dart' as _i22;
import '../module_categories/service/store_categories_service.dart' as _i39;
import '../module_categories/state_manager/categories_state_manager.dart'
    as _i55;
import '../module_categories/state_manager/packages_state_manager.dart' as _i56;
import '../module_categories/ui/screen/categories_screen.dart' as _i71;
import '../module_categories/ui/screen/packages_screen.dart' as _i80;
import '../module_chat/chat_module.dart' as _i92;
import '../module_chat/manager/chat/chat_manager.dart' as _i40;
import '../module_chat/presistance/chat_hive_helper.dart' as _i4;
import '../module_chat/repository/chat/chat_repository.dart' as _i23;
import '../module_chat/service/chat/char_service.dart' as _i41;
import '../module_chat/state_manager/chat_state_manager.dart' as _i42;
import '../module_chat/ui/screens/chat_page/chat_page.dart' as _i72;
import '../module_company/company_module.dart' as _i104;
import '../module_company/manager/company_manager.dart' as _i43;
import '../module_company/repository/company_repository.dart' as _i24;
import '../module_company/service/company_service.dart' as _i44;
import '../module_company/state_manager/company_financial_state_manager.dart'
    as _i73;
import '../module_company/state_manager/company_profile_state_manager.dart'
    as _i74;
import '../module_company/ui/screen/company_finance_screen.dart' as _i93;
import '../module_company/ui/screen/company_profile_screen.dart' as _i94;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i7;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i8;
import '../module_main/main_module.dart' as _i96;
import '../module_main/manager/home_manager.dart' as _i47;
import '../module_main/repository/home_repository.dart' as _i26;
import '../module_main/sceen/home_screen.dart' as _i75;
import '../module_main/sceen/main_screen.dart' as _i78;
import '../module_main/service/home_service.dart' as _i48;
import '../module_main/state_manager/home_state_manager.dart' as _i49;
import '../module_network/http_client/http_client.dart' as _i13;
import '../module_notice/manager/notice_manager.dart' as _i52;
import '../module_notice/notice_module.dart' as _i97;
import '../module_notice/repository/notice_repository.dart' as _i29;
import '../module_notice/service/notice_service.dart' as _i53;
import '../module_notice/state_manager/notice_state_manager.dart' as _i54;
import '../module_notice/ui/screen/notice_screen.dart' as _i79;
import '../module_notifications/preferences/notification_preferences/notification_preferences.dart'
    as _i10;
import '../module_notifications/repository/notification_repo.dart' as _i30;
import '../module_notifications/service/fire_notification_service/fire_notification_service.dart'
    as _i45;
import '../module_notifications/service/local_notification_service/local_notification_service.dart'
    as _i6;
import '../module_settings/settings_module.dart' as _i81;
import '../module_settings/ui/settings_page/choose_local_page.dart' as _i16;
import '../module_settings/ui/settings_page/settings_page.dart' as _i58;
import '../module_splash/splash_module.dart' as _i59;
import '../module_splash/ui/screen/splash_screen.dart' as _i32;
import '../module_stores/manager/stores_manager.dart' as _i60;
import '../module_stores/repository/stores_repository.dart' as _i33;
import '../module_stores/service/store_payment.dart' as _i61;
import '../module_stores/service/store_service.dart' as _i62;
import '../module_stores/state_manager/store_balance_state_manager.dart'
    as _i82;
import '../module_stores/state_manager/store_profile_state_manager.dart'
    as _i83;
import '../module_stores/state_manager/stores_inactive_state_manager.dart'
    as _i84;
import '../module_stores/state_manager/stores_need_support_state_manager.dart'
    as _i85;
import '../module_stores/state_manager/stores_state_manager.dart' as _i63;
import '../module_stores/stores_module.dart' as _i105;
import '../module_stores/ui/screen/store_balance_screen.dart' as _i98;
import '../module_stores/ui/screen/store_info_screen.dart' as _i99;
import '../module_stores/ui/screen/stores_inactive_screen.dart' as _i100;
import '../module_stores/ui/screen/stores_needs_support_screen.dart' as _i101;
import '../module_stores/ui/screen/stores_screen.dart' as _i86;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i11;
import '../module_theme/service/theme_service/theme_service.dart' as _i14;
import '../module_upload/manager/upload_manager/upload_manager.dart' as _i17;
import '../module_upload/repository/upload_repository/upload_repository.dart'
    as _i12;
import '../module_upload/service/image_upload/image_upload_service.dart'
    as _i27;
import '../utils/global/global_state_manager.dart' as _i107;
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
  gh.factory<_i31.RegisterStateManager>(
      () => _i31.RegisterStateManager(get<_i19.AuthService>()));
  gh.factory<_i32.SplashScreen>(
      () => _i32.SplashScreen(get<_i19.AuthService>()));
  gh.factory<_i33.StoresRepository>(() =>
      _i33.StoresRepository(get<_i13.ApiClient>(), get<_i19.AuthService>()));
  gh.factory<_i34.BranchesManager>(
      () => _i34.BranchesManager(get<_i20.BranchesRepository>()));
  gh.factory<_i35.CaptainsManager>(
      () => _i35.CaptainsManager(get<_i21.CaptainsRepository>()));
  gh.factory<_i36.CaptainsService>(
      () => _i36.CaptainsService(get<_i35.CaptainsManager>()));
  gh.factory<_i37.CaptainsStateManager>(
      () => _i37.CaptainsStateManager(get<_i36.CaptainsService>()));
  gh.factory<_i38.CategoriesManager>(
      () => _i38.CategoriesManager(get<_i22.CategoriesRepository>()));
  gh.factory<_i39.CategoriesService>(
      () => _i39.CategoriesService(get<_i38.CategoriesManager>()));
  gh.factory<_i40.ChatManager>(
      () => _i40.ChatManager(get<_i23.ChatRepository>()));
  gh.factory<_i41.ChatService>(() => _i41.ChatService(get<_i40.ChatManager>()));
  gh.factory<_i42.ChatStateManager>(
      () => _i42.ChatStateManager(get<_i41.ChatService>()));
  gh.factory<_i43.CompanyManager>(
      () => _i43.CompanyManager(get<_i24.CompanyRepository>()));
  gh.factory<_i44.CompanyService>(
      () => _i44.CompanyService(get<_i43.CompanyManager>()));
  gh.factory<_i45.FireNotificationService>(() => _i45.FireNotificationService(
      get<_i10.NotificationsPrefHelper>(), get<_i30.NotificationRepo>()));
  gh.factory<_i46.ForgotPassScreen>(
      () => _i46.ForgotPassScreen(get<_i25.ForgotPassStateManager>()));
  gh.factory<_i47.HomeManager>(
      () => _i47.HomeManager(get<_i26.HomeRepository>()));
  gh.factory<_i48.HomeService>(() => _i48.HomeService(get<_i47.HomeManager>()));
  gh.factory<_i49.HomeStateManager>(
      () => _i49.HomeStateManager(get<_i48.HomeService>()));
  gh.factory<_i50.InActiveCaptainsStateManager>(
      () => _i50.InActiveCaptainsStateManager(get<_i36.CaptainsService>()));
  gh.factory<_i51.LoginScreen>(
      () => _i51.LoginScreen(get<_i28.LoginStateManager>()));
  gh.factory<_i52.NoticeManager>(
      () => _i52.NoticeManager(get<_i29.NoticeRepository>()));
  gh.factory<_i53.NoticeService>(
      () => _i53.NoticeService(get<_i52.NoticeManager>()));
  gh.factory<_i54.NoticeStateManager>(
      () => _i54.NoticeStateManager(get<_i53.NoticeService>()));
  gh.factory<_i55.PackageCategoriesStateManager>(() =>
      _i55.PackageCategoriesStateManager(
          get<_i39.CategoriesService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i56.PackagesStateManager>(() => _i56.PackagesStateManager(
      get<_i39.CategoriesService>(), get<_i19.AuthService>()));
  gh.factory<_i57.RegisterScreen>(
      () => _i57.RegisterScreen(get<_i31.RegisterStateManager>()));
  gh.factory<_i58.SettingsScreen>(() => _i58.SettingsScreen(
      get<_i19.AuthService>(),
      get<_i8.LocalizationService>(),
      get<_i14.AppThemeDataService>(),
      get<_i45.FireNotificationService>()));
  gh.factory<_i59.SplashModule>(
      () => _i59.SplashModule(get<_i32.SplashScreen>()));
  gh.factory<_i60.StoreManager>(
      () => _i60.StoreManager(get<_i33.StoresRepository>()));
  gh.factory<_i61.StorePaymentsService>(
      () => _i61.StorePaymentsService(get<_i60.StoreManager>()));
  gh.factory<_i62.StoresService>(
      () => _i62.StoresService(get<_i60.StoreManager>()));
  gh.factory<_i63.StoresStateManager>(() => _i63.StoresStateManager(
      get<_i62.StoresService>(),
      get<_i19.AuthService>(),
      get<_i27.ImageUploadService>()));
  gh.factory<_i64.AuthorizationModule>(() => _i64.AuthorizationModule(
      get<_i51.LoginScreen>(),
      get<_i57.RegisterScreen>(),
      get<_i46.ForgotPassScreen>()));
  gh.factory<_i65.BranchesListService>(
      () => _i65.BranchesListService(get<_i34.BranchesManager>()));
  gh.factory<_i66.BranchesListStateManager>(
      () => _i66.BranchesListStateManager(get<_i65.BranchesListService>()));
  gh.factory<_i67.CaptainOfferStateManager>(() => _i67.CaptainOfferStateManager(
      get<_i36.CaptainsService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i68.CaptainOffersScreen>(
      () => _i68.CaptainOffersScreen(get<_i67.CaptainOfferStateManager>()));
  gh.factory<_i69.CaptainProfileStateManager>(
      () => _i69.CaptainProfileStateManager(get<_i36.CaptainsService>()));
  gh.factory<_i70.CaptainsScreen>(
      () => _i70.CaptainsScreen(get<_i37.CaptainsStateManager>()));
  gh.factory<_i71.CategoriesScreen>(
      () => _i71.CategoriesScreen(get<_i55.PackageCategoriesStateManager>()));
  gh.factory<_i72.ChatPage>(() => _i72.ChatPage(
      get<_i42.ChatStateManager>(),
      get<_i27.ImageUploadService>(),
      get<_i19.AuthService>(),
      get<_i4.ChatHiveHelper>()));
  gh.factory<_i73.CompanyFinanceStateManager>(() =>
      _i73.CompanyFinanceStateManager(
          get<_i19.AuthService>(), get<_i44.CompanyService>()));
  gh.factory<_i74.CompanyProfileStateManager>(() =>
      _i74.CompanyProfileStateManager(
          get<_i19.AuthService>(), get<_i44.CompanyService>()));
  gh.factory<_i75.HomeScreen>(
      () => _i75.HomeScreen(get<_i49.HomeStateManager>()));
  gh.factory<_i76.InActiveCaptainsScreen>(() =>
      _i76.InActiveCaptainsScreen(get<_i50.InActiveCaptainsStateManager>()));
  gh.factory<_i77.InitBranchesStateManager>(
      () => _i77.InitBranchesStateManager(get<_i65.BranchesListService>()));
  gh.factory<_i78.MainScreen>(() => _i78.MainScreen(get<_i75.HomeScreen>()));
  gh.factory<_i79.NoticeScreen>(
      () => _i79.NoticeScreen(get<_i54.NoticeStateManager>()));
  gh.factory<_i80.PackagesScreen>(
      () => _i80.PackagesScreen(get<_i56.PackagesStateManager>()));
  gh.factory<_i81.SettingsModule>(() => _i81.SettingsModule(
      get<_i58.SettingsScreen>(), get<_i16.ChooseLocalScreen>()));
  gh.factory<_i82.StoreBalanceStateManager>(() => _i82.StoreBalanceStateManager(
      get<_i62.StoresService>(), get<_i61.StorePaymentsService>()));
  gh.factory<_i83.StoreProfileStateManager>(
      () => _i83.StoreProfileStateManager(get<_i62.StoresService>()));
  gh.factory<_i84.StoresInActiveStateManager>(() =>
      _i84.StoresInActiveStateManager(get<_i62.StoresService>(),
          get<_i19.AuthService>(), get<_i27.ImageUploadService>()));
  gh.factory<_i85.StoresNeedsSupportStateManager>(
      () => _i85.StoresNeedsSupportStateManager(get<_i62.StoresService>()));
  gh.factory<_i86.StoresScreen>(
      () => _i86.StoresScreen(get<_i63.StoresStateManager>()));
  gh.factory<_i87.UpdateBranchStateManager>(
      () => _i87.UpdateBranchStateManager(get<_i65.BranchesListService>()));
  gh.factory<_i88.BranchesListScreen>(
      () => _i88.BranchesListScreen(get<_i66.BranchesListStateManager>()));
  gh.factory<_i89.CaptainProfileScreen>(
      () => _i89.CaptainProfileScreen(get<_i69.CaptainProfileStateManager>()));
  gh.factory<_i90.CaptainsModule>(() => _i90.CaptainsModule(
      get<_i68.CaptainOffersScreen>(),
      get<_i76.InActiveCaptainsScreen>(),
      get<_i70.CaptainsScreen>(),
      get<_i89.CaptainProfileScreen>()));
  gh.factory<_i91.CategoriesModule>(() => _i91.CategoriesModule(
      get<_i71.CategoriesScreen>(), get<_i80.PackagesScreen>()));
  gh.factory<_i92.ChatModule>(
      () => _i92.ChatModule(get<_i72.ChatPage>(), get<_i19.AuthService>()));
  gh.factory<_i93.CompanyFinanceScreen>(
      () => _i93.CompanyFinanceScreen(get<_i73.CompanyFinanceStateManager>()));
  gh.factory<_i94.CompanyProfileScreen>(
      () => _i94.CompanyProfileScreen(get<_i74.CompanyProfileStateManager>()));
  gh.factory<_i95.InitBranchesScreen>(
      () => _i95.InitBranchesScreen(get<_i77.InitBranchesStateManager>()));
  gh.factory<_i96.MainModule>(
      () => _i96.MainModule(get<_i78.MainScreen>(), get<_i75.HomeScreen>()));
  gh.factory<_i97.NoticeModule>(
      () => _i97.NoticeModule(get<_i79.NoticeScreen>()));
  gh.factory<_i98.StoreBalanceScreen>(
      () => _i98.StoreBalanceScreen(get<_i82.StoreBalanceStateManager>()));
  gh.factory<_i99.StoreInfoScreen>(
      () => _i99.StoreInfoScreen(get<_i83.StoreProfileStateManager>()));
  gh.factory<_i100.StoresInActiveScreen>(
      () => _i100.StoresInActiveScreen(get<_i84.StoresInActiveStateManager>()));
  gh.factory<_i101.StoresNeedsSupportScreen>(() =>
      _i101.StoresNeedsSupportScreen(
          get<_i85.StoresNeedsSupportStateManager>()));
  gh.factory<_i102.UpdateBranchScreen>(
      () => _i102.UpdateBranchScreen(get<_i87.UpdateBranchStateManager>()));
  gh.factory<_i103.BranchesModule>(() => _i103.BranchesModule(
      get<_i88.BranchesListScreen>(),
      get<_i102.UpdateBranchScreen>(),
      get<_i95.InitBranchesScreen>()));
  gh.factory<_i104.CompanyModule>(() => _i104.CompanyModule(
      get<_i94.CompanyProfileScreen>(), get<_i93.CompanyFinanceScreen>()));
  gh.factory<_i105.StoresModule>(() => _i105.StoresModule(
      get<_i86.StoresScreen>(),
      get<_i99.StoreInfoScreen>(),
      get<_i100.StoresInActiveScreen>(),
      get<_i98.StoreBalanceScreen>(),
      get<_i101.StoresNeedsSupportScreen>()));
  gh.factory<_i106.MyApp>(() => _i106.MyApp(
      get<_i14.AppThemeDataService>(),
      get<_i8.LocalizationService>(),
      get<_i45.FireNotificationService>(),
      get<_i6.LocalNotificationService>(),
      get<_i59.SplashModule>(),
      get<_i64.AuthorizationModule>(),
      get<_i92.ChatModule>(),
      get<_i81.SettingsModule>(),
      get<_i96.MainModule>(),
      get<_i105.StoresModule>(),
      get<_i91.CategoriesModule>(),
      get<_i104.CompanyModule>(),
      get<_i103.BranchesModule>(),
      get<_i97.NoticeModule>(),
      get<_i90.CaptainsModule>()));
  gh.singleton<_i107.GlobalStateManager>(_i107.GlobalStateManager());
  return get;
}

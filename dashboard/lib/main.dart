import 'dart:async';
import 'dart:io' as p;
import 'package:c4d/hive/util/argument_hive_helper.dart';
import 'package:c4d/module_bid_order/bid_order_module.dart';
import 'package:c4d/module_branches/branches_module.dart';
import 'package:c4d/module_captain/captains_module.dart';
import 'package:c4d/module_categories/categories_module.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_company/company_module.dart';
import 'package:c4d/module_delivary_car/cars_module.dart';
import 'package:c4d/module_main/main_module.dart';
import 'package:c4d/module_notice/notice_module.dart';
import 'package:c4d/module_notifications/model/notification_model.dart';
import 'package:c4d/module_orders/orders_module.dart';
import 'package:c4d/module_payments/payments_module.dart';
import 'package:c4d/module_stores/stores_module.dart';
import 'package:c4d/module_supplier_categories/categories_supplier_module.dart';
import 'package:device_info/device_info.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/utils/effect/scroll_behavior.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/hive/hive_init.dart';
import 'package:c4d/module_auth/authoriazation_module.dart';
import 'package:c4d/module_chat/chat_module.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:c4d/module_settings/settings_module.dart';
import 'package:c4d/module_splash/splash_module.dart';
import 'package:c4d/module_theme/service/theme_service/theme_service.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'module_notifications/service/local_notification_service/local_notification_service.dart';
import 'module_splash/splash_routes.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:lehttp_overrides/lehttp_overrides.dart';

import 'module_supplier/supplier_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  if (!kIsWeb) {
    if (p.Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt < 26) {
        p.HttpOverrides.global = LEHttpOverrides();
      }
    }
  }
  await HiveSetUp.init();
  await ArgumentHiveHelper().clean();
  await Firebase.initializeApp();
  if (kIsWeb) {
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = (FlutterErrorDetails details) {
      FirebaseCrashlytics.instance.recordFlutterError(details);
    };
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    FlutterError.onError = (FlutterErrorDetails details) async {
      Logger().error('Main', details.toString(), StackTrace.current);
    };
    await runZonedGuarded(() {
      configureDependencies();
      // Your App Here
      runApp(getIt<MyApp>());
    }, (error, stackTrace) {
      new Logger().error(
          'Main', error.toString() + stackTrace.toString(), StackTrace.current);
    });
  });
}

@injectable
class MyApp extends StatefulWidget {
  final AppThemeDataService _themeDataService;
  final LocalizationService _localizationService;
  final FireNotificationService _fireNotificationService;
  final LocalNotificationService _localNotificationService;
  final SplashModule _splashModule;
  final AuthorizationModule _authorizationModule;
  final SettingsModule _settingsModule;
  final ChatModule _chatModule;
  final MainModule _mainModule;
  final StoresModule _storesModule;
  final CategoriesModule _categoriesModule;
  final CompanyModule _companyModule;
  final BranchesModule _branchesModule;
  final NoticeModule _noticeModule;
  final CaptainsModule _captainsModule;
  final PaymentsModule _paymentsModule;
  final SupplierCategoriesModule _supplierCategoriesModule;
  final SupplierModule _supplierModule;
  final CarsModule _carsModule;
  final BidOrderModule _bidOrderModule;
  final OrdersModule _ordersModule;
  MyApp(
      this._themeDataService,
      this._localizationService,
      this._fireNotificationService,
      this._localNotificationService,
      this._splashModule,
      this._authorizationModule,
      this._chatModule,
      this._settingsModule,
      this._mainModule,
      this._storesModule,
      this._categoriesModule,
      this._companyModule,
      this._branchesModule,
      this._noticeModule,
      this._captainsModule,
      this._paymentsModule,
      this._supplierCategoriesModule,
      this._supplierModule,
      this._carsModule,
      this._bidOrderModule,
      this._ordersModule);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  late String lang;
  late ThemeData activeTheme;
  bool authorized = false;

  @override
  void initState() {
    super.initState();
    lang = widget._localizationService.getLanguage();
    activeTheme = widget._themeDataService.getActiveTheme();
    timeago.setDefaultLocale(lang);
    Moment.setLocaleGlobally(lang == 'en' ? LocaleEn() : LocaleAr());
    widget._fireNotificationService.init();
    widget._localNotificationService.init();
    widget._localizationService.localizationStream.listen((event) {
      timeago.setDefaultLocale(event);
      Moment.setLocaleGlobally(event == 'en' ? LocaleEn() : LocaleAr());
      lang = event;
      setState(() {});
    });
    widget._fireNotificationService.onNotificationStream.listen((event) {
      widget._localNotificationService.showNotification(event);
    });
    widget._localNotificationService.onLocalNotificationStream.listen((event) {
      NotificationModel notificationModel = NotificationModel.fromJson(event);
      if (notificationModel.navigateRoute == ChatRoutes.chatRoute) {
        Navigator.pushNamed(GlobalVariable.navState.currentContext!,
            notificationModel.navigateRoute ?? '',
            arguments: ChatArgument(
                roomID: notificationModel.chatNotification?.roomID ?? '',
                userID: notificationModel.chatNotification?.senderID,
                userType: null));
      } else {
        Navigator.pushNamed(GlobalVariable.navState.currentContext!,
            notificationModel.navigateRoute ?? '',
            arguments: notificationModel.argument);
      }
    });
    getIt<GlobalStateManager>().stateStream.listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
    widget._themeDataService.darkModeStream.listen((event) {
      activeTheme = event;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return getConfiguredApp(YesModule.RoutesMap);
  }

  Widget getConfiguredApp(
    Map<String, WidgetBuilder> fullRoutesList,
  ) {
    return FeatureDiscovery(
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: <NavigatorObserver>[observer],
        navigatorKey: GlobalVariable.navState,
        locale: Locale.fromSubtags(
          languageCode: lang,
        ),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: activeTheme,
        supportedLocales: S.delegate.supportedLocales,
        title: 'C4d',
        routes: fullRoutesList,
        initialRoute: SplashRoutes.SPLASH_SCREEN,
      ),
    );
  }
}

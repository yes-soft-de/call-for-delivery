// ignore_for_file: unused_field
import 'dart:async';
import 'dart:io' as p;
import 'package:c4d/module_about/about_module.dart';
import 'package:c4d/module_bidorder/bid_orders_module.dart';
import 'package:c4d/module_branches/branches_module.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_my_notifications/my_notifications_module.dart';
import 'package:c4d/module_notifications/model/notification_model.dart';
import 'package:c4d/module_orders/orders_module.dart';
import 'package:c4d/module_profile/module_profile.dart';
import 'package:c4d/module_subscription/subscriptions_module.dart';
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
import 'package:new_version_plus/new_version_plus.dart';

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
  final AboutModule _aboutModule;
  final ProfileModule _profileModule;
  final SubscriptionsModule _subscriptionsModule;
  final BranchesModule _branchesModule;
  final OrdersModule _ordersModule;
  final MyNotificationsModule _myNotificationsModule;
  final BidOrdersModule _bidOrdersModule;
  MyApp(
      this._ordersModule,
      this._themeDataService,
      this._localizationService,
      this._fireNotificationService,
      this._localNotificationService,
      this._splashModule,
      this._authorizationModule,
      this._chatModule,
      this._settingsModule,
      this._aboutModule,
      this._profileModule,
      this._branchesModule,
      this._subscriptionsModule,
      this._myNotificationsModule,
      this._bidOrdersModule);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  late String lang;
  late ThemeData activeTheme;
  bool authorized = false;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    checkForUpdates(context);
  }

  Future<void> checkForUpdates(context) async {
    final newVersion = NewVersionPlus();
    final VersionStatus? status = await newVersion.getVersionStatus();
    if (status?.canUpdate == true) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        dialogTitle: S.current.newVersion,
        dialogText: S.current.newVersionHint
            .replaceAll('^', status.localVersion)
            .replaceAll('&', status.storeVersion),
        updateButtonText: S.current.update,
        dismissButtonText: S.current.later,
      );
    }
  }

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
                userType: 'store'));
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    checkForUpdates(context);
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

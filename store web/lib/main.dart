import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:store_web/global_nav_key.dart';
import 'package:store_web/module_main/main_module.dart';
import 'package:store_web/utils/effect/scroll_behavior.dart';
import 'package:store_web/utils/global/global_state_manager.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:store_web/abstracts/module/yes_module.dart';
import 'package:store_web/di/di_config.dart';
import 'package:store_web/hive/hive_init.dart';
import 'package:store_web/module_auth/authoriazation_module.dart';

import 'package:store_web/module_splash/splash_module.dart';
import 'package:store_web/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'module_splash/splash_routes.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:new_version_plus/new_version_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  if (!kIsWeb) {}
  await HiveSetUp.init();
  if (kIsWeb) {
  } else {
    FlutterError.onError = (FlutterErrorDetails details) {};
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    FlutterError.onError = (FlutterErrorDetails details) async {
      Logger().error('Main', details.toString(), StackTrace.current);
    };
    runZonedGuarded(() {
      configureDependencies();
      // Your App Here
      runApp(getIt<MyApp>());
    }, (error, stackTrace) {
      Logger().error(
          'Main', error.toString() + stackTrace.toString(), StackTrace.current);
    });
  });
}

@injectable
class MyApp extends StatefulWidget {
  final SplashModule _splashModule;
  final AuthorizationModule _authorizationModule;
  final MainModule _mainModule;

  const MyApp(
    this._splashModule,
    this._authorizationModule,
    this._mainModule,
  );

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late String lang = 'ar';
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

    timeago.setDefaultLocale(lang);
    Moment.setLocaleGlobally(lang == 'en' ? LocaleEn() : LocaleAr());

    getIt<GlobalStateManager>().stateStream.listen((event) {
      if (mounted) {
        setState(() {});
      }
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
        // theme: activeTheme,
        supportedLocales: S.delegate.supportedLocales,
        title: 'C4d',
        routes: fullRoutesList,
        initialRoute: SplashRoutes.SPLASH_SCREEN,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSeed(
            primary: Color(0xff03816A),
            seedColor: PrimaryColor,
            background: Color.fromRGBO(236, 239, 241, 1),
          ),
        ),
      ),
    );
  }

  static Color get PrimaryColor {
    return Color.fromRGBO(33, 32, 156, 1);
  }
}

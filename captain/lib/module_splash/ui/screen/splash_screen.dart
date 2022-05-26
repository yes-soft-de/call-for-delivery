import 'package:c4d/module_about/about_routes.dart';
import 'package:c4d/module_about/hive/about_hive_helper.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:c4d/module_settings/setting_routes.dart';

@injectable
class SplashScreen extends StatefulWidget {
  final AuthService _authService;
  SplashScreen(this._authService);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _createNewChannel();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) {
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
    super.initState();
  }

  String _statusText = "Waiting...";
  final String _finished = "Finished creating channel";
  final String _error = "Error while creating channel";

  static const MethodChannel _channel =
      MethodChannel('yessoft.de/channel_test');

  Map<String, String> channelMap = {
    "id": "C4d_Notifications_custom_sound_test",
    "name": "C4d Notifications",
    "description": "C4d Notifications with custom sounds",
  };

  void _createNewChannel() async {
    try {
      await _channel.invokeMethod('createNotificationChannel', channelMap);
      setState(() {
        _statusText = _finished;
      });
      Logger().info('Notifications Channel', _statusText);
    } on PlatformException catch (e) {
      _statusText = _error;
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Image.asset(
            ImageAsset.LOGO,
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }

  Future<String> _getNextRoute() async {
    if (getIt<LocalizationService>().choosed()) {
      return needForLogging(widget._authService.isLoggedIn);
    } else {
      return SettingRoutes.CHOOSE_LANGUAGE;
    }
  }

  Future<String> needForLogging(bool login) async {
    if (login) {
      try {
        await getIt<AuthService>().accountStatus();
        return AuthPrefsHelper().getAccountStatusPhase();
      } catch (e) {
        return AuthorizationRoutes.LOGIN_SCREEN;
      }
    } else if (AboutHiveHelper().getWelcome()) {
      return AuthorizationRoutes.LOGIN_SCREEN;
    } else {
      return welcomePage();
    }
  }

  String welcomePage() {
    return AboutRoutes.ROUTE_ABOUT;
  }
}

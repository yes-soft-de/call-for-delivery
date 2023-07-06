// ignore_for_file: use_key_in_widget_constructors


import 'package:store_web/module_auth/presistance/auth_prefs_helper.dart';
import 'package:store_web/utils/images/images.dart';
import 'package:store_web/utils/logger/logger.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/di/di_config.dart';
import 'package:store_web/module_auth/authorization_routes.dart';
import 'package:store_web/module_auth/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

@injectable
class SplashScreen extends StatefulWidget {
  final AuthService _authService;
  const SplashScreen(this._authService);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> someChecks() async {
    _getNextRoute().then((route) {
      Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      someChecks();
    });

    super.initState();
  }

  String _statusText = 'Waiting...';
  final String _finished = 'Finished creating channel';
  final String _error = 'Error while creating channel';

  static const MethodChannel _channel =
      MethodChannel('yessoft.de/channel_test');

  Map<String, String> channelMap = {
    'id': 'C4d_Notifications_custom_sound_test',
    'name': 'C4d Notifications',
    'description': 'C4d Notifications with custom sounds',
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
    return Stack(fit: StackFit.expand, children: [
      Positioned.fill(
        child: Container(
          color: const Color.fromARGB(255, 233, 195, 113),
        ),
      ),
      Image.asset(
        ImageAsset.SPLASH_SCREEN_BACKGROUND,
        fit: BoxFit.fill,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image.asset(
            ImageAsset.C4D_LOGO,
            width: MediaQuery.sizeOf(context).width * 0.7,
          ),
        ),
      ),
    ]);
  }

  Future<String> _getNextRoute() async {
    try {
        return needForLogging(widget._authService.isLoggedIn);
      
    } catch (e) {
      return AuthorizationRoutes.LOGIN_SCREEN;
    }
  }

  Future<String> needForLogging(bool login) async {
    try {
      if (login) {
        try {
          await widget._authService.refreshToken();
          await getIt<AuthService>().accountStatus();
          return AuthPrefsHelper().getAccountStatusPhase();
        } catch (e) {
          return AuthorizationRoutes.LOGIN_SCREEN;
        }
      } else {
        return welcomePage();
      }
    } catch (e) {
      return AuthorizationRoutes.LOGIN_SCREEN;
    }
  }

  String welcomePage() {
    return AuthorizationRoutes.LOGIN_SCREEN;
  }
}

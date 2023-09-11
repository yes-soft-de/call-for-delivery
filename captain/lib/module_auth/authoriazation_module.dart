import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'authorization_routes.dart';

@injectable
class AuthorizationModule extends RoutingModule {
  final LoginScreen _loginScreen;
  final RegisterScreen _registerScreen;
  final ForgotPassScreen _forgotPassScreen;

  AuthorizationModule(
      this._loginScreen, this._registerScreen, this._forgotPassScreen) {
    RoutingModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AuthorizationRoutes.LOGIN_SCREEN: (context) => _loginScreen,
      AuthorizationRoutes.REGISTER_SCREEN: (context) => _registerScreen,
      AuthorizationRoutes.ForgotPass_SCREEN: (context) => _forgotPassScreen,
    };
  }
}

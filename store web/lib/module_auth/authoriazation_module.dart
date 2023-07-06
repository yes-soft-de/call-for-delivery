import 'package:store_web/module_auth/ui/screen/reset_password_screen/reset_password_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/abstracts/module/yes_module.dart';
import 'package:store_web/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart';
import 'package:store_web/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:store_web/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'authorization_routes.dart';

@injectable
class AuthorizationModule extends YesModule {
  final LoginScreen _loginScreen;
  final RegisterScreen _registerScreen;
  final ForgotPassScreen _forgotPassScreen;
  final ResetPasswordScreen _resetPasswordScreen;
  AuthorizationModule(this._loginScreen, this._registerScreen,
      this._resetPasswordScreen, this._forgotPassScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AuthorizationRoutes.LOGIN_SCREEN: (context) => _loginScreen,
      AuthorizationRoutes.REGISTER_SCREEN: (context) => _registerScreen,
      AuthorizationRoutes.ForgotPass_SCREEN: (context) => _forgotPassScreen,
      AuthorizationRoutes.RESET_PASS_SCREEN: (context) => _resetPasswordScreen,
    };
  }
}

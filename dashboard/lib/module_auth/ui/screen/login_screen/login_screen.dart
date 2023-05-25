import 'dart:async';
import 'package:c4d/module_main/main_routes.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:flutter/material.dart';
import 'package:c4d/module_splash/splash_routes.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class LoginScreen extends StatefulWidget {
  final LoginStateManager _stateManager;

  LoginScreen(this._stateManager);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late LoginState _currentStates;
  late AsyncSnapshot loadingSnapshot;
  late StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    loadingSnapshot = AsyncSnapshot.nothing();
    _currentStates = LoginStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentStates = event;
        });
      }
    });
    widget._stateManager.loadingStream.listen((event) {
      if (this.mounted) {
        setState(() {
          loadingSnapshot = event;
        });
      }
    });
    super.initState();
  }

  dynamic args;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.of(context).login, canGoBack: false),
        body: FixedContainer(
          child: loadingSnapshot.connectionState != ConnectionState.waiting
              ? _currentStates.getUI(context)
              : Stack(
                  children: [
                    _currentStates.getUI(context),
                    Container(
                      width: double.maxFinite,
                      color: Colors.transparent.withOpacity(0.0),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void loginClient(String email, String password) {
    widget._stateManager.loginClient(email, password, this);
  }

  void moveToNext() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
    CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.loginSuccess);
  }

  void verifyFirst(String? userID, String? password) {
    if (userID == null || password == null) {
      getIt<AuthService>().logout();
      Navigator.pushNamedAndRemoveUntil(
          context, SplashRoutes.SPLASH_SCREEN, (route) => false);
      return;
    } else {
      Navigator.pushNamed(context, AuthorizationRoutes.REGISTER_SCREEN,
          arguments: {'username': '$userID', 'password': '$password'});
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: S.current.notVerifiedNumber);
    }
  }

  void restPass(ResetPassRequest request) {
    widget._stateManager.resetCodeRequest(request, this);
  }

  void moveToForgetPage() {
    Navigator.of(context).pushNamed(AuthorizationRoutes.ForgotPass_SCREEN);
  }
}

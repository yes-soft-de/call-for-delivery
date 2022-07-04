import 'package:c4d/module_auth/request/register_request/verfy_code_request.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_auth/enums/auth_status.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class LoginStateManager {
  final AuthService _authService;
  final PublishSubject<LoginState> _loginStateSubject =
      PublishSubject<LoginState>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  late LoginScreenState _screenState;

  LoginStateManager(this._authService) {
    _authService.authListener.listen((event) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      switch (event) {
        case AuthStatus.CODE_SENT:
          _screenState.verifyFirst(getIt<AuthPrefsHelper>().getUsername(),
              getIt<AuthPrefsHelper>().getPassword());
          break;
        case AuthStatus.AUTHORIZED:
          _screenState.moveToNext();
          break;
        case AuthStatus.NOT_LOGGED_IN:
          _screenState.moveToForgetPage();
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_screenState));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      _loginStateSubject.add(LoginStateInit(_screenState, error: err));
    });
  }

  Stream<LoginState> get stateStream => _loginStateSubject.stream;

  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;
  void loginClient(
    String username,
    String password,
    LoginScreenState _loginScreenState,
  ) {
    _screenState = _loginScreenState;
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _authService.loginApi(username, password);
  }

  void resetCodeRequest(
      ResetPassRequest request, LoginScreenState _loginScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _screenState = _loginScreenState;
    _authService
        .resetPassRequest(request)
        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }

  void resendCode(
      VerifyCodeRequest request, LoginScreenState _loginScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _screenState = _loginScreenState;
    _authService.resendCode(request).whenComplete(
        () => _loadingStateSubject.add(const AsyncSnapshot.nothing()));
  }

  void verifyClient(
      VerifyCodeRequest request, LoginScreenState _loginScreenState) {
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _screenState = _loginScreenState;
    _authService.verifyCodeApi(request).whenComplete(
        () => _loadingStateSubject.add(const AsyncSnapshot.nothing()));
  }
}

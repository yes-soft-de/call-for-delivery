import 'package:store_web/generated/l10n.dart';
import 'package:store_web/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/abstracts/states/state.dart';
import 'package:store_web/module_auth/enums/auth_status.dart';
import 'package:store_web/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:store_web/module_auth/request/forget_password_request/verify_new_password_request.dart';
import 'package:store_web/module_auth/service/auth_service/auth_service.dart';
import 'package:store_web/module_auth/ui/screen/forget_password_screen/forget_password_screen.dart';
import 'package:store_web/module_auth/ui/states/forget_password_state/forget_password_code_sent.dart';
import 'package:store_web/module_auth/ui/states/forget_password_state/forget_state_update_password.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ForgotPassStateManager {
  final AuthService _authService;
  final PublishSubject<States> _forgotStateSubject = PublishSubject<States>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  late ForgotPassScreenState _screenState;

  ForgotPassStateManager(this._authService) {
    _authService.authListener.listen((event) {
      _loadingStateSubject.add(const AsyncSnapshot.nothing());
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _screenState.moveToLogin();
          break;
        case AuthStatus.VERIFIED:
          _forgotStateSubject.add(ForgotStateUpdatePassword(_screenState));
          break;
        case AuthStatus.CODE_SENT:
          _forgotStateSubject.add(ForgotStatePhoneCodeSent(_screenState));
          break;
        case AuthStatus.PASSWORD_RESET:
          _loadingStateSubject.add(const AsyncSnapshot.nothing());
          break;
        default:
          _forgotStateSubject.add(ForgotStatePhoneCodeSent(_screenState));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(const AsyncSnapshot.nothing());
      CustomFlushBarHelper.createError(title: S.current.warnning, message: err)
          .show(_screenState.context);
    });
  }

  Stream<States> get stateStream => _forgotStateSubject.stream;

  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void loginClient(
    String username,
    String password,
    ForgotPassScreenState loginScreenState,
  ) {
    _screenState = loginScreenState;
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _authService.loginApi(username, password);
  }

  void verifyResetPassCodeRequest(VerifyResetPassCodeRequest request,
      ForgotPassScreenState forgotScreenState) {
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _authService.verifyResetPassCodeRequest(request)
      ..then(
        (isVerified) {
          if (isVerified) _screenState = forgotScreenState;
        },
      )
      ..onError(
        (error, stackTrace) {
          // TODO: must show error message
          _screenState = forgotScreenState;
          _loadingStateSubject
              .add(AsyncSnapshot.withError(ConnectionState.done, error!));

          throw error;
        },
      )
      ..whenComplete(
        () {
          // TODO: remove this line after finish test
          // _loadingStateSubject.add(const AsyncSnapshot.nothing());
        },
      );
  }

  void updatePassword(
      UpdatePassRequest request, ForgotPassScreenState forgotScreenState) {
    _loadingStateSubject.add(const AsyncSnapshot.waiting());
    _screenState = forgotScreenState;
    _authService.updatePassword(request);
  }
}

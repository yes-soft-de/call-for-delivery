import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/ui/screen/reset_password_screen/reset_password_screen.dart';
import 'package:c4d/module_auth/ui/states/reset_password_state/reset_password.dart';
import 'package:c4d/module_splash/splash_routes.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ResetPasswordStateManager {
  final AuthService _authService;
  final PublishSubject<States> _forgotStateSubject = PublishSubject<States>();
  Stream<States> get resetPasswordStateStream => _forgotStateSubject.stream;
  ResetPasswordStateManager(this._authService);
  void updatePassword(
      UpdatePassRequest request, ResetPasswordScreenState _forgotScreenState) {
    _forgotStateSubject.add(LoadingState(_forgotScreenState));
    _authService.easyResetPassword(request).then((value) {
      if (value.hasError) {
        _forgotStateSubject.add(ResetPasswordLoadedState(_forgotScreenState));
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(_forgotScreenState.context);
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.passwordUpdatedSuccess)
              .show(_forgotScreenState.context)
              .whenComplete(() {
            Navigator.of(_forgotScreenState.context).pushNamedAndRemoveUntil(
                SplashRoutes.SPLASH_SCREEN, (route) => false);
          });
        });
      }
    });
  }
}

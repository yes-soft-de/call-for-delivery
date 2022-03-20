import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_splash/splash_routes.dart';
import 'package:flutter/material.dart';

class StatusCodeHelper {
  static String getStatusCodeMessages(var statusCode) {
    if (statusCode is int) {
      statusCode = statusCode.toString();
    }
    statusCode ??= '0';
    switch (statusCode) {
      case '200':
        return S.current.statusCodeOk;
      case '201':
        return S.current.statusCodeCreated;
      case '400':
        return S.current.statusCodeBadRequest;
      case '401':
        getIt<AuthService>().logout().then((value) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushNamedAndRemoveUntil(
                  SplashRoutes.SPLASH_SCREEN, (route) => false);
        });
        return S.current.statusCodeUnauthorized;
      case '404':
        return S.current.StatusCodeNotFound;
      case '500':
        return S.current.internalServerError;
      case '9000':
        return S.current.invalidCredentials;
      case '9001':
        return S.current.accountAlreadyExist;
      case '9302':
        return S.current.notSubscription;
      case '9204':
        return S.current.outOfCars;
      case '9303':
        return S.current.renewedFailedYourSubStillActive;
      case '9305':
        return S.current.alreadyExtended;
      case '9351':
        return S.current.packageNotFoundRenew;
      case '9454':
        return S.current.youSubscribedWithOffer;
      case '-1':
        return S.current.dataDecodeError;
      default:
        return S.current.errorHappened;
    }
  }
}

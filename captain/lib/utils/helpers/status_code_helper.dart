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
      case '9100':
        return S.current.captainAccountInActive;
      case '9101':
        return S.current.captainNotExist;
      case '9306':
        return S.current.storeCarsFinished;
      case '9602':
        return S.current.youCannotChoosePlan;
      case '9601':
        return S.current.youCannotChoosePlan;
      case '9604':
        return S.current.ThereIsNoCurrentActiveFinancialCycle;
      case '9207':
        return S.current.thisOrderAcceptedByAnotherCaptain;
      case '9105':
        return S.current.captainPlanNotAcceptedFromAdminYet;
      case '9107':
        return S.current.youAreOffline;
      case '9125':
        return S.current.orderCanceled;
      case '9218':
        return S.current.orderIsHidden;
      case '9011':
        return S.current.userNotVerified;
      case '9220':
        return S.current.captainProfileNotCompleted;
      case '9215':
        return S.current.orderCanceledYouCannotAccept;
      case '9200':
        return S.current.youCannotAcceptAnotherOrderFromThisStore;
      case '9380':
        return S.current.youCannotChangeYourAnswer;
      case '9223':
        return S.current.updateStatusForTimeLimitation;
      case '9229':
        return S.current
            .cantAcceptOrderBecauseOrderWithStatusCaptainInWayToStoreExist;
      case '9231':
        return S.current.captainHasTowIngoingOrderCantAcceptNewOrder;
      case '9751':
        return S.current.requestedAlreadyYouWillReceiveYourDuesSoon;
      case '-1':
        return S.current.dataDecodeError;
      default:
        return S.current.errorHappened;
    }
  }
}

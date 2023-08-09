import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/logger/logger.dart';

class StatusCodeHelper {
  static String getStatusCodeMessages(var statusCode,{String? optionalMessage}) {
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
        return S.current.statusCodeUnauthorized;
      case '404':
        return S.current.StatusCodeNotFound;
      case '500':
        return S.current.internalServerError;
      case '9000':
        return S.current.invalidCredentials;
      case '9001':
        return S.current.accountAlreadyExist;
      case '9053':
        return S.current.criteriaAlreadyExists(optionalMessage ?? S.current.unknown);
      case '9106':
        return S.current.youCannotMakePaymentThereIsNoOrderCash;
      case '9163':
        return S.current.thereIsNoSettingFotThisStore;
      case '9603':
        return S.current.yourRequestToChangeCaptainPlanFailed;
      case '9355':
        return S.current.accountHasPaymentsRecord;
      case '9351':
        return S.current.accountHasOrdersRecord;
      case '9353':
        return S.current.accountHasPaymentsRecord;
      case '9354':
        return S.current.accountHasPaymentsRecord;
      case '9204':
        return S.current.expiredSubscriptions;
      case '9200':
        return S.current.youCannotAcceptAnotherOrderFromThisStore;
      case '9218':
        return S.current.theOrderHidden;
      case '9307':
        return S.current.unableToDeletePaymentsExist;
      case '9302':
        return S.current.thereIsNoValidSubscription;
      case '9453':
        return S.current.cannotSubscribeToCaptainOffer;
      case '9224':
        return S.current.illegalCommand + '9224';
      case '9213':
        return S.current.invalidOrderType;
      case '9203':
        return S.current.issuesWithOrderStatusUpdate;
      case '9205':
        return S.current.orderNotFound;
      case '9215':
        return S.current.alreadyCanceled;
      case '9157':
        return S.current.storeProfileNotFound;
      case '9314':
        return S.current.invalidNumber;
      case '9502':
        return S.current.financialPayment;
      case '-1':
        return S.current.dataDecodeError;
      default:
        Logger().error('$statusCode', 'UnKnown Error', StackTrace.empty);
        return S.current.errorHappened + ' ' + statusCode;
    }
  }
}

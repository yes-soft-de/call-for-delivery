import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/logger/logger.dart';

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
        return S.current.statusCodeUnauthorized;
      case '404':
        return S.current.StatusCodeNotFound;
      case '500':
        return S.current.internalServerError;
      case '9000':
        return S.current.invalidCredentials;
      case '9001':
        return S.current.accountAlreadyExist;
      case '9106':
        return S.current.youCannotMakePaymentThereIsNoOrderCash;
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
      case '9307':
        return S.current.unableToDeletePaymentsExist;
      case '9302':
        return S.current.thereIsNoValidSubscription;
      case '-1':
        return S.current.dataDecodeError;
      default:
        Logger().error('$statusCode', 'UnKnown Error', StackTrace.empty);
        return S.current.errorHappened + ' ' + statusCode;
    }
  }
}

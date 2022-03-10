import 'package:c4d/consts/balance_status.dart';
import 'package:c4d/generated/l10n.dart';

class SubscriptionsStatusHelper {
  static String getStatusMessage(var status) {
    switch (status) {
      case 'active':
        return S.current.active;
      case 'inactive':
        return S.current.SubscriptionInactive;
      case 'cars finished':
        return S.current.outOfCars;
      case 'order finished':
        return S.current.orderIsFinished;
      case 'date finished':
        return S.current.ExpiredSubscriptions;
      case 'unsubscribed':
        return S.current.notSubscription;
      default:
        return S.current.errorHappened;
    }
  }

  static BalanceStatus getStatusEnum(String? status) {
    switch (status) {
      case 'active':
        return BalanceStatus.ACTIVE;
      case 'inactive':
        return BalanceStatus.INACTIVE;

      case 'cars finished':
        return BalanceStatus.CARS_FINISHED;

      case 'order finished':
        return BalanceStatus.ORDERS_FINISHED;

      case 'date finished':
        return BalanceStatus.EXPIRED;

      case 'unsubscribed':
        return BalanceStatus.UNSUBSCRIBED;

      default:
        return BalanceStatus.INACTIVE;
    }
  }
}

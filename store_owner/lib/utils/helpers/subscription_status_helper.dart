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
}

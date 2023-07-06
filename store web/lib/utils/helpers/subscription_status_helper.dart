import 'package:store_web/consts/balance_status.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:flutter/material.dart';

class SubscriptionsStatusHelper {
  static String getStatusMessage(String status) {
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
        return status;
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

  static Color? getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.red;
      case 'cars finished':
        return Colors.orange;
      case 'order finished':
        return Colors.purple;
      case 'date finished':
        return Colors.red[900]!;
      default:
        return null;
    }
  }
}

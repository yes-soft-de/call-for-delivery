import 'package:c4d/consts/app_type.dart';
import 'package:flutter/material.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';

class AppTypeHelper {
  static OrderStatusEnum getStatusEnum(String? status) {
    if (status == 'pending') {
      return OrderStatusEnum.WAITING;
    } else if (status == 'on way to pick order') {
      return OrderStatusEnum.GOT_CAPTAIN;
    } else if (status == 'in store') {
      return OrderStatusEnum.IN_STORE;
    } else if (status == 'ongoing') {
      return OrderStatusEnum.DELIVERING;
    } else if (status == 'delivered') {
      return OrderStatusEnum.FINISHED;
    } else if (status == 'cancelled') {
      return OrderStatusEnum.CANCELLED;
    }
    return OrderStatusEnum.WAITING;
  }

  static String getTypeString(AppTypeEnum? status) {
    switch (status) {
      case AppTypeEnum.CAPTAIN:
        return 'captains';
      case AppTypeEnum.STORE:
        return 'stores';
      case AppTypeEnum.ALL:
        return 'all';
      default:
        return 'all';
    }
  }

  static String getAppTypeMessages(AppTypeEnum? orderStatus) {
    switch (orderStatus) {
      case AppTypeEnum.CAPTAIN:
        return S.current.captains;
      case AppTypeEnum.STORE:
        return S.current.stores;
      case AppTypeEnum.ALL:
        return S.current.all;
      default:
        return S.current.all;
    }
  }


  static IconData getOrderStatusIcon(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return Icons.timer_rounded;
      case OrderStatusEnum.IN_STORE:
        return Icons.store_rounded;
      case OrderStatusEnum.DELIVERING:
        return Icons.pedal_bike_rounded;
      case OrderStatusEnum.GOT_CAPTAIN:
        return Icons.account_circle_rounded;
      case OrderStatusEnum.FINISHED:
        return Icons.check_circle_rounded;
      default:
        return Icons.cancel_rounded;
    }
  }

  static Color getOrderStatusColor(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return Colors.orange;
      case OrderStatusEnum.IN_STORE:
        return Colors.blue;
      case OrderStatusEnum.DELIVERING:
        return Colors.indigo;
      case OrderStatusEnum.GOT_CAPTAIN:
        return Colors.purple;
      case OrderStatusEnum.FINISHED:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  static int getOrderStatusIndex(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.WAITING:
        return 0;
      case OrderStatusEnum.IN_STORE:
        return 2;
      case OrderStatusEnum.DELIVERING:
        return 3;
      case OrderStatusEnum.GOT_CAPTAIN:
        return 1;
      case OrderStatusEnum.FINISHED:
        return 4;
      default:
        return 0;
    }
  }
}

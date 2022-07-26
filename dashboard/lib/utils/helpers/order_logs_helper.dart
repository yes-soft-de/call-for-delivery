import 'package:flutter/material.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';

class StatusHelper {
  static String getOrderLogsMessages(int? orderLog) {
    switch (orderLog) {
      case 1:
        return S.current.createdNewOrder;
      case 2:
        return S.current.updatedOrder;
      case 3:
        return S.current.canceledOrder;
      case 4:
        return S.current.orderRecycled;
      case 5:
        return S.current.confirmCaptainLocation;
      case 6:
        return S.current.orderHidedDuTimeExpired;
      case 7:
        return S.current.orderUnHidedDuCaptainAvailable;
      case 8:
        return S.current.newSubOrderCreated;
      case 9:
        return S.current.unlinkedSubOrder;
      case 10:
        return S.current.orderHidedToEditByStore;
      case 11:
        return S.current.unAssignOrder;
      case 12:
        return S.current.orderHidedToEditByAdmin;
      case 13:
        return S.current.updatedOrder;
      case 14:
        return S.current.captainFinishedFillingOrderInformation;
      case 15:
        return S.current.unlinkedSubOrderFromGroupedOrder;
      case 16:
        return S.current.unknownAction + ' !${orderLog}';
      case 17:
        return S.current.createdNewOrder;
      case 18:
        return S.current.assignedOrderToCaptain;
      case 19:
        return S.current.orderedCanceled;
      case 20:
        return S.current.UpdatedOrderState;
      default:
        return S.current.unknownAction + ' !${orderLog}';
    }
  }

  static String getOrderStatusDescriptionMessages(OrderStatusEnum orderStatus) {
    switch (orderStatus) {
      case OrderStatusEnum.WAITING:
        return S.current.waitingDescription;
      case OrderStatusEnum.IN_STORE:
        return S.current.captainInStoreDescription;
      case OrderStatusEnum.DELIVERING:
        return S.current.deliveringDescription;
      case OrderStatusEnum.GOT_CAPTAIN:
        return S.current.captainAcceptOrderDescription;
      case OrderStatusEnum.FINISHED:
        return S.current.orderDeliveredDescription;
      case OrderStatusEnum.CANCELLED:
        return S.current.cancelledHint;
      default:
        return S.current.waitingDescription;
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
}

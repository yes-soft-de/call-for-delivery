import 'package:c4d/generated/l10n.dart';

class ActionTypeLogsHelper {
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
}

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
        return S.current.UpdatedOrderState;
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
        return S.current.updatedOrderStatusByAdministration;
      case 21:
        return S.current.storeAnswerOrderCash;
      case 22:
        return S.current.newSubOrderCreatedByAdministration;
      case 23:
        return S.current.storeBranchToClientDistanceUpdated;
      case 24:
        return S.current.storeBranchToClientDistanceAndDestinationUpdated;
      case 25:
        return S.current.cashPaymentConfirmed + ' 25';
      case 26:
        return S.current.payConflictAnswersResolved;
      case 27:
        return S.current.payConflictAnswersResolvedByAdministration;
      case 28:
        return S.current.isCashPaymentConfirmedByStore;
      case 29:
        return S.current.destinationUpdate;
      case 30:
        return S.current.storeBranchToClientDistance2;
      case 31:
        return S.current.storeBranchToClientDistanceDirectly;
      case 32:
        return S.current.recycleOrderDone;
      case 33:
        return S.current.updateCustomerLocation;
      case 35:
        return S.current.captainRetreatOrder;
      case 36:
        return S.current.hideOrderBecauseThereAreNoCaptainAvailable;
      case 37:
        return S.current.updateDeliveryCostBecauseKMAddedDirectly;
      case 38:
        return S.current.updateDeliveryCostBecauseClientLocationBeenUpdated;
      case 39:
        return S.current.sendOrderAutomaticToTheExternalCompanyBecauseHeMeetWithCompanyStander;
      case 40:
        return S.current.sendOrderToExternalCompanyByAdmin;
      case 41:
        return S.current.NORMAL_ORDER_STATUS_UPDATE_BY_FETCHING_IT_FROM_EXTERNAL_COMPANY_CONST;
      case 42:
        return S.current.updateOrderStatusByMarsool;
      default:
        return S.current.unknownAction + ' !${orderLog}';
    }
  }
}

import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_orders/model/captain_cash_orders_finance.dart';
import 'package:c4d/module_orders/model/order/conflict_distance_order.dart';
import 'package:c4d/module_orders/model/order/order_action_logs_model.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/model/order_captain_logs_model.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/model/order_without_distance_model.dart';
import 'package:c4d/module_orders/model/pending_order.dart';
import 'package:c4d/module_orders/model/store_cash_orders_finance.dart';
import 'package:c4d/module_orders/request/add_extra_distance_request.dart';
import 'package:c4d/module_orders/request/captain_cash_finance_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/order/update_order_request.dart';
import 'package:c4d/module_orders/request/order_conflict_distance_request/order_conflict_distance_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/request/resolve_conflects_order_request.dart';
import 'package:c4d/module_orders/request/store_answer_cash_order_request.dart';
import 'package:c4d/module_orders/request/store_cash_finance_request.dart';
import 'package:c4d/module_orders/request/update_distance_request.dart';
import 'package:c4d/module_orders/response/order_actionlogs_response/order_actionlogs_response.dart';
import 'package:c4d/module_orders/response/order_captain_logs_response/order_captain_logs_response.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_orders/response/order_pending_response/order_pending_response.dart';
import 'package:c4d/module_orders/response/order_without_distance_response/order_captain_logs_response.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_captain_response/orders_cash_finances_for_captain_response.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_store_response/orders_cash_finances_for_store_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/module_stores/request/delete_order_request.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersService {
  final OrdersManager _ordersManager;
  OrdersService(this._ordersManager);

  Future<DataModel> getMyOrdersFilter(FilterOrderRequest request) async {
    OrdersResponse? response = await _ordersManager.getMyOrdersFilter(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }

  Future<DataModel> getNotAnsweredOrderCash(FilterOrderRequest request) async {
    OrdersResponse? response =
        await _ordersManager.getNotAnsweredOrderCash(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }

  Future<DataModel> getConflictingAnswerOrderCash(
      FilterOrderRequest request) async {
    OrdersResponse? response =
        await _ordersManager.getConflictingAnswerOrderCash(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }

  Future<DataModel> getOrdersConflictedDistance(
      FilterOrderRequest request) async {
    OrderConflictDistanceRequest? response =
        await _ordersManager.getOrdersConflictedDistance(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return ConflictDistanceOrder.withData(response);
  }

  Future<DataModel> getCaptainOrdersFilter(FilterOrderRequest request) async {
    OrderCaptainLogsResponse? response =
        await _ordersManager.getCaptainOrdersFilter(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderCaptainLogsModel.withData(response);
  }

  Future<DataModel> getOrderCashFinancesForStore(
      StoreCashFinanceRequest request) async {
    OrdersCashFinancesForStoreResponse? response =
        await _ordersManager.getOrderCashFinancesForStore(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return StoreCashOrdersFinanceModel.withData(response);
  }

  Future<DataModel> getOrderCashFinancesForCaptain(
      CaptainCashFinanceRequest request) async {
    OrdersCashFinancesForCaptainResponse? response =
        await _ordersManager.getOrderCashFinancesForCaptain(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return CaptainCashOrdersFinanceModel.withData(response);
  }

  Future<DataModel> getPendingOrder() async {
    OrderPendingResponse? response = await _ordersManager.getPendingOrders();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return PendingOrder.withData(response);
  }

  Future<DataModel> getActionOrderLogs(int orderID) async {
    OrderActionLogsResponse? response =
        await _ordersManager.getActionOrderLogs(orderID);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderActionLogsModel.withData(response);
  }

  Future<DataModel> createOrder(CreateOrderRequest request) async {
    OrderDetailsResponse? response = await _ordersManager.createOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    var location = await DeepLinksService.defaultLocation();
    return OrderDetailsModel.withData(response, location);
  }

  Future<DataModel> updateOrder(CreateOrderRequest request) async {
    ActionResponse? response = await _ordersManager.updateOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> addExtraDistanceToOrder(
      AddExtraDistanceRequest request) async {
    ActionResponse? response =
        await _ordersManager.addExtraDistanceToOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateExtraDistanceToOrder(
      AddExtraDistanceRequest request) async {
    ActionResponse? response =
        await _ordersManager.updateExtraDistanceToOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateOrderStatus(UpdateOrderRequest request) async {
    ActionResponse? response = await _ordersManager.updateOrderStatus(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> recycleOrder(CreateOrderRequest request) async {
    ActionResponse? response = await _ordersManager.recycleOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateDistance(UpdateDistanceRequest request) async {
    ActionResponse? response = await _ordersManager.updateDistance(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> hideOrder(int orderID) async {
    ActionResponse? response = await _ordersManager.hideOrder(orderID);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    FireStoreHelper().backgroundThread('Trigger');
    return DataModel.empty();
  }

  Future<DataModel> deleteOrder(DeleteOrderRequest request) async {
    ActionResponse? response = await _ordersManager.deleteOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> unAssignCaptain(int id) async {
    ActionResponse? response = await _ordersManager.unAssignCaptain(id);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getOrdersWithoutDistance(FilterOrderRequest request) async {
    OrdersWithoutDistanceResponse? response =
        await _ordersManager.getOrdersWithoutDistance(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrdersWithoutDistanceModel.withData(response);
  }

  Future<DataModel> getOrderDetails(int orderId) async {
    OrderDetailsResponse? response =
        await _ordersManager.getOrderDetails(orderId);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderDetailsModel.withData(response, null);
  }

  Future<DataModel> removeOrderSub(OrderNonSubRequest request) async {
    ActionResponse? response = await _ordersManager.removeOrderSub(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> resolveOrderConflicts(
      ResolveConflictsOrderRequest request) async {
    ActionResponse? response =
        await _ordersManager.resolveOrderConflicts(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateAnswerOrderCashForStore(
      StoreAnswerForOrderCashRequest request) async {
    ActionResponse? response =
        await _ordersManager.updateAnswerOrderCashForStore(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> addNewOrderLink(CreateOrderRequest request) async {
    ActionResponse? response = await _ordersManager.addNewOrderLink(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }
}

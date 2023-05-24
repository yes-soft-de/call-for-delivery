import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_orders/repository/order_repository/order_repository.dart';
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
import 'package:injectable/injectable.dart';

@injectable
class OrdersManager {
  final OrderRepository _repository;

  OrdersManager(
    this._repository,
  );

  Future<OrderDetailsResponse?> getOrderDetails(int orderId) =>
      _repository.getOrderDetails(orderId);
  Future<ActionResponse?> removeOrderSub(OrderNonSubRequest orderRequest) =>
      _repository.removeOrderSub(orderRequest);
  Future<OrdersResponse?> getMyOrdersFilter(FilterOrderRequest request) =>
      _repository.getMyOrdersFilter(request);

  Future<OrdersResponse?> getConflictingAnswerOrderCash(
          FilterOrderRequest request) =>
      _repository.getConflictingAnswerOrderCash(request);

  Future<OrdersResponse?> getNotAnsweredOrderCash(FilterOrderRequest request) =>
      _repository.getNotAnsweredOrderCash(request);
  Future<OrderCaptainLogsResponse?> getCaptainOrdersFilter(
          FilterOrderRequest request) =>
      _repository.getCaptainOrdersFilter(request);
  Future<OrdersCashFinancesForStoreResponse?> getOrderCashFinancesForStore(
          StoreCashFinanceRequest request) =>
      _repository.getOrderCashFinancesForStore(request);
  Future<OrdersCashFinancesForCaptainResponse?> getOrderCashFinancesForCaptain(
          CaptainCashFinanceRequest request) =>
      _repository.getOrderCashFinancesForCaptain(request);
  Future<OrderPendingResponse?> getPendingOrders() =>
      _repository.getPendingOrder();
  Future<OrderDetailsResponse?> createOrder(CreateOrderRequest request) =>
      _repository.createOrder(request);
  Future<ActionResponse?> updateOrder(CreateOrderRequest request) =>
      _repository.updateOrder(request);
  Future<ActionResponse?> updateOrderStatus(UpdateOrderRequest request) =>
      _repository.updateOrderStatus(request);

  Future<ActionResponse?> hideOrder(int orderID) =>
      _repository.hideOrder(orderID);

  Future<ActionResponse?> deleteOrder(DeleteOrderRequest request) =>
      _repository.deleteOrder(request);

  Future<ActionResponse?> unAssignCaptain(int orderId) =>
      _repository.unAssignCaptain(orderId);
  Future<OrderActionLogsResponse?> getActionOrderLogs(int orderID) =>
      _repository.getActionOrderLogs(orderID);
  Future<OrdersWithoutDistanceResponse?> getOrdersWithoutDistance(
          FilterOrderRequest request) =>
      _repository.getOrdersWithoutDistance(request);
  Future<OrderConflictDistanceRequest?> getOrdersConflictedDistance(
          FilterOrderRequest request) =>
      _repository.getOrdersConflictedDistance(request);
  Future<ActionResponse?> addExtraDistanceToOrder(
          AddExtraDistanceRequest request) =>
      _repository.addExtraDistanceToOrder(request);
  Future<ActionResponse?> updateExtraDistanceToOrder(
          AddExtraDistanceRequest request) =>
      _repository.updateExtraDistanceToOrder(request);
  Future<ActionResponse?> updateDistance(UpdateDistanceRequest request) =>
      _repository.updateDistance(request);
  Future<ActionResponse?> addNewOrderLink(CreateOrderRequest orderRequest) =>
      _repository.addNewOrderLink(orderRequest);
  Future<ActionResponse?> resolveOrderConflicts(
          ResolveConflictsOrderRequest request) =>
      _repository.resolveOrderConflicts(request);
  Future<ActionResponse?> updateAnswerOrderCashForStore(
          StoreAnswerForOrderCashRequest request) =>
      _repository.updateAnswerOrderCashForStore(request);

  Future<ActionResponse?> recycleOrder(CreateOrderRequest request) =>
      _repository.recycleOrder(request);
}

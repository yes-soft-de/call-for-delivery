import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_orders/repository/order_repository/order_repository.dart';
import 'package:c4d/module_orders/request/captain_cash_finance_request.dart';
import 'package:c4d/module_orders/request/confirm_captain_location_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/store_cash_finance_request.dart';
import 'package:c4d/module_orders/response/company_info_response/company_info_response.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_orders/response/order_pending_response/order_pending_response.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_captain_response/orders_cash_finances_for_captain_response.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_store_response/orders_cash_finances_for_store_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersManager {
  final OrderRepository _repository;

  OrdersManager(
    this._repository,
  );

  Future<OrderDetailsResponse?> getOrderDetails(int orderId) =>
      _repository.getOrderDetails(orderId);

  Future<OrdersResponse?> getMyOrdersFilter(FilterOrderRequest request) =>
      _repository.getMyOrdersFilter(request);
  Future<OrdersCashFinancesForStoreResponse?> getOrderCashFinancesForStore(
          StoreCashFinanceRequest request) =>
      _repository.getOrderCashFinancesForStore(request);
  Future<OrdersCashFinancesForCaptainResponse?> getOrderCashFinancesForCaptain(
          CaptainCashFinanceRequest request) =>
      _repository.getOrderCashFinancesForCaptain(request);
  Future<OrderPendingResponse?> getPendingOrders() =>
      _repository.getPendingOrder();
  Future<ActionResponse?> createOrder(CreateOrderRequest request) =>
      _repository.createOrder(request);
  Future<ActionResponse?> updateOrder(CreateOrderRequest request) =>
      _repository.updateOrder(request);

  Future<ActionResponse?> hideOrder(int orderID) =>
      _repository.hideOrder(orderID);
}

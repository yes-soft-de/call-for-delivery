import 'package:c4d/module_orders/repository/order_repository/order_repository.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersManager {
  final OrderRepository _repository;

  OrdersManager(
    this._repository,
  );

  Future<ActionResponse?> addNewOrder(CreateOrderRequest orderRequest) =>
      _repository.addNewOrder(orderRequest);

  Future<OrderStatusResponse?> getOrderDetails(int orderId) =>
      _repository.getOrderDetails(orderId);

  Future<OrdersResponse?> getMyOrders() => _repository.getMyOrders();

  // Future<Map> getOrder(int orderId) => _repository.getOrder(orderId);

  Future<ActionResponse?> deleteOrder(int orderId) =>
      _repository.deleteOrder(orderId);

  Future sendToRecord(var orderId, answar) =>
      _repository.sendToRecord(orderId, answar);
}

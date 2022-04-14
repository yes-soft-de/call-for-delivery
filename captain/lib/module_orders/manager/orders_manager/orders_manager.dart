import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/response/enquery_response/enquery_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_orders/repository/order_repository/order_repository.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_orders/response/order_status/order_action_response.dart';
import 'package:c4d/module_orders/response/orders_logs_response.dart';

@injectable
class OrdersManager {
  final OrderRepository _repository;

  OrdersManager(
    this._repository,
  );

  Future<OrderDetailsResponse?> getOrderDetails(int orderId) =>
      _repository.getOrderDetails(orderId);

  Future<OrdersResponse?> getNearbyOrders() => _repository.getNearbyOrders();

  Future<OrdersLogsResponse?> getOrdersLogs() => _repository.getOrdersLogs();

  Future<OrdersResponse?> getCaptainOrders() => _repository.getCaptainOrders();

  Future<CompanyInfoResponse?> getCompanyInfo() => _repository.getCompanyInfo();

  Future<OrderActionResponse?> updateOrder(
          UpdateOrderRequest updateOrderRequest) =>
      _repository.updateOrderState(updateOrderRequest);

  Future<OrdersResponse?> getMyOrdersFilter(FilterOrderRequest request) =>
      _repository.getMyOrdersFilter(request);
  Future<EnquiryResponse?> createChatRoom(int orderId) =>
      _repository.createChatRoom(orderId);
}

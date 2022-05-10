import 'package:c4d/module_orders/repository/order_repository/order_repository.dart';
import 'package:c4d/module_orders/request/confirm_captain_location_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/response/company_info_response/company_info_response.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/request/rating_request.dart';
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

  Future<ActionResponse?> removeOrderSub(OrderNonSubRequest orderRequest) =>
      _repository.removeOrderSub(orderRequest);
  Future<ActionResponse?> addNewOrderLink(CreateOrderRequest orderRequest) =>
      _repository.addNewOrderLink(orderRequest);

  Future<OrderDetailsResponse?> getOrderDetails(int orderId) =>
      _repository.getOrderDetails(orderId);

  Future<OrdersResponse?> getMyOrders() => _repository.getMyOrders();
  Future<OrdersResponse?> getMyOrdersFilter(FilterOrderRequest request) =>
      _repository.getMyOrdersFilter(request);

  // Future<Map> getOrder(int orderId) => _repository.getOrder(orderId);

  Future<ActionResponse?> deleteOrder(int orderId) =>
      _repository.deleteOrder(orderId);
  Future<ActionResponse?> ratingCaptain(RatingRequest request) =>
      _repository.rateCaptain(request);

  Future sendToRecord(var orderId, answar) =>
      _repository.sendToRecord(orderId, answar);
  Future<CompanyInfoResponse?> getCompanyInfo() => _repository.getCompanyInfo();
  Future<ActionResponse?> confirmCaptainLocation(
          ConfirmCaptainLocationRequest request) =>
      _repository.confirmCaptainLocation(request);
}

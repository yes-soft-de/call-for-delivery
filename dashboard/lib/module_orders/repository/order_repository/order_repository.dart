import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/request/captain_cash_finance_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/order/update_order_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/store_cash_finance_request.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_orders/response/order_pending_response/order_pending_response.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_captain_response/orders_cash_finances_for_captain_response.dart';
import 'package:c4d/module_orders/response/orders_cash_finances_for_store_response/orders_cash_finances_for_store_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  OrderRepository(
    this._apiClient,
    this._authService,
  );

  Future<OrderDetailsResponse?> getOrderDetails(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      'Urls.ORDER_STATUS_API' + '$orderId',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response == null) return null;
    return OrderDetailsResponse.fromJson(response);
  }

  Future<OrdersResponse?> getMyOrdersFilter(FilterOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.FILTER_OWNER_ORDERS_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersResponse.fromJson(response);
  }

  Future<OrdersCashFinancesForCaptainResponse?> getOrderCashFinancesForCaptain(
      CaptainCashFinanceRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.FILTER_CASH_ORDERS_FINANCES_CAPTAIN_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersCashFinancesForCaptainResponse.fromJson(response);
  }

  Future<OrdersCashFinancesForStoreResponse?> getOrderCashFinancesForStore(
      StoreCashFinanceRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.FILTER_CASH_ORDERS_FINANCES_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersCashFinancesForStoreResponse.fromJson(response);
  }

  Future<OrderPendingResponse?> getPendingOrder() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.ORDERS_PENDING_API,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrderPendingResponse.fromJson(response);
  }

  Future<OrderDetailsResponse?> createOrder(CreateOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.CREATE_ORDER_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrderDetailsResponse.fromJson(response);
  }

  Future<ActionResponse?> updateOrder(CreateOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.UPDATE_ORDER_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateOrderStatus(UpdateOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.UPDATE_ORDER_STATUS_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> hideOrder(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.HIDE_ORDER_API + '/$id',
      {},
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteOrder(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put('${Urls.DELETE_ORDER}/$orderId', {},
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

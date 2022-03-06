import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  OrderRepository(
    this._apiClient,
    this._authService,
  );

  Future<ActionResponse?> addNewOrder(CreateOrderRequest orderRequest) async {
    await _authService.refreshToken();
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.NEW_ORDER_API,
      orderRequest.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );

    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<OrderStatusResponse?> getOrderDetails(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.ORDER_STATUS_API + '$orderId',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response == null) return null;
    return OrderStatusResponse.fromJson(response);
  }

  Future<OrdersResponse?> getMyOrders() async {
    await _authService.refreshToken();
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.OWNER_ORDERS_API,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteOrder(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        '${Urls.DELETE_ORDER}$orderId', {'state': 'canceled'},
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  // Future<Map> getOrder(int orderId) async {
  //   dynamic response = await _apiClient.get('${Urls.ORDER_BY_ID}$orderId');
  //   if (response == null) return null;
  //   return response['Data'];
  // }

  Future<ActionResponse?> sendToRecord(var orderId, bool answer) async {
    dynamic response =
        await _apiClient.post('${Urls.SEND_TO_RECORD}/$orderId/$answer', {});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_bid_orders/request/order_filter_request.dart';
import 'package:c4d/module_bid_orders/response/orders_response/orders_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
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

//  Future<OrderDetailsResponse?> getOrderDetails(int orderId) async {
//    var token = await _authService.getToken();
//    dynamic response = await _apiClient.get(
//      '' + '$orderId',
//      headers: {'Authorization': 'Bearer $token'},
//    );
//    if (response == null) return null;
//    return OrderDetailsResponse.fromJson(response);
//  }

  Future<OrdersResponse?> getMyOrders() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      '',
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersResponse.fromJson(response);
  }

  Future<OrdersResponse?> getMyOrdersFilter(FilterBidOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.GET_BID_ORDER,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteOrder(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        '${''}/$orderId', {'state': 'canceled'},
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }


}

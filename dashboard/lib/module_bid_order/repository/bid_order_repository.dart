import 'package:c4d/module_bid_order/request/notice_request.dart';
import 'package:c4d/module_bid_order/response/order_details_response/order_details_reponse.dart';
import 'package:c4d/module_bid_order/response/orders_response/orders_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class BidOrderRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  BidOrderRepository(this._apiClient, this._authService);

  Future<OrdersResponse?> getBidOrder(FilterBidOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.GET_BID_ORDER,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersResponse.fromJson(response);
  }

  Future<OrderDetailsResponse?> getBidOrderDetails(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.GET_BID_ORDER_DETAILS + '$orderId',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response == null) return null;
    return OrderDetailsResponse.fromJson(response);
  }

}

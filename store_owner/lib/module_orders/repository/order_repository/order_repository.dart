import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/response/company_info_response/company_info_response.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/request/rating_request.dart';
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
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.NEW_ORDER_API,
      orderRequest.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );

    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<OrderDetailsResponse?> getOrderDetails(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.ORDER_STATUS_API + '$orderId',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response == null) return null;
    return OrderDetailsResponse.fromJson(response);
  }

  Future<OrdersResponse?> getMyOrders() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.OWNER_ORDERS_API,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersResponse.fromJson(response);
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

  Future<ActionResponse?> deleteOrder(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        '${Urls.DELETE_ORDER}$orderId', {'state': 'canceled'},
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> rateCaptain(RatingRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.RATING_CAPTAIN, request.toJson(),
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> sendToRecord(var orderId, bool answer) async {
    dynamic response =
        await _apiClient.post('${Urls.SEND_TO_RECORD}/$orderId/$answer', {});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<CompanyInfoResponse?> getCompanyInfo() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.COMPANY_API,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return CompanyInfoResponse.fromJson(response);
  }
}

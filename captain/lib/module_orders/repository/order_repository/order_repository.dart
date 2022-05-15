import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/response/enquery_response/enquery_response.dart';
import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
import 'package:c4d/module_orders/response/order_details_response/order_details_response.dart';
import 'package:c4d/module_orders/response/order_status/order_action_response.dart';
import 'package:c4d/module_orders/response/orders_logs_response.dart';

@injectable
class OrderRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  OrderRepository(
    this._apiClient,
    this._authService,
  );

  Future<OrdersResponse?> getNearbyOrders() async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.NEARBY_ORDERS_API,
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );

    if (response == null) return null;

    return OrdersResponse.fromJson(response);
  }

  Future<OrdersResponse?> getCaptainOrders() async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.CAPTAIN_ACCEPTED_ORDERS_API,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersResponse.fromJson(response);
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

  Future<OrdersLogsResponse?> getOrdersLogs() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_ORDER_LOGS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return OrdersLogsResponse.fromJson(response);
  }

  /////////////////////////////////////////////////////
  Future<EnquiryResponse?> createChatRoom(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.CREATE_CHATROOM_BEFORE_ACCEPT,
      {'orderId': orderId},
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) return null;

    return EnquiryResponse.fromJson(response);
  }

  Future<OrdersResponse?> getMyOrdersFilter(FilterOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.FILTER_CAPTAIN_ORDERS_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersResponse.fromJson(response);
  }

  Future<OrderActionResponse?> updateOrderState(
      UpdateOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      '${Urls.CAPTAIN_ORDER_UPDATE_API}',
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) return null;

    return OrderActionResponse.fromJson(response);
  }

  Future<CompanyInfoResponse?> getCompanyInfo() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get('${Urls.COMPANYINFO_API}',
        headers: {'Authorization': 'Bearer $token'});

    if (response == null) return null;
    return CompanyInfoResponse.fromJson(response);
  }

  Future<ActionResponse?> removeOrderSub(
      OrderNonSubRequest orderRequest) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.ORDER_NONSUB_API_LINK + '/${orderRequest.orderID}',
      {},
      headers: {'Authorization': 'Bearer ' + '$token'},
    );

    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }
}

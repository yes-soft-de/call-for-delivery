import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_order/request/order_state_request.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

import 'package:c4d/module_users/response/action_response.dart';

import 'package:injectable/injectable.dart';

@injectable
class OrdersRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  OrdersRepository(
      this._apiClient,
      this._authService,
      );

  Future<ActionResponse?> updateStatus(UpdateOrderStateRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.UPDATE_ORDER_STATUS,request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}
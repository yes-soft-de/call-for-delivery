import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_dev/request/create_test_order_request.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:injectable/injectable.dart';

@injectable
class DevRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  DevRepository(
    this._apiClient,
    this._authService,
  );

  Future<ActionResponse?> createOrder(CreateTestOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.CREATE_DEV_ORDER_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

}

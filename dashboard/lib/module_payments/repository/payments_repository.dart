import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/response/store_payments_response/store_payments_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  PaymentsRepository(this._apiClient, this._authService);

  Future<ActionResponse?> paymentToStore(
      CreateStorePaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_STORE_PAYMENTS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<StorePaymentsResponse?> getStorePayments(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_STORE_PAYMENTS + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StorePaymentsResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteStorePayments(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
       Urls.CREATE_STORE_PAYMENTS +
        '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

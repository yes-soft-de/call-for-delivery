import 'package:c4d/module_stores/response/subscriptions_financial_response/subscriptions_financial_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class SubscriptionsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  SubscriptionsRepository(this._apiClient, this._authService);

  Future<SubscriptionsFinancialResponse?> getSubscriptionsFinance(
      int storeId) async {
    var token = await _authService.getToken();
    var response = await _apiClient.get(
      Urls.GET_STORE_SUBSCRIPTIONS_FINANCE + '/$storeId',
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return SubscriptionsFinancialResponse.fromJson(response);
  }
}

import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_subscriptions/request/store_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/response/subscriptions_financial_response/subscriptions_financial_response.dart';
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

  Future<ActionResponse?> renewPackage(int storeID) async {
    var token = await _authService.getToken();
    var response = await _apiClient.put(
      Urls.RENEW_SUBSCRIPTION_API,
      {'storeProfileId': storeID},
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> extendSubscriptions(int storeID) async {
    var token = await _authService.getToken();
    var response = await _apiClient.post(
      Urls.EXTEND_SUBSCRIPTION_API,
      {'storeProfileId': storeID},
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> subscribeToPackage(
      StoreSubscribeToPackageRequest request) async {
    var token = await _authService.getToken();
    var response = await _apiClient.post(
      Urls.SUBSCRIBE_TO_PACKAGE_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

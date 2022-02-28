import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_subscription/response/package_categories_response/package_categories_response.dart';
import 'package:c4d/module_subscription/response/packages/packages_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  SubscriptionsRepository(this._apiClient, this._authService);

  Future<PackagesResponse?> getPackages() async {
    var response = await _apiClient.get(
      Urls.PACKAGES_API,
    );
    if (response == null) return null;
    return PackagesResponse.fromJson(response);
  }

  Future<PackageCategoriesResponse?> getPackagesCategories() async {
    var token = await _authService.getToken();
    var response = await _apiClient.get(
      Urls.PACKAGES_CATEGORIES_API,
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return PackageCategoriesResponse.fromJson(response);
  }

  Future<ActionResponse?> subscribePackage(int packageId) async {
    var token = await _authService.getToken();
    var response = await _apiClient.post(
      Urls.SUBSCRIPTION_API,
      {'package': '$packageId'},
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> renewPackage(int packageId) async {
    var token = await _authService.getToken();
    var response = await _apiClient.post(
      Urls.RENEW_SUBSCRIPTION_API,
      {'packageID': '$packageId'},
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

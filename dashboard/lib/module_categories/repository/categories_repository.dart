import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/request/package_category_request.dart';
import 'package:c4d/module_categories/request/package_request.dart';
import 'package:c4d/module_categories/response/package_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_categories/response/package_category_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class CategoriesRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  CategoriesRepository(this._apiClient, this._authService);

  Future<PackageCategoryResponse?> getPackagesCategories() async {
    var token = await _authService.getToken();
    dynamic response =
        await _apiClient.get(Urls.GET_PACKAGE_CATEGORY, headers: {
      'Authorization': 'Bearer ' + token.toString(),
    });
    if (response == null) return null;
    return PackageCategoryResponse.fromJson(response);
  }

  Future<ActionResponse?> addCategory(PackageCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_PACKAGE_CATEGORY, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> addPackage(PackageRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_PACKAGE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCategory(PackageCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.CREATE_PACKAGE_CATEGORY, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> enableCategory(ActivePackageRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.ACTIVE_PACKAGE_CATEGORIES, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updatePackage(PackageRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.CREATE_PACKAGE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> enablePackage(ActivePackageRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.ACTIVE_PACKAGE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<PackagesResponse?> getPackageByCategory(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_PACKAGE_BY_CATEGORY + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return PackagesResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteCategories(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete('' + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> getCategory(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get('' + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

import 'package:c4d/module_supplier_categories/request/active_category_request.dart';
import 'package:c4d/module_supplier_categories/request/supplier_category_request.dart';
import 'package:c4d/module_supplier_categories/response/supplier_category_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class SupplierCategoriesRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  SupplierCategoriesRepository(this._apiClient, this._authService);

  Future<SupplierCategoryResponse?> getCategories() async {
    var token = await _authService.getToken();
    dynamic response =
        await _apiClient.get(Urls.GET_SUPPLIER_CATEGORIES, headers: {
      'Authorization': 'Bearer ' + token.toString(),
    });
    if (response == null) return null;
    return SupplierCategoryResponse.fromJson(response);
  }

  Future<ActionResponse?> addCategory(SupplierCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_SUPPLIER_CATEGORY, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCategory(
      SupplierCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.CREATE_SUPPLIER_CATEGORY, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> enableCategory(ActiveCategoryRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.ENABLE_SUPPLIER_CATEGORY, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
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

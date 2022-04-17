import 'package:c4d/module_supplier/request/enable_supplier.dart';
import 'package:c4d/module_supplier/request/filter_supplier.dart';
import 'package:c4d/module_supplier/request/filter_supplier_ads.dart';
import 'package:c4d/module_supplier/request/update_supplier_request.dart';
import 'package:c4d/module_supplier/response/supplier_ads_response/ads_response.dart';
import 'package:c4d/module_supplier/response/supplier_need_support_response/supplier_need_support_response.dart';
import 'package:c4d/module_supplier/response/supplier_profile_response.dart';

import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

import '../response/in_active_supplier_response.dart';

@injectable
class SupplierRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  SupplierRepository(this._apiClient, this._authService);


  Future<SupplierResponse?> getInActiveSupplier() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(Urls.GET_SUPPLIERS ,
        FilterSupplierRequest(false).toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SupplierResponse.fromJson(response);
  }

  Future<SupplierResponse?> getSuppliers() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(Urls.GET_SUPPLIERS ,
        FilterSupplierRequest(true).toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SupplierResponse.fromJson(response);
  }

  Future<SupplierProfileResponse?> getSupplierProfile(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.GET_SUPPLIER_PROFILE+ '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SupplierProfileResponse.fromJson(response);
  }

  Future<ActionResponse?> enableSupplier(EnableSupplierRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.ACTIVE_SUPPLIER, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateSupplier(UpdateSupplierRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_CAPTAIN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<SupplierNeedSupportResponse?> getSupplierSupport() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CHAT_ROOMS_SUPPLIER,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return SupplierNeedSupportResponse.fromJson(response);
  }
  Future<AdsResponse?> getSupplierAds(FilterSupplierAds request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(Urls.GET_ANNOUNCEMENT ,
        request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return AdsResponse.fromJson(response);
  }
}

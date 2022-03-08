import 'package:c4d/module_stores/request/active_store_request.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/request/store_payment_request.dart';
import 'package:c4d/module_stores/response/store_balance_response/store_balance_response.dart';
import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/module_stores/response/stores_response.dart';

@injectable
class StoresRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  StoresRepository(this._apiClient, this._authService);

  Future<StoresResponse?> getStores() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_STORES+'active',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoresResponse.fromJson(response);
  }

  Future<StoresResponse?> getStoresInActive() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_STORES+'inactive',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoresResponse.fromJson(response);
  }


  Future<StoreProfileResponse?> getStoreProfile(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_STORE_PROFILE + '$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoreProfileResponse.fromJson(response);
  }
  Future<ActionResponse?> enableStore(ActiveStoreRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.ACTIVATE_STORE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateStore(UpdateStoreRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_STORE_INFO,
        request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<StoreBalanceResponse?> getStoreSpecificDate(
      int captainId, String firstDate, String lastDate) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
//        Urls.GET_ACCOUNT_BALANCE_CAPTAIN_SPECIFIC +
            '$captainId' +
            '/$firstDate' +
            '/$lastDate',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoreBalanceResponse.fromJson(response);
  }

  Future<StoreBalanceResponse?> getStoreAccountBalance(int storeId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
//        Urls.GET_ACCOUNT_BALANCE_STORE +
            '$storeId',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoreBalanceResponse.fromJson(response);
  }


  Future<ActionResponse?> createStorePayments(
      StorePaymentRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      '',
//        Urls.CREATE_PAYMENTS_FOR_STORE,
        request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteStorePayments(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
//        Urls.DELETE_PAYMENTS_FOR_STORE +
            '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

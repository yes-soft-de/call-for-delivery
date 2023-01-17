import 'package:c4d/module_orders/response/orders_response/orders_response.dart';
import 'package:c4d/module_stores/request/active_store_request.dart';
import 'package:c4d/module_stores/request/captain_not_arrived_request.dart';
import 'package:c4d/module_stores/request/filter_store_activity_request.dart';
import 'package:c4d/module_stores/request/order_filter_request.dart';
import 'package:c4d/module_stores/response/order/order_captain_not_arrived/orders_not_arrived_response.dart';
import 'package:c4d/module_stores/response/store_need_support_response/store_need_support_response.dart';
import 'package:c4d/module_stores/response/top_active_store.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/response/store_balance_response/store_balance_response.dart';
import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/module_stores/response/stores_response.dart';

import '../../module_orders/response/order_details_response/order_details_response.dart';

@injectable
class StoresRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  StoresRepository(this._apiClient, this._authService);

  Future<StoresResponse?> getStores() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_STORES + 'active',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoresResponse.fromJson(response);
  }

  Future<StoresResponse?> getStoresInActive() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_STORES + 'inactive',
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

  Future<ActionResponse?> deleteStore(int storeId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(Urls.DELETE_STORE,
        payLoad: {'storeOwnerId': storeId},
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateStore(UpdateStoreRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_STORE_INFO, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<StoreBalanceResponse?> getStoreSpecificDate(
      int captainId, String firstDate, String lastDate) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
//        Urls.GET_ACCOUNT_BALANCE_CAPTAIN_SPECIFIC +
        '$captainId' + '/$firstDate' + '/$lastDate',
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

  Future<StoreNeedSupportResponse?> getStoreSupport() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CHAT_ROOMS_STORES,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StoreNeedSupportResponse.fromJson(response);
  }

  Future<OrdersResponse?> getStoreOrdersFilter(
      FilterOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.FILTER_OWNER_ORDERS_API,
      await request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrdersResponse.fromJson(response);
  }

  Future<OrderCaptainResponse?> getOrdersNotArrivedCaptainFilter(
      FilterOrderCaptainNotArrivedRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.FILTER_CAPTAIN_NOT_ARRIVED,
      await request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OrderCaptainResponse.fromJson(response);
  }

  Future<OrderDetailsResponse?> getOrderDetails(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.GET_ORDERS_DETAILS + '$orderId',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response == null) return null;
    return OrderDetailsResponse.fromJson(response);
  }

  Future<TopActiveStoreResponse?> getTopStoreActive() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.TOP_ACTIVATE_STORE,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response == null) return null;
    return TopActiveStoreResponse.fromJson(response);
  }

  Future<TopActiveStoreResponse?> filterStoreActivity(
      FilterStoreActivityRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.FILTER_STORE_ACTIVITY,
      request.toJson(),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;
    return TopActiveStoreResponse.fromJson(response);
  }
}

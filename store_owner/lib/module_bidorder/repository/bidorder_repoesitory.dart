import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_bidorder/request/offer_state_request.dart';
import 'package:c4d/module_bidorder/response/bidorder_details/bidorder_details_response.dart';
import 'package:c4d/module_bidorder/response/offer/offer_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_bidorder/request/add_bidorder_request.dart';
import 'package:c4d/module_bidorder/request/filter_bidorder_request.dart';
import 'package:c4d/module_bidorder/response/bidorders_response/orders_response.dart';
import 'package:c4d/module_bidorder/response/supplier_category/supplier_category_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class BidOrderRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  BidOrderRepository(this._apiClient, this._authService);

  Future<ActionResponse?> addBidOrder(AddBidOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.ADD_BID_ORDER,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
  Future<BidOrdersResponse?> getOpenOrders(FilterBidOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.GET_BID_ORDER,
      request.toJson(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return BidOrdersResponse.fromJson(response);
  }
  Future<SupplierCategoriesResponse?> getSupplierCat() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.GET_SUPPLIER_CATEGORY,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return SupplierCategoriesResponse.fromJson(response);
  }

  Future<OffersResponse?> getOrderOffers(int orderBidId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.GET_ORDER_OFFERS + '$orderBidId',
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return OffersResponse.fromJson(response);
  }
  Future<BidOrderDetailsResponse?> getOrderDetails(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.BID_ORDER_DETAILS + '$orderId',
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response == null) return null;
    return BidOrderDetailsResponse.fromJson(response);
  }
  Future<ActionResponse?> updateOfferState(OfferStateRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.UPDATE_OFFER_STATE,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> cancelBidOrder(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.CANCEL_BID_ORDER + '$id',{},
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}
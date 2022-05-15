import 'package:c4d/module_bidorder/repository/bidorder_repoesitory.dart';
import 'package:c4d/module_bidorder/request/add_bidorder_request.dart';
import 'package:c4d/module_bidorder/request/filter_bidorder_request.dart';
import 'package:c4d/module_bidorder/request/offer_state_request.dart';
import 'package:c4d/module_bidorder/response/bidorder_details/bidorder_details_response.dart';
import 'package:c4d/module_bidorder/response/bidorders_response/orders_response.dart';
import 'package:c4d/module_bidorder/response/offer/offer_response.dart';
import 'package:c4d/module_bidorder/response/supplier_category/supplier_category_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class BidOrderManager {
  final BidOrderRepository _repository;

  BidOrderManager(this._repository);

  Future<ActionResponse?> addBidOrder(AddBidOrderRequest request) async =>
      await _repository.addBidOrder(request);

  Future<ActionResponse?> updateOfferState(OfferStateRequest request) async =>
      await _repository.updateOfferState(request);

  Future<BidOrderDetailsResponse?> getOrderDetails(int id) async =>
      await _repository.getOrderDetails(id);

  Future<BidOrdersResponse?> getOpenOrders(
          FilterBidOrderRequest request) async =>
      await _repository.getOpenOrders(request);

  Future<SupplierCategoriesResponse?> getSupplierCat() async =>
      await _repository.getSupplierCat();

  Future<OffersResponse?> getOrderOffers(int orderBidId) async =>
      await _repository.getOrderOffers(orderBidId);
}

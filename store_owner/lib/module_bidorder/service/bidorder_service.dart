import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/manager/bidorder_manager.dart';
import 'package:c4d/module_bidorder/model/offer/offers_model.dart';
import 'package:c4d/module_bidorder/model/order/bidorder_details_model.dart';
import 'package:c4d/module_bidorder/model/order/order_model.dart';
import 'package:c4d/module_bidorder/model/supplier_model/supplier_category_model.dart';
import 'package:c4d/module_bidorder/request/add_bidorder_request.dart';
import 'package:c4d/module_bidorder/request/filter_bidorder_request.dart';
import 'package:c4d/module_bidorder/request/offer_state_request.dart';
import 'package:c4d/module_bidorder/response/bidorder_details/bidorder_details_response.dart';
import 'package:c4d/module_bidorder/response/bidorders_response/orders_response.dart';
import 'package:c4d/module_bidorder/response/offer/offer_response.dart';
import 'package:c4d/module_bidorder/response/supplier_category/supplier_category_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class BidOrderService {
  final BidOrderManager _manager;
  BidOrderService(this._manager);

  Future<DataModel> addBidOrder(AddBidOrderRequest request) async {
    ActionResponse? response = await _manager.addBidOrder(request);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateOfferState(OfferStateRequest request) async {
    ActionResponse? response = await _manager.updateOfferState(request);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getOpenOrders(FilterBidOrderRequest request) async {
    BidOrdersResponse? response = await _manager.getOpenOrders(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return BidOrderModel.withData(response);
  }
  Future<DataModel> getSupplierCategories() async {
    SupplierCategoriesResponse? response = await _manager.getSupplierCat();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return SupplierCategoriesModel.withData(response);
  }

  Future<DataModel> getOrderOffers(int orderBidId) async {
    OffersResponse? response = await _manager.getOrderOffers(orderBidId);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OfferModel.withData(response);
  }


  Future<DataModel> getOrderDetails(int orderId) async {
    BidOrderDetailsResponse? response =
    await _manager.getOrderDetails(orderId);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();

    return BidOrderDetailsModel.withData(response);
  }
  Future<DataModel> cancelBidOrder(int request) async {
    ActionResponse? response = await _manager.cancelBidOrder(request);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }
}
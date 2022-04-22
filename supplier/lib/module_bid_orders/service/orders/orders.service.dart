import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/manager/orders_manager/orders_manager.dart';
import 'package:c4d/module_bid_orders/model/order/order_model.dart';
import 'package:c4d/module_bid_orders/model/order_details/order_details_model.dart';
import 'package:c4d/module_bid_orders/request/add_offer_request.dart';
import 'package:c4d/module_bid_orders/request/bid_order_offer_filter_request.dart';
import 'package:c4d/module_bid_orders/request/open_order_filter_request.dart';
import 'package:c4d/module_bid_orders/response/order_details_response/order_details_reponse.dart';
import 'package:c4d/module_bid_orders/response/orders_response/orders_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersService {
  final OrdersManager _ordersManager;
  final ProfileService _profileService;

  OrdersService(this._ordersManager, this._profileService);

//  Future<DataModel> getMyOrders() async {
//    OrdersResponse? response = await _ordersManager.getMyOrders();
//    if (response == null) return DataModel.withError(S.current.networkError);
//    if (response.statusCode != '200') {
//      return DataModel.withError(
//          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
//    }
//    if (response.data == null) return DataModel.empty();
//    return OrderModel.withData(response);
//  }

  Future<DataModel> getOpenOrders(FilterOpenBidOrderRequest request) async {
    OrdersResponse? response = await _ordersManager.getOpenOrders(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }

  Future<DataModel> getMyOfferOrder(FilterOrderOfferRequest request) async {
    OrdersResponse? response = await _ordersManager.getMyOfferOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }


  Future<DataModel> getOrderDetails(int orderId) async {
    OrderDetailsResponse? response =
        await _ordersManager.getOrderDetails(orderId);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderDetailsModel.withData(response);
  }

  Future<DataModel> addNewOffer(AddOfferRequest request) async {
    ActionResponse? response = await _ordersManager.addNewOffer(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

}

import 'package:c4d/module_bid_order/manager/bid_order_manager.dart';
import 'package:c4d/module_bid_order/model/order/order_model.dart';
import 'package:c4d/module_bid_order/model/order_details/order_details_model.dart';
import 'package:c4d/module_bid_order/request/notice_request.dart';
import 'package:c4d/module_bid_order/response/order_details_response/order_details_reponse.dart';
import 'package:c4d/module_bid_order/response/orders_response/orders_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class BidOrderService {
  final BidOrderManager _manager;

  BidOrderService(this._manager);

  Future<DataModel> getOrderDetails(int orderId) async {
    OrderDetailsResponse? response = await _manager.getOrderDetails(orderId);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderDetailsModel.withData(response);
  }

  Future<DataModel> getBidOrder(FilterBidOrderRequest request) async {
    OrdersResponse? response = await _manager.getBidOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return OrderModel.withData(response);
  }
}

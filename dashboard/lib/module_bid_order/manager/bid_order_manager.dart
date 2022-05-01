import 'package:c4d/module_bid_order/repository/bid_order_repository.dart';
import 'package:c4d/module_bid_order/request/notice_request.dart';
import 'package:c4d/module_bid_order/response/order_details_response/order_details_reponse.dart';
import 'package:c4d/module_bid_order/response/orders_response/orders_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class BidOrderManager {
  final BidOrderRepository _repository;

  BidOrderManager(this._repository);

  Future<OrdersResponse?> getBidOrder(FilterBidOrderRequest request) => _repository.getBidOrder(request);

  Future<OrderDetailsResponse?> getOrderDetails(int id) =>
      _repository.getBidOrderDetails(id);
}

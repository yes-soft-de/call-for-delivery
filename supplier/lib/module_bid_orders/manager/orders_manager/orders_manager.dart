import 'package:c4d/module_bid_orders/repository/order_repository/order_repository.dart';
import 'package:c4d/module_bid_orders/request/add_offer_request.dart';
import 'package:c4d/module_bid_orders/request/bid_order_offer_filter_request.dart';
import 'package:c4d/module_bid_orders/request/confirm_offer_request.dart';
import 'package:c4d/module_bid_orders/request/open_order_filter_request.dart';
import 'package:c4d/module_bid_orders/response/cars/cars_response.dart';
import 'package:c4d/module_bid_orders/response/order_details_response/order_details_reponse.dart';
import 'package:c4d/module_bid_orders/response/orders_response/orders_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersManager {
  final OrderRepository _repository;

  OrdersManager(
    this._repository,
  );

  Future<OrdersResponse?> getOpenOrders(FilterOpenBidOrderRequest request) =>
      _repository.getOpenOrder(request);

  Future<CarsResponse?> getDeliveryCar() =>
      _repository.getDeliveryCar();

  Future<OrdersResponse?> getMyOfferOrder(FilterOrderOfferRequest request) =>
      _repository.getMyOfferOrder(request);

  Future<OrderDetailsResponse?> getOrderDetails(int id) =>
      _repository.getOrderDetails(id);

  Future<ActionResponse?> addNewOffer(AddOfferRequest offerRequest) =>
      _repository.addNewOffer(offerRequest);

  Future<ActionResponse?> confirmOffer(ConfirmOfferRequest offerRequest) =>
      _repository.confirmOffer(offerRequest);
}

import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_bid_order/model/order/order_model.dart';
import 'package:c4d/module_bid_order/request/notice_request.dart';
import 'package:c4d/module_bid_order/service/bid_order_service.dart';
import 'package:c4d/module_bid_order/ui/screen/bid_orders_screen.dart';
import 'package:c4d/module_bid_order/ui/state/bid_orders/orders.state.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';

@injectable
class BidOrderStateManager extends StateManagerHandler {
  final BidOrderService _service;

  Stream<States> get stateStream => stateSubject.stream;

  BidOrderStateManager(this._service);

  void getBidOrder(
      BidOrdersScreenState screenState, FilterBidOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    _service.getBidOrder(request).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getBidOrder(screenState, request);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          getBidOrder(screenState, request);
        }, emptyMessage: S.current.homeDataEmpty, title: '', hasAppbar: false));
      } else {
        OrderModel model = value as OrderModel;
        stateSubject.add(BidOrdersListStateLoaded(
          screenState,
          orders: model.data,
        ));
      }
    });
  }
}

import 'dart:async';
import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/pending_order.dart';
import 'package:c4d/module_orders/request/order/pending_order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_pending_screen.dart';
import 'package:c4d/module_orders/ui/state/order_pending_state/order_pending_loaded_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderPendingStateManager extends StateManagerHandler {
  final OrdersService _myOrdersService;

  Stream<States> get stateStream => stateSubject.stream;

  OrderPendingStateManager(this._myOrdersService);

  void getPendingOrders(
      OrderPendingScreenState screenState, PendingOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getPendingOrder(request).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getPendingOrders(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getPendingOrders(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as PendingOrder;
        stateSubject.add(OrderPendingLoadedState(screenState, value.data));
      }
    });
  }
}

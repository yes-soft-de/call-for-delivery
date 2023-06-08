import 'dart:async';
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
import 'package:rxdart/rxdart.dart';

@injectable
class OrderPendingStateManager {
  final OrdersService _myOrdersService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderPendingStateManager(this._myOrdersService);

  void getPendingOrders(OrderPendingScreenState screenState,
  PendingOrderRequest request,
      [bool loading = true] ) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getPendingOrder(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getPendingOrders(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getPendingOrders(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as PendingOrder;
        _stateSubject.add(OrderPendingLoadedState(screenState, value.data));
      }
    });
  }
}

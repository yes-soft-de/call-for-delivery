import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_bid_orders/service/orders/orders.service.dart';
import 'package:c4d/module_bid_orders/ui/screens/order_time_line_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrderTimeLineStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = new PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderTimeLineStateManager(this._ordersService, this._authService);
  void getOrder(OrderTimeLineScreenState screenState, int id,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
//    _ordersService.getOrderDetails(id).then((value) {
//      if (value.hasError) {
//        _stateSubject.add(ErrorState(screenState, onPressed: () {
//          getOrder(screenState, id);
//        }, title: '', error: value.error, hasAppbar: false));
//      } else if (value.isEmpty) {
//        _stateSubject.add(EmptyState(screenState, onPressed: () {
//          getOrder(screenState, id);
//        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
//      } else {
//        value as OrderDetailsModel;
//        _stateSubject
//            .add(OrderTimLineLoadedState(screenState, value.data.orderLogs));
//      }
//    });
  }
}

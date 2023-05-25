import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/conflict_distance_order.dart';
import 'package:c4d/module_orders/request/add_extra_distance_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_conflict_distance_screen.dart';
import 'package:c4d/module_orders/ui/state/order_distance_state/order_distance_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrderDistanceConflictStateManager {
  final OrdersService _myOrdersService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderDistanceConflictStateManager(this._myOrdersService);

  void getOrdersFilters(
      OrderDistanceConflictScreenState screenState, FilterOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getOrdersConflictedDistance(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as ConflictDistanceOrder;
        _stateSubject
            .add(OrderDistanceConflictLoadedState(screenState, value.data));
      }
    });
  }

  void updateDistance(OrderDistanceConflictScreenState screenState,
      AddExtraDistanceRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _myOrdersService.updateExtraDistanceToOrder(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            ;
        screenState.getOrders();
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.distanceUpdatedSuccessfully)
            ;
        screenState.getOrders();
      }
    });
  }

  void addExtraDistance(OrderDistanceConflictScreenState screenState,
      AddExtraDistanceRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _myOrdersService.addExtraDistanceToOrder(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            ;
        screenState.getOrders();
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.distanceUpdatedSuccessfully)
            ;
        screenState.getOrders();
      }
    });
  }
}

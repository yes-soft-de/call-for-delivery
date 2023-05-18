import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order_without_distance_model.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/update_distance_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders_without_distance_screen.dart';
import 'package:c4d/module_orders/ui/state/order_without_distance/order_without_distance_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrderWithoutDistanceStateManager {
  final OrdersService _myOrdersService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderWithoutDistanceStateManager(this._myOrdersService);

  void getOrdersWithoutDistance(
      OrdersWithoutDistanceScreenState screenState, FilterOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getOrdersWithoutDistance(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrdersWithoutDistance(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrdersWithoutDistance(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrdersWithoutDistanceModel;
        _stateSubject
            .add(OrderWithoutDistanceLoadedState(screenState, value.data));
      }
    });
  }

  void updateDistance(OrdersWithoutDistanceScreenState screenState,
      UpdateDistanceRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _myOrdersService.updateDistance(request).then((value) {
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

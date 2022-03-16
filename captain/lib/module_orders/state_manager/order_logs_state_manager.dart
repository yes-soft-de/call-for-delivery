import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_empty_state.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_error_state.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_loaded_state.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_loading_state.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_state.dart';

@injectable
class OrderLogsStateManager {
  final OrdersService _myOrdersService;
  final PublishSubject<OrderLogsState> _stateSubject =
      PublishSubject<OrderLogsState>();

  Stream<OrderLogsState> get stateStream => _stateSubject.stream;

  OrderLogsStateManager(this._myOrdersService);

  void getOrdersLogs(OrderLogsScreenState screenState) {
    _stateSubject.add(OrderLogsLoadingState(screenState));
    _myOrdersService.getOrdersLogs().then((value) {
      if (value.hasError) {
        _stateSubject.add(OrderLogsErrorState(screenState, value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(OrderLogsEmptyState(screenState, S.current.homeDataEmpty));
      } else {
        _stateSubject.add(OrderLogsLoadedState(screenState, value.data));
      }
    });
  }
}

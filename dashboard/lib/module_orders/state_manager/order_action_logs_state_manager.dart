import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_action_logs_model.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_actions_log_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_orders/ui/state/order_action_logs/order_action_logs_loaded_state.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrderActionLogsStateManager {
  final OrdersService _myOrdersService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderActionLogsStateManager(this._myOrdersService);

  void getActions(OrderActionLogsScreenState screenState, int orderID,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getActionOrderLogs(orderID).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getActions(screenState, orderID);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getActions(screenState, orderID);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderActionLogsModel;
        _stateSubject.add(OrderActionLogsLoadedState(screenState, value.data));
      }
    });
  }
}

import 'dart:async';
import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_action_logs_model.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_actions_log_screen.dart';
import 'package:c4d/module_orders/ui/state/order_action_logs/order_action_logs_loaded_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderActionLogsStateManager extends StateManagerHandler {
  final OrdersService _myOrdersService;

  Stream<States> get stateStream => stateSubject.stream;

  OrderActionLogsStateManager(this._myOrdersService);

  void getActions(OrderActionLogsScreenState screenState, int orderID,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getActionOrderLogs(orderID).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getActions(screenState, orderID);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getActions(screenState, orderID);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderActionLogsModel;
        stateSubject.add(OrderActionLogsLoadedState(screenState, value.data));
      }
    });
  }
}

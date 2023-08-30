import 'dart:async';
import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order_captain_logs_model.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders_captain_screen.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_captain_logs_loaded_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderCaptainLogsStateManager extends StateManagerHandler {
  final OrdersService _myOrdersService;

  Stream<States> get stateStream => stateSubject.stream;

  OrderCaptainLogsStateManager(this._myOrdersService);

  void getOrdersFilters(
      OrderCaptainLogsScreenState screenState, FilterOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getCaptainOrdersFilter(request).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderCaptainLogsModel;
        stateSubject.add(OrderCaptainLogsLoadedState(screenState, value.data));
      }
    });
  }
}

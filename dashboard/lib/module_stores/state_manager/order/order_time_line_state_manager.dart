import 'dart:async';
import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/order/order_time_line_screen.dart';
import 'package:c4d/module_stores/ui/state/order/order_time_line.dart';
import 'package:injectable/injectable.dart';

import '../../../module_orders/model/order_details_model.dart';

@injectable
class OrderTimeLineStateManager extends StateManagerHandler {
  final StoresService _ordersService;

  Stream<States> get stateStream => stateSubject.stream;

  OrderTimeLineStateManager(this._ordersService);
  void getOrder(OrderTimeLineScreenState screenState, int id,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getOrderDetails(id).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrder(screenState, id);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          getOrder(screenState, id);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderDetailsModel;
        stateSubject
            .add(OrderTimLineLoadedState(screenState, value.data.orderLogs));
      }
    });
  }
}

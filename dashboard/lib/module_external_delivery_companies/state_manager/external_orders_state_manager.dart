import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_orders_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/external_orders_state_loaded.dart';
import 'package:c4d/module_orders/model/pending_order.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

import '../../module_orders/request/order/pending_order_request.dart';

@injectable
class ExternalOrdersStateManager {
  final OrdersService _myOrdersService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  ExternalOrdersStateManager(this._myOrdersService);

  Stream<States> get stateStream => _stateSubject.stream;

  void getPendingOrders(
      ExternalOrderScreenState screenState, PendingOrderRequest request,
      [bool loading = true]) {
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
        _stateSubject.add(ExternalOrdersLoadedState(screenState, value.data));
      }
    });
  }
}

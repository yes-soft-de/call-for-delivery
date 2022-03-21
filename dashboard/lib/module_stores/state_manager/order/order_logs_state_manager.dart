import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/order/order_model.dart';
import 'package:c4d/module_stores/request/order_filter_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import '../../ui/state/order/order_logs_loaded_state.dart';
import '../../ui/screen/order/order_logs_screen.dart';
 import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrderLogsStateManager {
  final StoresService _orderService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderLogsStateManager(this._orderService);

  void getOrdersFilters(
      OrderLogsScreenState screenState, FilterOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _orderService.getStoreOrdersFilter(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderModel;
        _stateSubject.add(OrderLogsLoadedState(screenState, value.data));
      }
    });
  }
}

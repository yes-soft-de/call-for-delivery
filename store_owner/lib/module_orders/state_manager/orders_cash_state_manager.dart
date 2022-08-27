import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order_cash_request.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders_cash_screen.dart';
import 'package:c4d/module_orders/ui/state/orders_cash/orders_cash_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrdersCashStateManager {
  final OrdersService _myOrdersService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  OrdersCashStateManager(this._myOrdersService);

  void getOrdersFilters(
      OrdersCashScreenState screenState, FilterOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getOrdersCash(request).then((value) {
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
        _stateSubject.add(OrdersCashLoadedState(screenState, value.data));
      }
    });
  }

  void confirmOrderCashFinance(
      OrdersCashScreenState screenState, OrderCashRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _myOrdersService.confirmOrderCashFinance(request).then((value) {
      if (value.hasError) {
        screenState.getOrders();
        Fluttertoast.showToast(msg: value.error ?? S.current.errorHappened);
      } else {
        screenState.getOrders();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.reportSent)
            .show(screenState.context);
      }
    });
  }
}

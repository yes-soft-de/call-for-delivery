import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/captain_cash_orders_finance.dart';
import 'package:c4d/module_orders/request/captain_cash_finance_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_cash_captain_screen.dart';
import 'package:c4d/module_orders/ui/state/order_cash_state/orders_cash_captain_loaded.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrderCashCaptainStateManager {
  final OrdersService _myOrdersService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderCashCaptainStateManager(this._myOrdersService);

  void getOrdersFilters(OrdersCashCaptainScreenState screenState,
      CaptainCashFinanceRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _myOrdersService.getOrderCashFinancesForCaptain(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', error: value.error, hasAppbar: false, size: 200));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
          getOrdersFilters(screenState, request);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as CaptainCashOrdersFinanceModel;
        _stateSubject
            .add(OrdersCashCaptainLoadedState(screenState, value.data));
      }
    });
  }

  void payForStore(OrdersCashCaptainScreenState screenState,
      CaptainPaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    getIt<PaymentsService>().paymentFromCaptain(request).then((value) {
      if (value.hasError) {
        getOrdersFilters(screenState, screenState.ordersFilter);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            ;
      } else {
        getOrdersFilters(screenState, screenState.ordersFilter);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: value.error ?? S.current.paymentSuccessfully)
            ;
      }
    });
  }
}

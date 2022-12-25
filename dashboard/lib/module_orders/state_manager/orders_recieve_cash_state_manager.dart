import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/resolve_conflects_order_request.dart';
import 'package:c4d/module_orders/request/store_answer_cash_order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/orders_receive_cash_screen.dart';
import 'package:c4d/module_orders/ui/state/orders_receive_cash_state/orders_reveive_cash_loaded_state.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrdersReceiveCashStateManager {
  final OrdersService _myOrdersService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  OrdersReceiveCashStateManager(this._myOrdersService);

  void getOrdersFilters(
      OrdersReceiveCashScreenState screenState, FilterOrderRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    if (screenState.currentIndex == 0) {
      getNotAnsweredOrder(screenState, request);
    } else {
      getConflictingAnswerOrderCash(screenState, request);
    }
  }

  void getNotAnsweredOrder(
      OrdersReceiveCashScreenState screenState, FilterOrderRequest request) {
    _myOrdersService.getNotAnsweredOrderCash(request).then((value) {
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
        _stateSubject
            .add(OrdersReceiveCashLoadedState(screenState, value.data));
      }
    });
  }

  void getConflictingAnswerOrderCash(
      OrdersReceiveCashScreenState screenState, FilterOrderRequest request) {
    _myOrdersService.getConflictingAnswerOrderCash(request).then((value) {
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
        _stateSubject
            .add(OrdersReceiveCashLoadedState(screenState, value.data));
      }
    });
  }

  void resolveConflictOrder(OrdersReceiveCashScreenState screenState,
      FilterOrderRequest request, ResolveConflictsOrderRequest resolve) {
    showDialog(
        context: screenState.context,
        builder: (ctx) {
          return CustomAlertDialog(
              onPressed: () {
                Navigator.of(ctx).pop();
                _myOrdersService.resolveOrderConflicts(resolve).then((value) {
                  if (value.hasError) {
                    CustomFlushBarHelper.createError(
                            title: S.current.warnning,
                            message: value.error ?? S.current.errorHappened)
                        .show(screenState.context);
                    getOrdersFilters(screenState, request);
                  } else {
                    CustomFlushBarHelper.createSuccess(
                            title: S.current.warnning,
                            message: S.current.orderConflictedSuccessfully)
                        .show(screenState.context);
                    getOrdersFilters(screenState, request);
                  }
                });
              },
              content: S.current.areSureAboutResolveThisOrder,
              oneAction: false);
        });
  }

  void storeAnswerCashOrder(OrdersReceiveCashScreenState screenState,
      FilterOrderRequest request, StoreAnswerForOrderCashRequest resolve) {
    showDialog(
        context: screenState.context,
        builder: (ctx) {
          return CustomAlertDialog(
              onPressed: () {
                Navigator.of(ctx).pop();
                _myOrdersService.updateAnswerOrderCashForStore(resolve).then((value) {
                  if (value.hasError) {
                    CustomFlushBarHelper.createError(
                            title: S.current.warnning,
                            message: value.error ?? S.current.errorHappened)
                        .show(screenState.context);
                    getOrdersFilters(screenState, request);
                  } else {
                    CustomFlushBarHelper.createSuccess(
                            title: S.current.warnning,
                            message: S.current.updateStoreAnswerSuccessfully)
                        .show(screenState.context);
                    getOrdersFilters(screenState, request);
                  }
                });
              },
              content: S.current.areSureAboutResolveThisOrder,
              oneAction: false);
        });
  }
}

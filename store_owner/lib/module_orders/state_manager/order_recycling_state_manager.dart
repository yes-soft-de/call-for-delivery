import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/confirm_captain_location_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_recylcing_screen.dart';
import 'package:c4d/module_orders/ui/state/order_recycling_loaded_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/request/rating_request.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrderRecyclingStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = new PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderRecyclingStateManager(this._ordersService, this._authService);
  void getOrder(OrderRecyclingScreenState screenState, int id,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _ordersService.getOrderDetails(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrder(screenState, id);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getOrder(screenState, id);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderDetailsModel;
        _stateSubject.add(OrderRecyclingLoaded(screenState, value.data));
      }
    });
  }

  void recycle(
      OrderRecyclingScreenState screenState, CreateOrderRequest request) {
    var context = screenState.context;
    _stateSubject.add(LoadingState(screenState));
    _ordersService.recycling(request).then((value) {
      if (value.hasError) {
        getIt<GlobalStateManager>().update();
        Navigator.pushNamedAndRemoveUntil(
            context, OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getIt<GlobalStateManager>().update();
        Navigator.pop(screenState.context);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.orderCreatedSuccessfully)
            .show(screenState.context);
      }
    });
  }
}

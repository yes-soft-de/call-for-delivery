import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_recylcing_screen.dart';
import 'package:c4d/module_orders/ui/state/order_recycling_loaded_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
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
        _stateSubject.add(OrderRecyclingLoaded(screenState, value.data, []));
        getBranches(screenState, value.data);
      }
    });
  }

  void getBranches(
      OrderRecyclingScreenState screenState, OrderDetailsModel details) {
    getIt<BranchesListService>().getBranches().then((value) {
      if (value.hasError == false && value.isEmpty == false) {
        value as BranchesModel;
        _stateSubject
            .add(OrderRecyclingLoaded(screenState, details, value.data));
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
        Navigator.of(context).pop();
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getIt<GlobalStateManager>().update();
        Navigator.pop(screenState.context);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }
}

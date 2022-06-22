import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/new_order/update_order_screen.dart';
import 'package:c4d/module_orders/ui/state/new_order/update_order_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class UpdateOrderStateManager {
  final OrdersService _ordersService;
  final PublishSubject<States> _stateSubject = new PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;
  UpdateOrderStateManager(this._ordersService);
  void getBranches(UpdateOrderScreenState screenState) {
    getIt<BranchesListService>().getBranches().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getBranches(screenState);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getBranches(screenState);
        },
            title: '',
            emptyMessage: S.current.thereIsNoBranches,
            hasAppbar: false));
      } else {
        value as BranchesModel;
        _stateSubject.add(
            UpdateOrderLoaded(screenState, value.data, screenState.orderInfo));
      }
    });
  }

  void updateOrder(
      UpdateOrderScreenState screenState, CreateOrderRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.updateOrder(request).then((value) {
      if (value.hasError) {
        FireStoreHelper().backgroundThread('Trigger');
        Navigator.of(screenState.context).pushNamedAndRemoveUntil(
            OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        Navigator.of(screenState.context).pushNamedAndRemoveUntil(
            OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updateOrderSuccess)
            .show(screenState.context);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }
}

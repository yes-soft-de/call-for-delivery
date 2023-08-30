import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_main/main_routes.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/new_order/update_order_screen.dart';
import 'package:c4d/module_orders/ui/state/new_order/update_order_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderStateManager extends StateManagerHandler {
  final OrdersService _ordersService;
  Stream<States> get stateStream => stateSubject.stream;

  UpdateOrderStateManager(this._ordersService);
  
  void getBranches(UpdateOrderScreenState screenState, int storeID) {
    getIt<BranchesListService>().getBranches(storeID.toString()).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getBranches(screenState, storeID);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          getBranches(screenState, storeID);
        },
            title: '',
            emptyMessage: S.current.thereIsNoBranches,
            hasAppbar: false));
      } else {
        value as BranchesModel;
        stateSubject.add(
            UpdateOrderLoaded(screenState, value.data, screenState.orderInfo));
      }
    });
  }

  void updateOrder(
      UpdateOrderScreenState screenState, CreateOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    _ordersService.updateOrder(request).then((value) {
      if (value.hasError) {
        getIt<GlobalStateManager>().updateList();
        Navigator.of(screenState.context)
            .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getIt<GlobalStateManager>().updateList();
        Navigator.of(screenState.context)
            .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.orderUpdatedSuccessfully);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }
}

import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/branches_routes.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_link.dart';
import 'package:c4d/module_orders/ui/state/new_order/new_order_link_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewOrderLinkStateManager extends StateManagerHandler {
  final OrdersService _ordersService;
  Stream<States> get stateStream => stateSubject.stream;
  
  NewOrderLinkStateManager(this._ordersService);
  void getBranches(NewOrderLinkScreenState screenState, String storeId) {
    getIt<BranchesListService>().getBranches(storeId).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getBranches(screenState, storeId);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          Navigator.of(screenState.context)
              .pushReplacementNamed(BranchesRoutes.BRANCHES_LIST_SCREEN);
        },
            title: '',
            buttonLabel: S.current.branchManagement,
            emptyMessage: S.current.thereIsNoBranches,
            hasAppbar: false));
      } else {
        value as BranchesModel;
        stateSubject.add(NewOrderLinkStateLoaded(value.data, screenState));
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }

  void createOrder(
      NewOrderLinkScreenState screenState, CreateOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    _ordersService.addNewOrderLink(request).then((value) {
      if (value.hasError) {
        getIt<GlobalStateManager>().updateList();
        Navigator.pop(screenState.context);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            ;
      } else {
        getIt<GlobalStateManager>().updateList();
        Navigator.pop(screenState.context);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.orderCreatedSuccessfully)
            ;
      }
    });
  }
}

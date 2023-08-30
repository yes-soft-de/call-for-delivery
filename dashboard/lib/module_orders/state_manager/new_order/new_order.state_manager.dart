import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/state/new_order/new_order.state.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewOrderStateManager extends StateManagerHandler {
  final OrdersService _ordersService;
  Stream<States> get stateStream => stateSubject.stream;

  NewOrderStateManager(this._ordersService);
  void getStores(NewOrderScreenState screenState) {
    getIt<StoresService>().getStores().then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getStores(screenState);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          getStores(screenState);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as StoresModel;
        stateSubject
            .add(NewOrderStateBranchesLoaded(value.data, [], screenState));
      }
    });
  }

  void getBranches(
      NewOrderScreenState screenState, int storeID, List<StoresModel> stores) {
    getIt<BranchesListService>().getBranches(storeID.toString()).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
        stateSubject.add(NewOrderStateBranchesLoaded(stores, [], screenState));
      } else if (value.isEmpty) {
        stateSubject.add(NewOrderStateBranchesLoaded(stores, [], screenState));
      } else {
        value as BranchesModel;
        stateSubject
            .add(NewOrderStateBranchesLoaded(stores, value.data, screenState));
      }
    });
  }

  void createOrder(
      NewOrderScreenState screenState, CreateOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    _ordersService.createOrder(request).then((value) {
      if (value.hasError) {
        screenState.clear();
        getStores(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getIt<GlobalStateManager>().updateList();
        screenState.clear();
        getStores(screenState);
        value as OrderDetailsModel;
        Navigator.of(screenState.context).pushNamed(
            StoresRoutes.ORDER_STATUS_SCREEN,
            arguments: value.data.id);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.orderCreatedSuccessfully);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }
}

import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_main/main_routes.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/recycle_order/recycle_order_screen.dart';
import 'package:c4d/module_orders/ui/state/recycle_order/recycle_order_state2.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class RecycleOrderStateManager {
  final OrdersService _ordersService;
  final PublishSubject<States> _stateSubject = new PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;
  RecycleOrderStateManager(this._ordersService);

  void getOrderbyId(RecycleOrderScreenState screenState, int orderId) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.getOrderDetails(orderId).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          // getOrder(screenState, id);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          // getOrder(screenState, id);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderDetailsModel;
        screenState.orderInfo = value.data;
        _stateSubject.add(RecycleOrderLoaded2(screenState, [], value.data));
      }
    });
  }

  void getBranches(RecycleOrderScreenState screenState, int storeID) {
    getIt<BranchesListService>().getBranches(storeID.toString()).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getBranches(screenState, storeID);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getBranches(screenState, storeID);
        },
            title: '',
            emptyMessage: S.current.thereIsNoBranches,
            hasAppbar: false));
      } else {
        value as BranchesModel;
        screenState.branches = value.data;
        _stateSubject
            .add(RecycleOrderLoaded2(screenState, [], screenState.orderInfo));
      }
    });
  }

  void updateOrder(
      RecycleOrderScreenState screenState, CreateOrderRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.updateOrder(request).then((value) {
      if (value.hasError) {
        getIt<GlobalStateManager>().updateList();
        Navigator.of(screenState.context)
            .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getIt<GlobalStateManager>().updateList();
        Navigator.of(screenState.context)
            .pushNamedAndRemoveUntil(MainRoutes.MAIN_SCREEN, (route) => false);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.orderUpdatedSuccessfully)
            .show(screenState.context);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }
}

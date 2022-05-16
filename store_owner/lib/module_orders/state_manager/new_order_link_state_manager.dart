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
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/new_order_link.dart';
import 'package:c4d/module_orders/ui/state/new_order_link/new_order_link_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class NewOrderLinkStateManager {
  final OrdersService _ordersService;
  final PublishSubject<States> _stateSubject = new PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;
  NewOrderLinkStateManager(this._ordersService);
  void getBranches(NewOrderLinkScreenState screenState) {
    getIt<BranchesListService>().getBranches().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getBranches(screenState);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          Navigator.of(screenState.context)
              .pushReplacementNamed(BranchesRoutes.BRANCHES_LIST_SCREEN);
        },
            title: '',
            buttonLabel: S.current.branchManagement,
            emptyMessage: S.current.thereIsNoBranches,
            hasAppbar: false));
      } else {
        value as BranchesModel;
        _stateSubject.add(NewOrderLinkStateLoaded(value.data, screenState));
      }
    });
  }

  void createOrder(
      NewOrderLinkScreenState screenState, CreateOrderRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.addNewOrderLink(request).then((value) {
      if (value.hasError) {
        getIt<GlobalStateManager>().update();
        Navigator.pop(screenState.context);
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

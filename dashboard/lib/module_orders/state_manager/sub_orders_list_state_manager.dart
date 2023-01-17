import 'dart:async';
import 'dart:developer';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart';
import 'package:c4d/module_orders/ui/state/sub_orders/sub_orders_list_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SubOrdersStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = new PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  SubOrdersStateManager(this._ordersService, this._authService);
  void getOrder(SubOrdersScreenState screenState, int id,
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
        var order = value.data;
      OrderModel primaryOrder = OrderModel(
          storeName: order.storeName,
          branchName: order.branchName,
          storeId: order.storeID,
          state: order.state,
          orderCost: order.orderCost,
          branchID: order.branchID,
          note: order.note,
          deliveryDate: DateFormat.jm().format(order.deliveryDate) +
              ' 📅 ' +
              DateFormat.Md().format(order.deliveryDate),
          createdDate: DateFormat.jm().format(order.createdAt) +
              ' 📅 ' +
              DateFormat.Md().format(order.deliveryDate),
          id: order.id,
          orderIsMain: true,
          subOrders: order.subOrders,
          created: null,
          delivery: null,
          kilometer: 0,
          storeBranchToClientDistance: 0,
        );
        List<OrderModel> orders = [];
        orders.addAll(order.subOrders);
        orders.insert(0, primaryOrder);
        _stateSubject
            .add(SubOrdersListStateLoaded(screenState, orders: orders));
      }
    });
  }

  void removeSubOrder(
      SubOrdersScreenState screenState, OrderNonSubRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.removeOrderSub(request).then((value) {
      if (value.hasError) {
        getIt<GlobalStateManager>().updateList();
        getOrder(screenState, screenState.orderId);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getOrder(screenState, screenState.orderId);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.orderRemovedSuccessfully)
            .show(screenState.context);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }
}

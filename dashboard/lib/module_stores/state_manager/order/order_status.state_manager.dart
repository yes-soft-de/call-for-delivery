import 'dart:async';
import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/request/add_extra_distance_request.dart';
import 'package:c4d/module_orders/request/order/delete_order_from_alshoroq_request.dart';
import 'package:c4d/module_orders/request/order/delete_order_from_marsool_request.dart';
import 'package:c4d/module_orders/request/order/update_order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_stores/request/delete_order_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/order/order_details_screen.dart';
import 'package:c4d/module_stores/ui/state/order/order_details_state_owner_order_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:injectable/injectable.dart';

import '../../../module_orders/model/order_details_model.dart';

@injectable
class OrderStatusStateManager extends StateManagerHandler {
  final StoresService _storeService;

  Stream<States> get stateStream => stateSubject.stream;

  OrderStatusStateManager(this._storeService);
  void getOrder(OrderDetailsScreenState screenState, int id,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _storeService.getOrderDetails(id).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getOrder(screenState, id);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          getOrder(screenState, id);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as OrderDetailsModel;
        stateSubject
            .add(OrderDetailsStateOwnerOrderLoaded(screenState, value.data));
        if (loading) {
          watcher(screenState, id);
        }
      }
    });
  }

  void watcher(OrderDetailsScreenState screenState, int id) {
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      getOrder(screenState, id, false);
    });
  }

  void deleteOrder(
      DeleteOrderRequest request, OrderDetailsScreenState screenState) {
    screenState.canRemoveOrder = false;
    stateSubject.add(LoadingState(screenState));
    getIt<OrdersService>().deleteOrder(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
        getOrder(screenState, request.orderID ?? -1);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.deleteSuccess);
        getOrder(screenState, request.orderID ?? -1);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }

  void deleteOrderFromAlShoroq(
    OrderDetailsScreenState screenState,
    DeleteOrderFromAlShoroqRequest request,
  ) {
    screenState.canRemoveOrder = false;
    stateSubject.add(LoadingState(screenState));
    getIt<OrdersService>().deleteOrderFromAlShoroq(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
        getOrder(screenState, request.orderId);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.deleteSuccess);
        getOrder(screenState, request.orderId);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }

  void deleteOrderFromAlMarsool(
    OrderDetailsScreenState screenState,
    DeleteOrderFromMarsoolRequest request,
  ) {
    screenState.canRemoveOrder = false;
    stateSubject.add(LoadingState(screenState));
    getIt<OrdersService>().deleteOrderFromMarsool(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
        getOrder(screenState, request.orderId);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.deleteSuccess);
        getOrder(screenState, request.orderId);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }

  void updateOrderStatus(
      OrderDetailsScreenState screenState, UpdateOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    getIt<OrdersService>().updateOrderStatus(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
        getOrder(screenState, request.id ?? -1);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.updateOrderStatusSuccessfully);
        getOrder(screenState, request.id ?? -1);
        FireStoreHelper().backgroundThread('Trigger').ignore();
      }
    });
  }

  void unAssignedOrder(int orderId, OrderDetailsScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    getIt<OrdersService>().unAssignCaptain(orderId).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
        getOrder(screenState, orderId);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.orderUpdatedSuccessfully);
        getOrder(screenState, orderId);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }

  void updateDistance(
      OrderDetailsScreenState screenState, AddExtraDistanceRequest request) {
    stateSubject.add(LoadingState(screenState));
    getIt<OrdersService>().updateExtraDistanceToOrder(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
        getOrder(screenState, request.id!, false);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.distanceUpdatedSuccessfully);
        getOrder(screenState, request.id!, false);
      }
    });
  }

  void addExtraDistance(
      OrderDetailsScreenState screenState, AddExtraDistanceRequest request) {
    stateSubject.add(LoadingState(screenState));
    getIt<OrdersService>().addExtraDistanceToOrder(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
        // screenState.getOrders();
        getOrder(screenState, request.id!, false);
      } else {
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.distanceUpdatedSuccessfully);
        // screenState.getOrders();
        getOrder(screenState, request.id!, false);
      }
    });
  }
}

import 'dart:async';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/request/confirm_captain_location_request.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_orders/ui/screens/order_details/order_details_screen.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_details_state_owner_order_loaded.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/request/rating_request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class OrderStatusStateManager {
  final OrdersService _ordersService;
  final AuthService _authService;

  final PublishSubject<States> _stateSubject = new PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  OrderStatusStateManager(this._ordersService, this._authService);
  void getOrder(OrderDetailsScreenState screenState, int id,
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
        _stateSubject
            .add(OrderDetailsStateOwnerOrderLoaded(screenState, value.data));
      }
    });
  }

  void rateCaptain(OrderDetailsScreenState screenState, RatingRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.ratingCaptain(request).then((value) {
      if (value.hasError) {
        getOrder(screenState, screenState.orderId);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getOrder(screenState, screenState.orderId);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.captainRated)
            .show(screenState.context);
      }
    });
  }

  void confirmCaptainLocation(OrderDetailsScreenState screenState,
      ConfirmCaptainLocationRequest request) {
    _ordersService.confirmCaptainLocation(request).then((value) {
      if (value.hasError) {
        getOrder(screenState, request.orderId, false);
        Fluttertoast.showToast(msg: value.error ?? S.current.errorHappened);
      } else {
        getOrder(screenState, request.orderId, false);
        Fluttertoast.showToast(msg: S.current.reportSent);
      }
    });
  }

  void deleteOrder(int orderId, OrderDetailsScreenState screenState) {
    screenState.canRemoveIt = false;
    _stateSubject.add(LoadingState(screenState));
    _ordersService.deleteOrder(orderId).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
        getOrder(screenState, orderId);
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.deleteSuccess)
            .show(screenState.context);
        getOrder(screenState, orderId);
        FireStoreHelper().backgroundThread('Trigger');
      }
    });
  }

  void removeSubOrder(
      OrderDetailsScreenState screenState, OrderNonSubRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _ordersService.removeOrderSub(request).then((value) {
      if (value.hasError) {
        getOrder(screenState, screenState.orderId);
        getIt<GlobalStateManager>().update();
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getOrder(screenState, screenState.orderId);
        getIt<GlobalStateManager>().update();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.orderRemovedSuccessfully)
            .show(screenState.context);
      }
    });
  }
}

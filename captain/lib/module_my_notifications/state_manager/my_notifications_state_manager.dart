import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_my_notifications/model/notification_model.dart';
import 'package:c4d/module_my_notifications/service/my_notification_service.dart';
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:c4d/module_my_notifications/ui/state/my_notifications/my_notifications_loaded_state.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyNotificationsStateManager extends StateManagerHandler {
  final MyNotificationsService _myNotificationsService;
  final AuthService _authService;
  final OrdersService _ordersService;

  MyNotificationsStateManager(
      this._myNotificationsService, this._ordersService, this._authService);

  Stream<States> get stateStream => stateSubject.stream;

  void getNotifications(MyNotificationsScreenState screenState) {
    if (_authService.isLoggedIn) {
      stateSubject.add(LoadingState(screenState));
      _myNotificationsService.getNotification().then((value) {
        if (value.hasError) {
          stateSubject.add(ErrorState(screenState,
              title: S.current.notifications,
              error: value.error ?? S.current.errorHappened, onPressed: () {
            getNotifications(screenState);
          }));
        } else if (value.isEmpty) {
          stateSubject.add(EmptyState(screenState,
              title: S.current.notifications,
              emptyMessage: S.current.homeDataEmpty, onPressed: () {
            getNotifications(screenState);
          }));
        } else {
          value as NotificationModel;
          stateSubject.add(MyNotificationsLoadedState(screenState, value.data));
        }
      });
    } else {
      screenState.goToLogin();
    }
  }

  void deleteNotification(MyNotificationsScreenState screenState, String id) {
    stateSubject.add(LoadingState(screenState));
    _myNotificationsService.deleteNotification(id).then((value) {
      if (value.hasError) {
        getNotifications(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        getNotifications(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.notificationDeletedSuccess)
            .show(screenState.context);
      }
    });
  }

  void deleteNotifications(
      MyNotificationsScreenState screenState, List<String> notifications) {
    stateSubject.add(LoadingState(screenState));
    for (var id in notifications) {
      _myNotificationsService.deleteNotification(id).then((value) {
        if (value.hasError) {
          Fluttertoast.showToast(
              msg: value.error ?? S.current.errorHappened,
              backgroundColor: Theme.of(screenState.context).colorScheme.error,
              textColor: Colors.white);
          if (notifications.last == id) {
            getNotifications(screenState);
          }
        } else if (notifications.last == id) {
          getNotifications(screenState);
          CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.notificationsDeletedSuccess)
              .show(screenState.context);
        }
      });
    }
  }

  void updateOrder(
      MyNotificationsScreenState screenState, UpdateOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    getIt<OrdersService>().updateOrder(request).then((value) {
      if (value.hasError) {
        getNotifications(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error)
            .show(screenState.context);
      } else {
        getNotifications(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updateOrderSuccess)
            .show(screenState.context);
      }
    });
  }

  void removeOrderSub(
      MyNotificationsScreenState screenState, OrderNonSubRequest request) {
    stateSubject.add(LoadingState(screenState));
    getIt<OrdersService>().removeOrderSub(request).then((value) {
      if (value.hasError) {
        getNotifications(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getNotifications(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.orderRemovedSuccessfully)
            .show(screenState.context);
      }
    });
  }
}

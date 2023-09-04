import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_my_notifications/model/notification_model.dart';
import 'package:c4d/module_my_notifications/service/my_notification_service.dart';
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:c4d/module_my_notifications/ui/state/my_notifications/my_notifications_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyNotificationsStateManager extends StateManagerHandler {
  final MyNotificationsService _myNotificationsService;
  final AuthService _authService;

  MyNotificationsStateManager(this._myNotificationsService, this._authService);

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
            message: value.error ?? S.current.errorHappened);
      } else {
        getNotifications(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.notificationDeletedSuccess);
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
              message: S.current.notificationsDeletedSuccess);
        }
      });
    }
  }

  // void rateCaptain(
  //     MyNotificationsScreenState screenState, RatingRequest request) {
  //   _stateSubject.add(LoadingState(screenState));
  //   _ordersService.ratingCaptain(request).then((value) {
  //     if (value.hasError) {
  //       getNotifications(screenState);
  //       CustomFlushBarHelper.createError(
  //               title: S.current.warnning, message: value.error ?? '')
  //           ;
  //     } else {
  //       getNotifications(screenState);
  //       CustomFlushBarHelper.createSuccess(
  //               title: S.current.warnning, message: S.current.captainRated)
  //           ;
  //     }
  //   });
  // }
}

import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_my_notifications/service/my_notification_service.dart';
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:c4d/module_my_notifications/ui/state/my_notifications/my_notifications_loaded_state.dart';

@injectable
class MyNotificationsStateManager {
  final MyNotificationsService _myNotificationsService;
  final AuthService _authService;

  MyNotificationsStateManager(this._myNotificationsService, this._authService);
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  void getNotifications(MyNotificationsScreenState screenState) {
    if (_authService.isLoggedIn) {
      _stateSubject.add(LoadingState(screenState));
      _myNotificationsService.getNotification().then((value) {
        if (value.hasError) {
          _stateSubject.add(ErrorState(screenState,
              title: '',
              error: value.error ?? S.current.errorHappened,
              onPressed: () {
            getNotifications(screenState);
          }));
        } else if (value.isEmpty) {
          _stateSubject.add(EmptyState(screenState,
              emptyMessage: S.current.homeDataEmpty, onPressed: () {
            getNotifications(screenState);
          }, title: ''));
        } else {
          _stateSubject
              .add(MyNotificationsLoadedState(screenState, value.data));
        }
      });
    } else {
      screenState.goToLogin();
    }
  }
}

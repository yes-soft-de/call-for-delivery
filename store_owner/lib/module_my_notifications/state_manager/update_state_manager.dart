import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_my_notifications/model/update_model.dart';
import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart';
import 'package:c4d/module_my_notifications/ui/state/update_state/update_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_my_notifications/service/my_notification_service.dart';

@injectable
class UpdatesStateManager {
  final MyNotificationsService _myNotificationsService;
  final AuthService _authService;

  UpdatesStateManager(this._myNotificationsService, this._authService);
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  void getUpdates(UpdateScreenState screenState) {
    if (_authService.isLoggedIn) {
      _stateSubject.add(LoadingState(screenState));
      _myNotificationsService.getUpdates().then((value) {
        if (value.hasError) {
          _stateSubject.add(ErrorState(screenState,
              title: S.current.notifications,
              error: value.error ?? S.current.errorHappened, onPressed: () {
            getUpdates(screenState);
          }));
        } else if (value.isEmpty) {
          _stateSubject.add(EmptyState(screenState,
              title: S.current.notifications,
              emptyMessage: S.current.homeDataEmpty, onPressed: () {
            getUpdates(screenState);
          }));
        } else {
          value as UpdateModel;
          _stateSubject.add(UpdatesLoadedState(screenState, value.data));
        }
      });
    } else {
      screenState.goToLogin();
    }
  }
}

import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_my_notifications/model/update_model.dart';
import 'package:c4d/module_my_notifications/service/my_notification_service.dart';
import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart';
import 'package:c4d/module_my_notifications/ui/state/update_state/update_loaded_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatesStateManager extends StateManagerHandler {
  final MyNotificationsService _myNotificationsService;
  final AuthService _authService;

  UpdatesStateManager(this._myNotificationsService, this._authService);

  Stream<States> get stateStream => stateSubject.stream;

  void getUpdates(UpdateScreenState screenState) {
    if (_authService.isLoggedIn) {
      stateSubject.add(LoadingState(screenState));
      _myNotificationsService.getUpdates().then((value) {
        if (value.hasError) {
          stateSubject.add(ErrorState(screenState,
              title: S.current.notifications,
              error: value.error ?? S.current.errorHappened, onPressed: () {
            getUpdates(screenState);
          }));
        } else if (value.isEmpty) {
          stateSubject.add(EmptyState(screenState,
              title: S.current.notifications,
              emptyMessage: S.current.homeDataEmpty, onPressed: () {
            getUpdates(screenState);
          }));
        } else {
          value as UpdateModel;
          stateSubject.add(UpdatesLoadedState(screenState, value.data));
        }
      });
    } else {
      screenState.goToLogin();
    }
  }
}

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_users/model/users_model.dart';
import 'package:c4d/module_users/request/filter_user_request.dart';
import 'package:c4d/module_users/request/send_notification_request.dart';
import 'package:c4d/module_users/request/update_pass_request.dart';
import 'package:c4d/module_users/service/users_service.dart';
import 'package:c4d/module_users/ui/screen/users_screen.dart';
import 'package:c4d/module_users/ui/states/user_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class UserStateManager {
  final UsersService _service;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  UserStateManager(this._service);

  void getUsers(UsersScreenState screenState , FilterUserRequest request) {
    _stateSubject.add(LoadingState(screenState));
       _service.getUsers(request).then((value) {
        if (value.hasError) {
          _stateSubject.add(
              UsersLoadedState(screenState,null,error: value.error));
        } else if(value.isEmpty) {
          _stateSubject.add(UsersLoadedState(screenState ,null , empty: true));
        }
        else {
          UsersModel usersModel  = value as UsersModel;
          _stateSubject.add(UsersLoadedState(screenState ,usersModel.data));

        }
      });
  }


  void updatePassword(UsersScreenState screenState , UpdatePassRequest request){
    _stateSubject.add(LoadingState(screenState));
    _service.updatePassword(request).then((value) {
      if(value.hasError){
        getUsers(screenState, screenState.request);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      }
      else{
        getUsers(screenState, screenState.request);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.passwordUpdatedSuccess)
          ..show(screenState.context);
      }
    });
  }
  void sendNotification(UsersScreenState screenState , SendNotificationRequest request){
    _stateSubject.add(LoadingState(screenState));
    _service.sendNotification(request).then((value) {
      if(value.hasError){
        getUsers(screenState, screenState.request);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      }
      else{
        getUsers(screenState, screenState.request);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.notificationsSentSuccessfully)
          ..show(screenState.context);
      }
    });
  }
}
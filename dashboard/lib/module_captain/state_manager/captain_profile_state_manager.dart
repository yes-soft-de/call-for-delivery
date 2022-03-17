import 'package:c4d/module_captain/request/enable_captain.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/porfile_model.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captain_profile_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_profile/captain_profile.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class CaptainProfileStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CaptainProfileStateManager(this._captainsService);

  void getCaptainProfile(CaptainProfileScreenState screenState, int captainId) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getCaptainProfile(captainId).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            CaptainProfileLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            CaptainProfileLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        ProfileModel _model = value as ProfileModel;
        _stateSubject.add(CaptainProfileLoadedState(screenState, _model.data));
      }
    });
  }

  void acceptCaptainProfile(CaptainProfileScreenState screenState,
      int captainId, EnableCaptainRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.enableCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getCaptainProfile(screenState, captainId);
      } else {
        getCaptainProfile(screenState, captainId);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.captainUpdatedSuccessfully)
            .show(screenState.context);
        getIt<GlobalStateManager>().updateList();
      }
    });
  }


  void updateCaptainProfile(CaptainProfileScreenState screenState,
       UpdateCaptainRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.updateCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getCaptainProfile(screenState, request.id);
      } else {
        getCaptainProfile(screenState,  request.id);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.captainUpdatedSuccessfully)
            .show(screenState.context);
        getIt<GlobalStateManager>().updateList();
      }
    });
  }
}

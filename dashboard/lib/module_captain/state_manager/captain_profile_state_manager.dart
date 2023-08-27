import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/module_captain/request/captain_finance_request.dart';
import 'package:c4d/module_captain/request/enable_captain.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:injectable/injectable.dart';
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
class CaptainProfileStateManager extends StateManagerHandler {
  final CaptainsService _captainsService;

  Stream<States> get stateStream => stateSubject.stream;

  CaptainProfileStateManager(this._captainsService);

  void getCaptainProfile(CaptainProfileScreenState screenState, int captainId,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _captainsService.getCaptainProfile(captainId).then((value) {
      if (value.hasError) {
        stateSubject.add(
            CaptainProfileLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(
            CaptainProfileLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        ProfileModel _model = value as ProfileModel;
        _model = _model.data;
        _model.profileId = screenState.captainProfileId;
        stateSubject.add(CaptainProfileLoadedState(screenState, _model));
      }
    });
  }

  void acceptCaptainProfile(CaptainProfileScreenState screenState,
      int captainId, EnableCaptainRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _captainsService.enableCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.showSnackFailed(
            screenState, value.error.toString(), loading);
        getCaptainProfile(screenState, captainId, loading);
      } else {
        CustomFlushBarHelper.showSnackSuccess(
            screenState, S.current.captainUpdatedSuccessfully, loading);
        getCaptainProfile(screenState, captainId, loading);
      }
    });
  }

  void deleteCaptainProfile(
      CaptainProfileScreenState screenState, String captainID) {
    stateSubject.add(LoadingState(screenState));
    _captainsService.deleteCaptain(captainID).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString());
        getCaptainProfile(screenState, int.tryParse(captainID) ?? -1);
      } else {
        getCaptainProfile(screenState, int.tryParse(captainID) ?? -1);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.accountDeletedSuccessfully);
        getIt<GlobalStateManager>().updateList();
      }
    });
  }

  void updateCaptainProfile(
      CaptainProfileScreenState screenState, UpdateCaptainRequest request) {
    stateSubject.add(LoadingState(screenState));
    _captainsService.updateCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString());
        getCaptainProfile(screenState, request.id);
      } else {
        getCaptainProfile(screenState, request.id);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.captainUpdatedSuccessfully);
        getIt<GlobalStateManager>().updateList();
      }
    });
  }

  void captainFinanceStatusPlan(CaptainProfileScreenState screenState,
      int captainId, CaptainFinanceRequest request) {
    stateSubject.add(LoadingState(screenState));
    _captainsService.captainFinancePlanStatus(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString());
        getCaptainProfile(screenState, captainId);
      } else {
        getCaptainProfile(screenState, captainId);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.captainUpdatedSuccessfully);
        getIt<GlobalStateManager>().updateList();
      }
    });
  }
}

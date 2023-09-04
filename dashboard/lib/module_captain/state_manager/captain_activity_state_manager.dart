import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/model/captain_activity_model.dart';
import 'package:c4d/module_captain/request/captain_activities_filter_request.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captain_activity_model.dart';
import 'package:c4d/module_captain/ui/state/captain_activity/captain_activity_loaded_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainsActivityStateManager extends StateManagerHandler {
  final CaptainsService _captainsService;
  CaptainsActivityScreenState? _captainsScreenState;
  Stream<States> get stateStream => stateSubject.stream;
  CaptainsActivityScreenState? get state => _captainsScreenState;

  CaptainsActivityStateManager(this._captainsService);

  void getCaptains(CaptainsActivityScreenState screenState) {
    _captainsScreenState = screenState;
    stateSubject.add(LoadingState(screenState));
    _captainsService.getCaptainActivity().then((value) {
      if (value.hasError) {
        stateSubject.add(
            CaptainsActivityLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(CaptainsActivityLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainActivityModel _model = value as CaptainActivityModel;
        stateSubject.add(CaptainsActivityLoadedState(screenState, _model.data));
      }
    });
  }

  void getCaptainsFilter(CaptainsActivityScreenState screenState,
      CaptainActivityFilterRequest request) {
    _captainsScreenState = screenState;
    _captainsService.getCaptainFilterActivity(request).then((value) {
      if (value.hasError) {
        stateSubject.add(
            CaptainsActivityLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(CaptainsActivityLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainActivityModel _model = value as CaptainActivityModel;
        stateSubject.add(CaptainsActivityLoadedState(screenState, _model.data));
      }
    });
  }
}

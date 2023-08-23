import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/model/inActiveModel.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart';
import 'package:c4d/module_captain/ui/state/in_active/in_active_captains_loaded_state.dart';

@injectable
class InActiveCaptainsStateManager extends StateManagerHandler  {
  final CaptainsService _captainsService;

  Stream<States> get stateStream => stateSubject.stream;
  InActiveCaptainsScreenState? _captainsScreenState;
  InActiveCaptainsScreenState? get state => _captainsScreenState;

  InActiveCaptainsStateManager(this._captainsService);

  void getCaptains(InActiveCaptainsScreenState screenState) {
    _captainsScreenState = screenState;
    stateSubject.add(LoadingState(screenState));
    _captainsService.getInActiveCaptains().then((value) {
      if (value.hasError) {
        stateSubject.add(
            InCaptainActiveLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(InCaptainActiveLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        InActiveModel _model = value as InActiveModel;
        stateSubject.add(InCaptainActiveLoadedState(screenState, _model.data));
      }
    });
  }
}

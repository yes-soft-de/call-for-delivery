import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/module_captain/model/inActiveModel.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captains_list_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_list/captains_loaded_state.dart';

@injectable
class CaptainsStateManager extends StateManagerHandler {
  final CaptainsService _captainsService;
  CaptainsScreenState? _captainsScreenState;

  Stream<States> get stateStream => stateSubject.stream;

  CaptainsScreenState? get state => _captainsScreenState;

  CaptainsStateManager(this._captainsService);

  void getCaptains(CaptainsScreenState screenState) {
    _captainsScreenState = screenState;
    stateSubject.add(LoadingState(screenState));
    _captainsService.getCaptains().then((value) {
      if (value.hasError) {
        stateSubject
            .add(CaptainsLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject
            .add(CaptainsLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        InActiveModel _model = value as InActiveModel;
        stateSubject.add(CaptainsLoadedState(screenState, _model.data));
      }
    });
  }
}

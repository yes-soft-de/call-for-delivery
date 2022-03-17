import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/model/inActiveModel.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart';
import 'package:c4d/module_captain/ui/state/in_active/in_active_captains_loaded_state.dart';


@injectable
class InActiveCaptainsStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;
  InActiveCaptainsScreenState? _captainsScreenState;
  InActiveCaptainsScreenState? get state => _captainsScreenState;

  InActiveCaptainsStateManager(this._captainsService);

  void getCaptains(InActiveCaptainsScreenState screenState) {
    _captainsScreenState = screenState;
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getInActiveCaptains().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            InCaptainActiveLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(InCaptainActiveLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        InActiveModel _model = value as InActiveModel;
        _stateSubject.add(InCaptainActiveLoadedState(screenState, _model.data));
      }
    });
  }
}

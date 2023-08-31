import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/module_captain/model/captain_rating_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_rating_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_rating/captain_rating_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/service/captains_service.dart';

@injectable
class CaptainsRatingStateManager extends StateManagerHandler{
  final CaptainsService _captainsService;
  CaptainsRatingScreenState? _captainsScreenState;
  Stream<States> get stateStream => stateSubject.stream;
  CaptainsRatingScreenState? get state => _captainsScreenState;

  CaptainsRatingStateManager(this._captainsService);

  void getCaptains(CaptainsRatingScreenState screenState) {
    _captainsScreenState = screenState;
    stateSubject.add(LoadingState(screenState));
    _captainsService.getCaptainRating().then((value) {
      if (value.hasError) {
        stateSubject.add(
            CaptainsRatingLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(
            CaptainsRatingLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        CaptainRatingModel _model = value as CaptainRatingModel;
        stateSubject.add(CaptainsRatingLoadedState(screenState, _model.data));
      }
    });
  }
}

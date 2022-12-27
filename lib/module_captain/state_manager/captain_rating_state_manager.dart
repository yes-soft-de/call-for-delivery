import 'package:c4d/module_captain/ui/screen/captain_rating_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_rating/captain_rating_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/service/captains_service.dart';

import '../model/captain_rating_model.dart';

@injectable
class CaptainsRatingStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();
  CaptainsRatingScreenState? _captainsScreenState;
  Stream<States> get stateStream => _stateSubject.stream;
  CaptainsRatingScreenState? get state => _captainsScreenState;

  CaptainsRatingStateManager(this._captainsService);

  void getCaptains(CaptainsRatingScreenState screenState) {
    _captainsScreenState = screenState;
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getCaptainRating().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            CaptainsRatingLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            CaptainsRatingLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        CaptainRatingModel _model = value as CaptainRatingModel;
        _stateSubject.add(CaptainsRatingLoadedState(screenState, _model.data));
      }
    });
  }
}


  // void getCaptainRating(CaptainsRatingScreenState screenState, int captainId,
  //     [bool loading = true]) {
  //   if (loading) {
  //     _stateSubject.add(LoadingState(screenState));
  //   }
  //   _captainsService.getCaptainProfile(captainId).then((value) {
  //     if (value.hasError) {
  //       _stateSubject.add(
  //           CaptainsRatingLoadedState(screenState, null, error: value.error));
  //     } else if (value.isEmpty) {
  //       _stateSubject.add(
  //           CaptainsRatingLoadedState(screenState, null, empty: value.isEmpty));
  //     } else {
  //       List<DataRating> _model = value as List<DataRating>;
  //       _stateSubject.add(CaptainsRatingLoadedState(screenState, _model));
  //     }
  //   });
  // }


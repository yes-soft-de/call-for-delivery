import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../abstracts/states/loading_state.dart';
import '../../abstracts/states/state.dart';
import '../model/captin_rating_details_model.dart';
import '../service/captains_service.dart';
import '../ui/screen/captin_rating_details_state.dart';
import '../ui/state/captin_rating_details/captin_rating_details_state.dart';

@injectable
class CaptinRatingDetailsStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;
  CaptinRatingDetailsStateManager(this._captainsService);

  void getCaptinRatingDetails(
      CaptinRatingDetailsScreenState screenState, int captainId,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _captainsService.getCaptainRatingDetails(captainId).then((value) {
      if (value.hasError) {
        _stateSubject.add(CaptinRatingDetailsLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(CaptinRatingDetailsLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainRatingDetailsModel _model = value as CaptainRatingDetailsModel;
        _stateSubject
            .add(CaptinRatingDetailsLoadedState(screenState, _model.data));
      }
    });
  }
}

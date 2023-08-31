import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:injectable/injectable.dart';

import '../../abstracts/states/loading_state.dart';
import '../../abstracts/states/state.dart';
import '../model/captin_rating_details_model.dart';
import '../service/captains_service.dart';
import '../ui/screen/captin_rating_details_state.dart';
import '../ui/state/captin_rating_details/captin_rating_details_state.dart';

@injectable
class CaptainRatingDetailsStateManager extends StateManagerHandler {
  final CaptainsService _captainsService;

  Stream<States> get stateStream => stateSubject.stream;
  CaptainRatingDetailsStateManager(this._captainsService);

  void getCaptainRatingDetails(
      CaptainRatingDetailsScreenState screenState, int captainId,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _captainsService.getCaptainRatingDetails(captainId).then((value) {
      if (value.hasError) {
        stateSubject.add(CaptainRatingDetailsLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(CaptainRatingDetailsLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainRatingDetailsModel _model = value as CaptainRatingDetailsModel;
        stateSubject
            .add(CaptainRatingDetailsLoadedState(screenState, _model.data));
      }
    });
  }
}

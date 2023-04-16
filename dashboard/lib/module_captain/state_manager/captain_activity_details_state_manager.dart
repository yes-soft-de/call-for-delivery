import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/module_captain/model/captain_activity_details_model.dart';
import 'package:c4d/module_captain/request/specific_captain_activities_filter_request.dart';
import 'package:c4d/module_captain/ui/screen/captain_activity_details_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_activity_details/loaded_captain_activity_details.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../abstracts/states/state.dart';
import '../service/captains_service.dart';

@injectable
class CaptainActivityDetailsStateManager {
  final stateSubject = PublishSubject<States>();
  final CaptainsService _captainService;

  CaptainActivityDetailsStateManager(this._captainService);
  Stream<States> get stateStream => stateSubject.stream;

  void getCaptainActivityDetails(
      CaptainActivityDetailsScreenState screenState, int captainID,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _captainService.getCaptainActivityDetails(captainID).then((value) {
      if (value.hasError) {
        stateSubject.add(LoadedCaptainActivityDetails(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        stateSubject
            .add(LoadedCaptainActivityDetails(screenState, null, empty: true));
      } else {
        CaptainActivityDetailsModel model =
            value as CaptainActivityDetailsModel;
        stateSubject.add(LoadedCaptainActivityDetails(screenState, model.data));
      }
    });
  }

  void getCaptainActivityDetailsFilter(
      CaptainActivityDetailsScreenState screenState,
      SpecificCaptainActivityFilterRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _captainService.getCaptainActivityDetailsFilter(request).then((value) {
      if (value.hasError) {
        stateSubject.add(LoadedCaptainActivityDetails(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        stateSubject
            .add(LoadedCaptainActivityDetails(screenState, null, empty: true));
      } else {
        CaptainActivityDetailsModel model =
            value as CaptainActivityDetailsModel;
        stateSubject.add(LoadedCaptainActivityDetails(screenState, model.data));
      }
    });
  }
}

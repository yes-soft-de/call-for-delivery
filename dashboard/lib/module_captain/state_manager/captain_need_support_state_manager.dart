import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/model/captain_need_support.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captain_needs_support_screen.dart';
import 'package:c4d/module_captain/ui/state/captains_supports/captain_support_loaded_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainsNeedsSupportStateManager extends StateManagerHandler {
  final CaptainsService _service;
  Stream<States> get stateStream => stateSubject.stream;

  CaptainsNeedsSupportStateManager(this._service);

  void getCaptainSupport(CaptainsNeedsSupportScreenState screenState) {
    _service.getCaptainSupport().then((value) {
      if (value.hasError) {
        stateSubject.add(CaptainsNeedSupportLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(CaptainsNeedSupportLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainNeedSupportModel _model = value as CaptainNeedSupportModel;
        stateSubject
            .add(CaptainsNeedSupportLoadedState(screenState, _model.data));
      }
    });
  }
}

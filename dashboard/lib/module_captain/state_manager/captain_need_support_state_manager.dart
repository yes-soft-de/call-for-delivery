import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/model/captain_need_support.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captain_needs_support_screen.dart';
import 'package:c4d/module_captain/ui/state/captains_supports/stores_support_loaded_state.dart';
import 'package:c4d/module_stores/model/store_need_support.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_needs_support_screen.dart';
import 'package:c4d/module_stores/ui/state/stores_supports/stores_support_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class CaptainsNeedsSupportStateManager {
  final CaptainsService _service;
  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  CaptainsNeedsSupportStateManager(this._service);

  void getCaptainSupport(CaptainsNeedsSupportScreenState screenState) {
    _service.getCaptainSupport().then((value) {
      if (value.hasError) {
        _stateSubject.add(CaptainsNeedSupportLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(CaptainsNeedSupportLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainNeedSupportModel _model = value as CaptainNeedSupportModel;
        _stateSubject
            .add(CaptainsNeedSupportLoadedState(screenState, _model.data));
      }
    });
  }
}

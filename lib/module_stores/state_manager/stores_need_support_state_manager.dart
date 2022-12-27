import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/model/store_need_support.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_needs_support_screen.dart';
import 'package:c4d/module_stores/ui/state/stores_supports/stores_support_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StoresNeedsSupportStateManager {
  final StoresService _service;
  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  StoresNeedsSupportStateManager(this._service);

  void getStores(StoreNeedsSupportScreenState screenState) {
    _service.getStoreNeedSupport().then((value) {
      if (value.hasError) {
        _stateSubject.add(StoresNeedSupportLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(StoresNeedSupportLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        StoresNeedSupportModel _model = value as StoresNeedSupportModel;
        _stateSubject
            .add(StoresNeedSupportLoadedState(screenState, _model.data));
      }
    });
  }
}

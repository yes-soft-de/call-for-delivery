import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/model/store_need_support.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_needs_support_screen.dart';
import 'package:c4d/module_stores/ui/state/stores_supports/stores_support_loaded_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoresNeedsSupportStateManager extends StateManagerHandler {
  final StoresService _service;
  Stream<States> get stateStream => stateSubject.stream;

  StoresNeedsSupportStateManager(this._service);

  void getStores(StoreNeedsSupportScreenState screenState) {
    _service.getStoreNeedSupport().then((value) {
      if (value.hasError) {
        stateSubject.add(StoresNeedSupportLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(StoresNeedSupportLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        StoresNeedSupportModel _model = value as StoresNeedSupportModel;
        stateSubject
            .add(StoresNeedSupportLoadedState(screenState, _model.data));
      }
    });
  }
}

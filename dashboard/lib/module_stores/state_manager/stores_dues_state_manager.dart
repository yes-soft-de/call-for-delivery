import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/model/stores_dues/stores_dues_model.dart';
import 'package:c4d/module_stores/request/stores_dues_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_dues/stores_dues_screen.dart';
import 'package:c4d/module_stores/ui/state/stores_dues/stores_dues_loaded_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoresDuesStateManager extends StateManagerHandler {
  final StoresService _storesService;

  Stream<States> get stateStream => stateSubject.stream;

  StoresDuesStateManager(this._storesService);

  void getStoresDues(
      StoresDuesScreenState screenState, StoresDuesRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _storesService.getStoresDues(request).then((value) {
      if (value.hasError) {
        stateSubject
            .add(StoresDuesLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(StoresDuesLoadedState(screenState, null, empty: true));
      } else {
        StoresDuesModel model = value as StoresDuesModel;
        stateSubject.add(StoresDuesLoadedState(screenState, model.data));
      }
    });
  }
}

import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/model/top_active_store_model.dart';
import 'package:c4d/module_stores/request/filter_store_activity_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/top_active_store_screen.dart';
import 'package:c4d/module_stores/ui/state/top_active_store_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class TopActiveStateManagement extends StateManagerHandler {
  final StoresService _storesService;

  Stream<States> get stateStream => stateSubject.stream;
  TopActiveStateManagement(this._storesService);

  void getTopActiveStore(TopActiveStoreScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _storesService.getTopActiveStore().then((value) {
      if (value.hasError) {
        stateSubject
            .add(TopActiveStoreLoaded(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(TopActiveStoreLoaded(screenState, null, empty: true));
      } else {
        TopActiveStoreModel model = value as TopActiveStoreModel;
        stateSubject.add(TopActiveStoreLoaded(screenState, model.data));
      }
    });
  }

  void filterStoreActivity(
      TopActiveStoreScreenState screenState, FilterStoreActivityRequest request,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _storesService.filterStoreActivity(request).then((value) {
      if (value.hasError) {
        stateSubject
            .add(TopActiveStoreLoaded(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(TopActiveStoreLoaded(screenState, null, empty: true));
      } else {
        value as TopActiveStoreModel;
        stateSubject.add(TopActiveStoreLoaded(screenState, value.data));
      }
    });
  }
}

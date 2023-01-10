import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/model/top_active_store_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/top_active_store_screen.dart';
import 'package:c4d/module_stores/ui/state/top_active_store_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class TopActiveStateManagment {
  final StoresService _storesService;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;
  TopActiveStateManagment(this._storesService);

  void getTopActiveStore(TopActiveStoreScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.getTopActiveStore().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(TopActiveStoreLoaded(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(TopActiveStoreLoaded(screenState, null, empty: true));
      } else {
        TopActiveStoreModel model = value as TopActiveStoreModel;
        _stateSubject.add(TopActiveStoreLoaded(screenState, model.data));
      }
    });
  }
}

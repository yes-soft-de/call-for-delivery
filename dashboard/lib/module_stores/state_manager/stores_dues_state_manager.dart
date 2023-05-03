import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/request/stores_dues_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_dues/stores_dues_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StoresDuesStateManager {
  final StoresService _storesService;
  final PublishSubject<States> _stateSubject = new PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoresDuesStateManager(this._storesService);

  void getStoresDues(
      StoresDuesScreenState screenState, StoresDuesRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _storesService.getStoresDues(request).then((value) {
      // if (value.hasError) {
      //   _stateSubject.add(
      //       StoreProfileLoadedState(screenState, null, error: value.error));
      // } else if (value.isEmpty) {
      //   _stateSubject
      //       .add(StoreProfileLoadedState(screenState, null, empty: true));
      // } else {
      //   StoreProfileModel model = value as StoreProfileModel;
      //   _stateSubject.add(StoreProfileLoadedState(screenState, model.data));
      // }
    });
  }
}

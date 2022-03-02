import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/request/active_store_request.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/store_info_screen.dart';
import 'package:c4d/module_stores/ui/state/store_profile/store_profile_loaded_state.dart';

@injectable
class StoreProfileStateManager {
  final StoresService _storesService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreProfileStateManager(this._storesService);

  void getStore(StoreInfoScreenState screenState, int id) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.getStoreProfile(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            StoreProfileLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(StoreProfileLoadedState(screenState, null, empty: true));
      } else {
        StoreProfileModel model = value as StoreProfileModel;
        _stateSubject.add(StoreProfileLoadedState(screenState, model.data));
      }
    });
  }

  void enableStore(StoreInfoScreenState screenState,
      ActiveStoreRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.enableStore(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getStore(screenState, request.id);
      } else {
        getStore(screenState, request.id);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.storeUpdatedSuccessfully)
            .show(screenState.context);
        getIt<GlobalStateManager>().updateList();
      }
    });
  }

}

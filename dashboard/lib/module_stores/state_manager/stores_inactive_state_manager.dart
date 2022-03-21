import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/ui/state/stores_lists/stores_inactive_state_loaded.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_inactive_screen.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class StoresInActiveStateManager {
  final StoresService _storesService;
  final AuthService _authService;
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoresInActiveStateManager(this._storesService, this._authService,
      this._uploadService);

  void getStores(StoresInActiveScreenState screenState) {
    _storesService.getStoresInActive().then((value) {
      if (value.hasError) {
        _stateSubject.add(StoresInActiveLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(StoresInActiveLoadedState(screenState, []));
      } else {
        StoresModel model = value as StoresModel;
        _stateSubject.add(StoresInActiveLoadedState(
            screenState, model.data));
      }
    });
  }


  void updateStore(
      StoresInActiveScreenState screenState, UpdateStoreRequest request) {
    if (request.image?.contains('/original-image/') == true) {
      _stateSubject.add(LoadingState(screenState));
      _storesService.updateStore(request).then((value) {
        if (value.hasError) {
          getStores(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getStores(screenState);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.storeUpdatedSuccessfully)
            ..show(screenState.context);
        }
      });
    } else {
      _stateSubject.add(LoadingState(screenState));
      if (request.image == null) {
        _storesService.updateStore(request).then((value) {
          if (value.hasError) {
            getStores(screenState);
            CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
              ..show(screenState.context);
          } else {
            getStores(screenState);
            CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.storeUpdatedSuccessfully)
              ..show(screenState.context);
          }
        });
      } else {
        _uploadService.uploadImage(request.image).then((value) {
          if (value == null) {
            getStores(screenState);
            CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: S.current.errorUploadingImages)
              ..show(screenState.context);
          } else {
            request.image = value;
            _storesService.updateStore(request).then((value) {
              if (value.hasError) {
                getStores(screenState);
                CustomFlushBarHelper.createError(
                    title: S.current.warnning, message: value.error ?? '')
                  ..show(screenState.context);
              } else {
                getStores(screenState);
                CustomFlushBarHelper.createSuccess(
                    title: S.current.warnning,
                    message: S.current.storeUpdatedSuccessfully)
                  ..show(screenState.context);
              }
            });
          }
        });
      }
    }
  }
}

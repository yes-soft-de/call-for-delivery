import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_screen.dart';
import 'package:c4d/module_stores/ui/state/store_categories/stores_loaded_state.dart';
import 'package:c4d/module_stores/ui/state/store_categories/stores_loading_state.dart';
import 'package:c4d/module_stores/ui/state/store_categories/stores_state.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class StoresStateManager {
  final StoresService _storesService;

  final AuthService _authService;
  final ImageUploadService _uploadService;
  final PublishSubject<StoresState> _stateSubject = PublishSubject();

  Stream<StoresState> get stateStream => _stateSubject.stream;

  StoresStateManager(this._storesService, this._authService,
      this._uploadService);

  void getStores(StoresScreenState screenState) {
    _stateSubject.add(StoresLoadingState(screenState));
    _storesService.getStores().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(StoresLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(StoresLoadedState(screenState, null, empty: true));
      } else {
        StoresModel model = value as StoresModel;
        _stateSubject.add(StoresLoadedState(screenState, model.data));
      }
    });
  }

//  void createStore(
//      StoresScreenState screenState, CreateStoreRequest request) {
//    _stateSubject.add(StoresLoadingState(screenState));
//
//    _uploadService.uploadImage(request.image!).then((value) {
//      if (value == null) {
//        getStores(screenState);
//        CustomFlushBarHelper.createError(
//            title: S.current.warnning, message: S.current.errorUploadingImages)
//          ..show(screenState.context);
//      } else {
//        request.image = value;
//        _storesService.createStores(request).then((value) {
//          if (value.hasError) {
//            getStores(screenState);
//            CustomFlushBarHelper.createError(
//                title: S.current.warnning, message: value.error ?? '')
//              ..show(screenState.context);
//          } else {
//            getStores(screenState);
//            CustomFlushBarHelper.createSuccess(
//                title: S.current.warnning,
//                message: S.current.storeCreatedSuccessfully)
//              ..show(screenState.context);
//          }
//        });
//      }
//    });
//  }

  void updateStore(StoresScreenState screenState, UpdateStoreRequest request) {
    if (request.image?.contains('/original-image/') == true) {
      _stateSubject.add(StoresLoadingState(screenState));
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
      _stateSubject.add(StoresLoadingState(screenState));
      _uploadService.uploadImage(request.image).then((value) {
        if (value == null && request.image != null && request.image != '') {
          getStores(screenState);
          CustomFlushBarHelper.createError(
                  title: S.current.warnning,
                  message: S.current.errorUploadingImages)
              .show(screenState.context);
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

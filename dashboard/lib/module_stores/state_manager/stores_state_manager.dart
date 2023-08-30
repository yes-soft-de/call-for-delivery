import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/ui/state/stores_lists/stores_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_screen.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class StoresStateManager extends StateManagerHandler {
  final StoresService _storesService;
  final ImageUploadService _uploadService;

  Stream<States> get stateStream => stateSubject.stream;

  StoresStateManager(this._storesService, this._uploadService);

  void getStores(StoresScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _storesService.getStores().then((value) {
      if (value.hasError) {
        stateSubject
            .add(StoresLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(StoresLoadedState(screenState, null, empty: true));
      } else {
        StoresModel model = value as StoresModel;
        stateSubject.add(StoresLoadedState(screenState, model.data));
      }
    });
  }

//  void createStore(
//      StoresScreenState screenState, CreateStoreRequest request) {
//    stateSubject.add(StoresLoadingState(screenState));
//
//    _uploadService.uploadImage(request.image!).then((value) {
//      if (value == null) {
//        getStores(screenState);
//        CustomFlushBarHelper.createError(
//            title: S.current.warnning, message: S.current.errorUploadingImages)
//          .;
//      } else {
//        request.image = value;
//        _storesService.createStores(request).then((value) {
//          if (value.hasError) {
//            getStores(screenState);
//            CustomFlushBarHelper.createError(
//                title: S.current.warnning, message: value.error ?? '')
//              .;
//          } else {
//            getStores(screenState);
//            CustomFlushBarHelper.createSuccess(
//                title: S.current.warnning,
//                message: S.current.storeCreatedSuccessfully)
//              .;
//          }
//        });
//      }
//    });
//  }

  void updateStore(StoresScreenState screenState, UpdateStoreRequest request,
      bool haveImage) {
    stateSubject.add(LoadingState(screenState));
    if (haveImage) {
      _uploadService.uploadImage(request.image).then((image) {
        if (image == null) {
          screenState.getStores();
          CustomFlushBarHelper.createError(
              title: S.current.warnning,
              message: S.current.errorUploadingImages);
          return;
        } else {
          request.image = image;
          _storesService.updateStore(request).then((value) {
            if (value.hasError) {
              getStores(screenState);
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '');
            } else {
              getStores(screenState);
              CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.storeUpdatedSuccessfully);
            }
          });
        }
      });
    } else {
      _storesService.updateStore(request).then((value) {
        if (value.hasError) {
          getStores(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          getStores(screenState);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.storeUpdatedSuccessfully);
        }
      });
    }
  }
}

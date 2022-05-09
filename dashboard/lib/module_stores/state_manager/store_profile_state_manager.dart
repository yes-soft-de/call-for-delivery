import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/request/active_store_request.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreProfileStateManager(this._storesService, this._uploadService);

  void getStore(StoreInfoScreenState screenState, int id,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
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

  void enableStore(StoreInfoScreenState screenState, ActiveStoreRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _storesService.enableStore(request).then((value) {
      if (value.hasError) {
        getStore(screenState, request.id, loading);
        showSnackFailed(
            screenState, value.error ?? S.current.errorHappened, loading);
      } else {
        getIt<GlobalStateManager>().updateList();
        getStore(screenState, request.id, loading);
        showSnackSuccess(
            screenState, S.current.storeUpdatedSuccessfully, loading);
      }
    });
  }

  void showSnackSuccess(
      StoreInfoScreenState screenState, String message, bool loading) {
    if (loading) {
      CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.storeUpdatedSuccessfully)
          .show(screenState.context);
    } else {
      Fluttertoast.showToast(msg: message);
    }
  }


  void updateStore(StoreInfoScreenState screenState, UpdateStoreRequest request,
      bool haveImage) {
    _stateSubject.add(LoadingState(screenState));
    if (haveImage) {
      _uploadService.uploadImage(request.image).then((image) {
        if (image == null) {
          getStore(screenState,request.id);
          CustomFlushBarHelper.createError(
              title: S.current.warnning,
              message: S.current.errorUploadingImages)
              .show(screenState.context);
          return;
        } else {
          request.image = image;
          _storesService.updateStore(request).then((value) {
            if (value.hasError) {
              getStore(screenState,request.id);
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
                ..show(screenState.context);
            } else {
              getStore(screenState,request.id);
              CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.storeUpdatedSuccessfully)
                ..show(screenState.context);
            }
          });
        }
      });
    } else {
      _storesService.updateStore(request).then((value) {
        if (value.hasError) {
          getStore(screenState,request.id);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '')
            ..show(screenState.context);
        } else {
          getStore(screenState,request.id);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.storeUpdatedSuccessfully)
            ..show(screenState.context);
        }
      });
    }
  }
  void showSnackFailed(
      StoreInfoScreenState screenState, String message, bool loading) {
    if (loading) {
      CustomFlushBarHelper.createError(
              title: S.current.warnning, message: message)
          .show(screenState.context);
    } else {
      Fluttertoast.showToast(msg: message);
    }
  }
}

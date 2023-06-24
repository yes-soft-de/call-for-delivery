import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/store_setting_model.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/request/edit_store_setting_request.dart';
import 'package:c4d/module_stores/request/welcome_package_payment_request.dart';
import 'package:c4d/module_stores/ui/screen/edit_store_setting_screen.dart';
import 'package:c4d/module_stores/ui/state/edit_store_setting_state_loaded.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/service/store_service.dart';

@injectable
class EditStoreSettingStateManager {
  final StoresService _storesService;
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  EditStoreSettingStateManager(this._storesService, this._uploadService);

  void updateWelcomePackagePayment(EditStoreSettingScreenState screenState,
      WelcomePackagePaymentRequest request, int storeID,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _storesService.updateWelcomePackageWithoutPayment(request).then((value) {
      if (value.hasError) {
        showSnackFailed(
            screenState, value.error ?? S.current.errorHappened, loading);
      } else {
        showSnackSuccess(
          screenState,
          S.current.dataUpdatedSuccessfully,
          false,
        );
        getStoreSetting(screenState, true);
      }
    });
  }

  void showSnackSuccess(
      EditStoreSettingScreenState screenState, String message, bool loading) {
    if (loading) {
      CustomFlushBarHelper.createSuccess(
          title: S.current.warnning,
          message: S.current.storeUpdatedSuccessfully);
    } else {
      Fluttertoast.showToast(msg: message);
    }
  }

  void updateStore(EditStoreSettingScreenState screenState,
      UpdateStoreRequest request, bool haveImage) {
    if (haveImage) {
      _uploadService.uploadImage(request.image).then((image) {
        if (image == null) {
          // getStore(screenState, request.id);
          CustomFlushBarHelper.createError(
              title: S.current.warnning,
              message: S.current.errorUploadingImages);
          return;
        } else {
          request.image = image;
          _storesService.updateStore(request).then((value) {
            if (value.hasError) {
              // getStore(screenState, request.id);
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '');
            } else {
              // getStore(screenState, request.id);
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
          // getStore(screenState, request.id);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          // getStore(screenState, request.id);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.storeUpdatedSuccessfully);
        }
      });
    }
  }

  void showSnackFailed(
      EditStoreSettingScreenState screenState, String message, bool loading) {
    if (loading) {
      CustomFlushBarHelper.createError(
          title: S.current.warnning, message: message);
    } else {
      Fluttertoast.showToast(msg: message);
    }
  }

  void getStoreSetting(EditStoreSettingScreenState screenState,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }

    _storesService.getStoreSetting(screenState.model.id).then((value) {
      if (value.hasError) {
        if (value.error == 'no setting') {
          screenState.shouldCreateNewSetting = true;
          _stateSubject.add(EditStoreSettingStateLoaded(
            screenState,
            screenState.model,
            StoreSettingModel.empty(),
          ));
          return;
        }
        showSnackFailed(
            screenState, value.error ?? S.current.errorHappened, loading);
      } else {
        StoreSettingModel model = value as StoreSettingModel;
        _stateSubject.add(EditStoreSettingStateLoaded(
          screenState,
          screenState.model,
          model.data,
        ));
      }
    });
  }

  void createOrEditStoreSetting(EditStoreSettingScreenState screenState,
      EditStoreSettingRequest request) {
    if (screenState.shouldCreateNewSetting) {
      _storesService.createStoreSetting(request).then(
        (value) {
          if (value.hasError) {
            showSnackFailed(
                screenState, value.error ?? S.current.errorHappened, false);
          } else {
            showSnackSuccess(
              screenState,
              S.current.dataUpdatedSuccessfully,
              false,
            );
            getStoreSetting(screenState, true);
          }
        },
      );
    } else {
      _storesService.editStoreSetting(request).then(
        (value) {
          if (value.hasError) {
            showSnackFailed(
                screenState, value.error ?? S.current.errorHappened, false);
          } else {
            showSnackSuccess(
              screenState,
              S.current.dataUpdatedSuccessfully,
              false,
            );
          }
        },
      );
    }
  }
}

import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/request/welcome_package_payment_request.dart';
import 'package:c4d/module_stores/ui/state/stores_lists/stores_inactive_state_loaded.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/stores_model.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_inactive_screen.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class StoresInActiveStateManager {
  final StoresService _storesService;
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoresInActiveStateManager(this._storesService, this._uploadService);

  void getStores(StoresInActiveScreenState screenState) {
    _storesService.getStoresInActive().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            StoresInActiveLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(StoresInActiveLoadedState(screenState, []));
      } else {
        StoresModel model = value as StoresModel;
        _stateSubject.add(StoresInActiveLoadedState(screenState, model.data));
      }
    });
  }

  void updateStore(StoresInActiveScreenState screenState,
      UpdateStoreRequest request, bool haveImage) {
    _stateSubject.add(LoadingState(screenState));
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

  void updateWelcomePackagePayment(StoresInActiveScreenState screenState,
      WelcomePackagePaymentRequest request, int storeID,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _storesService.updateWelcomePackageWithoutPayment(request).then((value) {
      if (value.hasError) {
        getStores(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getStores(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.updateSuccess);
      }
    });
  }
}

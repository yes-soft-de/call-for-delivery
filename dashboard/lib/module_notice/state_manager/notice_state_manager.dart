import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_notice/model/notice_model.dart';
import 'package:c4d/module_notice/request/notice_request.dart';
import 'package:c4d/module_notice/service/notice_service.dart';
import 'package:c4d/module_notice/ui/screen/notice_screen.dart';
import 'package:c4d/module_notice/ui/state/notice/notice_loaded_state.dart';
import 'package:c4d/module_notice/ui/widget/uploud_image_failed_dialog.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class NoticeStateManager {
  final NoticeService _service;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  NoticeStateManager(this._service);

  void getNotice(NoticeScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _service.getNotice().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(NoticeLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(NoticeLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        NoticeModel model = value as NoticeModel;
        _stateSubject.add(NoticeLoadedState(screenState, model.data));
      }
    });
  }

  void addNotice(NoticeScreenState screenState, NoticeRequest request) async {
    // _stateSubject.add(LoadingState(screenState));

    CustomFlushBarHelper.createSuccess(
        title: S.current.warnning, message: S.current.inProcess);

    request.images = await _uploadImages(request.images ?? []);
    bool imagesUploadSuccess = _hasNoUploadError(request.images ?? []);

    if (imagesUploadSuccess) {
      _service.addNotice(request).then((value) {
        if (value.hasError) {
          getNotice(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          getNotice(screenState);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning, message: S.current.saveSuccess);
        }
      });
    } else {
      CustomFlushBarHelper.createError(
          title: S.current.warnning, message: S.current.failedToUploadSomeImage);

      await showDialog(
        barrierDismissible: false,
        context: screenState.context,
        builder: (context) => UploadImageFailedDialog(
          request: request,
          onConfirm: (newRequest) {
            addNotice(screenState, newRequest);
          },
        ),
      );
    }
  }

  void updateNotice(
      NoticeScreenState screenState, NoticeRequest request) async {
    // _stateSubject.add(LoadingState(screenState));

    CustomFlushBarHelper.createSuccess(
        title: S.current.warnning, message: S.current.inProcess);

    request.images = await _uploadImages(request.images ?? []);
    bool imagesUploadSuccess = _hasNoUploadError(request.images ?? []);

    if (imagesUploadSuccess) {
      request.images =
          request.images?.where((element) => element.toDelete != true).toList();
      _service.updateNotice(request).then((value) {
        if (value.hasError) {
          getNotice(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          getNotice(screenState);
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.adUpdatedSuccessfully);
        }
      });
    } else {
      CustomFlushBarHelper.createError(
          title: S.current.warnning, message: S.current.failedToUploadSomeImage);

      await showDialog(
        barrierDismissible: false,
        context: screenState.context,
        builder: (context) => UploadImageFailedDialog(
          request: request,
          onConfirm: (newRequest) {
            updateNotice(screenState, newRequest);
          },
        ),
      );
    }
  }

  Future<List<NoticeImage>> _uploadImages(List<NoticeImage> images) async {
    for (int i = 0; i < images.length; i++) {
      // image already uploaded
      if (images[i].isRemote) {
        // delete toDelete images from the server
        if (images[i].toDelete) {
          await _service.deleteImage(images[i].id ?? -1);
        }
        continue;
      }

      String? url =
          await getIt<ImageUploadService>().uploadImage(images[i].image);

      if (url != null) {
        images[i] = images[i].copyWith(image: url, isRemote: true);
      } else {
        images[i] = images[i].copyWith(uploadError: true);
      }
    }

    // remove toDelete images from the list
    images = images.where((element) => element.toDelete != true).toList();

    return images;
  }

  bool _hasNoUploadError(List<NoticeImage> images) {
    for (var image in images) {
      if (image.uploadError == true) return false;
    }

    return true;
  }

//  void deleteCategories(CategoriesScreenState screenState, String id) {
//    _stateSubject.add(LoadingState(screenState));
//    _categoriesService.deleteCategories(id).then((value) {
//      if (value.hasError) {
//        getCategories(screenState);
//        CustomFlushBarHelper.createError(
//                title: S.current.warnning, message: value.error ?? '')
//            ;
//      } else {
//        getCategories(screenState);
//        CustomFlushBarHelper.createSuccess(
//                title: S.current.warnning, message: S.current.deleteSuccess)
//            ;
//      }
//    });
//  }
}

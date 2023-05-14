import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_notice/model/notice_model.dart';
import 'package:c4d/module_notice/request/notice_request.dart';
import 'package:c4d/module_notice/service/notice_service.dart';
import 'package:c4d/module_notice/ui/screen/notice_screen.dart';
import 'package:c4d/module_notice/ui/state/notice/notice_loaded_state.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
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
    _stateSubject.add(LoadingState(screenState));

    bool saveToContinue = true;

    for (int i = 0; i < (request.images?.length ?? 0); i++) {
      String? url =
          await getIt<ImageUploadService>().uploadImage(request.images![i]);

      if (url == null) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: S.current.errorUploadingImages)
            .show(screenState.context);

        saveToContinue = false;
        break;
      }

      request.images![i] = url;
    }

    if (saveToContinue) {
    _service.addNotice(request).then((value) {
      if (value.hasError) {
        getNotice(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        getNotice(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.saveSuccess)
          ..show(screenState.context);
      }
    });
    }
  }

  void updateNotice(
      NoticeScreenState screenState, NoticeRequest request) async {
    _stateSubject.add(LoadingState(screenState));

    bool saveToContinue = true;

    for (int i = 0; i < (request.images?.length ?? 0); i++) {
      String? url =
          await getIt<ImageUploadService>().uploadImage(request.images![i]);

      if (url == null) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: S.current.errorUploadingImages)
            .show(screenState.context);

        saveToContinue = false;
        break;
      }

      request.images![i] = url;
    }
    // if (saveToContinue) {
    //   _service.updateNotice(request).then((value) {
    //     if (value.hasError) {
    //       getNotice(screenState);
    //       CustomFlushBarHelper.createError(
    //           title: S.current.warnning, message: value.error ?? '')
    //         ..show(screenState.context);
    //     } else {
    //       getNotice(screenState);
    //       CustomFlushBarHelper.createSuccess(
    //           title: S.current.warnning,
    //           message: S.current.categoryUpdatedSuccessfully)
    //         ..show(screenState.context);
    //     }
    //   });
    // }
  }

//  void deleteCategories(CategoriesScreenState screenState, String id) {
//    _stateSubject.add(LoadingState(screenState));
//    _categoriesService.deleteCategories(id).then((value) {
//      if (value.hasError) {
//        getCategories(screenState);
//        CustomFlushBarHelper.createError(
//                title: S.current.warnning, message: value.error ?? '')
//            .show(screenState.context);
//      } else {
//        getCategories(screenState);
//        CustomFlushBarHelper.createSuccess(
//                title: S.current.warnning, message: S.current.deleteSuccess)
//            .show(screenState.context);
//      }
//    });
//  }
}

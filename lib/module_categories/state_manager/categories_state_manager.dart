import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/request/package_category_request.dart';
import 'package:c4d/module_categories/ui/state/categories/package_categories_loaded_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/service/store_categories_service.dart';
import 'package:c4d/module_categories/ui/screen/categories_screen.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class PackageCategoriesStateManager {
  final CategoriesService _categoriesService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  PackageCategoriesStateManager(this._categoriesService, this._uploadService);

  void getCategories(CategoriesScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getCategories().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(CategoriesLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            CategoriesLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        PackagesCategoryModel model = value as PackagesCategoryModel;
        _stateSubject.add(CategoriesLoadedState(screenState, model.data));
      }
    });
  }

  void createCategory(
      CategoriesScreenState screenState, PackageCategoryRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.createCategory(request).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        getCategories(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.saveSuccess)
          ..show(screenState.context);
      }
    });
  }

  void updateCategory(
      CategoriesScreenState screenState, PackageCategoryRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.updateCategory(request).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        getCategories(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.categoryUpdatedSuccessfully)
          ..show(screenState.context);
      }
    });
  }

  void deleteCategories(CategoriesScreenState screenState, String id) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.deleteCategories(id).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getCategories(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.deleteSuccess)
            .show(screenState.context);
      }
    });
  }

  void enableCategories(
      CategoriesScreenState screenState, ActivePackageRequest request) {
    _categoriesService.enableCategory(request).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        getCategories(screenState);
        Fluttertoast.showToast(msg: S.current.categoryUpdatedSuccessfully);
      }
    });
  }
}

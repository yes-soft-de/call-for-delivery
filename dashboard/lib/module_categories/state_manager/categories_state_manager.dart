import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/request/package_category_request.dart';
import 'package:c4d/module_categories/service/store_categories_service.dart';
import 'package:c4d/module_categories/ui/screen/categories_screen.dart';
import 'package:c4d/module_categories/ui/state/categories/package_categories_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

@injectable
class PackageCategoriesStateManager extends StateManagerHandler {
  final CategoriesService _categoriesService;

  Stream<States> get stateStream => stateSubject.stream;

  PackageCategoriesStateManager(this._categoriesService);

  void getCategories(CategoriesScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _categoriesService.getCategories().then((value) {
      if (value.hasError) {
        stateSubject
            .add(CategoriesLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(
            CategoriesLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        PackagesCategoryModel model = value as PackagesCategoryModel;
        stateSubject.add(CategoriesLoadedState(screenState, model.data));
      }
    });
  }

  void createCategory(
      CategoriesScreenState screenState, PackageCategoryRequest request) {
    stateSubject.add(LoadingState(screenState));
    _categoriesService.createCategory(request).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getCategories(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.saveSuccess);
      }
    });
  }

  void updateCategory(
      CategoriesScreenState screenState, PackageCategoryRequest request) {
    stateSubject.add(LoadingState(screenState));
    _categoriesService.updateCategory(request).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getCategories(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.categoryUpdatedSuccessfully);
      }
    });
  }

  void deleteCategories(CategoriesScreenState screenState, String id) {
    stateSubject.add(LoadingState(screenState));
    _categoriesService.deleteCategories(id).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getCategories(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.deleteSuccess);
      }
    });
  }

  void enableCategories(
      CategoriesScreenState screenState, ActivePackageRequest request) {
    _categoriesService.enableCategory(request).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getCategories(screenState);
        Fluttertoast.showToast(msg: S.current.categoryUpdatedSuccessfully);
      }
    });
  }
}

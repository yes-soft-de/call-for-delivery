import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/model/packages_model.dart';
import 'package:c4d/module_categories/request/active_package_request.dart';
import 'package:c4d/module_categories/request/package_request.dart';
import 'package:c4d/module_categories/ui/state/packages/packages_loaded_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_categories/service/store_categories_service.dart';
import 'package:c4d/module_categories/ui/screen/packages_screen.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class PackagesStateManager {
  final CategoriesService _categoriesService;
  final AuthService _authService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  PackagesStateManager(this._categoriesService, this._authService);
  PackagesCategoryModel? cats;
  void getCategories(PackagesScreenState screenState, [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _categoriesService.getCategories().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            PackagesLoadedState(screenState, null, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            PackagesLoadedState(screenState, null, null, empty: value.isEmpty));
      } else {
        PackagesCategoryModel model = value as PackagesCategoryModel;
        cats = model;
        _stateSubject.add(PackagesLoadedState(screenState, model.data, []));
      }
    });
  }

  void getPackagesByCategory(PackagesScreenState screenState, int id,
      List<PackagesCategoryModel> categories) {
//    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getPackagesByCategory(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(PackagesLoadedState(screenState, categories, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(PackagesLoadedState(screenState, categories, []));
      } else {
        PackagesModel packagesModel = value as PackagesModel;
        _stateSubject.add(
            PackagesLoadedState(screenState, categories, packagesModel.data));
      }
    });
  }

  void createPackage(PackagesScreenState screenState, PackageRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.createPackage(request).then((value) {
      if (value.hasError) {
        screenState.id = null;
        getCategories(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        screenState.id = null;
        getCategories(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.addPackageSuccessfully)
          ..show(screenState.context);
      }
    });
  }

  void enablePackage(
      PackagesScreenState screenState, ActivePackageRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _categoriesService.enablePackage(request).then((value) {
      if (value.hasError) {
        screenState.id = null;
        getCategories(screenState, loading);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        getPackagesByCategory(screenState,
            int.tryParse(screenState.id ?? '1') ?? -1, cats?.data ?? []);
        Fluttertoast.showToast(msg: S.current.updatePackageSuccessfully);
      }
    });
  }

  void updatePackage(PackagesScreenState screenState, PackageRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.updatePackage(request).then((value) {
      if (value.hasError) {
        screenState.id = null;
        getCategories(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        screenState.id = null;
        getCategories(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.updatePackageSuccessfully)
          ..show(screenState.context);
      }
    });
  }
}

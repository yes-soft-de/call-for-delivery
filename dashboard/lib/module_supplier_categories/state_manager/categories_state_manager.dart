import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_supplier_categories/model/supplier_categories_model.dart';
import 'package:c4d/module_supplier_categories/request/active_category_request.dart';
import 'package:c4d/module_supplier_categories/request/supplier_category_request.dart';
import 'package:c4d/module_supplier_categories/service/supplier_categories_service.dart';
import 'package:c4d/module_supplier_categories/ui/screen/supplier_categories_screen.dart';
import 'package:c4d/module_supplier_categories/ui/state/categories/supplier_categories_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class SupplierCategoriesStateManager {
  final SupplierCategoriesService _categoriesService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  SupplierCategoriesStateManager(this._categoriesService, this._uploadService);

  void getCategories(SupplierCategoriesScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getCategories().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(SupplierCategoriesLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(
            SupplierCategoriesLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        SupplierCategoryModel model = value as SupplierCategoryModel;
        _stateSubject.add(SupplierCategoriesLoadedState(screenState, model.data));
      }
    });
  }

  void createCategory(
      SupplierCategoriesScreenState screenState, SupplierCategoryRequest request) {
    _stateSubject.add(LoadingState(screenState));
   _uploadService.uploadImage(request.image).then((value) {
     print('this is the image');
     print(value);
     if(value == null){
       getCategories(screenState);
       CustomFlushBarHelper.createError(
           title: S.current.warnning, message: S.current.errorUploadingImages)
         ..show(screenState.context);
     }else
       {
         request.image = value;
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

   });

  }

  void updateCategory(
      SupplierCategoriesScreenState screenState, SupplierCategoryRequest request) {
    _stateSubject.add(LoadingState(screenState));
    if(!request.image!.contains('http')){
      _uploadService.uploadImage(request.image).then((value) {
        print('this is the image');
        print(value);
        if(value == null){
          getCategories(screenState);
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: S.current.errorUploadingImages)
            ..show(screenState.context);
        }else
        {
          request.image = value;
          _categoriesService.updateCategory(request).then((value) {
            if (value.hasError) {
              getCategories(screenState);
              CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
                ..show(screenState.context);
            } else {
              getCategories(screenState);
              CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning, message: S.current.categoryUpdatedSuccessfully)
                ..show(screenState.context);
            }
          });
        }

      });
    }
    else{
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
  }



  void enableCategory(
      SupplierCategoriesScreenState screenState, ActiveCategoryRequest request) {
    _stateSubject.add(LoadingState(screenState));
      _categoriesService.enableCategory(request).then((value) {
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

 }

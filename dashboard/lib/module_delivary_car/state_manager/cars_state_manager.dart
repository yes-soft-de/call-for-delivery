import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_delivary_car/model/car_model.dart';
import 'package:c4d/module_delivary_car/request/car_request.dart';
import 'package:c4d/module_delivary_car/service/cars_service.dart';
import 'package:c4d/module_delivary_car/ui/screen/cars_screen.dart';
import 'package:c4d/module_delivary_car/ui/state/cars/cars_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class CarsStateManager {
  final CarsService _service;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  CarsStateManager(this._service);

  void getCars(CarsScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _service.getCars().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(CarsLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(CarsLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        CarsModel model = value as CarsModel;
        _stateSubject.add(CarsLoadedState(screenState, model.data));
      }
    });
  }

  void addCars(CarsScreenState screenState, CarRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _service.addCars(request).then((value) {
      if (value.hasError) {
        getCars(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '')
          ..show(screenState.context);
      } else {
        getCars(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.saveSuccess)
          ..show(screenState.context);
      }
    });
  }

 void updateCars(CarsScreenState screenState, CarRequest request) {
   _stateSubject.add(LoadingState(screenState));
   _service.updateCars(request).then((value) {
     if (value.hasError) {
       getCars(screenState);
       CustomFlushBarHelper.createError(
           title: S.current.warnning, message: value.error ?? '')
         ..show(screenState.context);
     } else {
       getCars(screenState);
       CustomFlushBarHelper.createSuccess(
           title: S.current.warnning,
           message: S.current.categoryUpdatedSuccessfully)
         ..show(screenState.context);
     }
   });
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

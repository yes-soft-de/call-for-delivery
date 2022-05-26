import 'package:c4d/module_delivary_car/repository/cars_repository.dart';
import 'package:c4d/module_delivary_car/request/car_request.dart';
import 'package:c4d/module_delivary_car/response/cars_response.dart';

import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class CarsManager {
  final CarsRepository _categoriesRepository;

  CarsManager(this._categoriesRepository);

  Future<CarsResponse?> getCars() => _categoriesRepository.getDeliveryCars();

  Future<ActionResponse?> addCars(CarRequest request) =>
      _categoriesRepository.addCar(request);
       Future<ActionResponse?> updateCar(CarRequest request) =>
      _categoriesRepository.updateCar(request);
}

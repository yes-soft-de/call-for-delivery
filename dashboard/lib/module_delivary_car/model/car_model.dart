import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_delivary_car/response/cars_response.dart';

class CarsModel extends DataModel {
  int id = -1;
  String carModel = '';
  String details = '';
  num deliveryCost = 0;

  List<CarsModel> _model = [];

  CarsModel(
      {required this.carModel,
      required this.id,
      required this.deliveryCost,
      required this.details});

  CarsModel.withData(List<DataCars> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(CarsModel(
          id: element.id ?? -1,
          carModel: element.carModel ?? S.current.unknown,
          details: element.details ?? '',
          deliveryCost: element.deliveryCost ?? 0));
    }
  }
  List<CarsModel> get data => _model;
}

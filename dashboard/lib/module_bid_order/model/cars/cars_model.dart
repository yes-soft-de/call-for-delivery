import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_delivary_car/response/cars_response.dart';

class CarsModel extends DataModel {
  late int id;

  late String carModel;
  String? details;
  late num cost;

  CarsModel(
      {required this.id,
      required this.carModel,
      required this.details,
      required this.cost});
  List<CarsModel> _orders = [];
  CarsModel.withData(CarsResponse response) {
    var data = response.data;
    data?.forEach((element) {
      _orders.add(new CarsModel(
        id: element.id ?? -1,
        cost: element.deliveryCost ?? 0,
        details: element.details,
        carModel: element.carModel ?? S.current.unknown,
      ));
    });
  }
  List<CarsModel> get data => _orders;
}

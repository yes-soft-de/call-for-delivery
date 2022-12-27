import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/response/package_response.dart';

class PackagesModel extends DataModel {
  int id = -1;
  String name = '';
  String note = '';
  String city = '';
  String status = '';
  num cost = 0;
  num carCount = 0;
  num orderCount = 0;
  num expired = 0;
  num type = 0;
  num? geographicalRange = 0;
  num? extraCost = 0;
  List<PackagesModel> _model = [];
  PackagesModel(
      {required this.id,
      required this.name,
      required this.note,
      required this.city,
      required this.status,
      required this.cost,
      required this.carCount,
      required this.orderCount,
      required this.expired,
      required this.geographicalRange,
      required this.type,
      required this.extraCost});

  PackagesModel.withData(List<PackageData> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(PackagesModel(
          id: element.id ?? -1,
          name: element.name ?? S.current.unknown,
          city: element.city ?? S.current.unknown,
          status: element.status ?? S.current.unknown,
          carCount: element.carCount ?? 0,
          cost: element.cost ?? 0,
          expired: element.expired ?? 0,
          note: element.note ?? '',
          orderCount: element.orderCount ?? 0,
          geographicalRange: element.geographicalRange,
          type: element.type ?? 0,
          extraCost: element.extraCost));
    }
  }
  List<PackagesModel> get data => _model;
}

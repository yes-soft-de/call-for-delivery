import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/response/packages/packages_response.dart';

class PackageModel extends DataModel {
  late int id;
  late String name;
  late num cost;
  late String note;
  late num carCount;
  late String city;
  late num orderCount;
  late String status;

  PackageModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.note,
    required this.carCount,
    required this.city,
    required this.orderCount,
    required this.status,
  });
  List<PackageModel> _packageList = [];
  PackageModel.withData(PackagesResponse response) {
    _packageList = [];
    var data = response.data;
    data?.forEach((element) {
      _packageList.add(PackageModel(
        id: element.id ?? -1,
        name: element.name ?? S.current.unknown,
        cost: element.cost ?? 0,
        note: element.note ?? '',
        carCount: element.carCount ?? 0,
        city: element.city ?? '',
        orderCount: element.orderCount ?? 0,
        status: element.status ?? 'inActive',
      ));
    });
  }
  List<PackageModel> get data => _packageList;
}

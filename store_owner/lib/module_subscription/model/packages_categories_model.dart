import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/model/packages.model.dart';
import 'package:c4d/module_subscription/response/package_categories_response/package_categories_response.dart';

class PackageCategoriesModel extends DataModel {
  late int id;
  late String name;
  late List<PackageModel> packages;

  PackageCategoriesModel(
      {required this.id, required this.name, required this.packages});

  List<PackageCategoriesModel> _packageList = [];
  PackageCategoriesModel.withData(PackageCategoriesResponse response) {
    _packageList = [];
    var data = response.data;
    data?.forEach((element) {
      var packages = <PackageModel>[];
      element.packages?.forEach((element) {
        packages.add(PackageModel(
          id: element.id ?? -1,
          name: element.name ?? S.current.unknown,
          cost: element.cost ?? 0,
          note: element.note ?? '',
          carCount: element.carCount ?? 0,
          city: element.city ?? '',
          orderCount: element.orderCount ?? 0,
          status: element.status ?? 'inActive',
          expired: element.expired ?? 0,
        ));
      });
      _packageList.add(PackageCategoriesModel(
        id: element.id ?? -1,
        name: element.name ?? S.current.unknown,
        packages: packages,
      ));
    });
  }
  List<PackageCategoriesModel> get data => _packageList;
}

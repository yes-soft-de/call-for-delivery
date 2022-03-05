import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';

import '../response/package_category_response.dart';

class PackagesCategoryModel extends DataModel {
  String categoryName = '';
  String? description ;

  int id = -1;

  List<PackagesCategoryModel> _model = [];

  PackagesCategoryModel({required this.categoryName, required this.id , this.description});

  PackagesCategoryModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(PackagesCategoryModel(
        id: element.id ?? -1,
        description: element.description,
        categoryName: element.categoryName ?? S.current.category,
      ));
    }
  }
  List<PackagesCategoryModel> get data => _model;
}

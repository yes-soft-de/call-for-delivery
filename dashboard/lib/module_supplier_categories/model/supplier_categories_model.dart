import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';

import '../response/supplier_category_response.dart';

class SupplierCategoryModel extends DataModel {
  String name = '';
  String? description;
  bool? status;
  String? image;
  String? imageSource;

  int id = -1;

  List<SupplierCategoryModel> _model = [];

  SupplierCategoryModel(
      {required this.imageSource,
        required this.name, required this.id, this.description,this.status,this.image});

  SupplierCategoryModel.withData(List<Data> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(SupplierCategoryModel(
        id: element.id ?? -1,
        description: element.description,
        name: element.categoryName ?? S.current.category,
        image: element.image?.image ?? '',
        status: element.status ?? false,
        imageSource: element.image?.imageURL
      ));
    }
  }
  List<SupplierCategoryModel> get data => _model;
}

import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_bidorder/response/supplier_category/supplier_category_response.dart';

class SupplierCategoriesModel extends DataModel {
  late int id;
  late String name;
  List<SupplierCategoriesModel> _orders = [];

  SupplierCategoriesModel({
    required this.id,
    required this.name,
  });

  SupplierCategoriesModel.withData(SupplierCategoriesResponse response) {
    var data = response.data;
    data?.forEach((element) {
      _orders.add(new SupplierCategoriesModel(
        id: element.id ?? -1,
        name: element.name ?? '',
      ));
    });
  }
  List<SupplierCategoriesModel> get data => _orders;
}

import 'package:c4d/module_supplier/response/supplier_profile_response.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';

class ProfileSupplierModel extends DataModel {
  int id = -1;
  String? image;
  String? name;
  String? phone;
  String? supplierCategoryName;
  bool? status;

  ProfileSupplierModel(
      {required this.id,
      this.image,
      this.name,
      this.phone,
      this.status,this.supplierCategoryName});

  ProfileSupplierModel? _models;

  ProfileSupplierModel.withData(DataSupplierProfile data) : super.withData() {
    _models = ProfileSupplierModel(
        id: data.id ?? -1,
        image: data.image?[0].image,
        name: data.supplierName,
        phone: data.phone,
        status: data.status,supplierCategoryName: data.supplierCategoryName);
  }

  ProfileSupplierModel get data => _models ?? ProfileSupplierModel(id: -1);
}

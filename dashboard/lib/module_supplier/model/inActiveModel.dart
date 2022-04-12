import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_supplier/response/in_active_supplier_response.dart';

class InActiveModel extends DataModel {
  int supplierID = -1;
  String supplierName = '';
  String image = '';

  List<InActiveModel> _model = [];

  InActiveModel({
    required this.supplierID,
    required this.image,
    required this.supplierName,
  });

  InActiveModel.withData(List<SupplierData> data) : super.withData() {
    _model = [];
    for (var element in data) {
      print('Supplier id');
      print(element.id);
      _model.add(InActiveModel(
          supplierID: element.id ?? -1,
          image: element.image?[0].image ?? '',
          supplierName: element.supplierName ?? ''));
    }
  }
  List<InActiveModel> get data => _model;
}

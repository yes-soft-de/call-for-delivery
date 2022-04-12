import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_supplier/response/in_active_supplier_response.dart';

class InActiveModel extends DataModel {
  int captainID = -1;
  String captainName = '';
  String image = '';

  List<InActiveModel> _model = [];

  InActiveModel({
    required this.captainID,
    required this.image,
    required this.captainName,
  });

  InActiveModel.withData(List<SupplierData> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(InActiveModel(
          captainID: element.id ?? -1,
          image: element.image?.image ?? '',
          captainName: element.captainName ?? ''));
    }
  }
  List<InActiveModel> get data => _model;
}

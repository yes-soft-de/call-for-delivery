import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_supplier/response/supplier_need_support_response/datum.dart';

class SupplierNeedSupportModel extends DataModel {
  String roomID = '';
  String captainName = '';
  String image = '';
  String id = '';
  List<SupplierNeedSupportModel> _model = [];

  SupplierNeedSupportModel({
    required this.roomID,
    required this.image,
    required this.captainName,
    required this.id,
  });

  SupplierNeedSupportModel.withData(List<DatumSupplier> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(SupplierNeedSupportModel(
        roomID: element.roomId ?? '-1',
        image: element.images?.image ?? '',
        captainName: element.captainName ?? '',
        id: element.id?.toString() ?? '',
      ));
    }
  }
  List<SupplierNeedSupportModel> get data => _model;
}

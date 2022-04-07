import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_stores/response/store_need_support_response/datum.dart';

class StoresNeedSupportModel extends DataModel {
  String roomID = '';
  String storeName = '';
  String image = '';
  String id = '';
  List<StoresNeedSupportModel> _model = [];

  StoresNeedSupportModel({
    required this.roomID,
    required this.image,
    required this.storeName,
    required this.id,
  });

  StoresNeedSupportModel.withData(List<Datum> data) : super.withData() {
    _model = [];
    for (var element in data) {
      _model.add(StoresNeedSupportModel(
        roomID: element.roomId ?? '-1',
        image: element.image?.image ?? '',
        storeName: element.storeOwnerName ?? '',
        id: element.id?.toString() ?? '',
      ));
    }
  }
  List<StoresNeedSupportModel> get data => _model;
}

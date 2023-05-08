// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_stores/response/stores_dues_response/stores_dues_response/stores_dues_response.dart';

class StoresDuesModel extends DataModel {
  int? id;
  int? storeOwnerProfileId;
  String? storeOwnerName;
  String? image;
  num? amountSum;
  num? toBePaid;

  StoresDuesModel(
    this.id,
    this.amountSum,
    this.image,
    this.storeOwnerName,
    this.storeOwnerProfileId,
    this.toBePaid,
  );

  List<StoresDuesModel> _storesDuesModel = [];

  StoresDuesModel.withData(StoresDuesResponse response) {
    var data = response.data;

    data?.forEach((element) {
      _storesDuesModel.add(StoresDuesModel(
        element.id,
        element.amountSum,
        element.image,
        element.storeOwnerName,
        element.storeOwnerProfileId,
        element.toBePaid,
      ));
    });
  }

  List<StoresDuesModel> get data => _storesDuesModel;
}

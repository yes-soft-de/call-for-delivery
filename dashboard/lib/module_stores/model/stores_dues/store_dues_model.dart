import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_stores/response/stores_dues_response/store_dues_response/store_dues_response.dart';

class StoreDuesModel extends DataModel {
  late int month;
  late int storeOwnerProfileId;
  late String storeOwnerName;
  late String image;
  late int amount;
  late int toBePaid;
  late List<StoreDuesModel> _storeDuesModel = [];

  StoreDuesModel(
    this.month,
    this.amount,
    this.image,
    this.storeOwnerName,
    this.storeOwnerProfileId,
    this.toBePaid,
  );

  StoreDuesModel.withData(StoreDuesResponse response) {
    var data = response.data;
    data?.forEach(
      (element) {
        _storeDuesModel.add(StoreDuesModel(
          int.tryParse(element.month ?? '0') ?? 0,
          element.amount ?? 0,
          element.image ?? '',
          element.storeOwnerName ?? '',
          element.storeOwnerProfileId ?? 0,
          element.toBePaid ?? 0,
        ));
      },
    );
  }

  List<StoreDuesModel> get data => _storeDuesModel;
}

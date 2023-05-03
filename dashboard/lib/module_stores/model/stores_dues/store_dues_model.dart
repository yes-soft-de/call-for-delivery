import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_stores/response/stores_dues_response/store_dues_response/store_dues_response.dart';

class StoreDuesModel extends DataModel {
  late int id;
  late int storeOwnerProfileId;
  late String storeOwnerName;
  late String image;
  late int amount;
  late int toBePaid;
  late List<String> paymentFromCompanyToStore;
  late String flag;
  late List<StoreDuesModel> _storeDuesModel = [];

  StoreDuesModel(
    this.id,
    this.amount,
    this.flag,
    this.image,
    this.paymentFromCompanyToStore,
    this.storeOwnerName,
    this.storeOwnerProfileId,
    this.toBePaid,
  );

  StoreDuesModel.withData(StoreDuesResponse response) {
    var data = response.data;

    data?.forEach(
      (element) {
        _storeDuesModel.add(StoreDuesModel(
          element.id ?? 0,
          element.amount ?? 0,
          element.flag ?? '',
          element.image ?? '',
          element.paymentFromCompanyToStore ?? [],
          element.storeOwnerName ?? '',
          element.storeOwnerProfileId ?? 0,
          element.toBePaid ?? 0,
        ));
      },
    );
  }

  List<StoreDuesModel> get data => _storeDuesModel;
}

import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_stores/response/store_setting_response/store_setting_response.dart';

class StoreSettingModel extends DataModel {
  late int id;
  late int subscriptionCostLimit;
  late bool openingPackagePaymentHasPassed;

  StoreSettingModel? _models;

  StoreSettingModel({
    required this.id,
    required this.subscriptionCostLimit,
    required this.openingPackagePaymentHasPassed,
  });

  StoreSettingModel.empty()
      : id = -1,
        subscriptionCostLimit = 100,
        openingPackagePaymentHasPassed = false;

  StoreSettingModel.withData(StoreSettingResponse response) : super.withData() {
    var data = response.data;
    _models = StoreSettingModel(
      id: data?.id ?? -1,
      subscriptionCostLimit: data?.subscriptionCostLimit ?? 100,
      openingPackagePaymentHasPassed:
          data?.openingPackagePaymentHasPassed ?? false,
    );
  }

  StoreSettingModel get data {
    if (_models != null) {
      return _models!;
    } else {
      throw Exception('There is no data');
    }
  }
}

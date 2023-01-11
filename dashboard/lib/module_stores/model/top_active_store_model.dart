import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/response/top_active_store.dart';
import 'package:c4d/utils/images/images.dart';

class TopActiveStoreModel extends DataModel {
  int id = -1;
  String? storeOwnerName = '';
  String? image;
  String? imageUrl;
  String? storeBranchName = '';
  dynamic? ordersCount;
  String? todayOrdersCount = '';
  String? lastTwentyFourOrdersCount = '';
  List<TopActiveStoreModel> _models = [];

  TopActiveStoreModel(
      {required this.id,
      this.storeOwnerName,
      this.image,
      this.imageUrl,
      this.storeBranchName,
      this.ordersCount,
      this.todayOrdersCount,
      this.lastTwentyFourOrdersCount});

  TopActiveStoreModel.withData(List<DataActiveStore> data) {
    _models = [];
    for (var element in data) {
      _models.add(TopActiveStoreModel(
          id: element.id ?? -1,
          storeOwnerName: element.storeOwnerName ?? S.current.store,
          image: element.image?.image,
          imageUrl: element.image?.imageURL ?? ImageAsset.PLACEHOLDER,
          ordersCount: element.ordersCount ?? 0,
          storeBranchName: element.storeBranchName ?? S.current.store,
          todayOrdersCount: element.todayOrdersCount ?? '0',
          lastTwentyFourOrdersCount: element.lastTwentyFourOrdersCount ?? '0'));
    }
  }
  List<TopActiveStoreModel> get data => _models;
}

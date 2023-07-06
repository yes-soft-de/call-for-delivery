import 'package:store_web/abstracts/data_model/data_model.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_main/response/store_profile_response.dart';
import 'package:store_web/utils/images/images.dart';

class StoreProfileModel extends DataModel {
  int id = -1;
  String storeOwnerName = '';
  String phone = '';
  String bankName = '';
  String bankNumber = '';
  String? image;
  String? imageUrl;
  DateTime? closingTime;
  DateTime? openingTime;
  String? city;
  String? employeeCount;
  String? status;
  num profitMargin = 0;
  late int storeId;
  String? roomId;
  late bool openingSubscriptionWithoutPayment;

  StoreProfileModel? _models;

  StoreProfileModel({
    required this.id,
    required this.storeOwnerName,
    required this.phone,
    required this.image,
    this.closingTime,
    this.openingTime,
    required this.bankName,
    required this.bankNumber,
    this.employeeCount,
    this.city,
    this.status,
    required this.profitMargin,
    this.imageUrl,
    required this.storeId,
    required this.roomId,
    required this.openingSubscriptionWithoutPayment,
  });

  StoreProfileModel.withData(Data data) : super.withData() {
    _models = StoreProfileModel(
      id: data.id ?? -1,
      storeOwnerName: data.storeOwnerName ?? S.current.store,
      image: data.image?.image,
      imageUrl: data.image?.imageURL ?? ImageAsset.PLACEHOLDER,
      phone: data.phone ?? data.userId,
      bankName: data.bankName ?? '',
      bankNumber: data.bankAccountNumber ?? '',
      employeeCount: data.employeeCount,
      city: data.city,
      status: data.status,
      profitMargin: data.profitMargin ?? 0,
      storeId: int.tryParse(data.storeId.toString()) ?? -1,
      roomId: data.roomId,
      openingSubscriptionWithoutPayment:
          data.openingSubscriptionWithoutPayment ?? false,
    );
  }

  StoreProfileModel get data {
    if (_models != null) {
      return _models!;
    } else {
      throw Exception('There is no data');
    }
  }
}

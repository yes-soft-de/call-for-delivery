import 'package:intl/intl.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:c4d/module_stores/response/store_profile_response.dart';

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
  });

  StoreProfileModel.withData(Data data) : super.withData() {
    _models = StoreProfileModel(
      id: data.id ?? -1,
      storeOwnerName: data.storeOwnerName ?? S.current.store,
      image: data.image?.image,
      imageUrl: data.image?.imageURL ?? ImageAsset.PLACEHOLDER,
      phone: data.phone ?? data.userId,
      openingTime: DateHelper.convert(data.openingTime?.timestamp),
      closingTime: DateHelper.convert(data.closingTime?.timestamp),
      bankName: data.bankName ?? '',
      bankNumber: data.bankAccountNumber ?? '',
      employeeCount: data.employeeCount,
      city: data.city,
      status: data.status,
      profitMargin: data.profitMargin ?? 0,
      storeId: int.tryParse(data.storeId.toString()) ?? -1,
      roomId: data.roomId,
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

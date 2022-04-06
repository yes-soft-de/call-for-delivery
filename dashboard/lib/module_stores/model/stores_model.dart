import 'dart:math';

import 'package:intl/intl.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/response/stores_response.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/images/images.dart';

class StoresModel extends DataModel {
  int id = -1;
  String storeOwnerName = '';
  String phone = '';
  DateTime? closingTime;
  DateTime? openingTime;
  String status = '';
  String? image;
  String? imageUrl;
  String? city;
  String? employeeCount;
  String? bankAccountNumber;
  String? bankName;
  List<StoresModel> _models = [];

  StoresModel(
      {required this.id,
      required this.storeOwnerName,
      required this.phone,
      this.openingTime,
      this.closingTime,
      required this.status,
      this.image,
      this.imageUrl,
      this.employeeCount,
      this.bankName,
      this.bankAccountNumber,
      this.city});

  StoresModel.withData(List<Data> data) : super.withData() {
    _models = [];
    for (var element in data) {
      _models.add(StoresModel(
          id: element.id ?? -1,
          storeOwnerName: element.storeOwnerName ?? S.current.store,
          phone: element.phone ?? '',
          openingTime: DateHelper.convert(element.openingTime?.timestamp),
          closingTime: DateHelper.convert(element.closingTime?.timestamp),
          status: element.status ?? '',
          image: element.image?.image,
          imageUrl: element.image?.imageURL ?? ImageAsset.PLACEHOLDER,
          bankAccountNumber: element.bankAccountNumber,
          bankName: element.bankName,
          city: element.city,
          employeeCount: element.employeeCount));
    }
  }

  List<StoresModel> get data => _models;
}

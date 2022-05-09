import 'dart:math';

import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_company/response/company_profile_response.dart';

class CompanyProfileModel extends DataModel {
  int id = -1;
  String phone = '';
  String phone2 = '';
  String whatsapp = '';
  String fax = '';
  String bank = '';
  String stc = '';
  String email = '';
  String roomID = '';

  num kilometers = 0;
  num maxKilometerBonus = 0;
  num minKilometerBonus = 0;
  num supplierProfitMargin = 0;
  num storeProfitMargin = 0;

  CompanyProfileModel? _model;

  CompanyProfileModel(
      {required this.id,
      required this.phone,
      required this.phone2,
      required this.whatsapp,
      required this.fax,
      required this.bank,
      required this.stc,
      required this.email,
      required this.roomID,
      required this.minKilometerBonus,
      required this.maxKilometerBonus,
      required this.kilometers,
        required this.supplierProfitMargin,
       required this.storeProfitMargin

      });

  CompanyProfileModel.withData(Data data) : super.withData() {
    _model = CompanyProfileModel(
        id: data.id ?? -1,
        phone: data.phone ?? '',
        phone2: data.phone2 ?? '',
        whatsapp: data.whatspp ?? '',
        fax: data.fax ?? '',
        bank: data.bankName ?? '',
        stc: data.stc ?? '',
        email: data.email ?? '',
        roomID: data.roomID ?? '',
        kilometers: data.kilometers ?? 0,
        maxKilometerBonus: data.maxKilometerBonus ?? 0,
        minKilometerBonus: data.minKilometerBonus ?? 0,
      storeProfitMargin: data.storeProfitMargin ?? 0,
      supplierProfitMargin: data.supplierProfitMargin ?? 0

    );
  }

  CompanyProfileModel get data {
    if (_model != null) {
      return _model!;
    } else {
      throw Exception('There is no data');
    }
  }
}

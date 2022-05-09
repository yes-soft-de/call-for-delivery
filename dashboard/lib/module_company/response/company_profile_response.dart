import 'package:c4d/utils/logger/logger.dart';

class CompanyProfileResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CompanyProfileResponse({this.statusCode, this.msg, this.data});

  CompanyProfileResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = Data.fromJson(json['Data']);
    }
    try {} catch (e) {
      Logger().error('Company Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
}

class Data {
  int? id;
  String? phone;
  String? phone2;
  String? whatspp;
  String? fax;
  String? bankName;
  String? stc;
  String? email;
  String? roomID;

  num? kilometers;
  num? maxKilometerBonus;
  num? minKilometerBonus;

  num? supplierProfitMargin;
  num? storeProfitMargin;

  Data(
      {this.id,
      this.phone,
      this.phone2,
      this.whatspp,
      this.fax,
      this.bankName,
      this.stc,
      this.email,
      this.roomID,
      this.kilometers,
      this.maxKilometerBonus,
      this.minKilometerBonus,
        this.storeProfitMargin,
        this.supplierProfitMargin
      });

  Data.fromJson(dynamic json) {
    id = json['id'];
    phone = json['phone'];
    phone2 = json['phoneTwo'];
    whatspp = json['whatsapp'];
    fax = json['fax'];
    bankName = json['bankName'];
    stc = json['stc'];
    email = json['email'];
    roomID = json['roomID'];

    kilometers = json['kilometers'];
    maxKilometerBonus = json['maxKilometerBonus'];
    minKilometerBonus = json['minKilometerBonus'];
    supplierProfitMargin = json['supplierProfitMargin'];
    storeProfitMargin = json['storeProfitMargin'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['phone'] = phone;
    map['phoneTwo'] = phone2;
    map['whatsapp'] = whatspp;
    map['fax'] = fax;
    map['bankName'] = bankName;
    map['stc'] = stc;
    map['email'] = email;
    map['roomID'] = roomID;
    map['minKilometerBonus'] = minKilometerBonus;
    map['maxKilometerBonus'] = maxKilometerBonus;
    map['kilometers'] = kilometers;
    map['storeProfitMargin'] = storeProfitMargin;
    map['supplierProfitMargin'] = supplierProfitMargin;
    return map;
  }
}

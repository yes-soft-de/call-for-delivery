import 'package:c4d/module_stores/response/store_balance_response/date.dart';
import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/utils/logger/logger.dart';

class StoresResponse {
  String? statusCode;
  String? msg;
  List<Data>? data;

  StoresResponse({this.statusCode, this.msg, this.data});

  StoresResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    try {} catch (e) {
      Logger().error('stores response', '${e.toString()}', StackTrace.current);
      statusCode = '-1';
    }
  }
}

class Data {
  int? id;
  String? storeOwnerId;
  String? storeOwnerName;
  ImageUrl? image;
  dynamic phone;

  Date? closingTime;
  Date? openingTime;
  String? status;
  String? city;
  String? employeeCount;
  String? bankName;
  String? bankAccountNumber;

  Data(
      {this.id,
      this.storeOwnerName,
      this.image,
      this.phone,
      this.closingTime,
      this.openingTime,
      this.status,
      this.city,
      this.bankAccountNumber,
      this.bankName,
      this.employeeCount});

  Data.fromJson(dynamic json) {
    id = json['id'];
    storeOwnerName = json['storeOwnerName'];
    image = json['images'] != null ? ImageUrl.fromJson(json['images']) : null;
    phone = json['phone'];
    closingTime =
        json['closingTime'] != null ? Date.fromJson(json['closingTime']) : null;
    openingTime =
        json['openingTime'] != null ? Date.fromJson(json['openingTime']) : null;
    status = json['status'];
    city = json['city'];
    bankAccountNumber = json['bankAccountNumber'];
    bankName = json['bankName'];
    employeeCount = json['employeeCount'];
  }
}

class GeoJson {
  num? lat;
  num? long;

  GeoJson({this.lat, this.long});

  GeoJson.fromJson(dynamic json) {
    lat = json['lat'];
    long = json['lon'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['lat'] = lat;
    data['lon'] = long;

    return data;
  }
}

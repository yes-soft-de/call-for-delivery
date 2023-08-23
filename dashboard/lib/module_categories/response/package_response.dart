import 'package:c4d/utils/logger/logger.dart';

class PackagesResponse {
  PackagesResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  PackagesResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        json['Data'].forEach((v) {
          data?.add(PackageData.fromJson(v));
        });
      }
    } catch (e) {
      statusCode = '-1';
      Logger.error('Packages Response', e.toString(), StackTrace.current);
    }
  }
  String? statusCode;
  String? msg;
  List<PackageData>? data;
}

class PackageData {
  int? id;
  String? name;
  String? note;
  String? city;
  String? status;
  num? cost;
  num? carCount;
  num? orderCount;
  num? expired;
  num? type;
  num? extraCost;
  num? geographicalRange;
  PackageData(
      {this.id,
      this.name,
      this.note,
      this.orderCount,
      this.expired,
      this.cost,
      this.carCount,
      this.status,
      this.city,
      this.extraCost,
      this.geographicalRange,
      this.type});

  PackageData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    note = json['note'];
    city = json['city'];
    status = json['status'];
    cost = json['cost'];
    carCount = json['carCount'];
    orderCount = json['orderCount'];
    expired = json['expired'];
    geographicalRange = json['geographicalRange'];
    extraCost = json['extraCost'];
    type = json['type'];
  }
}

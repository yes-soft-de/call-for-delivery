import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/logger/logger.dart';

class PackagesResponse {
  List<Data>? data;
  String? statusCode;
  PackagesResponse({this.data});

  PackagesResponse.fromJson(Map<String, dynamic> json) {
    try {
      statusCode = json['status_code'];
      if (json['Data'] != null) {
        data = <Data>[];
        json['Data'].forEach((v) {
          data?.add(new Data.fromJson(v));
        });
      }
    } catch (e) {
      Logger().error('Package Response', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  num? cost;
  String? note;
  num? carCount;
  String? city;
  num? orderCount;
  String? status;
  int? expired;
  Data(
      {this.id,
      this.name,
      this.cost,
      this.note,
      this.carCount,
      this.city,
      this.orderCount,
      this.status,
      this.expired});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cost = json['cost'];
    note = json['note'];
    carCount = json['carCount'];
    city = json['city'];
    orderCount = json['orderCount'];
    status = json['status'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['cost'] = this.cost;
    data['note'] = this.note;
    data['carCount'] = this.carCount;
    data['city'] = this.city;
    data['orderCount'] = this.orderCount;
    data['status'] = this.status;
    return data;
  }
}

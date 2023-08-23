import 'package:c4d/utils/logger/logger.dart';

class CarsResponse {
  CarsResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  CarsResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        json['Data'].forEach((v) {
          data?.add(DataCars.fromJson(v));
        });
      }
    } catch (e) {
      statusCode = '-1';
      Logger.error('Cars Response', e.toString(), StackTrace.current);
    }
  }
  String? statusCode;
  String? msg;
  List<DataCars>? data;
}

class DataCars {
  DataCars({this.id, this.carModel, this.deliveryCost, this.details});

  DataCars.fromJson(dynamic json) {
    id = json['id'];
    carModel = json['carModel'];
    deliveryCost = json['deliveryCost'];
    details = json['details'];
  }
  int? id;
  String? carModel;
  String? details;
  num? deliveryCost;
}

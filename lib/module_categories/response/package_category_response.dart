import 'package:c4d/utils/logger/logger.dart';

class PackageCategoryResponse {
  PackageCategoryResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  PackageCategoryResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        json['Data'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    } catch (e) {
      statusCode = '-1';
      Logger()
          .error('Package Category Response', e.toString(), StackTrace.current);
    }
  }
  String? statusCode;
  String? msg;
  List<Data>? data;
}

class Data {
  Data({
    this.id,
    this.categoryName,
    this.description,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['name'];
    description = json['description'];
    status = json['status'];
  }
  int? id;
  String? categoryName;
  String? description;
  int? status;
}

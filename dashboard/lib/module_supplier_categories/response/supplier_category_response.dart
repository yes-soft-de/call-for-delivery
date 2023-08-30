import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/utils/logger/logger.dart';

class SupplierCategoryResponse {
  SupplierCategoryResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  SupplierCategoryResponse.fromJson(dynamic json) {
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
      Logger.error(
          'Supplier Category Response', e.toString(), StackTrace.current);
    }
  }
  String? statusCode;
  String? msg;
  List<Data>? data;
}

class Data {
  Data({this.id, this.categoryName, this.description, this.status, this.image});

  Data.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['name'];
    description = json['description'];
    status = json['status'];
    image = json['image'] != null ? ImageUrl.fromJson(json['image']) : null;
  }
  int? id;
  String? categoryName;
  String? description;
  bool? status;
  ImageUrl? image;
}

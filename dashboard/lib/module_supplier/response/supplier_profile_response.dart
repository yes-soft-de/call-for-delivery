import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/utils/logger/logger.dart';

class SupplierProfileResponse {
  String? statusCode;
  String? msg;
  DataSupplierProfile? data;

  SupplierProfileResponse({this.statusCode, this.msg, this.data});

  SupplierProfileResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      data = json['Data'] != null ? DataSupplierProfile.fromJson(json['Data']) : null;
    } catch (e) {
      Logger().error('Supplier Profile', e.toString(), StackTrace.current);
      statusCode = '-1';
    }
  }
}

class DataSupplierProfile {
  int? id;
  int? supplierID;
  String? supplierName;

  bool? status;
  String? phone;
  String? supplierCategoryName;
  List<ImageUrl>? image;

  DataSupplierProfile(
      {this.id,
      this.supplierID,
      this.supplierCategoryName,
      this.supplierName,
      this.status,
      this.image
      });

  DataSupplierProfile.fromJson(dynamic json) {
    id = json['id'];
    supplierID = json[' supplierId'];
    supplierName = json['supplierName'];
    status = json['status'];
    supplierCategoryName = json['supplierCategoryName'];
    if (json['images'] != null) {
      image = [];
      json['images'].forEach((v) {
        image?.add(ImageUrl.fromJson(v));
      });
    }
    phone = json['phone'];
  }


}

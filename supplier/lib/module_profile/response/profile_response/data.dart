import 'package:c4d/module_profile/response/profile_response/loaction.dart';

import 'images.dart';

class Data {
  int? id;
  List<CategorySupplier>? supplierCategories;
  String? name;
  List<Images>? images;
  String? phone;
  bool? status;
  String? bankName;
  String? bankAccountNumber;
  String? stcPay;
  String? roomId;
  GeoJson? location;
  Data(
      {this.supplierCategories,
      this.id,
      this.images,
      this.phone,
      this.status,
      this.roomId,
      this.name,
      this.location,
      this.bankName,
      this.bankAccountNumber,
      this.stcPay});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int?,
      name: json['supplierName'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      phone: json['phone'] as String?,
      status: json['status'] as bool?,
      roomId: json['roomId'] as String?,
      supplierCategories: (json['supplierCategories'] as List<dynamic>?)
          ?.map((e) => CategorySupplier.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: GeoJson.fromJson(json['location']),
      bankName: json['bankName'],
      bankAccountNumber: json['bankAccountNumber'],
      stcPay: json['stcPay']);
}

class CategorySupplier {
  int? id;
  String? name;

  CategorySupplier({this.id, this.name});

  factory CategorySupplier.fromJson(Map<String, dynamic> json) =>
      CategorySupplier(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );
}

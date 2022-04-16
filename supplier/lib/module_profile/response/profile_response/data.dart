import 'images.dart';

class Data {
  int? id;
  String? name;
 List<Images> ? images;
  String? phone;
  bool? status;
  String? roomId;
  String? supplierCategoryName;
  Data(
      {this.id,
      this.images,
      this.phone,
      this.status,
      this.roomId,this.supplierCategoryName,
        this.name
      });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['supplierName'] as String?,
        images: (json['images'] as List<dynamic>?)
        ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
        .toList(),
        phone: json['phone'] as String?,
        status: json['status'] as bool?,
        supplierCategoryName: json['supplierCategoryName'] as String,
        roomId: json['roomId'] as String?,
      );

}

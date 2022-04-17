import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'created_at.dart';

class Datum {
  int? id;
  num? price;
  num? quantity;
  String? details;
  bool? status;
  bool? administrationStatus;
  CreatedAt? createdAt;
  List<ImageUrl>? images;
  Datum({
    this.id,
    this.status,
    this.details,
    this.quantity,
    this.price,
    this.administrationStatus,
    this.images,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        status: json['status'] as bool?,
        details: json['details'] as String?,
        quantity: json['quantity'] as num?,
        price: json['price'] as int?,
        administrationStatus: json['administrationStatus'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => ImageUrl.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

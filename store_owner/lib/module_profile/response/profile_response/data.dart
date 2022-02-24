import 'images.dart';

class Data {
  int? id;
  String? storeOwnerName;
  Images? images;
  String? phone;
  String? status;
  dynamic commission;
  String? employeeCount;

  Data({
    this.id,
    this.storeOwnerName,
    this.images,
    this.phone,
    this.status,
    this.commission,
    this.employeeCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        storeOwnerName: json['storeOwnerName'] as String?,
        images: json['images'] == null
            ? null
            : Images.fromJson(json['images'] as Map<String, dynamic>),
        phone: json['phone'] as String?,
        status: json['status'] as String?,
        commission: json['commission'] as dynamic,
        employeeCount: json['employeeCount'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeOwnerName': storeOwnerName,
        'images': images?.toJson(),
        'phone': phone,
        'status': status,
        'commission': commission,
        'employeeCount': employeeCount,
      };
}

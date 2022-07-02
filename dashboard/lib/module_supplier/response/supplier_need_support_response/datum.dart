import 'package:c4d/module_stores/response/store_profile_response.dart';

class DatumSupplier {
  int? id;
  String? captainName;
  String? roomId;
  ImageUrl? images;
  int? userId;
  DatumSupplier(
      {this.id, this.captainName, this.roomId, this.images, this.userId});

  factory DatumSupplier.fromJson(Map<String, dynamic> json) => DatumSupplier(
        id: json['supplierProfileId'] as int?,
        userId: json['userId'] as int?,
        captainName: json['supplierName'] as String?,
        roomId: json['roomId'] as String?,
        images:
            (json['images'] != null) ? ImageUrl.fromJson(json['images']) : null,
      );

  Map<String, dynamic> toJson() => {
        'captainProfileId': id,
        'storeOwnerName': captainName,
        'roomID': roomId,
        'images': images,
      };
}

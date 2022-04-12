import 'package:c4d/module_stores/response/store_profile_response.dart';

class DatumSupplier {
  int? id;
  String? captainName;
  String? roomId;
  ImageUrl? image;
  DatumSupplier({this.id, this.captainName, this.roomId, this.image});

  factory DatumSupplier.fromJson(Map<String, dynamic> json) => DatumSupplier(
      id: json['captainProfileId'] as int?,
      captainName: json['captainName'] as String?,
      roomId: json['roomId'] as String?,
      image: ImageUrl.fromJson(json['images']));

  Map<String, dynamic> toJson() => {
        'captainProfileId': id,
        'storeOwnerName': captainName,
        'roomID': roomId,
        'images': image,
      };
}

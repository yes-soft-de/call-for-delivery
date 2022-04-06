import 'package:c4d/module_stores/response/store_profile_response.dart';

class Datum {
  int? id;
  String? storeOwnerName;
  String? roomId;
  ImageUrl? image;
  Datum({this.id, this.storeOwnerName, this.roomId, this.image});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json['storeOwnerProfileId'] as int?,
      storeOwnerName: json['storeOwnerName'] as String?,
      roomId: json['roomId'] as String?,
      image: ImageUrl.fromJson(json['images']));

  Map<String, dynamic> toJson() => {
        'storeOwnerProfileId': id,
        'storeOwnerName': storeOwnerName,
        'roomID': roomId,
        'images': image,
      };
}

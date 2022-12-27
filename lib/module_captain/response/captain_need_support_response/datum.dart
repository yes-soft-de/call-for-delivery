import 'package:c4d/module_stores/response/store_profile_response.dart';

class Datum {
  int? id;
  String? captainName;
  String? roomId;
  ImageUrl? image;
  int? userId;
  Datum({this.id, this.captainName, this.roomId, this.image, this.userId});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json['captainProfileId'] as int?,
      userId: json['userId'] as int?,
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

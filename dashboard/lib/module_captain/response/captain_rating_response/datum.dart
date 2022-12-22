import 'image.dart';

class Datum {
  int? id;
  String? captainName;
  String? avgRating;
  Image? image;

  Datum({this.id, this.captainName, this.avgRating, this.image});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        captainName: json['captainName'] as String?,
        avgRating: json['avgRating'] as String?,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'captainName': captainName,
        'avgRating': avgRating,
        'image': image?.toJson(),
      };
}

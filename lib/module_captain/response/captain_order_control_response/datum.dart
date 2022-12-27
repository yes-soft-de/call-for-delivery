import 'images.dart';

class Datum {
  int? id;
  int? captainId;
  String? captainName;
  Images? images;
  int? countOngoingOrders;

  Datum({
    this.id,
    this.captainId,
    this.captainName,
    this.images,
    this.countOngoingOrders,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        captainId: json['captainId'] as int?,
        captainName: json['captainName'] as String?,
        images: json['images'] == null
            ? null
            : Images.fromJson(json['images'] as Map<String, dynamic>),
        countOngoingOrders: json['countOngoingOrders'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'captainId': captainId,
        'captainName': captainName,
        'images': images?.toJson(),
        'countOngoingOrders': countOngoingOrders,
      };
}

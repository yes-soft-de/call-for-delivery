import 'images.dart';

class Datum {
  int? id;
  String? captainName;
  String? usedAs;
  Images? images;
  String? roomId;
  String? orderId;

  Datum({
    this.id,
    this.captainName,
    this.usedAs,
    this.images,
    this.roomId,
    this.orderId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        captainName: json['captainName'] as String?,
        usedAs: json['usedAs']?.toString() as String?,
        images: json['images'] == null
            ? null
            : Images.fromJson(json['images'] as Map<String, dynamic>),
        roomId: json['roomId'] as String?,
        orderId: json['orderId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'captainName': captainName,
        'usedAs': usedAs,
        'images': images?.toJson(),
        'roomId': roomId,
        'orderId': orderId,
      };
}

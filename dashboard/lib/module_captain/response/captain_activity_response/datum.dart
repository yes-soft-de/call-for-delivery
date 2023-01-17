import 'image.dart';

class Datum {
  int? id;
  int? captainId;
  String? captainName;
  Image? image;
  String? ordersCount;
  String? todayOrdersCount;
  String? lastTwentyFourOrdersCount;
  Datum({
    this.id,
    this.captainId,
    this.captainName,
    this.image,
    this.ordersCount,
    this.lastTwentyFourOrdersCount,
    this.todayOrdersCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        captainId: json['captainId'] as int?,
        captainName: json['captainName'] as String?,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
        ordersCount: json['ordersCount'] as String?,
        lastTwentyFourOrdersCount: json['lastTwentyFourOrdersCount'] as String?,
        todayOrdersCount: json['todayOrdersCount'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'captainId': captainId,
        'captainName': captainName,
        'image': image?.toJson(),
        'ordersCount': ordersCount,
        'todayOrdersCount': todayOrdersCount,
        'lastTwentyFourOrdersCount': lastTwentyFourOrdersCount
      };
}

import 'start_date.dart';

class CaptainOffer {
  int? id;
  StartDate? startDate;
  num? price;
  bool? captainOfferFirstTime;
  num? carCount;
  num? expired;
  String? status;
  CaptainOffer(
      {this.id,
      this.startDate,
      this.price,
      this.captainOfferFirstTime,
      this.carCount,
      this.expired,
      this.status});

  factory CaptainOffer.fromJson(Map<String, dynamic> json) => CaptainOffer(
        id: json['id'] as int?,
        startDate: json['startDate'] == null
            ? null
            : StartDate.fromJson(json['startDate'] as Map<String, dynamic>),
        price: json['price'] as num?,
        captainOfferFirstTime: json['captainOfferFirstTime'] as bool?,
        status: json['status'] as String?,
        expired: json['expired'] as num,
        carCount: json['carCount'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'startDate': startDate?.toJson(),
        'price': price,
      };
}

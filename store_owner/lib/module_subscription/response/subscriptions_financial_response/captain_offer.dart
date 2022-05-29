import 'start_date.dart';

class CaptainOffer {
  int? id;
  StartDate? startDate;
  num? price;

  CaptainOffer({this.id, this.startDate, this.price});

  factory CaptainOffer.fromJson(Map<String, dynamic> json) => CaptainOffer(
        id: json['id'] as int?,
        startDate: json['startDate'] == null
            ? null
            : StartDate.fromJson(json['startDate'] as Map<String, dynamic>),
        price: json['price'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'startDate': startDate?.toJson(),
        'price': price,
      };
}

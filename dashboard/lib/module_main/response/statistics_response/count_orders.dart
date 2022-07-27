import 'delivered.dart';

class CountOrders {
  int? allOrders;
  Delivered? delivered;
  int? pending;
  int? onGoing;

  CountOrders({this.allOrders, this.delivered, this.pending, this.onGoing});

  factory CountOrders.fromJson(Map<String, dynamic> json) => CountOrders(
        allOrders: json['allOrders'] as int?,
        delivered: json['delivered'] == null
            ? null
            : Delivered.fromJson(json['delivered'] as Map<String, dynamic>),
        pending: json['pending'] as int?,
        onGoing: json['onGoing'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'allOrders': allOrders,
        'delivered': delivered?.toJson(),
        'pending': pending,
        'onGoing': onGoing,
      };
}

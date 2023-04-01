import 'orders_count.dart';

class Orders {
  OrdersCount? counts;

  Orders({this.counts});

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        counts: json['count'] == null
            ? null
            : OrdersCount.fromJson(json['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'count': counts?.toJson(),
      };
}

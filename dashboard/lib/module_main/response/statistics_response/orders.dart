import 'count_orders.dart';

class Orders {
  CountOrders? countOrders;

  Orders({this.countOrders});

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        countOrders: json['count'] == null
            ? null
            : CountOrders.fromJson(json['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'count': countOrders?.toJson(),
      };
}

import 'package:c4d/module_statistics/response/orders_counts/orders_counts.dart';

class Orders {
  OrdersCounts? count;

  Orders({this.count});

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        count: json['count'] == null
            ? null
            : OrdersCounts.fromJson(json['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'count': count?.toJson(),
      };
}

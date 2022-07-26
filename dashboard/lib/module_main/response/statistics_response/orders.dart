import 'count_order.dart';

class Orders {
  CountOrder? countOrder;

  Orders({this.countOrder});

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        countOrder: json['countOrder'] == null
            ? null
            : CountOrder.fromJson(json['countOrder'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'countOrder': countOrder?.toJson(),
      };
}

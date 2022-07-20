import 'package:c4d/module_orders/response/orders_response/datum.dart';

class Data {
  List<DatumOrder>? orders;
  int? countOrders;

  Data({this.orders, this.countOrders});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: (json['orders'] as List<dynamic>?)
            ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
        countOrders: json['countOrders'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'orders': orders?.map((e) => e.toJson()).toList(),
        'countOrders': countOrders,
      };
}

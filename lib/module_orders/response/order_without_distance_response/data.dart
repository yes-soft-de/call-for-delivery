import 'package:c4d/module_orders/response/orders_response/datum.dart';

class Data {
  List<DatumOrder>? orders;
  Data({this.orders});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: (json['orderWithOutDistance'] as List<dynamic>?)
            ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'orderWithOutDistance': orders?.map((e) => e.toJson()).toList(),
      };
}

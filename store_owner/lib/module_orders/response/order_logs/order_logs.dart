import 'order_logs.dart';

class OrderLogs {
  OrderLogs? orderLogs;

  OrderLogs({this.orderLogs});

  factory OrderLogs.fromJson(Map<String, dynamic> json) => OrderLogs(
        orderLogs: json['orderLogs'] == null
            ? null
            : OrderLogs.fromJson(json['orderLogs'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'orderLogs': orderLogs?.toJson(),
      };
}

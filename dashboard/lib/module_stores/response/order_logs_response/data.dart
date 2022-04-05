import 'order_logs.dart';

class OrderLogsResponse {
  OrderLogs? orderLogs;

  OrderLogsResponse({this.orderLogs});

  factory OrderLogsResponse.fromJson(Map<String, dynamic> json) =>
      OrderLogsResponse(
        orderLogs: json['orderLogs'] == null
            ? null
            : OrderLogs.fromJson(json['orderLogs'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'orderLogs': orderLogs?.toJson(),
      };
}

import 'log.dart';
import 'order_state.dart';

class OrderLogs {
  OrderState? orderState;
  List<Log>? logs;

  OrderLogs({this.orderState, this.logs});

  factory OrderLogs.fromJson(Map<String, dynamic> json) => OrderLogs(
        orderState: json['orderState'] == null
            ? null
            : OrderState.fromJson(json['orderState'] as Map<String, dynamic>),
        logs: (json['logs'] as List<dynamic>?)
            ?.map((e) => Log.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'orderState': orderState?.toJson(),
        'logs': logs?.map((e) => e.toJson()).toList(),
      };
}

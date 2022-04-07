import 'package:c4d/module_stores/response/order/order_captain_not_arrived/data.dart';

class OrderCaptainResponse {
  String? statusCode;
  String? msg;
  List<OrderCaptainNotArrivedData>? data;

  OrderCaptainResponse({this.statusCode, this.msg, this.data});

  factory OrderCaptainResponse.fromJson(Map<String, dynamic> json) =>
      OrderCaptainResponse(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: (json['Data'] as List<dynamic>?)
            ?.map((e) =>
                OrderCaptainNotArrivedData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

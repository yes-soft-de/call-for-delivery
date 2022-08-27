import 'datum.dart';

class OrdersResponse {
  String? statusCode;
  String? msg;
  List<DatumOrder>? data;

  OrdersResponse({this.statusCode, this.msg, this.data});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: (json['Data'] as List<dynamic>?)
            ?.map((e) => DatumOrder.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.map((e) => e.toJson()).toList(),
      };
}

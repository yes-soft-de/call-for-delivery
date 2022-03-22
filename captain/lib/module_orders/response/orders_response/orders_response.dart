import 'datum.dart';

class OrdersResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  OrdersResponse({this.statusCode, this.msg, this.data});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data:json['Data'] is List ? (json['Data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList() : null,
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.map((e) => e.toJson()).toList(),
      };
}

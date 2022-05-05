import 'datum.dart';

class OrderDetailsResponse {
  String? statusCode;
  String? msg;
  Datum? data;

  OrderDetailsResponse({this.statusCode, this.msg, this.data});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) => OrderDetailsResponse(
    statusCode: json['status_code'] as String?,
    msg: json['msg'] as String?,
    data:Datum.fromJson(json['Data'])
  );
}
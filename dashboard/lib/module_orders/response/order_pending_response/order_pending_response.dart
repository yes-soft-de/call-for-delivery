import 'data.dart';

class OrderPendingResponse {
  String? statusCode;
  String? msg;
  Data? data;

  OrderPendingResponse({this.statusCode, this.msg, this.data});

  factory OrderPendingResponse.fromJson(Map<String, dynamic> json) {
    return OrderPendingResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.toJson(),
      };
}

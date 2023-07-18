import 'data.dart';

class PaymentHistoryResponse {
  String? statusCode;
  String? msg;
  Data? data;

  PaymentHistoryResponse({this.statusCode, this.msg, this.data});

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
    );
  }
}

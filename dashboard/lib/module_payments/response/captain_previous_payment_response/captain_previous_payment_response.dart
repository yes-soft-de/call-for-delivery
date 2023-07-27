import 'data.dart';

class CaptainPreviousPaymentResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CaptainPreviousPaymentResponse({this.statusCode, this.msg, this.data});

  factory CaptainPreviousPaymentResponse.fromJson(Map<String, dynamic> json) {
    return CaptainPreviousPaymentResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
    );
  }
}

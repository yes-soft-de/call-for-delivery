import 'data.dart';

class CaptainAccountBalanceResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CaptainAccountBalanceResponse({this.statusCode, this.msg, this.data});

  factory CaptainAccountBalanceResponse.fromJson(Map<String, dynamic> json) {
    return CaptainAccountBalanceResponse(
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

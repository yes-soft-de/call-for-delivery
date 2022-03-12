import 'data.dart';

class CompanyInfoResponse {
  String? statusCode;
  String? msg;
  Data? data;

  CompanyInfoResponse({this.statusCode, this.msg, this.data});

  factory CompanyInfoResponse.fromJson(Map<String, dynamic> json) {
    return CompanyInfoResponse(
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

import 'datum.dart';

class CaptainFinancialDuesResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  CaptainFinancialDuesResponse({this.statusCode, this.msg, this.data});

  factory CaptainFinancialDuesResponse.fromJson(Map<String, dynamic> json) {
    return CaptainFinancialDuesResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: (json['Data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.map((e) => e.toJson()).toList(),
      };
}

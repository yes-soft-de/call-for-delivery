import 'datum.dart';

class CaptainPaymentsResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  CaptainPaymentsResponse({this.statusCode, this.msg, this.data});

  factory CaptainPaymentsResponse.fromJson(Map<String, dynamic> json) {
    return CaptainPaymentsResponse(
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

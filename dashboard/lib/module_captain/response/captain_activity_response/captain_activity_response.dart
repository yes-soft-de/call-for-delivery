import 'datum.dart';

class CaptainActivityResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  CaptainActivityResponse({this.statusCode, this.msg, this.data});

  factory CaptainActivityResponse.fromJson(Map<String, dynamic> json) {
    return CaptainActivityResponse(
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

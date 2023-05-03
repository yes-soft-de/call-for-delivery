import 'datum.dart';

class StoreDuesResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  StoreDuesResponse({this.statusCode, this.msg, this.data});

  factory StoreDuesResponse.fromJson(Map<String, dynamic> json) {
    return StoreDuesResponse(
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

import 'datum.dart';

class StoresDuesResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  StoresDuesResponse({this.statusCode, this.msg, this.data});

  factory StoresDuesResponse.fromJson(Map<String, dynamic> json) {
    return StoresDuesResponse(
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

import 'datum.dart';

class UpdateResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  UpdateResponse({this.statusCode, this.msg, this.data});

  factory UpdateResponse.fromJson(Map<String, dynamic> json) {
    return UpdateResponse(
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

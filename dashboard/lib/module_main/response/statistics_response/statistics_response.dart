import 'dataum.dart';

class StatisticsResponse {
  String? statusCode;
  String? msg;
  Dataum? dataum;

  StatisticsResponse({this.statusCode, this.msg, this.dataum});

  factory StatisticsResponse.fromJson(Map<String, dynamic> json) {
    return StatisticsResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      dataum: json['Data'] == null
          ? null
          : Dataum.fromJson(json['Data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Dataum': dataum?.toJson(),
      };
}

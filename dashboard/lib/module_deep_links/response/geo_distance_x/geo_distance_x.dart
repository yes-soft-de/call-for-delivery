import 'data.dart';

class GeoDistanceX {
  String? statusCode;
  String? msg;
  Data? data;

  GeoDistanceX({this.statusCode, this.msg, this.data});

  factory GeoDistanceX.fromJson(Map<String, dynamic> json) => GeoDistanceX(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: json['Data'] == null
            ? null
            : Data.fromJson(json['Data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status code': statusCode,
        'msg': msg,
        'Data': data?.toJson(),
      };
}

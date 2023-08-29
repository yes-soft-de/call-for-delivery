// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'data.dart';

class GeoDistanceX {
  String? statusCode;
  String? msg;
  Data? data;

  GeoDistanceX({
    this.statusCode,
    this.msg,
    this.data,
  });

  GeoDistanceX copyWith({
    String? statusCode,
    String? msg,
    Data? data,
  }) {
    return GeoDistanceX(
      statusCode: statusCode ?? this.statusCode,
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }

  factory GeoDistanceX.fromMap(Map<String, dynamic> json) {
    var r = GeoDistanceX(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
    );
    return r;
  }

  Map<String, dynamic> toMap() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.toJson(),
      };

  String toJson() => json.encode(toMap());

  factory GeoDistanceX.fromJson(String source) =>
      GeoDistanceX.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GeoDistanceX(statusCode: $statusCode, msg: $msg, data: $data)';

  @override
  bool operator ==(covariant GeoDistanceX other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode &&
        other.msg == msg &&
        other.data == data;
  }

  @override
  int get hashCode => statusCode.hashCode ^ msg.hashCode ^ data.hashCode;
}

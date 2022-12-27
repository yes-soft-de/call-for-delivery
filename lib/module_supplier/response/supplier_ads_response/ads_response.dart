import 'datum.dart';

class AdsResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  AdsResponse({this.statusCode, this.msg, this.data});

  factory AdsResponse.fromJson(Map<String, dynamic> json) => AdsResponse(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: (json['Data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

import 'datum.dart';

class CarsResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  CarsResponse({this.statusCode, this.msg, this.data});

  factory CarsResponse.fromJson(Map<String, dynamic> json) => CarsResponse(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: (json['Data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

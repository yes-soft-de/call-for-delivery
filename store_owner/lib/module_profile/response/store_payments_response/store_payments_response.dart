import 'datum.dart';

class StorePaymentsResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  StorePaymentsResponse({this.statusCode, this.msg, this.data});

  factory StorePaymentsResponse.fromJson(Map<String, dynamic> json) {
    return StorePaymentsResponse(
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

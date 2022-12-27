import 'datum.dart';

class CaptainFinanceByOrderResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  CaptainFinanceByOrderResponse({this.statusCode, this.msg, this.data});

  factory CaptainFinanceByOrderResponse.fromJson(Map<String, dynamic> json) {
    return CaptainFinanceByOrderResponse(
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

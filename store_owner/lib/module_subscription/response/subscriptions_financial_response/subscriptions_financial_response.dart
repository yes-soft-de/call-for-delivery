import 'datum.dart';

class SubscriptionsFinancialResponse {
  String? statusCode;
  String? msg;
  List<Datum>? data;

  SubscriptionsFinancialResponse({this.statusCode, this.msg, this.data});

  factory SubscriptionsFinancialResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionsFinancialResponse(
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

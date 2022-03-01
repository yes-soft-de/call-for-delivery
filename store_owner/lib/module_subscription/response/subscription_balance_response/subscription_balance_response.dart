import 'data.dart';

class SubscriptionBalanceResponse {
  String? statusCode;
  String? msg;
  Data? data;

  SubscriptionBalanceResponse({this.statusCode, this.msg, this.data});

  factory SubscriptionBalanceResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionBalanceResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': data?.toJson(),
      };
}

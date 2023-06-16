import 'data.dart';

class NewSubscriptionBalanceResponse {
  String? statusCode;
  String? msg;
  Data? data;

  NewSubscriptionBalanceResponse({this.statusCode, this.msg, this.data});

  factory NewSubscriptionBalanceResponse.fromJson(Map<String, dynamic> json) {
    return NewSubscriptionBalanceResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] == null || json['Data'] is String?
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

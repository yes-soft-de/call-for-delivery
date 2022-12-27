import 'package:c4d/module_subscriptions/response/subscriptions_financial_response/subscriptions_response.dart';

class SubscriptionsFinancialResponse {
  String? statusCode;
  String? msg;
  SubscriptionsResponse? data;

  SubscriptionsFinancialResponse({this.statusCode, this.msg, this.data});

  factory SubscriptionsFinancialResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionsFinancialResponse(
      statusCode: json['status_code'] as String?,
      msg: json['msg'] as String?,
      data: json['Data'] != null
          ? SubscriptionsResponse.fromJson(json['Data'])
          : null,
    );
  }
}

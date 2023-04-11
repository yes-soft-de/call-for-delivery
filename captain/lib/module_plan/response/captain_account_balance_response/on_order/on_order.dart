import 'package:c4d/module_plan/response/captain_account_balance_response/captain_account_balance_response.dart';

import 'on_order_data.dart';

class OnOrder extends CaptainAccountBalanceResponse {
  OnOrder({super.statusCode, super.msg, super.data});

  factory OnOrder.fromJson(Map<String, dynamic> json) => OnOrder(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: json['Data'] == null
            ? null
            : OnOrderData.fromJson(json['Data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': (data as OnOrderData?)?.toJson(),
      };
}

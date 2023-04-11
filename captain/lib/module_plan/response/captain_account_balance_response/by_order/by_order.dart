import 'package:c4d/module_plan/response/captain_account_balance_response/captain_account_balance_response.dart';

import 'by_order_data.dart';

class ByOrder extends CaptainAccountBalanceResponse {
  ByOrder({super.statusCode, super.msg, super.data});

  factory ByOrder.fromJson(Map<String, dynamic> json) => ByOrder(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: json['Data'] == null
            ? null
            : ByOrderData.fromJson(json['Data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': (data as ByOrderData?)?.toJson(),
      };
}

import 'package:c4d/module_plan/response/captain_account_balance_response/captain_account_balance_response.dart';

import 'by_hour_data.dart';

class ByHour extends CaptainAccountBalanceResponse {
  ByHour({super.data, super.msg, super.statusCode});

  factory ByHour.fromJson(Map<String, dynamic> json) => ByHour(
        statusCode: json['status_code'] as String?,
        msg: json['msg'] as String?,
        data: json['Data'] == null
            ? null
            : ByHourData.fromJson(json['Data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'msg': msg,
        'Data': (data as ByHourData?)?.toJson(),
      };
}

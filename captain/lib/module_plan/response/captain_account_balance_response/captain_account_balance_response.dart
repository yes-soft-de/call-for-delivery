import 'package:c4d/module_plan/response/captain_account_balance_response/by_hour/by_hour.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/by_order/by_order.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/on_order/on_order.dart';

import 'account_balance_data.dart';

// ----< response type >---- \\
const int _kByHours = 1;
const int _kByOrder = 2;
// ignore: unused_element
const int _kOnOrder = 3;

abstract class CaptainAccountBalanceResponse {
  String? statusCode;
  String? msg;
  AccountBalanceData? data;

  CaptainAccountBalanceResponse({this.statusCode, this.msg, this.data});

  factory CaptainAccountBalanceResponse.fromJson(Map<String, dynamic> json) {
    int type = json['Data']['captainFinancialSystemType'];
    if (type == _kByHours) {
      return ByHour.fromJson(json);
    } else if (type == _kByOrder) {
      return ByOrder.fromJson(json);
    } else {
      return OnOrder.fromJson(json);
    }
  }
}

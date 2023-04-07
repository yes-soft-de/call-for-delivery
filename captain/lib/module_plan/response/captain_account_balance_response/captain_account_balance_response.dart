import 'package:c4d/module_plan/response/captain_account_balance_response/by_hour/by_hour.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/by_order/by_order.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/on_order/on_order.dart';

import 'account_balance_data.dart';

const int _kByHoursFelidsNumber = 12;
const int _kByOrderFelidsNumber = 16;

abstract class CaptainAccountBalanceResponse {
  String? statusCode;
  String? msg;
  AccountBalanceData? data;

  CaptainAccountBalanceResponse({this.statusCode, this.msg, this.data});

  factory CaptainAccountBalanceResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'].length == _kByHoursFelidsNumber) {
      return ByHour.fromJson(json);
    } else if (json['Data'].length == _kByOrderFelidsNumber) {
      return ByOrder.fromJson(json);
    } else {
      return OnOrder.fromJson(json);
    }
  }
}

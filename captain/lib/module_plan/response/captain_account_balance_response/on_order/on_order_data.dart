import 'package:c4d/module_plan/response/captain_account_balance_response/account_balance_data.dart';

import 'final_financial_account.dart';
import 'financial_account_detail.dart';

class OnOrderData extends AccountBalanceData {
  List<FinancialAccountDetail>? financialAccountDetails;
  FinalFinancialAccount? finalFinancialAccount;

  OnOrderData({this.financialAccountDetails, this.finalFinancialAccount});

  factory OnOrderData.fromJson(Map<String, dynamic> json) => OnOrderData(
        financialAccountDetails:
            (json['financialAccountDetails'] as List<dynamic>?)
                ?.map((e) =>
                    FinancialAccountDetail.fromJson(e as Map<String, dynamic>))
                .toList(),
        finalFinancialAccount: json['finalFinancialAccount'] == null
            ? null
            : FinalFinancialAccount.fromJson(
                json['finalFinancialAccount'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'financialAccountDetails':
            financialAccountDetails?.map((e) => e.toJson()).toList(),
        'finalFinancialAccount': finalFinancialAccount?.toJson(),
      };
}

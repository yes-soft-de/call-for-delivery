import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_plan/model/captain_finance_by_order_count.dart';
import 'package:c4d/module_plan/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_plan/model/captain_financial_dues.dart';
import 'package:c4d/module_plan/request/captain_finance_request.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/captain_account_balance_response.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/financial_account_detail.dart';
import 'package:c4d/module_plan/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';
import 'package:c4d/module_plan/response/captain_finance_by_order_count_response/captain_finance_by_order_count_response.dart';
import 'package:c4d/module_plan/response/captain_financeby_order_response/captain_financeby_order_response.dart';
import 'package:c4d/module_plan/response/captain_financial_dues_response/captain_financial_dues_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/helpers/translating.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/manager/captain_balance_manager.dart';

@injectable
class PlanService {
  final CaptainBalanceManager _manager;
  PlanService(this._manager);
  Future<DataModel> getCaptainFinanceByOrder() async {
    CaptainFinanceByOrderResponse? actionResponse =
        await _manager.getCaptainFinance();
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return CaptainFinanceByOrderModel.withData(actionResponse);
  }

  Future<DataModel> getCaptainFinanceByHour() async {
    CaptainFinanceByHoursResponse? actionResponse =
        await _manager.getCaptainFinanceByHours();
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return CaptainFinanceByHoursModel.withData(actionResponse);
  }

  Future<DataModel> getCaptainFinanceByOrderCounts() async {
    CaptainFinanceByOrderCountResponse? actionResponse =
        await _manager.getCaptainFinanceByCountOrder();
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return CaptainFinanceByOrdersCountModel.withData(actionResponse);
  }

  Future<DataModel> financeRequest(CaptainFinanceRequest request) async {
    ActionResponse? actionResponse = await _manager.financeRequest(request);
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getCaptainAccountBalance() async {
    CaptainAccountBalanceResponse? actionResponse =
        await _manager.getCaptainAccountBalance();
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    if (actionResponse.data?.financialAccountDetails != null) {
      actionResponse.data?.financialAccountDetails =
          await _getTranslated(actionResponse);
    }
    return CaptainAccountBalanceModel.withData(actionResponse);
  }

  Future<DataModel> getCaptainFinancialDues() async {
    CaptainFinancialDuesResponse? actionResponse =
        await _manager.getCaptainFinancialDues();
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    if (actionResponse.data == null) {
      return DataModel.empty();
    }
    return CaptainFinancialDuesModel.withData(actionResponse);
  }

  Future<List<FinancialAccountDetail>?> _getTranslated(
      CaptainAccountBalanceResponse actionResponse) async {
    var translated = <FinancialAccountDetail>[];
    translated = actionResponse.data!.financialAccountDetails!;
    for (var element in translated) {
      element.message = await Trans.translateService(element.message ?? '');
    }
    return translated;
  }
}

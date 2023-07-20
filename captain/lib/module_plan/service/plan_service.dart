import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_plan/model/captain_finance_by_order_count.dart';
import 'package:c4d/module_plan/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_plan/model/captain_financial_dues.dart';
import 'package:c4d/module_plan/model/my_profits_model.dart';
import 'package:c4d/module_plan/model/payment_history_model.dart';
import 'package:c4d/module_plan/request/captain_finance_request.dart';
import 'package:c4d/module_plan/request/payment_history_request.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/captain_account_balance_response.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/on_order/on_order_data.dart';
import 'package:c4d/module_plan/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';
import 'package:c4d/module_plan/response/captain_finance_by_order_count_response/captain_finance_by_order_count_response.dart';
import 'package:c4d/module_plan/response/captain_financeby_order_response/captain_financeby_order_response.dart';
import 'package:c4d/module_plan/response/captain_financial_dues_response/captain_financial_dues_response.dart';
import 'package:c4d/module_plan/response/my_profits_response/my_profits_response.dart';
import 'package:c4d/module_plan/response/payment_history_response/payment_history_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/helpers/translating.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/manager/captain_balance_manager.dart';

import '../request/request_payment.dart';
import '../response/captain_account_balance_response/on_order/financial_account_detail.dart';

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

    // no need to translate any more
    // if (actionResponse is OnOrder) {
    //   var data = actionResponse.data as OnOrderData?;

    //   data?.financialAccountDetails = await _getTranslated(data);

    //   actionResponse.data = data;
    // }
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

  Future<DataModel> stopCaptainFinancialDues() async {
    ActionResponse? actionResponse = await _manager.stopFinanceRequest();
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<List<FinancialAccountDetail>?> _getTranslated(OnOrderData data) async {
    try {
      var translated = <FinancialAccountDetail>[];
      translated = data.financialAccountDetails!;
      for (var element in translated) {
        if (element.message == null) {
          continue;
        }

        element.message = await Trans.translateService(element.message ?? '');
      }
      return translated;
    } catch (e) {
      return data.financialAccountDetails;
    }
  }

  num calculateProfit(MyProfitsModel myProfitModel, num kilometer) {
    if (kilometer == 0) return 0;

    if (0 < kilometer && kilometer <= myProfitModel.firstSliceToLimit) {
      return (myProfitModel.firstSliceCost) + myProfitModel.openOrderCost;
    } else if (myProfitModel.secondSliceFromLimit < kilometer &&
        kilometer < myProfitModel.secondSliceToLimit) {
      return (kilometer * myProfitModel.secondSliceOneKilometerCost) +
          myProfitModel.openOrderCost;
    } else if (myProfitModel.thirdSliceFromLimit <= kilometer) {
      return (kilometer * myProfitModel.thirdSliceOneKilometerCost) +
          myProfitModel.openOrderCost;
    }

    return 0;
  }

  Future<DataModel> getPaymentHistory(PaymentHistoryRequest request) async {
    PaymentHistoryResponse? response =
        await _manager.getPaymentHistory(request);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }

    if (response.data?.payments?.isEmpty ?? true) {
      return DataModel.empty();
    }

    return PaymentHistoryModel.withData(response);
  }

  Future<DataModel> getMyProfit() async {
    MyProfitsResponse? response = await _manager.getMyProfits();
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return MyProfitsModel.withData(response);
  }

  Future<DataModel> requestPayment(RequestPayment request) async {
    ActionResponse? actionResponse = await _manager.requestPayment(request);
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      if (actionResponse.statusCode == '404') {
        return DataModel.withError(S.current.thisFeatureNotAvailableYet);
      }
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}

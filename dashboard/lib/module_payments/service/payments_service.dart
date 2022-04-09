import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/manager/payments_manager.dart';
import 'package:c4d/module_payments/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_count.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_payments/model/store_balance_model.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_count_order_request.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_hours.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_order_request.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';
import 'package:c4d/module_payments/response/captain_finance_by_order_counts_response/captain_finance_by_order_counts_response.dart';
import 'package:c4d/module_payments/response/captain_finance_by_order_response/captain_finance_by_order_response.dart';
import 'package:c4d/module_payments/response/store_payments_response/store_payments_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentsService {
  final PaymentsManager _paymentsManager;

  PaymentsService(this._paymentsManager);
  /*-----------------------------------STORE PAYMENTS----------------------------------------------- */
  Future<DataModel> paymentToStore(CreateStorePaymentsRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.paymentToStore(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getStorePayments(int id) async {
    StorePaymentsResponse? actionResponse =
        await _paymentsManager.getStorePayments(id);
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return StoreBalanceModel.withData(actionResponse.data ?? []);
  }

  Future<DataModel> deletePaymentToStore(String id) async {
    ActionResponse? actionResponse =
        await _paymentsManager.deleteStorePayment(id);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  /* ---------------------------------- CAPTAIN FINANCE --------------------------------------- */
  /* GET */
  Future<DataModel> getCaptainFinanceByOrder() async {
    CaptainFinanceByOrderResponse? actionResponse =
        await _paymentsManager.getCaptainFinanceByOrder();
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
        await _paymentsManager.getCaptainFinanceByHour();
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
    CaptainFinanceByOrderCountsResponse? actionResponse =
        await _paymentsManager.getCaptainFinanceByOrderCounts();
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return CaptainFinanceByOrdersCountModel.withData(actionResponse);
  }

  /* CREATE */
  Future<DataModel> createCaptainFinanceByOrder(
      CreateCaptainFinanceByOrderRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.createCaptainFinanceByOrder(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> createCaptainFinanceByHour(
      CreateCaptainFinanceByHoursRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.createCaptainFinanceByHour(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> createCaptainFinanceByOrderCounts(
      CreateCaptainFinanceByCountOrderRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.createCaptainFinanceByOrderCounts(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}

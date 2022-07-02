import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/request/captain_finance_request.dart';
import 'package:c4d/module_payments/manager/payments_manager.dart';
import 'package:c4d/module_payments/model/captain_balance_model.dart';
import 'package:c4d/module_payments/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_count.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_payments/model/store_balance_model.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_count_order_request.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_hours.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_order_request.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';
import 'package:c4d/module_payments/response/captain_finance_by_order_counts_response/captain_finance_by_order_counts_response.dart';
import 'package:c4d/module_payments/response/captain_finance_by_order_response/captain_finance_by_order_response.dart';
import 'package:c4d/module_payments/response/captain_payments_response/captain_payments_response.dart';
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

  Future<DataModel> paymentFromStore(CreateStorePaymentsRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.paymentFromStore(request);

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

  Future<DataModel> deletePaymentFromStore(String id) async {
    ActionResponse? actionResponse =
        await _paymentsManager.deleteFromStorePayment(id);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  /*-----------------------------------CAPTAIN PAYMENTS----------------------------------------------- */
  Future<DataModel> getCaptainBalance(int captainId) async {
    CaptainPaymentsResponse? _captainProfileResponse =
        await _paymentsManager.getAccountBalance(captainId);
    if (_captainProfileResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_captainProfileResponse.statusCode != '200') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          _captainProfileResponse.statusCode));
    }
    if (_captainProfileResponse.data == null) return DataModel.empty();
    return CaptainBalanceModel.withData(_captainProfileResponse.data ?? []);
  }

  Future<DataModel> paymentToCaptain(CaptainPaymentsRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.paymentToCaptain(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> paymentFromCaptain(CaptainPaymentsRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.paymentFromCaptain(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deletePaymentToCaptain(String id) async {
    ActionResponse? actionResponse =
        await _paymentsManager.deletePaymentToCaptain(id);

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
    if (actionResponse.data == null) {
      return DataModel.empty();
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
    if (actionResponse.data == null) {
      return DataModel.empty();
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
    if (actionResponse.data == null) {
      return DataModel.empty();
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

  /* UPDATE */
  Future<DataModel> updateCaptainFinanceByOrder(
      CreateCaptainFinanceByOrderRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.updateCaptainFinanceByOrder(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateCaptainFinanceByHour(
      CreateCaptainFinanceByHoursRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.updateCaptainFinanceByHour(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateCaptainFinanceByOrderCounts(
      CreateCaptainFinanceByCountOrderRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.updateCaptainFinanceByOrderCounts(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  /* DELETE */
  Future<DataModel> deleteCaptainFinanceByOrder(int id) async {
    ActionResponse? actionResponse =
        await _paymentsManager.deleteCaptainFinanceByOrder(id);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deleteCaptainFinanceByHour(int id) async {
    ActionResponse? actionResponse =
        await _paymentsManager.deleteCaptainFinanceByHour(id);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deleteCaptainFinanceByOrderCounts(int id) async {
    ActionResponse? actionResponse =
        await _paymentsManager.deleteCaptainFinanceByOrderCounts(id);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  /* CHANGE CAPTAIN PLAN */
  Future<DataModel> financeRequest(CaptainFinanceRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.financeRequest(request);
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}

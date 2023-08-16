import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_captain/request/captain_payment_request.dart';
import 'package:c4d/module_captain/request/captain_finance_request.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_payments/request/captain_daily_payment_request.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/request/captain_previous_payments_request.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_count_order_request.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_hours.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_order_request.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/response/captain_all_amounts.dart';
import 'package:c4d/module_payments/response/captain_dialy_finance/captain_dialy_finance.dart';
import 'package:c4d/module_payments/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';
import 'package:c4d/module_payments/response/captain_finance_by_order_counts_response/captain_finance_by_order_counts_response.dart';
import 'package:c4d/module_payments/response/captain_finance_by_order_response/captain_finance_by_order_response.dart';
import 'package:c4d/module_payments/response/captain_finance_response/captain_finance_response.dart';
import 'package:c4d/module_payments/response/captain_payments_response/captain_payments_response.dart';
import 'package:c4d/module_payments/response/captain_previous_payment_response/captain_previous_payment_response.dart';
import 'package:c4d/module_payments/response/store_payments_response/store_payments_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  PaymentsRepository(this._apiClient, this._authService);
  /* ---------------------------------- PAYMENT TO STORE --------------------------------------- */
  Future<ActionResponse?> paymentToStore(
      CreateStorePaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_STORE_PAYMENTS_TO_STORE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> paymentFromStore(
      CreateStorePaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_STORE_PAYMENTS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<StorePaymentsResponse?> getStorePayments(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_FROM_STORE_PAYMENTS + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return StorePaymentsResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteStorePayments(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.CREATE_STORE_PAYMENTS + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteFromStorePayments(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.CREATE_STORE_FROM_PAYMENTS + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  /* ---------------------------------- PAYMENT TO CAPTAIN --------------------------------------- */
  Future<CaptainPreviousPaymentResponse?> filterCaptainPayment(
      CaptainPreviousPaymentRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.FILTER_CAPTAIN_PAYMENT, await request.toMap(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainPreviousPaymentResponse.fromJson(response);
  }

  Future<ActionResponse?> paymentToCaptain(
      CaptainPaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_CAPTAIN_PAYMENTS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> paymentFromCaptain(
      CaptainPaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_CAPTAIN_PAYMENTS_TO_COMPANY, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deletePaymentToCaptain(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.DELETE_CAPTAIN_PAYMENTS_TO_COMPANY + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<CaptainPaymentsResponse?> getCaptainAccountBalance(
      int captainId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_CAPTAIN_PAYMENTS_FROM_CASH + '/$captainId',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainPaymentsResponse.fromJson(response);
  }

  /* ---------------------------------- CAPTAIN DAILY PAYMENTS FINANCE --------------------------------------- */

  Future<CaptainDailyFinanceResponse?> getCaptainDailyFinance(
      CaptainPaymentRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.GET_CAPTAIN_DAILY_FINANCE, await request.toMap(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainDailyFinanceResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteDailyFinance(
      CaptainDailyPaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.DELETE_CAPTAIN_DAILY_FINANCE,
        payLoad: request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> payADailyFinance(
      CaptainDailyPaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.PAY_CAPTAIN_DAILY_FINANCE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> editADailyFinance(
      CaptainDailyPaymentsRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.EDIT_CAPTAIN_DAILY_FINANCE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  /* ---------------------------------- CAPTAIN FINANCE --------------------------------------- */
  Future<CaptainFinanceResponse?> getCaptainFinance(int captainId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        '${Urls.GET_CAPTAIN_FINCANCE_DUES}/${captainId}',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainFinanceResponse.fromJson(response);
  }

  /* GET */
  Future<CaptainFinanceByOrderResponse?> getCaptainFinanceByOrder() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_FINANCE_BY_ORDERS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainFinanceByOrderResponse.fromJson(response);
  }

  Future<CaptainFinanceByHoursResponse?> getCaptainFinanceByHour() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_FINANCE_BY_HOURS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainFinanceByHoursResponse.fromJson(response);
  }

  Future<CaptainFinanceByOrderCountsResponse?>
      getCaptainFinanceByOrderCounts() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_CAPTAIN_FINANCE_BY_ORDER_COUNTS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainFinanceByOrderCountsResponse.fromJson(response);
  }

  /* CREATE */
  Future<ActionResponse?> createCaptainFinanceByOrder(
      CreateCaptainFinanceByOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.GET_CAPTAIN_FINANCE_BY_ORDERS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> createCaptainFinanceByHour(
      CreateCaptainFinanceByHoursRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.GET_CAPTAIN_FINANCE_BY_HOURS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> createCaptainFinanceByOrderCounts(
      CreateCaptainFinanceByCountOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.GET_CAPTAIN_FINANCE_BY_ORDER_COUNTS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  /* UPDATE */
  Future<ActionResponse?> updateCaptainFinanceByOrder(
      CreateCaptainFinanceByOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.GET_CAPTAIN_FINANCE_BY_ORDERS, request.toJsonWithID(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCaptainFinanceByHour(
      CreateCaptainFinanceByHoursRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.GET_CAPTAIN_FINANCE_BY_HOURS, request.toJsonWithID(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCaptainFinanceByOrderCounts(
      CreateCaptainFinanceByCountOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.GET_CAPTAIN_FINANCE_BY_ORDER_COUNTS, request.toJsonWithID(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  /* DELETE */
  Future<ActionResponse?> deleteCaptainFinanceByOrder(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.GET_CAPTAIN_FINANCE_BY_ORDERS + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteCaptainFinanceByHour(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.GET_CAPTAIN_FINANCE_BY_HOURS + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteCaptainFinanceByOrderCounts(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        Urls.GET_CAPTAIN_FINANCE_BY_ORDER_COUNTS + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> financeRequest(CaptainFinanceRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.CHANGE_CAPTAIN_FINANCE_PLAN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> financeCreate(CaptainFinanceRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_CAPTAIN_FINANCE_PLAN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<CaptainAllFinanceResponse?> getAllAmountCaptain(
      CaptainPaymentRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.NEW_GET_CAPTAIN_FINANCE_ALL_AMOUNT, await request.toMap(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainAllFinanceResponse.fromJson(response);
  }
}

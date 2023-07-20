import 'package:c4d/module_plan/request/captain_finance_request.dart';
import 'package:c4d/module_plan/request/payment_history_request.dart';
import 'package:c4d/module_plan/request/request_payment.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/captain_account_balance_response.dart';
import 'package:c4d/module_plan/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';
import 'package:c4d/module_plan/response/captain_finance_by_order_count_response/captain_finance_by_order_count_response.dart';
import 'package:c4d/module_plan/response/captain_financeby_order_response/captain_financeby_order_response.dart';
import 'package:c4d/module_plan/response/captain_financial_dues_response/captain_financial_dues_response.dart';
import 'package:c4d/module_plan/response/my_profits_response/my_profits_response.dart';
import 'package:c4d/module_plan/response/payment_history_response/payment_history_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class PackageBalanceRepository {
  final AuthService _authService;
  final ApiClient _apiClient;
  PackageBalanceRepository(this._authService, this._apiClient);
  /*------------------------------------------CAPTAIN FINANCE-------------------------------------------*/

  Future<CaptainFinanceByOrderResponse?> getCaptainFinanceByOrder() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_FINANCE_BY_ORDER,
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return CaptainFinanceByOrderResponse.fromJson(response);
  }

  Future<CaptainFinanceByHoursResponse?> getCaptainFinanceByHours() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_FINANCE_BY_HOURS,
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return CaptainFinanceByHoursResponse.fromJson(response);
  }

  Future<CaptainFinanceByOrderCountResponse?>
      getCaptainFinanceByCountOrder() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_CAPTAIN_FINANCE_BY_COUNT_ORDER,
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return CaptainFinanceByOrderCountResponse.fromJson(response);
  }

  Future<ActionResponse?> financeRequest(CaptainFinanceRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_CAPTAIN_FINANCE, request.toJson(),
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> stopFinanceRequest() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.STOP_FINANCE_CAPTAIN, {},
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  /*------------------------------------------ACCOUNT BALANCE-------------------------------------------*/
  Future<CaptainAccountBalanceResponse?> getCaptainAccountBalance() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_ACCOUNT_BALANCE,
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return CaptainAccountBalanceResponse.fromJson(response);
  }

  Future<CaptainFinancialDuesResponse?> getCaptainFinancialDues() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_FINANCIAL_DUES,
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return CaptainFinancialDuesResponse.fromJson(response);
  }

  //------------------------ my profits
  Future<PaymentHistoryResponse?> getPaymentHistory(
      PaymentHistoryRequest request) async {
    var token = await _authService.getToken();

    var timezone = await FlutterNativeTimezone.getLocalTimezone();
    request = request.copyWith(customizedTimezone: timezone);

    dynamic response = await _apiClient.post(
        Urls.GET_PAYMENTS_HISTORY, request.toMap(),
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return PaymentHistoryResponse.fromJson(response);
  }

  Future<MyProfitsResponse?> getMyProfits() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_ACCOUNT_BALANCE,
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return MyProfitsResponse.fromJson(response);
  }

  Future<ActionResponse?> requestPayment(RequestPayment request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.post(
        Urls.REQUEST_PAYMENT, request.toMap(),
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

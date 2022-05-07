import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/module_captain/request/enable_captain.dart';
import 'package:c4d/module_captain/request/enable_offer.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:c4d/module_captain/response/capatin_offer_response.dart';
import 'package:c4d/module_captain/response/captain_account_balance_response/captain_account_balance_response.dart';
import 'package:c4d/module_captain/response/captain_financial_dues_response/captain_financial_dues_response.dart';
import 'package:c4d/module_captain/response/captain_need_support_response/captain_need_support_response.dart';
import 'package:c4d/module_captain/response/captain_profile_response.dart';
import 'package:c4d/module_captain/response/in_active_captain_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class CaptainsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  CaptainsRepository(this._apiClient, this._authService);

  Future<CaptainOfferResponse?> getCaptainOffer() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_OFFERS, headers: {
      'Authorization': 'Bearer ' + token.toString(),
    });
    if (response == null) return null;
    return CaptainOfferResponse.fromJson(response);
  }

  Future<ActionResponse?> addCaptainOffer(CaptainOfferRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_CAPTAIN_OFFERS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCaptainOffer(
      CaptainOfferRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_CAPTAIN_OFFERS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> enableCaptainOffer(EnableOfferRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.ACTIVE_CAPTAIN_OFFERS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<CaptainResponse?> getInActiveCaptain() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAINS + 'inactive',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainResponse.fromJson(response);
  }

  Future<CaptainResponse?> getCaptains() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAINS + 'active',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainResponse.fromJson(response);
  }

  Future<CaptainProfileResponse?> getCaptainProfile(int captainId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_CAPTAIN_PROFILE + '$captainId',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainProfileResponse.fromJson(response);
  }

  Future<ActionResponse?> enableCaptain(EnableCaptainRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.ACTIVATE_CAPTAIN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCaptain(UpdateCaptainRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_CAPTAIN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<CaptainNeedSupportResponse?> getCaptainSupport() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CHAT_ROOMS_CAPTAINS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainNeedSupportResponse.fromJson(response);
  }

  /*------------------------------------------ACCOUNT BALANCE-------------------------------------------*/
  Future<CaptainAccountBalanceResponse?> getCaptainAccountBalance(
      int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_CAPTAIN_ACCOUNT_BALANCE + '/$id',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainAccountBalanceResponse.fromJson(response);
  }

  Future<ActionResponse?> captainFinanceStatus(
      EnableCaptainRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_CAPTAIN_FINANCE_PLAN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<CaptainFinancialDuesResponse?> getCaptainFinancialDues(
      int captainID) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GET_CAPTAIN_FINANCE_DUES + '/$captainID',
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainFinancialDuesResponse.fromJson(response);
  }
}

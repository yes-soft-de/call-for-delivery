import 'package:c4d/abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_company/request/create_company_profile.dart';
import 'package:c4d/module_company/request/delivery_company_financial.dart';
import 'package:c4d/module_company/request/financial_compensation_request.dart';
import 'package:c4d/module_company/response/company_delivery_price_response.dart';
import 'package:c4d/module_company/response/company_profile_response.dart';
import 'package:c4d/module_company/response/financial_compensations_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class CompanyRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  CompanyRepository(this._apiClient, this._authService);

  Future<CompanyProfileResponse?> getProfileCompany() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.COMPANY_INFO,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CompanyProfileResponse.fromJson(response);
  }

//  Future<FinancialCompensationsResponse?> getFinancialCompensations() async {
//    var token = await _authService.getToken();
//    dynamic response = await _apiClient.get(Urls.GET_FINANCIAL_COMPANY,
//        headers: {'Authorization': 'Bearer ' + token.toString()});
//    if (response == null) return null;
//    return FinancialCompensationsResponse.fromJson(response);
//  }

//  Future<CompanyDeliveryPriceResponse?> getDeliveryPrice() async {
//    var token = await _authService.getToken();
//    dynamic response = await _apiClient.get(Urls.GET_DELIVERY_PRICE_COMPANY,
//        headers: {'Authorization': 'Bearer ' + token.toString()});
//    if (response == null) return null;
//    return CompanyDeliveryPriceResponse.fromJson(response);
//  }

  Future<ActionResponse?> createCompanyProfile(
      CreateCompanyProfile request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.COMPANY_INFO, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCompanyProfile(
      CreateCompanyProfile request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.COMPANY_INFO, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

//  Future<ActionResponse?> updateFinancialCompany(
//      FinancialCompensationRequest request, bool create) async {
//    var token = await _authService.getToken();
//    dynamic response;
//    if (create) {
//      response = await _apiClient.post(
//          Urls.UPDATE_FINANCIAL_COMPANY, request.toJson(),
//          headers: {'Authorization': 'Bearer ' + token.toString()});
//    } else {
//      response = await _apiClient.put(
//          Urls.UPDATE_FINANCIAL_COMPANY, request.toJson(),
//          headers: {'Authorization': 'Bearer ' + token.toString()});
//    }
//    return ActionResponse.fromJson(response);
//  }
//
//  Future<ActionResponse?> updateFinancialDeliveryPriceCompany(
//      DeliveryCompanyFinancialRequest request, bool create) async {
//    var token = await _authService.getToken();
//    dynamic response;
//    if (create) {
//      response = await _apiClient.post(
//          Urls.UPDATE_DELIVERY_PRICE_COMPANY, request.toJson(),
//          headers: {'Authorization': 'Bearer ' + token.toString()});
//    } else {
//      response = await _apiClient.put(
//          Urls.UPDATE_DELIVERY_PRICE_COMPANY, request.toJson(),
//          headers: {'Authorization': 'Bearer ' + token.toString()});
//    }
//    if (response == null) return null;
//    return ActionResponse.fromJson(response);
//  }
}

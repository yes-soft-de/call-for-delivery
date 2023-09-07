import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_external_delivery_companies/request/assign_order_to_external_company/assign_order_to_external_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/create_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/delete_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/update_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/update_company_criterial_status_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/create_new_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/delete_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/update_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/update_delivery_company_status_request.dart';
import 'package:c4d/module_external_delivery_companies/request/external_order_request/external_orders_request.dart';
import 'package:c4d/module_external_delivery_companies/request/feature_request/feature_request.dart';
import 'package:c4d/module_external_delivery_companies/request/naher_evan_captain_request/naher_evan_captain_request.dart';
import 'package:c4d/module_external_delivery_companies/response/delivery_companies_response/delivery_companies_response.dart';
import 'package:c4d/module_external_delivery_companies/response/delivery_company_criteria_response/delivery_company_criteria_response.dart';
import 'package:c4d/module_external_delivery_companies/response/external_order_response/order_pending_response.dart';
import 'package:c4d/module_external_delivery_companies/response/feature_response/feature_response/feature_response.dart';
import 'package:c4d/module_external_delivery_companies/response/naher_evan_captain_response/naher_evan_captain_response.dart';
import 'package:c4d/module_external_delivery_companies/response/naher_evan_captains_response/naher_evan_captains_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExternalDeliveryCompaniesRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ExternalDeliveryCompaniesRepository(
    this._apiClient,
    this._authService,
  );

  Future<ActionResponse?> updateCompany(
      UpdateDeliveryCompanyRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.put(
      Urls.EXTERNAL_DELIVERY_COMPANY,
      request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> createNewCompany(
      CreateNewDeliveryCompanyRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.post(
      Urls.EXTERNAL_DELIVERY_COMPANY,
      request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteCompany(
      DeleteDeliveryCompanyRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.delete(
      Urls.EXTERNAL_DELIVERY_COMPANY,
      payLoad: request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCompanyStatus(
      UpdateDeliveryCompanyStatusRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.put(
      Urls.EXTERNAL_DELIVERY_COMPANY_STATUS,
      request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<DeliveryCompaniesResponse?> getAllCompanies() async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.FETCH_EXTERNAL_DELIVERY_COMPANY,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return DeliveryCompaniesResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCompanyCriterial(
      UpdateCompanyCriterialRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.put(
      Urls.EXTERNAL_DELIVERY_COMPANY_CRITERIA,
      request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> createCompanyCriterial(
      CreateCompanyCriteria request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.post(
      Urls.EXTERNAL_DELIVERY_COMPANY_CRITERIA,
      request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteCompanyCriterial(
      DeleteCompanyCriterialRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.delete(
      Urls.EXTERNAL_DELIVERY_COMPANY_CRITERIA,
      payLoad: request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateCompanyCriterialStatus(
      UpdateCompanyCriterialStatusRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.put(
      Urls.EXTERNAL_DELIVERY_COMPANY_CRITERIA_STATUS,
      request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<DeliveryCompanyCriteriaResponse?> getCompanyCriterial(
      int companyId) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.EXTERNAL_DELIVERY_COMPANY_CRITERIA + '/$companyId',
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return DeliveryCompanyCriteriaResponse.fromJson(response);
  }

  Future<FeatureResponse?> getFeatureStatus() async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.SEND_ORDER_TO_EXTERNAL_PARTY,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return FeatureResponse.fromJson(response);
  }

  Future<ActionResponse?> updateFeatureStatus(FeatureRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.put(
      Urls.APP_FEATURE_STATUS_BY_ADMIN,
      request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> assignOrderToExternalCompany(
      AssignOrderToExternalCompanyRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.post(
      Urls.EXTERNAL_DELIVERY_ODER_BY_ADMIN,
      request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<ExternalOrderResponse?> getExternalOrders(
      ExternalOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.FILTER_EXTERNAL_ORDERS_BY_ADMIN,
      request.toMap(),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return ExternalOrderResponse.fromJson(response);
  }

  Future<NaherEvanCaptainsResponse?> getNaherEvanCaptains() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.GET_NAHER_EVAN_CAPTAINS,
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) return null;
    return NaherEvanCaptainsResponse.fromJson(response);
  }

  Future<NaherEvanCaptainResponse?> getNaherEvanCaptain(
      NaherEvanCaptainRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.GET_NAHER_EVAN_CAPTAIN,
      await request.toMap(),
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) return null;
    return NaherEvanCaptainResponse.fromJson(response);
  }
}

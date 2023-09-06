import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_external_delivery_companies/repository/external_delivery_companies_repository.dart';
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
import 'package:c4d/module_external_delivery_companies/response/delivery_companies_response/delivery_companies_response.dart';
import 'package:c4d/module_external_delivery_companies/response/delivery_company_criteria_response/delivery_company_criteria_response.dart';
import 'package:c4d/module_external_delivery_companies/response/external_order_response/order_pending_response.dart';
import 'package:c4d/module_external_delivery_companies/response/feature_response/feature_response/feature_response.dart';
import 'package:c4d/module_external_delivery_companies/response/naher_evan_captains_response/naher_evan_captains_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExternalDeliveryCompaniesManager {
  final ExternalDeliveryCompaniesRepository _repository;

  ExternalDeliveryCompaniesManager(this._repository);

  Future<ActionResponse?> updateCompany(UpdateDeliveryCompanyRequest request) =>
      _repository.updateCompany(request);

  Future<ActionResponse?> createNewCompany(
          CreateNewDeliveryCompanyRequest request) =>
      _repository.createNewCompany(request);

  Future<ActionResponse?> deleteCompany(DeleteDeliveryCompanyRequest request) =>
      _repository.deleteCompany(request);

  Future<ActionResponse?> updateCompanyStatus(
          UpdateDeliveryCompanyStatusRequest request) =>
      _repository.updateCompanyStatus(request);

  Future<DeliveryCompaniesResponse?> getAllCompanies() =>
      _repository.getAllCompanies();

  Future<ActionResponse?> updateCompanyCriterial(
          UpdateCompanyCriterialRequest request) =>
      _repository.updateCompanyCriterial(request);

  Future<ActionResponse?> createCompanyCriterial(
          CreateCompanyCriteria request) =>
      _repository.createCompanyCriterial(request);

  Future<ActionResponse?> deleteCompanyCriterial(
          DeleteCompanyCriterialRequest request) =>
      _repository.deleteCompanyCriterial(request);

  Future<ActionResponse?> updateCompanyCriterialStatus(
          UpdateCompanyCriterialStatusRequest request) =>
      _repository.updateCompanyCriterialStatus(request);

  Future<DeliveryCompanyCriteriaResponse?> getCompanyCriterial(int companyId) =>
      _repository.getCompanyCriterial(companyId);

  Future<FeatureResponse?> getFeatureStatus() => _repository.getFeatureStatus();

  Future<ActionResponse?> updateFeatureStatus(FeatureRequest request) =>
      _repository.updateFeatureStatus(request);

  Future<ActionResponse?> assignOrderToExternalCompany(
          AssignOrderToExternalCompanyRequest request) =>
      _repository.assignOrderToExternalCompany(request);

  Future<ExternalOrderResponse?> getExternalOrders(
          ExternalOrderRequest request) =>
      _repository.getExternalOrders(request);

  Future<NaherEvanCaptainsResponse?> getNaherEvanCaptains() =>
      _repository.getNaherEvanCaptains();
}

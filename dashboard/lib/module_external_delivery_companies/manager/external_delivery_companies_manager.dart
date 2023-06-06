import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_external_delivery_companies/repository/external_delivery_companies_repository.dart';
import 'package:c4d/module_external_delivery_companies/request/create_new_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/delete_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/update_delivery_company_status_request.dart';
import 'package:c4d/module_external_delivery_companies/request/update_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/response/delivery_companies_response/delivery_companies_response.dart';
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
}

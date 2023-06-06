import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/manager/external_delivery_companies_manager.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/request/create_new_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/delete_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/update_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/update_delivery_company_status_request.dart';
import 'package:c4d/module_external_delivery_companies/response/delivery_companies_response/delivery_companies_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExternalDeliveryCompaniesService {
  final ExternalDeliveryCompaniesManager _manager;

  ExternalDeliveryCompaniesService(this._manager);

  Future<DataModel> updateCompany(UpdateDeliveryCompanyRequest request) async {
    ActionResponse? response = await _manager.updateCompany(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> createNewCompany(
      CreateNewDeliveryCompanyRequest request) async {
    ActionResponse? response = await _manager.createNewCompany(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deleteCompany(DeleteDeliveryCompanyRequest request) async {
    ActionResponse? response = await _manager.deleteCompany(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateCompanyStatus(
      UpdateDeliveryCompanyStatusRequest request) async {
    ActionResponse? response = await _manager.updateCompanyStatus(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getAllCompanies() async {
    DeliveryCompaniesResponse? response = await _manager.getAllCompanies();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return CompanyModel.withData(response);
  }
}

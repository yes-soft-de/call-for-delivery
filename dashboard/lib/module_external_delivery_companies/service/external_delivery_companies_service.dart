import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/manager/external_delivery_companies_manager.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/model/external_order.dart';
import 'package:c4d/module_external_delivery_companies/model/feature_model.dart';
import 'package:c4d/module_external_delivery_companies/model/naher_evan_captain_model.dart';
import 'package:c4d/module_external_delivery_companies/model/naher_evan_captains_model.dart';
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
import 'package:c4d/module_external_delivery_companies/request/naher_evan_cpatain_request/naher_evan_cpatain_request.dart';
import 'package:c4d/module_external_delivery_companies/response/delivery_companies_response/delivery_companies_response.dart';
import 'package:c4d/module_external_delivery_companies/response/delivery_company_criteria_response/delivery_company_criteria_response.dart';
import 'package:c4d/module_external_delivery_companies/response/external_order_response/order_pending_response.dart';
import 'package:c4d/module_external_delivery_companies/response/feature_response/feature_response/feature_response.dart';
import 'package:c4d/module_external_delivery_companies/response/naher_evan_captain_response/naher_evan_captain_response.dart';
import 'package:c4d/module_external_delivery_companies/response/naher_evan_captains_response/naher_evan_captains_response.dart';
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
      String? companyName = _extractCompanyNameFromActionResponse(response);
      return DataModel.withError(
        StatusCodeHelper.getStatusCodeMessages(
          response.statusCode,
          optionalMessage: companyName,
        ),
      );
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

  Future<DataModel> updateCompanyCriterial(
      UpdateCompanyCriterialRequest request) async {
    ActionResponse? response = await _manager.updateCompanyCriterial(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      String? companyName = _extractCompanyNameFromActionResponse(response);
      return DataModel.withError(
        StatusCodeHelper.getStatusCodeMessages(
          response.statusCode,
          optionalMessage: companyName,
        ),
      );
    }
    return DataModel.empty();
  }

  Future<DataModel> createCompanyCriterial(
      CreateCompanyCriteria request) async {
    ActionResponse? response = await _manager.createCompanyCriterial(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      String? companyName = _extractCompanyNameFromActionResponse(response);

      return DataModel.withError(
        StatusCodeHelper.getStatusCodeMessages(
          response.statusCode,
          optionalMessage: companyName,
        ),
      );
    }
    return DataModel.empty();
  }

  Future<DataModel> deleteCompanyCriterial(
      DeleteCompanyCriterialRequest request) async {
    ActionResponse? response = await _manager.deleteCompanyCriterial(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateCompanyCriterialStatus(
      UpdateCompanyCriterialStatusRequest request) async {
    ActionResponse? response =
        await _manager.updateCompanyCriterialStatus(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      String? companyName = _extractCompanyNameFromActionResponse(response);
      return DataModel.withError(
        StatusCodeHelper.getStatusCodeMessages(
          response.statusCode,
          optionalMessage: companyName,
        ),
      );
    }
    return DataModel.empty();
  }

  Future<DataModel> getCompanyCriterial(int companyId) async {
    DeliveryCompanyCriteriaResponse? response =
        await _manager.getCompanyCriterial(companyId);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    // if (response.data == null) return DataModel.empty();
    return CompanySetting.withData(response);
  }

  Future<DataModel> getFeatureStatus() async {
    FeatureResponse? response = await _manager.getFeatureStatus();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return FeatureModel.withData(response);
  }

  Future<DataModel> updateFeatureStatus(FeatureRequest request) async {
    ActionResponse? response = await _manager.updateFeatureStatus(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> assignOrderToExternalCompany(
      AssignOrderToExternalCompanyRequest request) async {
    ActionResponse? response =
        await _manager.assignOrderToExternalCompany(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      return DataModel.withError(
          _getAssignOrderToExternalCompanyMessage(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getExternalOrders(ExternalOrderRequest request) async {
    ExternalOrderResponse? response = await _manager.getExternalOrders(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          _getAssignOrderToExternalCompanyMessage(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return ExternalOrder.withData(response);
  }

  Future<DataModel> getNaherEvanCaptains() async {
    NaherEvanCaptainsResponse? _ordersResponse =
        await _manager.getNaherEvanCaptains();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return NaherEvanCaptainsModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> getNaherEvanCaptain(NaherEvanCaptainRequest request) async {
    NaherEvanCaptainResponse? _ordersResponse =
        await _manager.getNaherEvanCaptain(request);
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return NaherEvanCaptainModel.withData(_ordersResponse);
  }
}

String _getAssignOrderToExternalCompanyMessage(String? statusCode) {
  if (statusCode == '9055') return S.current.externalCompanyNotExist;
  if (statusCode == '9052') return S.current.companyDoesntHaveSetting;

  return StatusCodeHelper.getStatusCodeMessages(statusCode);
}

/// in case the response was to dynamic
String? _extractCompanyNameFromActionResponse(ActionResponse response) {
  var data = response.data;
  if (data == null) return null;
  String result = '';
  if (data is List) {
    data.forEach(
      (element) {
        if (element['externalCompanyName'] is String) {
          result += element['externalCompanyName'] + ', ';
        }
      },
    );
    return result;
  }
  return null;
}

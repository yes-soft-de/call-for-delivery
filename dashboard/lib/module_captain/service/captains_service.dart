import 'package:c4d/module_captain/manager/captains_manager.dart';
import 'package:c4d/module_captain/model/captain_balance_model.dart';
import 'package:c4d/module_captain/model/captain_financial_dues.dart';
import 'package:c4d/module_captain/model/captain_need_support.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:c4d/module_captain/model/captain_rating_model.dart';
import 'package:c4d/module_captain/model/captains_order_model.dart';
import 'package:c4d/module_captain/model/inActiveModel.dart';
import 'package:c4d/module_captain/model/porfile_model.dart';
import 'package:c4d/module_captain/request/assign_order_to_captain_request.dart';
import 'package:c4d/module_captain/request/captain_finance_request.dart';
import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/module_captain/request/enable_captain.dart';
import 'package:c4d/module_captain/request/enable_offer.dart';
import 'package:c4d/module_captain/request/update_captain_request.dart';
import 'package:c4d/module_captain/response/capatin_offer_response.dart';
import 'package:c4d/module_captain/response/captain_account_balance_response/captain_account_balance_response.dart';
import 'package:c4d/module_captain/response/captain_financial_dues_response/captain_financial_dues_response.dart';
import 'package:c4d/module_captain/response/captain_need_support_response/captain_need_support_response.dart';
import 'package:c4d/module_captain/response/captain_order_control_response/captain_order_control_response.dart';
import 'package:c4d/module_captain/response/captain_profile_response.dart';
import 'package:c4d/module_captain/response/captain_rating_response/captain_rating_response.dart';
import 'package:c4d/module_captain/response/in_active_captain_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class CaptainsService {
  final CaptainsManager _manager;

  CaptainsService(this._manager);

  Future<DataModel> getCaptainOffer() async {
    CaptainOfferResponse? _ordersResponse = await _manager.getCaptainOffer();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return CaptainsOffersModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> addCaptainOffer(CaptainOfferRequest request) async {
    ActionResponse? actionResponse = await _manager.addCaptainOffer(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateCaptainOffer(CaptainOfferRequest request) async {
    ActionResponse? actionResponse = await _manager.updateCaptainOffer(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> enableCaptainOffer(EnableOfferRequest request) async {
    ActionResponse? actionResponse = await _manager.enableCaptainOffer(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> updateCaptain(UpdateCaptainRequest request) async {
    ActionResponse? actionResponse = await _manager.updateCaptain(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> enableCaptain(EnableCaptainRequest request) async {
    ActionResponse? actionResponse = await _manager.enableCaptain(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deleteCaptain(String captainId) async {
    ActionResponse? actionResponse = await _manager.deleteCaptain(captainId);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> assignOrderToCaptain(
      AssignOrderToCaptainRequest request) async {
    ActionResponse? actionResponse =
        await _manager.assignOrderToCaptain(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getCaptains() async {
    CaptainResponse? _ordersResponse = await _manager.getCaptains();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return InActiveModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> getInActiveCaptains() async {
    CaptainResponse? _ordersResponse = await _manager.getInActiveCaptain();
    if (_ordersResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_ordersResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_ordersResponse.statusCode));
    }
    if (_ordersResponse.data == null) return DataModel.empty();
    return InActiveModel.withData(_ordersResponse.data!);
  }

  Future<DataModel> getCaptainProfile(int id) async {
    CaptainProfileResponse? _storeResponse =
        await _manager.getCaptainProfile(id);
    if (_storeResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_storeResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_storeResponse.statusCode));
    }
    if (_storeResponse.data == null) return DataModel.empty();
    return ProfileModel.withData(_storeResponse.data!);
  }

  Future<DataModel> getCaptainSupport() async {
    CaptainNeedSupportResponse? _clients = await _manager.getCaptainSupport();
    if (_clients == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_clients.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_clients.statusCode));
    }
    if (_clients.data == null) return DataModel.empty();
    return CaptainNeedSupportModel.withData(_clients.data!);
  }

  Future<DataModel> getCaptainOrder() async {
    CaptainOrderControlResponse? _clients = await _manager.getCaptainsOrder();
    if (_clients == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_clients.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_clients.statusCode));
    }
    if (_clients.data == null) return DataModel.empty();
    return CaptainOrderModel.withData(_clients);
  }

  Future<DataModel> getCaptainAccountBalance(int captainID) async {
    CaptainAccountBalanceResponse? actionResponse =
        await _manager.getCaptainAccountBalance(captainID);
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return CaptainAccountBalanceModel.withData(actionResponse);
  }

  Future<DataModel> captainFinancePlanStatus(
      CaptainFinanceRequest request) async {
    ActionResponse? actionResponse =
        await _manager.captainFinancePlanStatus(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getCaptainFinancialDues(int captainID) async {
    CaptainFinancialDuesResponse? actionResponse =
        await _manager.getCaptainFinancialDues(captainID);
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
    return CaptainFinancialDuesModel.withData(actionResponse);
  }

  Future<DataModel> getCaptainRating() async {
    CaptainRatingResponse? actionResponse = await _manager.getCaptainRating();
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
    return CaptainRatingModel.withData(actionResponse);
  }
}

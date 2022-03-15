import 'package:c4d/module_captain/manager/captains_manager.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/module_captain/response/capatin_offer_response.dart';
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
    CaptainOfferResponse? _ordersResponse =
        await _manager.getCaptainOffer();
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
    ActionResponse? actionResponse =
        await _manager.addCaptainOffer(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
  Future<DataModel> updateCaptainOffer(
      CaptainOfferRequest request) async {
    ActionResponse? actionResponse =
    await _manager.updateCaptainOffer(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}

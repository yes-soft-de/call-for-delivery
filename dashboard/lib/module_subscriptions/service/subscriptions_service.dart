import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_subscriptions/manager/subscriptions_manager.dart';
import 'package:c4d/module_subscriptions/model/store_subscriptions_financial.dart';
import 'package:c4d/module_subscriptions/request/store_captain_offer_request.dart';
import 'package:c4d/module_subscriptions/request/store_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/response/subscriptions_financial_response/subscriptions_financial_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class SubscriptionsService {
  final SubscriptionsManager _storeManager;

  SubscriptionsService(this._storeManager);

  Future<DataModel> getSubscriptionsFinance(int storeID) async {
    SubscriptionsFinancialResponse? response =
        await _storeManager.getSubscriptionsFinance(storeID);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return StoreSubscriptionsFinanceModel.withData(response);
  }

  Future<DataModel> renewPackage(int storeID) async {
    ActionResponse? response = await _storeManager.renewPackage(storeID);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deleteFutureSubscriptions(int storeID) async {
    ActionResponse? response =
        await _storeManager.deleteFutureSubscriptions(storeID);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> extendPackage(int storeID) async {
    ActionResponse? response = await _storeManager.extendPackage(storeID);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> subscribePackage(
      StoreSubscribeToPackageRequest request) async {
    ActionResponse? response = await _storeManager.subscribeToPackage(request);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> subscribeToCaptainOffer(
      StoreSubscribeToCaptainOfferRequest request) async {
    ActionResponse? response =
        await _storeManager.subscribeToCaptainOffer(request);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }
}

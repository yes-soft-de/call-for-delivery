import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/manager/subscription_manager.dart';
import 'package:c4d/module_subscription/model/can_make_order_model.dart';
import 'package:c4d/module_subscription/model/captain_offers_model.dart';
import 'package:c4d/module_subscription/model/new_subscription_balance_model.dart';
import 'package:c4d/module_subscription/model/packages.model.dart';
import 'package:c4d/module_subscription/model/packages_categories_model.dart';
import 'package:c4d/module_subscription/model/store_subscriptions_financial.dart';
import 'package:c4d/module_subscription/model/subscription_balance_model.dart';
import 'package:c4d/module_subscription/response/can_make_order_response/can_make_order_response.dart';
import 'package:c4d/module_subscription/response/captain_offers_response/captain_offers_response.dart';
import 'package:c4d/module_subscription/response/new_subscription_balance_response/new_subscription_balance_response.dart';
import 'package:c4d/module_subscription/response/package_categories_response/package_categories_response.dart';
import 'package:c4d/module_subscription/response/packages/packages_response.dart';
import 'package:c4d/module_subscription/response/subscription_balance_response/subscription_balance_response.dart';
import 'package:c4d/module_subscription/response/subscriptions_financial_response/subscriptions_financial_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionService {
  final SubscriptionsManager _manager;

  SubscriptionService(
    this._manager,
  );

  Future<DataModel> getPackages() async {
    PackagesResponse? response = await _manager.getPackages();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return PackageModel.withData(response);
  }

  Future<DataModel> getCategoriesPackages() async {
    PackageCategoriesResponse? response =
        await _manager.getPackagesCategories();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return PackageCategoriesModel.withData(response);
  }

  Future<DataModel> getSubscriptionBalance() async {
    SubscriptionBalanceResponse? response =
        await _manager.getSubscriptionBalance();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return SubscriptionBalanceModel.withData(response);
  }

  Future<DataModel> getNewSubscriptionBalance() async {
    NewSubscriptionBalanceResponse? response =
        await _manager.getNewSubscriptionBalance();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return NewSubscriptionBalanceModel.withData(response);
  }

  Future<DataModel> getCaptainsOffers() async {
    CaptainOffersResponse? response = await _manager.getCaptainsOffers();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return CaptainsOffersModel.withData(response);
  }

  Future<DataModel> subscribePackage(int packageId) async {
    ActionResponse? response = await _manager.subscribePackage(packageId);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> renewPackage(int packageId) async {
    ActionResponse? response = await _manager.renewPackage(packageId);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> subscribeToCaptainOffer(int offerID) async {
    ActionResponse? response = await _manager.subscribeToCaptainOffer(offerID);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> extendPackage() async {
    ActionResponse? response = await _manager.extendPackage();
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getMakingOrderAbility() async {
    CanMakeOrderResponse? response = await _manager.canMakeOrder();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return CanMakeOrderModel.withData(response);
  }

  Future<DataModel> getSubscriptionsFinance() async {
    SubscriptionsFinancialResponse? response =
        await _manager.getSubscriptionsFinance();
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
}

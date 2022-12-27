import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_subscriptions/repository/subscriptions_repository.dart';
import 'package:c4d/module_subscriptions/request/delete_captain_offer_request.dart';
import 'package:c4d/module_subscriptions/request/delete_subscription_request.dart';
import 'package:c4d/module_subscriptions/request/store_captain_offer_request.dart';
import 'package:c4d/module_subscriptions/request/store_edit_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/request/store_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/response/subscriptions_financial_response/subscriptions_financial_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionsManager {
  final SubscriptionsRepository _storesRepository;
  SubscriptionsManager(this._storesRepository);
  Future<SubscriptionsFinancialResponse?> getSubscriptionsFinance(
          int orderID) async =>
      await _storesRepository.getSubscriptionsFinance(orderID);
  Future<ActionResponse?> renewPackage(int storeID) async =>
      await _storesRepository.renewPackage(storeID);
  Future<ActionResponse?> deleteFutureSubscriptions(int storeID) async =>
      await _storesRepository.deleteFutureSubscriptions(storeID);
  Future<ActionResponse?> extendPackage(int storeID) async =>
      await _storesRepository.extendSubscriptions(storeID);
  Future<ActionResponse?> subscribeToPackage(
          StoreSubscribeToPackageRequest request) async =>
      await _storesRepository.subscribeToPackage(request);
  Future<ActionResponse?> editSubscribeToPackage(
          EditStoreSubscribeToPackageRequest request) async =>
      await _storesRepository.editSubscribeToPackage(request);
  Future<ActionResponse?> deleteCaptainOffer(
          DeleteCaptainOfferSubscriptionsRequest request) async =>
      await _storesRepository.deleteCaptainOffer(request);
  Future<ActionResponse?> deleteSubscription(
          DeleteSubscriptionsRequest request) async =>
      await _storesRepository.deleteSubscription(request);
  Future<ActionResponse?> subscribeToCaptainOffer(
          StoreSubscribeToCaptainOfferRequest request) async =>
      await _storesRepository.subscribeToCaptainOffer(request);
}

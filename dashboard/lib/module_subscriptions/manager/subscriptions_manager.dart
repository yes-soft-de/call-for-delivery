import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_subscriptions/repository/subscriptions_repository.dart';
import 'package:c4d/module_subscriptions/response/subscriptions_financial_response/subscriptions_financial_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionsManager {
  final SubscriptionsRepository _storesRepository;
  SubscriptionsManager(this._storesRepository);
  Future<SubscriptionsFinancialResponse?> getSubscriptionsFinance(
          int orderID) async =>
      await _storesRepository.getSubscriptionsFinance(orderID);
  Future<ActionResponse?> renewPackage(int packageId) async =>
      await _storesRepository.renewPackage(packageId);
  Future<ActionResponse?> extendPackage() async =>
      await _storesRepository.extendSubscriptions();
}

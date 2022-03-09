import 'package:c4d/module_subscription/repository/subscription_repository.dart';
import 'package:c4d/module_subscription/response/package_categories_response/package_categories_response.dart';
import 'package:c4d/module_subscription/response/packages/packages_response.dart';
import 'package:c4d/module_subscription/response/subscription_balance_response/subscription_balance_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubscriptionsManager {
  final SubscriptionsRepository _repository;

  SubscriptionsManager(this._repository);

  Future<PackagesResponse?> getPackages() async =>
      await _repository.getPackages();
  Future<SubscriptionBalanceResponse?> getSubscriptionBalance() async =>
      await _repository.getSubscriptionBalance();
  Future<PackageCategoriesResponse?> getPackagesCategories() async =>
      await _repository.getPackagesCategories();

  Future<ActionResponse?> subscribePackage(int packageId) async =>
      await _repository.subscribePackage(packageId);
  Future<ActionResponse?> renewPackage(int packageId) async =>
      await _repository.renewPackage(packageId);
  Future<ActionResponse?> extendPackage() async =>
      await _repository.extendSubscriptions();
}

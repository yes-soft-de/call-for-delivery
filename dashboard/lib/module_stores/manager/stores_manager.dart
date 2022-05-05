import 'package:c4d/module_stores/request/active_store_request.dart';
import 'package:c4d/module_stores/request/captain_not_arrived_request.dart';
import 'package:c4d/module_stores/request/order_filter_request.dart';
import 'package:c4d/module_stores/response/order/order_captain_not_arrived/orders_not_arrived_response.dart';
import 'package:c4d/module_stores/response/order/order_details_response/order_details_response.dart';
import 'package:c4d/module_stores/response/order/orders_response/orders_response.dart';
import 'package:c4d/module_stores/response/store_need_support_response/store_need_support_response.dart';
import 'package:c4d/module_stores/response/subscriptions_financial_response/subscriptions_financial_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_stores/repository/stores_repository.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/response/store_balance_response/store_balance_response.dart';
import 'package:c4d/module_stores/response/store_profile_response.dart';
import 'package:c4d/module_stores/response/stores_response.dart';

@injectable
class StoreManager {
  final StoresRepository _storesRepository;

  StoreManager(this._storesRepository);

  Future<StoresResponse?> getStores() => _storesRepository.getStores();
  Future<StoresResponse?> getStoresInActive() =>
      _storesRepository.getStoresInActive();
  Future<StoreProfileResponse?> getStoreProfile(int id) =>
      _storesRepository.getStoreProfile(id);
  Future<ActionResponse?> updateStore(UpdateStoreRequest request) =>
      _storesRepository.updateStore(request);
  Future<StoreBalanceResponse?> getStoreAccountBalance(int id) =>
      _storesRepository.getStoreAccountBalance(id);

  Future<ActionResponse?> enableStore(ActiveStoreRequest request) =>
      _storesRepository.enableStore(request);

  Future<StoreNeedSupportResponse?> getStoreSupport() =>
      _storesRepository.getStoreSupport();

  Future<OrdersResponse?> getStoreOrdersFilter(FilterOrderRequest request) =>
      _storesRepository.getStoreOrdersFilter(request);
  Future<OrderCaptainResponse?> getOrdersNotArrivedCaptainFilter(
          FilterOrderCaptainNotArrivedRequest request) =>
      _storesRepository.getOrdersNotArrivedCaptainFilter(request);
  Future<OrderDetailsResponse?> getOrderDetails(int orderId) =>
      _storesRepository.getOrderDetails(orderId);
  Future<SubscriptionsFinancialResponse?> getSubscriptionsFinance(
          int orderID) async =>
      await _storesRepository.getSubscriptionsFinance(orderID);
}

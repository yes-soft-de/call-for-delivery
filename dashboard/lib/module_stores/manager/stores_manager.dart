import 'package:c4d/module_stores/request/active_store_request.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_stores/repository/stores_repository.dart';
import 'package:c4d/module_stores/request/create_store_request.dart';
import 'package:c4d/module_stores/request/store_payment_request.dart';
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
  Future<ActionResponse?> createStorePayment(StorePaymentRequest request) =>
      _storesRepository.createStorePayments(request);
  Future<ActionResponse?> deleteStorePayment(String id) =>
      _storesRepository.deleteStorePayments(id);

  Future<ActionResponse?> enableStore(ActiveStoreRequest request) =>
      _storesRepository.enableStore(request);
}

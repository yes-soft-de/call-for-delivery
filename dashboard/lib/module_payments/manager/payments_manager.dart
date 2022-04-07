import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_payments/repository/payments_repository.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/response/store_payments_response/store_payments_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentsManager {
  final PaymentsRepository _paymentsRepository;

  PaymentsManager(this._paymentsRepository);
  Future<StorePaymentsResponse?> getStorePayments(int id) =>
      _paymentsRepository.getStorePayments(id);
  Future<ActionResponse?> paymentToStore(CreateStorePaymentsRequest request) =>
      _paymentsRepository.paymentToStore(request);
  Future<ActionResponse?> deleteStorePayment(String id) =>
      _paymentsRepository.deleteStorePayments(id);
}

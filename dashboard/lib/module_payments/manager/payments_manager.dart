import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_payments/repository/payments_repository.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_count_order_request.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_hours.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_order_request.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';
import 'package:c4d/module_payments/response/captain_finance_by_order_counts_response/captain_finance_by_order_counts_response.dart';
import 'package:c4d/module_payments/response/captain_finance_by_order_response/captain_finance_by_order_response.dart';
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
  /* ---------------------------------- CAPTAIN FINANCE --------------------------------------- */
  /* GET */
  Future<CaptainFinanceByOrderResponse?> getCaptainFinanceByOrder() =>
      _paymentsRepository.getCaptainFinanceByOrder();
  Future<CaptainFinanceByHoursResponse?> getCaptainFinanceByHour() =>
      _paymentsRepository.getCaptainFinanceByHour();
  Future<CaptainFinanceByOrderCountsResponse?>
      getCaptainFinanceByOrderCounts() =>
          _paymentsRepository.getCaptainFinanceByOrderCounts();
  /* CREATE */
  Future<ActionResponse?> createCaptainFinanceByOrder(
          CreateCaptainFinanceByOrderRequest request) =>
      _paymentsRepository.createCaptainFinanceByOrder(request);
  Future<ActionResponse?> createCaptainFinanceByHour(
          CreateCaptainFinanceByHoursRequest request) =>
      _paymentsRepository.createCaptainFinanceByHour(request);
  Future<ActionResponse?> createCaptainFinanceByOrderCounts(
          CreateCaptainFinanceByCountOrderRequest request) =>
      _paymentsRepository.createCaptainFinanceByOrderCounts(request);
}

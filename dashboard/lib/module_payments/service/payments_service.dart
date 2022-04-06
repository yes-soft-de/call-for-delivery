import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/manager/payments_manager.dart';
import 'package:c4d/module_payments/model/store_balance_model.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/response/store_payments_response/store_payments_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentsService {
  final PaymentsManager _paymentsManager;

  PaymentsService(this._paymentsManager);

  Future<DataModel> paymentToStore(CreateStorePaymentsRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.paymentToStore(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
    Future<DataModel> updateStorePayments(CreateStorePaymentsRequest request) async {
    ActionResponse? actionResponse =
        await _paymentsManager.updateStorePayments(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> getStorePayments(int id) async {
    StorePaymentsResponse? actionResponse =
        await _paymentsManager.getStorePayments(id);
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return StoreBalanceModel.withData(actionResponse.data ?? []);
  }

}

import 'package:c4d/module_stores/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/manager/stores_manager.dart';
import 'package:c4d/module_stores/request/store_payment_request.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class StorePaymentsService {
  final StoreManager _storeManager;
  StorePaymentsService(this._storeManager);

  Future<DataModel> paymentToStore(StorePaymentRequest request) async {
    ActionResponse? actionResponse =
        await _storeManager.createStorePayment(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deletePaymentToStore(String id) async {
    ActionResponse? actionResponse = await _storeManager.deleteStorePayment(id);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '401') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}

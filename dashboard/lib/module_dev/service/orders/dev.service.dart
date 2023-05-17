import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_dev/manager/dev_manager.dart';
import 'package:c4d/module_dev/request/create_test_order_request.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class DevService {
  final DevManager _devManager;
  DevService(this._devManager);

  Future<DataModel> createOrder(CreateTestOrderRequest request) async {
    ActionResponse? response = await _devManager.createOrder(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return DataModel.empty();
  }

}

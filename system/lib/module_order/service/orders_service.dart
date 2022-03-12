import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_order/manager/order_manager.dart';
import 'package:c4d/module_order/request/order_state_request.dart';
import 'package:c4d/module_users/request/update_pass_request.dart';
import 'package:c4d/module_users/model/users_model.dart';
import 'package:c4d/module_users/request/filter_user_request.dart';
import 'package:c4d/module_users/response/action_response.dart';
import 'package:c4d/module_users/response/users_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersService {
  final OrdersManager _manager;

  OrdersService(this._manager);


  Future<DataModel> updateStatus(UpdateOrderStateRequest request) async {
    ActionResponse? actionResponse =
    await _manager.updateStatus(request);

    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '204') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}
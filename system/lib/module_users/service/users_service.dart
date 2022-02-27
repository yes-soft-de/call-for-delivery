import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_users/request/update_pass_request.dart';
import 'package:c4d/module_users/manager/users_manager.dart';
import 'package:c4d/module_users/model/users_model.dart';
import 'package:c4d/module_users/request/filter_user_request.dart';
import 'package:c4d/module_users/response/action_response.dart';
import 'package:c4d/module_users/response/users_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:injectable/injectable.dart';

@injectable
class UsersService {
  final UsersManager _manager;

  UsersService(this._manager);

  Future<DataModel> getUsers(FilterUserRequest request) async {
    UsersResponse? _response = await _manager.getUsers(request);
    if (_response == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (_response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(_response.statusCode));
    }
    return UsersModel.withData(_response.data!);
  }

  Future<DataModel> updatePassword(UpdatePassRequest request) async {
    ActionResponse? actionResponse =
    await _manager.updatePassword(request);

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
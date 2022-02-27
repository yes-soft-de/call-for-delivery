import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_users/request/update_pass_request.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_users/request/filter_user_request.dart';
import 'package:c4d/module_users/response/action_response.dart';
import 'package:c4d/module_users/response/users_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class UsersRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  UsersRepository(
      this._apiClient,
      this._authService,
      );

  Future<UsersResponse?> getUsers(FilterUserRequest request) async {
      var token = await _authService.getToken();
      dynamic response = await _apiClient.post(
        Urls.GET_USERS,
        request.toJson(),
        headers: {'Authorization': 'Bearer ' + '$token'},
      );
      if (response == null) return null;
      return UsersResponse.fromJson(response);
    }

  Future<ActionResponse?> updatePassword(UpdatePassRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(Urls.UPDATE_USER_PASSWORD,request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}
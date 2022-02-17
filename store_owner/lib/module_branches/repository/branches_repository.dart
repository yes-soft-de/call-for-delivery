import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/response/branches/branches_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class BranchesRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  BranchesRepository(this._apiClient, this._authService);

  Future<ActionResponse?> updateBranch(UpdateBranchesRequest request) async {
    var token = await _authService.getToken();
    var response = await _apiClient.put(
      Urls.UPDATE_BRANCH_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + '$_apiClient'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<BranchListResponse?> getBranches() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.UPDATE_BRANCH_API,
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return BranchListResponse.fromJson(response);
  }

  Future<ActionResponse?> createBranch(CreateBrancheRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.UPDATE_BRANCH_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

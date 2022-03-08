import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/create_list_branches/create_list_branches.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/response/branches/branches_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
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
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<BranchListResponse?> getBranches(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.GET_BRANCHES_API + '$id',
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return BranchListResponse.fromJson(response);
  }

  Future<ActionResponse?> createBranch(CreateListBranchesRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.CREATE_BRANCH_LIST_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> addBranch(CreateListBranchesRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.CREATE_BRANCH_LIST_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteBranch(int id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.DELETE_BRANCH_API,
      {'id': id, 'isActive': '0'},
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/response/get_branches_response.dart';
import 'package:c4d/module_profile/response/get_records_response.dart';
import 'package:c4d/module_profile/response/profile_response/profile_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ProfileRepository(
    this._apiClient,
    this._authService,
  );

  Future<ProfileResponse?> getOwnerProfile() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.OWNER_PROFILE_API,
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;

    return ProfileResponse.fromJson(response);
  }

  Future<Branch?> createBranch(CreateBranchRequest createBranch) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.BRANCHES_API,
      createBranch.toJson(),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;

    return CreateBranchResponse.fromJson(response).data;
  }

  Future<List<Branch>?> getMyBranches() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.BRANCHES_API,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;

    return GetBranchesResponse.fromJson(response).data;
  }

  Future<List<ActivityRecord>?> getUserActivityLog() async {
    await _authService.refreshToken();
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.LOG_API,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;

    return GetRecordsResponse.fromJson(response).data;
  }

// new repo function shape

  Future<ActionResponse?> createOwnerProfile(
      ProfileRequest profileRequest) async {
    var token = await _authService.getToken();
    var response = await _apiClient.put(
      Urls.OWNER_PROFILE_API,
      profileRequest.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

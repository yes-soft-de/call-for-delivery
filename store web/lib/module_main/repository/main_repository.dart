import 'package:store_web/consts/urls.dart';
import 'package:store_web/module_auth/service/auth_service/auth_service.dart';
import 'package:store_web/module_main/response/login_response/login_response.dart';
import 'package:store_web/module_main/response/profile_response/profile_response.dart';
import 'package:store_web/module_main/response/store_profile_response.dart';
import 'package:store_web/module_network/http_client/http_client.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/utils/response/action_response.dart';

@injectable
class MainRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  MainRepository(this._apiClient, this._authService);

  Future<LoginResponse?> getAdminToken() async {
    var result = await _apiClient.post(
      Urls.CREATE_TOKEN_API,
      {"username": "966551111111", "password": "123456"},
    );
    if (result == null) {
      return null;
    }
    return LoginResponse.fromJson(result);
  }

  Future<ActionResponse?> deleteStore(int storeId, String adminToken) async {
    var token = adminToken;
    dynamic response = await _apiClient.delete(Urls.DELETE_STORE,
        payLoad: {'storeOwnerId': storeId},
        headers: {'Authorization': 'Bearer ' + token});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ProfileResponse?> getOwnerProfile() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.GET_OWNER_PROFILE_API,
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;

    return ProfileResponse.fromJson(response);
  }

  Future<StoreProfileResponse?> getStoreProfile(
      int id, String adminToken) async {
    var token = adminToken;
    dynamic response = await _apiClient.get(
        Urls.GET_STORE_PROFILE_FOR_ADMIN + '$id',
        headers: {'Authorization': 'Bearer ' + token});
    if (response == null) return null;
    return StoreProfileResponse.fromJson(response);
  }
}

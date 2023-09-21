import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_releases_tracker/request/profile_release_request.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class ReleasesTrackerRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ReleasesTrackerRepository(
    this._apiClient,
    this._authService,
  );

  Future<ActionResponse?> checkForUpdates(ProfileReleaseRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.put(
      Urls.PROFILE_RELEASE_VERSION,
      request.toMap(),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }
}

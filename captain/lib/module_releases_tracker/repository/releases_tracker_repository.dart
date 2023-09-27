import 'package:injectable/injectable.dart';

import '../../consts/urls.dart';
import '../../module_auth/service/auth_service/auth_service.dart';
import '../../module_network/http_client/http_client.dart';
import '../request/profile_release_request.dart';
import '../response/profile_release_response/profile_release_response.dart';

@injectable
class ReleasesTrackerRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ReleasesTrackerRepository(
    this._apiClient,
    this._authService,
  );

  Future<ProfileReleaseResponse?> checkForUpdates(
      ProfileReleaseRequest request) async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.put(
      Urls.PROFILE_RELEASE_VERSION,
      request.toMap(),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;

    return ProfileReleaseResponse.fromJson(response);
  }
}

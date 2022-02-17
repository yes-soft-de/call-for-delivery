import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_home/response/check_api.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckApiRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  CheckApiRepository(
      this._apiClient,
      this._authService,
      );

  Future<CheckApiResponse?> checkApiHealth() async {
      var token = await _authService.getToken();
      dynamic response = await _apiClient.get(
        Urls.CHECK_API_HEALTH,
        headers: {'Authorization': 'Bearer ' + '$token'},
      );
      if (response == null) return null;

      return CheckApiResponse.fromJson(response);
    }
}
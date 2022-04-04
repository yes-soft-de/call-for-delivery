import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_rest_data/response/rest_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class RestDataRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  RestDataRepository(
      this._apiClient,
      this._authService,
      );

  Future<RestDataResponse?> restData() async {
      var token = await _authService.getToken();
      dynamic response = await _apiClient.post(
        Urls.REST_DATA_API,{},
        headers: {'Authorization': 'Bearer ' + '$token'},
      );
      if (response == null) return null;

      return RestDataResponse.fromJson(response);
    }
}
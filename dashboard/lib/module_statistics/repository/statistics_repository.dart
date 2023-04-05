// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_statistics/response/statistics_response/statistics_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class StatisticsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  StatisticsRepository(
    this._apiClient,
    this._authService,
  );

  Future<StatisticsResponse?> getStatistics() async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.GET_STATISTICS,
      headers: {'Authorization': 'Bearer ${token}'},
    );

    if (response == null) return null;
    return StatisticsResponse.fromJson(response);
  }
}

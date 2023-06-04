import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExternalDeliveryCompaniesRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ExternalDeliveryCompaniesRepository(
    this._apiClient,
    this._authService,
  );
}

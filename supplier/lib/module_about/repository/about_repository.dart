import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_about/request/create_appointment_request.dart';
import 'package:c4d/module_about/response/company_info_response/company_info_response.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  AboutRepository(this._apiClient, this._authService);

  Future<CompanyInfoResponse?> getCompanyInfo() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.COMPANY_API,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return null;
    return CompanyInfoResponse.fromJson(response);
  }

}

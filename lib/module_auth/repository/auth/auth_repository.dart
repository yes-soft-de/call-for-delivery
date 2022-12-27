import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:c4d/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:c4d/module_auth/request/forget_password_request/verify_new_password_request.dart';
import 'package:c4d/module_auth/request/login_request/login_request.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/request/register_request/verfy_code_request.dart';
import 'package:c4d/module_auth/response/login_response/login_response.dart';
import 'package:c4d/module_auth/response/regester_response/regester_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/utils/logger/logger.dart';

@injectable
class AuthRepository {
  final ApiClient _apiClient;
  final Logger _logger;
  AuthRepository(this._apiClient, this._logger);

  Future<RegisterResponse?> createUser(RegisterRequest request) async {
    dynamic result = await _apiClient.post(
      Urls.SIGN_UP_API,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }

  Future<RegisterResponse?> verifyUser(VerifyCodeRequest request) async {
    dynamic result = await _apiClient.post(
      Urls.VERIFY_CODE_API,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }

  Future<RegisterResponse?> checkUserIfVerified(
      VerifyCodeRequest request) async {
    dynamic result = await _apiClient.post(
      Urls.CHECK_USER_VERIFIED_API,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }

  Future<RegisterResponse?> resendCode(VerifyCodeRequest request) async {
    dynamic result = await _apiClient.post(
      Urls.RESEND_CODE_API,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }

  Future<LoginResponse?> getToken(LoginRequest loginRequest) async {
    var result = await _apiClient.post(
      Urls.CREATE_TOKEN_API,
      loginRequest.toJson(),
    );
    if (result == null) {
      return null;
    }
    return LoginResponse.fromJson(result);
  }

  Future<RegisterResponse?> checkUserType(String role, String token) async {
    dynamic result = await _apiClient.post(Urls.CHECK_USER_ROLE + '/$role', {},
        headers: {'Authorization': 'Bearer $token'});

    if (result == null) return null;

    return RegisterResponse.fromJson(result);
  }

  Future<RegisterResponse?> resetPassRequest(ResetPassRequest request) async {
    dynamic result = await _apiClient.post(
      Urls.RESET_PASSWORD,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }

  Future<RegisterResponse?> updatePassRequest(UpdatePassRequest request) async {
    dynamic result = await _apiClient.put(
      Urls.UPDATE_PASSWORD,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }

  Future<RegisterResponse?> verifyResetPassCodeRequest(
      VerifyResetPassCodeRequest request) async {
    dynamic result = await _apiClient.post(
      Urls.VERIFY_RESET_PASSWORD_CODE,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }
}

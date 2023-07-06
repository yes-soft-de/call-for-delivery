import 'package:store_web/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/module_auth/repository/auth/auth_repository.dart';
import 'package:store_web/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:store_web/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:store_web/module_auth/request/forget_password_request/verify_new_password_request.dart';
import 'package:store_web/module_auth/request/login_request/login_request.dart';
import 'package:store_web/module_auth/request/register_request/register_request.dart';
import 'package:store_web/module_auth/request/register_request/verfy_code_request.dart';
import 'package:store_web/module_auth/response/login_response/login_response.dart';
import 'package:store_web/module_auth/response/regester_response/regester_response.dart';

@injectable
class AuthManager {
  final AuthRepository _authRepository;
  AuthManager(this._authRepository);

  Future<RegisterResponse?> register(RegisterRequest registerRequest) =>
      _authRepository.createUser(registerRequest);

  Future<LoginResponse?> login(LoginRequest loginRequest) =>
      _authRepository.getToken(loginRequest);
  Future<RegisterResponse?> userTypeCheck(String role, String token) =>
      _authRepository.checkUserType(role, token);
  Future<RegisterResponse?> verify(VerifyCodeRequest registerRequest) =>
      _authRepository.verifyUser(registerRequest);

  Future<RegisterResponse?> checkUserIfVerified(
          VerifyCodeRequest registerRequest) =>
      _authRepository.checkUserIfVerified(registerRequest);
  Future<RegisterResponse?> resendCode(VerifyCodeRequest registerRequest) =>
      _authRepository.resendCode(registerRequest);

  Future<RegisterResponse?> resetPassRequest(ResetPassRequest request) =>
      _authRepository.resetPassRequest(request);

  Future<RegisterResponse?> updatePassRequest(UpdatePassRequest request) =>
      _authRepository.updatePassRequest(request);
  Future<RegisterResponse?> easyUpdatePassword(UpdatePassRequest request) =>
      _authRepository.easyUpdatePassword(request);

  Future<RegisterResponse?> verifyResetPassCodeRequest(
          VerifyResetPassCodeRequest request) =>
      _authRepository.verifyResetPassCodeRequest(request);

  Future<ActionResponse?> accountStatus() => _authRepository.accountStatus();
  Future<ActionResponse?> deleteUser() => _authRepository.deleteUser();
}

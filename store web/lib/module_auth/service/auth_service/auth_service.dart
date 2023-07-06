import 'package:store_web/abstracts/data_model/data_model.dart';
import 'package:store_web/module_main/main_routes.dart';

import 'package:store_web/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:store_web/module_auth/enums/auth_status.dart';
import 'package:store_web/module_auth/exceptions/auth_exception.dart';
import 'package:store_web/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:store_web/module_auth/presistance/auth_prefs_helper.dart';
import 'package:store_web/module_auth/request/forget_password_request/reset_password_request.dart';
import 'package:store_web/module_auth/request/forget_password_request/update_password_request.dart';
import 'package:store_web/module_auth/request/forget_password_request/verify_new_password_request.dart';
import 'package:store_web/module_auth/request/login_request/login_request.dart';
import 'package:store_web/module_auth/request/register_request/register_request.dart';
import 'package:store_web/module_auth/request/register_request/verfy_code_request.dart';
import 'package:store_web/module_auth/response/login_response/login_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:store_web/module_auth/response/regester_response/regester_response.dart';
import 'package:store_web/utils/helpers/status_code_helper.dart';

@Injectable()
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final PublishSubject<AuthStatus> _authSubject = PublishSubject<AuthStatus>();

  AuthService(
    this._prefsHelper,
    this._authManager,
  );

  bool get isLoggedIn => _prefsHelper.isSignedIn();

  Stream<AuthStatus> get authListener => _authSubject.stream;
  String get username => _prefsHelper.getUsername() ?? '';

  Future<void> loginApi(String username, String password) async {
    LoginResponse? loginResult = await _authManager.login(LoginRequest(
      username: username,
      password: password,
    ));
    if (loginResult == null) {
      await logout();
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (loginResult.statusCode == '401') {
      await logout();
      _authSubject.addError(S.current.invalidCredentials);
      throw AuthorizationException(S.current.networkError);
    } else if (loginResult.token == null) {
      await logout();
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          loginResult.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          loginResult.statusCode ?? '0'));
    }
    RegisterResponse? response =
        await _authManager.userTypeCheck('ROLE_OWNER', loginResult.token ?? '');
    if (response?.statusCode != '201') {
      await logout();
      _authSubject.addError(
          StatusCodeHelper.getStatusCodeMessages(response?.statusCode ?? '0'));
      throw AuthorizationException(
          StatusCodeHelper.getStatusCodeMessages(response?.statusCode ?? '0'));
    }
    RegisterResponse? responseVerify = await _authManager
        .checkUserIfVerified(VerifyCodeRequest(userID: username));
    if (responseVerify?.statusCode != '200') {
      _prefsHelper.setUsername(username);
      _prefsHelper.setPassword(password);
      _prefsHelper.setToken(loginResult.token);
      _authSubject.add(AuthStatus.CODE_SENT);
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          responseVerify?.statusCode ?? '0'));
    }
    _prefsHelper.setUsername(username);
    _prefsHelper.setPassword(password);
    _prefsHelper.setToken(loginResult.token);

    await accountStatus();
    if (_prefsHelper.getAccountStatusPhase() == 'userDeleted') {
      _authSubject.addError(S.current.invalidCredentials);
      throw AuthorizationException(S.current.invalidCredentials);
    }
    _authSubject.add(AuthStatus.AUTHORIZED);
  }

  Future<void> registerApi(RegisterRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse = await _authManager.register(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '201') {
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    }
    _prefsHelper.setUsername(request.userID ?? '');
    _prefsHelper.setPassword(request.password ?? '');
    //_authSubject.add(AuthStatus.CODE_SENT);
    loginApi(request.userID ?? '', request.password ?? '');
  }

  Future<void> verifyCodeApi(VerifyCodeRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse = await _authManager.verify(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '200') {
      _authSubject.add(AuthStatus.CODE_TIMEOUT);
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    }
    _authSubject.add(AuthStatus.REGISTERED);
    await loginApi(request.userID, request.password ?? '');
  }

  Future<String?> getToken() async {
    try {
      var tokenDate = _prefsHelper.getTokenDate();
      var diff = DateTime.now().difference(tokenDate).inMinutes;
      if (diff.abs() > 55) {
        throw TokenExpiredException('Token is created $diff minutes ago');
      }
      return _prefsHelper.getToken();
    } on AuthorizationException {
      _prefsHelper.deleteToken();
      await _prefsHelper.cleanAll();
      return null;
    } on TokenExpiredException {
      return await refreshToken();
    } catch (e) {
      await _prefsHelper.cleanAll();
      return null;
    }
  }

  /// refresh API token, this is done using Firebase Token Refresh
  Future<String?> refreshToken() async {
    String? username = _prefsHelper.getUsername();
    String? password = _prefsHelper.getPassword();
    if (username != null && password != null) {
      await loginApi(
        username,
        password,
      );
    }
    var token = await getToken();
    if (token != null) {
      return token;
    }
    throw const AuthorizationException('error getting token');
  }

  Future<void> logout() async {
    await _prefsHelper.cleanAll();
  }

  Future<void> updateCategoryFavorite([fource = false]) async {
    if (isLoggedIn == false) return;
  }

  Future<void> resendCode(VerifyCodeRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse = await _authManager.resendCode(request);
    if (registerResponse == null) {
//      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '201') {
      _authSubject.add(AuthStatus.UNVERIFIED);
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    } else {
      _authSubject.add(AuthStatus.CODE_RESENT);
    }
  }

  Future<void> resetPassRequest(ResetPassRequest request) async {
    request.role = 'ROLE_OWNER';
    // Create the profile in our database
    RegisterResponse? registerResponse =
        await _authManager.resetPassRequest(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '201') {
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    } else {
      _prefsHelper.setUsername(request.userID);
      _authSubject.add(AuthStatus.NOT_LOGGED_IN);
    }
  }

  Future<bool> verifyResetPassCodeRequest(
      VerifyResetPassCodeRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse =
        await _authManager.verifyResetPassCodeRequest(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '200') {
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    } else {
      _authSubject.add(AuthStatus.VERIFIED);
      return true;
    }
  }

  Future<void> updatePassword(UpdatePassRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse =
        await _authManager.updatePassRequest(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.networkError);
    } else if (registerResponse.statusCode != '204') {
      _authSubject.add(AuthStatus.UNVERIFIED);
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    } else {
      loginApi(username, request.newPassword).whenComplete(() {
        _authSubject.add(AuthStatus.PASSWORD_RESET);
      });
    }
  }

  Future<DataModel> easyResetPassword(UpdatePassRequest request) async {
    // Create the profile in our database
    RegisterResponse? registerResponse =
        await _authManager.updatePassRequest(request);
    if (registerResponse == null) {
      return DataModel.withError(S.current.networkError);
    } else if (registerResponse.statusCode != '204') {
      return DataModel.withError(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    } else {
      await loginApi(username, request.newPassword);
      return DataModel.empty();
    }
  }

  Future<void> accountStatus() async {
    var response = await _authManager.accountStatus();
    if (response?.statusCode != '200') {
      _prefsHelper.setNewAccount(false);
      switch (response?.statusCode) {
        // account  subscript with free plan
        case '9161':
          _prefsHelper.setUserCompetedProfile(MainRoutes.MAIN_SCREEN);

        default:
          _prefsHelper.setUserCompetedProfile(MainRoutes.MAIN_SCREEN);
          break;
      }
      return;
    }
    _prefsHelper.setUserCompetedProfile(MainRoutes.MAIN_SCREEN);
    return;
  }

  Future<DataModel> deleteUser() async {
    ActionResponse? response = await _authManager.deleteUser();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }
}

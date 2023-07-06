import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:store_web/module_auth/exceptions/auth_exception.dart';
import 'package:store_web/module_main/main_routes.dart';

@injectable
class AuthPrefsHelper {
  var box = Hive.box('Authorization');
  var suggestion = Hive.box('Suggestions');

  void setNewAccount(bool isNewAccount) {
    box.put('isNewAccount', isNewAccount);
  }

  /// default is false
  bool getIsNewAccount() {
    var v = box.get('isNewAccount');
    if (v is bool) {
      return v;
    }

    return false;
  }

  void setOpenWelcomeDialogWithoutPayment(
      bool openWelcomeDialogWithoutPayment) {
    box.put('openWelcomeDialogWithoutPayment', openWelcomeDialogWithoutPayment);
  }

  /// default is false
  bool getOpenWelcomeDialogWithoutPayment() {
    var v = box.get('openWelcomeDialogWithoutPayment');
    if (v is bool) {
      return v;
    }

    return false;
  }

  void setUsername(String username) {
    box.put('username', username);
  }

  String? getUsername() {
    return box.get('username');
  }

  void setPassword(String password) {
    box.put('password', password);
  }

  String? getPassword() {
    return box.get('password');
  }

  void setUserCreated(bool created) {
    box.put('created', created);
  }

  bool getUserCreated() {
    return box.get('created') ?? false;
  }

  void clearUserCreated() {
    box.delete('created');
  }

  void setUserCompetedProfile(String status) {
    box.put('account status', status);
  }

  String getAccountStatusPhase() {
    return box.get('account status') ?? MainRoutes.MAIN_SCREEN;
  }

  bool isSignedIn() {
    try {
      String? uid = getToken();
      return uid != null;
    } catch (e) {
      return false;
    }
  }

  void saveLoginCredential() {
    var username = getUsername();
    var password = getPassword();
    if (username == null || password == null) {
      return;
    }
    suggestion.put(username, password);
    List<String> users = savedUsersCredential();
    if (users.contains(username)) {
      users.removeWhere((element) => element == username);
    }
    users.add(username);
    suggestion.put('users', users);
  }

  String getSavedPasswordCredential(String user) {
    return suggestion.get(user) ?? '';
  }

  List<String> savedUsersCredential() {
    List<String> users = suggestion.get('users') ?? [];
    return users;
  }

  /// @Function saves token string
  /// @returns void
  void setToken(String? token) {
    if (token != null) {
      box.put('token', token);
      box.put(
        'token_date',
        DateTime.now().toIso8601String(),
      );
    }
  }

  void deleteToken() {
    box.delete('token');
    box.delete('token_date');
  }

  Future<void> cleanAll() async {
    await box.clear();
  }

  /// @return String Token String
  /// @throw Unauthorized Exception when token is null
  String? getToken() {
    var token = box.get('token');
    if (token == null) {
      throw AuthorizationException('Token not found');
    }
    return token;
  }

  /// @return DateTime tokenDate
  /// @throw UnauthorizedException when token date not found
  DateTime getTokenDate() {
    var dateStr = box.get('token_date');
    if (dateStr == null) {
      throw AuthorizationException('Token date not found');
    }
    return DateTime.parse(dateStr);
  }
}

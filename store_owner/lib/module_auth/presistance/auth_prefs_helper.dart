import 'package:c4d/module_orders/orders_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AuthPrefsHelper {
  var box = Hive.box('Authorization');
  var suggestion = Hive.box('Suggestions');
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
    return box.get('account status') ?? OrdersRoutes.OWNER_ORDERS_SCREEN;
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

import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class NotificationRepo {
  final ApiClient _apiClient;
  final AuthService _authService;

  NotificationRepo(this._apiClient, this._authService);

  void postToken(String? token) {
    _authService.getToken().then(
      (value) {
        if (value != null) {
          var sound =
              NotificationsPrefHelper().getNotification().split('/').last;
          _apiClient.post(
              Urls.NOTIFICATION_API, {'token': token, 'sound': sound},
              headers: {'Authorization': 'Bearer ${value}'});
        }
      },
    );
  }
}

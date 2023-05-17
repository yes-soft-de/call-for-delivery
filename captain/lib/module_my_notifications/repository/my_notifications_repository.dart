import 'package:c4d/module_my_notifications/response/update_response/update_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_my_notifications/response/my_notification_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class MyNotificationsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  MyNotificationsRepository(this._apiClient, this._authService);

  Future<MyNotificationResponse?> getMyNotification() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_MY_NOTIFICATION,
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return MyNotificationResponse.fromJson(response);
  }

  Future<UpdateResponse?> getUpdates(bool onlyNewUpdates) async {
    var token = await _authService.getToken();

    var url = Urls.GET_UPDATES;
    if (onlyNewUpdates) url += '/199';

    dynamic response =
        await _apiClient.get(url, headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return UpdateResponse.fromJson(response);
  }

  Future<ActionResponse?> deleteNotification(String id) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.delete(
        '${Urls.DELETE_MY_NOTIFICATION}/$id',
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

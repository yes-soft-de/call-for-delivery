import 'package:c4d/module_notice/request/notice_request.dart';
import 'package:c4d/module_notice/response/notice_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class NoticeRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  NoticeRepository(this._apiClient, this._authService);

  Future<NoticeResponse?> getNotice() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_NOTICE, headers: {
      'Authorization': 'Bearer ' + token.toString(),
    });
    if (response == null) return null;
    return NoticeResponse.fromJson(response);
  }

  Future<ActionResponse?> addNotice(NoticeRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_NOTICE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

  Future<ActionResponse?> updateNotice(NoticeRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_NOTICE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

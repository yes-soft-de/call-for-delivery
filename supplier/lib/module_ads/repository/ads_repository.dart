import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_ads/request/create_ads.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  AdsRepository(this._apiClient, this._authService);

  Future<ActionResponse?> updateAds(CreateAdsRequest request) async {
    var token = await _authService.getToken();
    var response = await _apiClient.put(
      Urls.CREATE_ADS,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + '$token'},
    );
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }

//  Future<BranchListResponse?> getBranches() async {
//    var token = await _authService.getToken();
//    dynamic response = await _apiClient.get(
//      Urls.BRANCHES_API,
//      headers: {'Authorization': 'Bearer ' + '$token'},
//    );
//    if (response == null) return null;
//    return BranchListResponse.fromJson(response);
//  }

}
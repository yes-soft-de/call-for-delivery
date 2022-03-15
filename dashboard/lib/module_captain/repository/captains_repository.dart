import 'package:c4d/module_captain/request/captain_offer_request.dart';
import 'package:c4d/module_captain/response/capatin_offer_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class CaptainsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  CaptainsRepository(
      this._apiClient, this._authService);

  Future<CaptainOfferResponse?> getCaptainOffer() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_OFFERS ,
        headers: {
          'Authorization': 'Bearer ' + token.toString(),
        });
    if (response == null) return null;
    return CaptainOfferResponse.fromJson(response);
  }

  Future<ActionResponse?> addCaptainOffer(
      CaptainOfferRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.CREATE_CAPTAIN_OFFERS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }



  Future<ActionResponse?> updateCaptainOffer(
      CaptainOfferRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.UPDATE_CAPTAIN_OFFERS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }




  Future<ActionResponse?> enableCaptainOffer(CaptainOfferRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        Urls.ACTIVE_PACKAGE, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }





}

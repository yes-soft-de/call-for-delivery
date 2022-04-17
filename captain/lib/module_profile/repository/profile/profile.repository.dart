import 'package:c4d/module_profile/request/captain_payments_request.dart';
import 'package:c4d/module_profile/response/captain_payments_response/captain_payments_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_init/response/create_profile_response/create_profile_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/response/terms/terms_respons.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/profile_response.dart';

@injectable
class ProfileRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ProfileRepository(
    this._apiClient,
    this._authService,
  );

  Future<ProfileResponse?> getCaptainProfile() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.CAPTAIN_PROFILE_API,
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );
    if (response == null) {
      return null;
    }
    return ProfileResponse.fromJson(response);
  }

  Future<CreateCaptainProfileResponse?> createCaptainProfile(
      ProfileRequest profileRequest) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.CREATE_CAPTAIN_PROFILE,
      profileRequest.toJSON(),
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );

    if (response == null) return null;

    return CreateCaptainProfileResponse.fromJson(response);
  }

  Future<ActionResponse?> changeCaptainStatus(bool status) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.CHANGE_CAPTAIN_PROFILE_STATUS_API,
      {'isOnline': status ? '1' : '0'},
      headers: {'Authorization': 'Bearer ' + token.toString()},
    );

    if (response == null) return null;

    return ActionResponse.fromJson(response);
  }

  Future<List<Terms>?> getTerms() async {
    var token = await _authService.getToken();
    dynamic response;

    response = await _apiClient
        .get(Urls.TERMS_CAPTAIN, headers: {'Authorization': 'Bearer $token'});

    if (response == null) return null;

    return TermsResponse.fromJson(response).data;
  }

  Future<CaptainPaymentsResponse?> getStoreAccountBalance(
      CaptainPaymentRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.GET_ACCOUNT_BALANCE_CAPTAIN, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainPaymentsResponse.fromJson(response);
  }
}

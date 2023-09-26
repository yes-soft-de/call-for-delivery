import 'package:c4d/consts/urls.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_deep_links/request/geo_distance_request.dart';
import 'package:c4d/module_deep_links/response/geo_distance_x/geo_distance_x.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeepLinkRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  DeepLinkRepository(this._apiClient, this._authService);

  Future<GeoDistanceX?> getDistance(GeoDistanceRequest g) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
        Urls.GEO_DISTANCE +
            '/${g.distance?.latitude}' +
            '/${g.distance?.longitude}' +
            '/${g.origin?.latitude}' +
            '/${g.origin?.longitude}',
        headers: {'Authorization': 'Bearer $token'});
    if (response == null) return null;
    return GeoDistanceX.fromJson(response);
  }

  Future<GeoDistanceX?> getDistanceWithDeliveryCost(
      GeoDistanceRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.GEO_DISTANCE_WITH_DELIVERY_COST,
      request.toMap(),
      headers: {'Authorization': 'Bearer $token'},
    );

    var context = GlobalVariable.navState.currentContext!;

    CustomFlushBarHelper.createSuccess(
      title: 'the result is',
      message: response.toString(),
    ).show(context);

    if (response == null) return null;

    return GeoDistanceX.fromJson(response);
  }
}

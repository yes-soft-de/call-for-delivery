import 'package:c4d/module_delivary_car/request/car_request.dart';
import 'package:c4d/module_delivary_car/response/cars_response.dart';
import 'package:c4d/module_notice/request/notice_request.dart';
import 'package:c4d/module_notice/response/notice_response.dart';
import '../../abstracts/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class CarsRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  CarsRepository(this._apiClient, this._authService);

  Future<CarsResponse?> getDeliveryCars() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_DELIVERY_CARS, headers: {
      'Authorization': 'Bearer ' + token.toString(),
    });
    if (response == null) return null;
    return CarsResponse.fromJson(response);
  }

  Future<ActionResponse?> addCar(CarRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
        Urls.ADD_DELIVERY_CARS, request.toJson(),
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return ActionResponse.fromJson(response);
  }
}

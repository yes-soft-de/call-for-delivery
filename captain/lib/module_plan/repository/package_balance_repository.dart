import 'package:c4d/module_plan/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';
import 'package:c4d/module_plan/response/captain_finance_by_order_count_response/captain_finance_by_order_count_response.dart';
import 'package:c4d/module_plan/response/captain_financeby_order_response/captain_financeby_order_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';

@injectable
class PackageBalanceRepository {
  final AuthService _authService;
  final ApiClient _apiClient;
  PackageBalanceRepository(this._authService, this._apiClient);
  /*------------------------------------------CAPTAIN FINANCE-------------------------------------------*/

  Future<CaptainFinanceByOrderResponse?> getCaptainFinanceByOrder() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_FINANCE_BY_ORDER,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainFinanceByOrderResponse.fromJson(response);
  }

  Future<CaptainFinanceByHoursResponse?> getCaptainFinanceByHours() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_FINANCE_BY_HOURS,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainFinanceByHoursResponse.fromJson(response);
  }

  Future<CaptainFinanceByOrderCountResponse?> getCaptainFinanceByCountOrder() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(Urls.GET_CAPTAIN_FINANCE_BY_COUNT_ORDER,
        headers: {'Authorization': 'Bearer ' + token.toString()});
    if (response == null) return null;
    return CaptainFinanceByOrderCountResponse.fromJson(response);
  }
}

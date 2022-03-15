import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/manager/captain_balance_manager.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/response/account_balance_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class PlanService {
  final CaptainBalanceManager _manager;
  PlanService(this._manager);

  Future<BalanceModel> getAccountBalance() async {
    AccountBalanceResponse? response = await _manager.getAccountBalance();
    if (response == null) {
      return BalanceModel.error(S.current.networkError);
    }
    String code = response.statusCode.toString();
    if (code != '200')
      return BalanceModel.error(StatusCodeHelper.getStatusCodeMessages(code));
    if (response.data == null) return BalanceModel.empty();
    return BalanceModel.withData(response.data!);
  }

  Future<BalanceModel> getAccountBalanceLastMonth() async {
    AccountBalanceResponse? response =
        await _manager.getAccountBalanceLastMonth();
    if (response == null) {
      return BalanceModel.error(S.current.networkError);
    }
    String code = response.statusCode.toString();
    if (code != '200')
      return BalanceModel.error(StatusCodeHelper.getStatusCodeMessages(code));
    if (response.data == null) return BalanceModel.empty();
    return BalanceModel.withData(response.data!);
  }
}

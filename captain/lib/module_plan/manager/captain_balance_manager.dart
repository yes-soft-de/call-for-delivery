import 'package:c4d/module_plan/request/captain_finance_request.dart';
import 'package:c4d/module_plan/response/captain_account_balance_response/captain_account_balance_response.dart';
import 'package:c4d/module_plan/response/captain_finance_by_hours_response/captain_finance_by_hours_response.dart';
import 'package:c4d/module_plan/response/captain_finance_by_order_count_response/captain_finance_by_order_count_response.dart';
import 'package:c4d/module_plan/response/captain_financeby_order_response/captain_financeby_order_response.dart';
import 'package:c4d/module_plan/response/captain_financial_dues_response/captain_financial_dues_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_plan/repository/plan_repository.dart';

@injectable
class CaptainBalanceManager {
  final PackageBalanceRepository _packageBalanceRepository;

  CaptainBalanceManager(this._packageBalanceRepository);
  Future<CaptainFinanceByOrderResponse?> getCaptainFinance() =>
      _packageBalanceRepository.getCaptainFinanceByOrder();
  Future<CaptainFinanceByHoursResponse?> getCaptainFinanceByHours() =>
      _packageBalanceRepository.getCaptainFinanceByHours();
  Future<CaptainFinanceByOrderCountResponse?> getCaptainFinanceByCountOrder() =>
      _packageBalanceRepository.getCaptainFinanceByCountOrder();
  Future<ActionResponse?> financeRequest(CaptainFinanceRequest request) =>
      _packageBalanceRepository.financeRequest(request);
  Future<CaptainAccountBalanceResponse?> getCaptainAccountBalance() =>
      _packageBalanceRepository.getCaptainAccountBalance();
  Future<CaptainFinancialDuesResponse?> getCaptainFinancialDues() =>
      _packageBalanceRepository.getCaptainFinancialDues();
}

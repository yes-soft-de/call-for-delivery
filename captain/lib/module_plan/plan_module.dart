import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_plan/ui/screen/account_balance_screen.dart';
import 'package:c4d/module_plan/ui/screen/captain_financial_details_screen.dart';
import 'package:c4d/module_plan/ui/screen/captain_financial_dues_screen.dart';
import 'package:c4d/module_plan/ui/screen/daily_payments_screen.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlanModule extends YesModule {
  final PlanScreen _planScreen;
  final AccountBalanceScreen accountBalanceScreen;
  final CaptainFinancialDuesScreen captainFinancialDuesScreen;
  final CaptainFinancialDuesDetailsScreen captainFinancialDuesDetailsScreen;
  final DailyPaymentsScreen paymentsScreen;
  PlanModule(
    this._planScreen,
    this.accountBalanceScreen,
    this.captainFinancialDuesDetailsScreen,
    this.captainFinancialDuesScreen,
    this.paymentsScreen,
  ) {
    YesModule.RoutesMap.addAll({
      // PlanRoutes.PLAN_ROUTE: (context) => _planScreen,
      PlanRoutes.BALANCE_ROUTE: (context) => accountBalanceScreen,
      PlanRoutes.CAPTAIN_FINANCIAL_DUES: (context) =>
          captainFinancialDuesScreen,
      PlanRoutes.CAPTAIN_FINANCIAL_DUES_DETAILS: (context) =>
          captainFinancialDuesDetailsScreen,
      PlanRoutes.CAPTAIN_DAILY_PAYMENTS: (context) => paymentsScreen,
    });
  }
}

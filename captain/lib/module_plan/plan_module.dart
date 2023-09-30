import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_plan/ui/screen/account_balance_screen.dart';
import 'package:c4d/module_plan/ui/screen/captain_financial_details_screen.dart';
import 'package:c4d/module_plan/ui/screen/captain_financial_dues_screen.dart';
import 'package:c4d/module_plan/ui/screen/my_profits_screen.dart';
import 'package:c4d/module_plan/ui/screen/payment_history_screen.dart';
import 'package:c4d/module_plan/ui/screen/plan_details_screen.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlanModule extends RoutingModule {
  // final PlanScreen _planScreen;
  // final DailyPaymentsScreen paymentsScreen;

  PlanModule(
      // this._planScreen,
      // this.paymentsScreen,
      ) {
    RoutingModule.RoutesMap.addAll({
      // PlanRoutes.PLAN_ROUTE: (context) => _planScreen,
      PlanRoutes.BALANCE_ROUTE: (context) => const AccountBalanceScreen(),
      PlanRoutes.CAPTAIN_FINANCIAL_DUES: (context) =>
          const CaptainFinancialDuesScreen(),
      PlanRoutes.CAPTAIN_FINANCIAL_DUES_DETAILS: (context) =>
          CaptainFinancialDuesDetailsScreen(),
      // PlanRoutes.CAPTAIN_DAILY_PAYMENTS: (context) => paymentsScreen,
      PlanRoutes.MY_PROFIT: (context) => const MyProfitsScreen(),
      PlanRoutes.PAYMENT_HISTORY: (context) => const PaymentHistoryScreen(),
      PlanRoutes.PLAN_DETAILS: (context) => const PlanDetailsScreen(),
    });
  }
}

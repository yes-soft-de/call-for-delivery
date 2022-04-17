import 'package:c4d/module_plan/ui/screen/account_balance_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';

@injectable
class PlanModule extends YesModule {
  final PlanScreen _planScreen;
  final AccountBalanceScreen accountBalanceScreen;
  PlanModule(this._planScreen, this.accountBalanceScreen) {
    YesModule.RoutesMap.addAll({
      PlanRoutes.PLAN_ROUTE: (context) => _planScreen,
      PlanRoutes.BALANCE_ROUTE: (context) => accountBalanceScreen,

    });
  }
}

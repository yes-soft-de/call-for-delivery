import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_payments/payments_routes.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_hours_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_count_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_screen.dart';
import 'package:c4d/module_payments/ui/screen/payment_to_captain_screen.dart';
import 'package:c4d/module_payments/ui/screen/store_balance_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentsModule extends YesModule {
  final CaptainFinanceByOrderScreen financeByOrderScreen;
  final CaptainFinanceByCountOrderScreen financeByCountOrderScreen;
  final CaptainFinanceByHoursScreen financeByHoursScreen;
  final PaymentsToCaptainScreen paymentsToCaptainScreen;
  final StoreBalanceScreen storeBalanceScreen;
  PaymentsModule(
      this.financeByCountOrderScreen,
      this.financeByHoursScreen,
      this.financeByOrderScreen,
      this.paymentsToCaptainScreen,
      this.storeBalanceScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      PaymentsRoutes.CAPTAIN_FINANCE_BY_ORDER: (context) =>
          financeByOrderScreen,
      PaymentsRoutes.CAPTAIN_FINANCE_BY_HOURS: (context) =>
          financeByHoursScreen,
      PaymentsRoutes.CAPTAIN_FINANCE_BY_COUNT_ORDERS: (context) =>
          financeByCountOrderScreen,
      PaymentsRoutes.PAYMENTS_TO_CAPTAIN: (context) => paymentsToCaptainScreen,
      PaymentsRoutes.PAYMENTS_LIST: (context) => storeBalanceScreen
    };
  }
}

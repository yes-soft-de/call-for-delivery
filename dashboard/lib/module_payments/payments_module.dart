import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_payments/payments_routes.dart';
import 'package:c4d/module_payments/ui/screen/all_amount_captains_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_hours_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_count_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_payment_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_previous_payments_screen.dart';
import 'package:c4d/module_payments/ui/screen/payment_to_captain_screen.dart';
import 'package:c4d/module_payments/ui/screen/store_balance_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentsModule extends YesModule {
  PaymentsModule() {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      PaymentsRoutes.CAPTAIN_FINANCE_BY_ORDER: (context) =>
          CaptainFinanceByOrderScreen(),
      PaymentsRoutes.CAPTAIN_FINANCE_BY_HOURS: (context) =>
          CaptainFinanceByHoursScreen(),
      PaymentsRoutes.CAPTAIN_FINANCE_BY_COUNT_ORDERS: (context) =>
          CaptainFinanceByCountOrderScreen(),
      PaymentsRoutes.PAYMENTS_TO_CAPTAIN: (context) =>
          PaymentsToCaptainScreen(),
      PaymentsRoutes.PAYMENTS_LIST: (context) => StoreBalanceScreen(),
      PaymentsRoutes.CAPTAIN_PAYMENT: (context) => CaptainPaymentScreen(),
      PaymentsRoutes.ALL_AMOUNT_CAPTAINS: (context) =>
          AllAmountCaptainsScreen(),
      PaymentsRoutes.CAPTAIN_PREVIOUS_PAYMENTS: (context) =>
          CaptainPreviousPaymentsScreen(),
    };
  }
}

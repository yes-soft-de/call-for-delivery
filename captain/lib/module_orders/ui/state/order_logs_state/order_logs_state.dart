import 'package:flutter/material.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';

abstract class OrderLogsState {
  final OrderLogsScreenState orderLogsScreenState;

  OrderLogsState(this.orderLogsScreenState);

  Widget getUI(BuildContext context);
}

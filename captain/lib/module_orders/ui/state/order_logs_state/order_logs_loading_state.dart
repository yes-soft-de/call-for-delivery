import 'package:flutter/material.dart';
import 'package:c4d/module_orders/ui/screens/order_logs_screen.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_state.dart';

class OrderLogsLoadingState extends OrderLogsState {
  OrderLogsLoadingState(OrderLogsScreenState screenState) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

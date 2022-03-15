import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_orders/state_manager/order_logs_state_manager.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_error_state.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_loading_state.dart';
import 'package:c4d/module_orders/ui/state/order_logs_state/order_logs_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class OrderLogsScreen extends StatefulWidget {
  final OrderLogsStateManager _stateManager;

  OrderLogsScreen(this._stateManager);

  @override
  OrderLogsScreenState createState() => OrderLogsScreenState();
}

class OrderLogsScreenState extends State<OrderLogsScreen> {
  late OrderLogsState currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 1);
    CustomFlushBarHelper.createError(
            title: S.current.warnning, message: S.current.pleaseLoginToContinue)
        .show(context);
  }

  @override
  void initState() {
    super.initState();
    currentState = OrderLogsLoadingState(this);
    widget._stateManager.getOrdersLogs(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> getOrders() async {
    widget._stateManager.getOrdersLogs(this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.orderLog,
            buttonBackground:
                currentState is OrderLogsErrorState ? Colors.red : null),
        body: currentState.getUI(context),
      ),
    );
  }
}

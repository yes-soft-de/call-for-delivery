import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state_manager/new_order/new_order.state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NewOrderScreen extends StatefulWidget {
  final NewOrderStateManager _stateManager;

  NewOrderScreen(
    this._stateManager,
  );

  @override
  NewOrderScreenState createState() => NewOrderScreenState();
}

class NewOrderScreenState extends State<NewOrderScreen> {
  late States currentState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void addNewOrder(
    String recipientName,
    String recipientPhone,
  ) {}

  void moveToNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      OrdersRoutes.OWNER_ORDERS_SCREEN,
      (r) => false,
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void initNewOrder() {
    refresh();
  }

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  void saveInfo(String info) {}

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
        key: _scaffoldKey,
        body: SafeArea(
          child: currentState.getUI(context),
        ),
      ),
    );
  }
}

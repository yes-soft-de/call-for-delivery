import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderStatusScreen extends StatefulWidget {
  final OrderStatusStateManager _stateManager;
  OrderStatusScreen(this._stateManager);

  @override
  OrderStatusScreenState createState() => OrderStatusScreenState();
}

class OrderStatusScreenState extends State<OrderStatusScreen> {
  late int orderId;
  late States currentState;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void deleteOrder(model) {}

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void sendOrderReportState(var orderId, bool answar) {}

  void sendState(bool success) {
    if (success) {
      Flushbar(
        title: S.of(context).warnning,
        message: 'S.of(context).sendToRecordSuccess',
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      Flushbar(
        title: S.of(context).warnning,
        message: 'S.of(context).sendToRecordFaild',
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void goBack(String error) {
    Flushbar(
      title: S.of(context).errorHappened,
      message: error,
      icon: Icon(
        Icons.info,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void requestOrderProgress() {}

  void getOrderDetails(var orderId) {}

  void changeStateToLoaded(OrderModel order) {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentState == null) {}
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:
            CustomC4dAppBar.appBar(context, title: S.current.orderDetails),
        body: currentState.getUI(context),
      ),
    );
  }
}

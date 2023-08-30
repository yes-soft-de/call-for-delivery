import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_orders/request/order/delete_order_from_alshoroq_request.dart';
import 'package:c4d/module_orders/request/order/update_order_request.dart';
import 'package:c4d/module_stores/request/delete_order_request.dart';
import 'package:c4d/module_stores/state_manager/order/order_status.state_manager.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderDetailsScreen();

  @override
  OrderDetailsScreenState createState() => OrderDetailsScreenState();
}

class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int orderId = -1;

  late States currentState;
  late OrderStatusStateManager _stateManager;
  late StreamSubscription _stateSubscription;
  StreamSubscription? firebaseStream;

  OrderStatusStateManager get manager => _stateManager;

  @override
  void initState() {
    currentState = LoadingState(this);
    _stateManager = getIt();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _stateSubscription = _stateManager.stateStream.listen((event) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          currentState = event;
          if (mounted) {
            setState(() {});
          }
        });
      });
      firebaseStream =
          FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
        if (flag == false) {
          _stateManager.getOrder(this, orderId, false);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    firebaseStream?.cancel();
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void deleteOrderFromAlShoroq() {
    var request = DeleteOrderFromAlShoroqRequest(orderId: orderId);

    _stateManager.deleteOrderFromAlShoroq(this, request);
  }

  void deleteOrder(DeleteOrderRequest request) {
    _stateManager.deleteOrder(request, this);
  }

  void updateOrderStatus(UpdateOrderRequest request) {
    _stateManager.updateOrderStatus(this, request);
  }

  int currentIndex = -1;
  bool flag = true;
  bool canRemoveOrder = false;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && currentState is LoadingState && flag) {
      orderId = args as int;
      _stateManager.getOrder(this, orderId);
      flag = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(body: currentState.getUI(context)),
    );
  }
}

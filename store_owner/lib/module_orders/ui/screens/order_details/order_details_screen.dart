import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:c4d/utils/request/rating_request.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderDetailsScreen extends StatefulWidget {
  final OrderStatusStateManager _stateManager;
  OrderDetailsScreen(this._stateManager);

  @override
  OrderDetailsScreenState createState() => OrderDetailsScreenState();
}

class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int orderId = -1;
  late States currentState;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  OrderStatusStateManager get manager => widget._stateManager;
  void deleteOrder() {
    widget._stateManager.deleteOrder(orderId, this);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    FireStoreHelper().onInsertChangeWatcher()?.listen((event) {
      if (mounted) {
        widget._stateManager.getOrder(this, orderId, false);
      }
    });
    super.initState();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void rateCaptain(RatingRequest request) {
    widget._stateManager.rateCaptain(this, request);
  }

  bool canRemoveIt = false;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && currentState is LoadingState && flag) {
      orderId = args as int;
      widget._stateManager.getOrder(this, orderId);
      flag = false;
    }
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomC4dAppBar.appBar(context, title: S.current.orderDetails),
        body: currentState.getUI(context),
        floatingActionButton: Visibility(
            visible: canRemoveIt,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.error,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return CustomAlertDialog(
                          onPressed: () {
                            Navigator.of(context).pop();
                            deleteOrder();
                          },
                          content: S.current.areYouSureAboutDeleteOrder);
                    });
              },
            )),
      ),
    );
  }
}

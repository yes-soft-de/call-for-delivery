import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_action_logs_model.dart';
import 'package:c4d/module_orders/ui/screens/order_actions_log_screen.dart';
import 'package:c4d/module_orders/ui/widgets/action_widget.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class OrderActionLogsLoadedState extends States {
  OrderActionLogsScreenState screenState;
  List<OrderActionLogsModel> orders;
  OrderActionLogsLoadedState(this.screenState, this.orders)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders(context));
  }

  List<Widget> getOrders(context) {
    List<Widget> widgets = [];
    widgets.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).backgroundColor,
        ),
        child: ListTile(
          leading: Icon(
            Icons.info,
            color: Theme.of(context).disabledColor,
          ),
          title: Text(S.current.actionLogHistoryHint),
        ),
      ),
    ));
    orders.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ActionOrderCard(
          orderStatus: StatusHelper.getOrderStatusMessages(element.state),
          createdDate: element.createdAt,
          action: element.action,
          background: StatusHelper.getOrderStatusColor(element.state),
          createdBy: element.createdBy,
        ),
      ));
      widgets.add(Container(
        width: 5,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 2.5,
              height: 40,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
        ),
      ));
    });
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_action_logs_model.dart';
import 'package:c4d/module_orders/ui/screens/order_actions_log_screen.dart';
import 'package:c4d/module_orders/ui/widgets/action_widget.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class OrderActionLogsLoadedState extends States {
  OrderActionLogsScreenState screenState;
  List<OrderActionLogsModel> orders;
  OrderActionLogsLoadedState(this.screenState, this.orders)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).colorScheme.background,
            ),
            child: ListTile(
              leading: Icon(
                Icons.info,
                color: Theme.of(context).disabledColor,
              ),
              title: Text(S.current.actionLogHistoryHint),
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActionOrderCard(
                      userJobDescription: orders[index].userJobDescription,
                      image: orders[index].image,
                      orderStatus: StatusHelper.getOrderStatusMessages(
                          orders[index].state),
                      createdDate: orders[index].createdAt,
                      action: orders[index].action,
                      background:
                          StatusHelper.getOrderStatusColor(orders[index].state),
                      createdBy: orders[index].createdBy,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 2.5,
                      height: 40,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}

import 'package:c4d/consts/navigator_assistant.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/order/orders_details_card.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';

class OrdersCards extends StatelessWidget {
  final StatisticsOrder statisticsOrder;

  const OrdersCards({Key? key, required this.statisticsOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            NavigatorAssistant.nonDeliveringIndex = 1;
            getIt<GlobalStateManager>().goToNonDeliveredOrder();
          },
          child: OrdersDetailsCard(
              title: S.current.ongoing,
              value: statisticsOrder.ongoing.toString(),
              cardColor: Colors.lightBlue.shade200),
        ),
        InkWell(
          onTap: () {
            NavigatorAssistant.nonDeliveringIndex = 0;
            getIt<GlobalStateManager>().goToNonDeliveredOrder();
          },
          child: OrdersDetailsCard(
              title: S.current.pending,
              value: statisticsOrder.pending.toString(),
              cardColor: Colors.yellow.shade200),
        ),
        OrdersDetailsCard(
            title: S.current.last7days,
            value: statisticsOrder.lastSevenDays.toString()),
        OrdersDetailsCard(
            title: S.current.allOrders,
            value: statisticsOrder.allOrders.toString()),
      ],
    );
  }
}

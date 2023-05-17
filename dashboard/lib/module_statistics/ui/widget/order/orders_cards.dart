import 'package:c4d/consts/navigator_assistant.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/order/orders_details_card.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
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
              cardColor: StatusHelper.getOrderStatusColor(
                  OrderStatusEnum.GOT_CAPTAIN)),
        ),
        InkWell(
          onTap: () {
            NavigatorAssistant.nonDeliveringIndex = 0;
            getIt<GlobalStateManager>().goToNonDeliveredOrder();
          },
          child: OrdersDetailsCard(
              title: S.current.pending,
              value: statisticsOrder.pending.toString(),
              cardColor:
                  StatusHelper.getOrderStatusColor(OrderStatusEnum.WAITING)),
        ),
        OrdersDetailsCard(
            title: S.current.last7days,
            cardColor: Theme.of(context).colorScheme.secondaryContainer,
            value: statisticsOrder.lastSevenDays.toString()),
        OrdersDetailsCard(
            title: S.current.allOrders,
            cardColor: Theme.of(context).colorScheme.tertiaryContainer,
            value: statisticsOrder.allOrders.toString()),
      ],
    );
  }
}

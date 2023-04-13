import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/order/orders_details_card.dart';
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
        OrdersDetailsCard(
            onTap: () {
              Navigator.pushNamed(context, OrdersRoutes.PENDING_ORDERS_SCREEN,
                  arguments: 1);
            },
            title: S.current.ongoing,
            value: statisticsOrder.ongoing.toString(),
            cardColor: Colors.lightBlue.shade200),
        OrdersDetailsCard(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(OrdersRoutes.PENDING_ORDERS_SCREEN);
            },
            title: S.current.pending,
            value: statisticsOrder.pending.toString(),
            cardColor: Colors.yellow.shade200),
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

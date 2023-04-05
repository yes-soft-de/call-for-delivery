import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/order/orders_details_row.dart';
import 'package:flutter/material.dart';

class OrdersRows extends StatelessWidget {
  final StatisticsOrder statisticsOrder;

  const OrdersRows({Key? key, required this.statisticsOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrdersDetailsRow(
            title: S.current.maxDeliveredPerDay,
            value: statisticsOrder.maxDeliveredPerDay.toString()),
        OrdersDetailsRow(
            title: S.current.minDeliveredPerDay,
            value: statisticsOrder.minDeliveredPerDay.toString()),
      ],
    );
  }
}

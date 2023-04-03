import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/order/orders_cards.dart';
import 'package:c4d/module_statistics/ui/widget/order/orders_chart.dart';

import 'package:flutter/material.dart';

class OrdersSection extends StatelessWidget {
  final StatisticsOrder statisticsOrder;

  const OrdersSection({Key? key, required this.statisticsOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: 10),
          OrdersChart(statisticsOrder: statisticsOrder),
          SizedBox(height: 20),
          OrdersCards(statisticsOrder: statisticsOrder),
          SizedBox(height: 20),
          // OrdersRows(statisticsOrder: statisticsOrder)
        ],
      ),
    );
  }
}

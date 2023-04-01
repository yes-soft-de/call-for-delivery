import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/orders_card.dart';
import 'package:c4d/module_statistics/ui/widget/orders_chart.dart';
import 'package:flutter/material.dart';

class OrdersSection extends StatelessWidget {
  final StatisticsOrder statisticsOrder;

  const OrdersSection({Key? key, required this.statisticsOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Text(S.current.orders, style: Theme.of(context).textTheme.titleLarge),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.current.lastSevenDays,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          OrdersChart(statisticsOrder: statisticsOrder),
          OrdersCard(statisticsOrder: statisticsOrder)
        ],
      ),
    );
  }
}

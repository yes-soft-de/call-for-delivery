import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:flutter/material.dart';

class OrdersCard extends StatelessWidget {
  final StatisticsOrder statisticsOrder;

  const OrdersCard({Key? key, required this.statisticsOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Text(S.current.allOrdersCount),
            trailing: Text(statisticsOrder.allOrders.toString()),
          ),
          ListTile(
            leading: Text(S.current.last7WeekOrders),
            trailing: Text(statisticsOrder.lastSevenDays.toString()),
          ),
          ListTile(
            leading: Text(S.current.ongoing),
            trailing: Text(statisticsOrder.ongoing.toString()),
          ),
          ListTile(
            leading: Text(S.current.pending),
            trailing: Text(statisticsOrder.pending.toString()),
          ),
          ListTile(
            leading: Text(S.current.maxDeliveredPerDay),
            trailing: Text(statisticsOrder.maxDeliveredPerDay.toString()),
          ),
          ListTile(
            leading: Text(S.current.minDeliveredPerDay),
            trailing: Text(statisticsOrder.minDeliveredPerDay.toString()),
          ),
        ],
      ),
    );
  }
}

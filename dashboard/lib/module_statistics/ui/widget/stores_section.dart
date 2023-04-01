import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/last_3_active.dart';
import 'package:flutter/material.dart';

class StoresSection extends StatelessWidget {
  final StatisticsStores statisticsStores;

  const StoresSection({Key? key, required this.statisticsStores})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Text(
            S.current.stores,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Text(S.current.activeStores),
                  trailing: Text(statisticsStores.active.toString()),
                ),
                ListTile(
                  leading: Text(S.current.inactiveStores),
                  trailing: Text(statisticsStores.nonActive.toString()),
                ),
                Last3Active(lastActive: statisticsStores.stores),
              ],
            ),
          )
        ],
      ),
    );
  }
}

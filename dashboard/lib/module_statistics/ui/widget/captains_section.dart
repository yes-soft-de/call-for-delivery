import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/last_3_active.dart';
import 'package:flutter/material.dart';

class CaptainsSection extends StatelessWidget {
  final StatisticsCaptains statisticsCaptains;

  const CaptainsSection({Key? key, required this.statisticsCaptains})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Text(
            S.current.captains,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Text(S.current.activeCapitan),
                  trailing: Text(statisticsCaptains.active.toString()),
                ),
                ListTile(
                  leading: Text(S.current.inActiveCaptains),
                  trailing: Text(statisticsCaptains.nonActive.toString()),
                ),
                Last3Active(lastActive: statisticsCaptains.captains)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/captain_info.dart';
import 'package:c4d/module_statistics/ui/widget/order/detail_row.dart';
import 'package:flutter/material.dart';

class CaptainsCard extends StatelessWidget {
  final StatisticsCaptains captains;

  const CaptainsCard({Key? key, required this.captains}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          DetailRow(
              title: S.current.activeCapitan,
              value: captains.active.toString()),
          DetailRow(
              title: S.current.inActiveCaptains,
              value: captains.active.toString()),
          Text(S.current.last3Active),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: captains.captains.length,
              itemBuilder: (context, index) => Expanded(
                  child: CaptainInfo(captain: captains.captains[index])),
            ),
          )
        ],
      ),
    );
  }
}

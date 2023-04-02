import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/captains_card.dart';
import 'package:c4d/module_statistics/ui/widget/stores_card.dart';
import 'package:flutter/material.dart';

class ActorsSection extends StatelessWidget {
  final StatisticsModel statisticsModel;

  const ActorsSection({Key? key, required this.statisticsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
        child: CaptainsCard(captains: statisticsModel.captains),
      ),
      Expanded(child: StoresCard(stores: statisticsModel.stores))
    ]);
  }
}

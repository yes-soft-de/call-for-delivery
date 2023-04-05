import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/widget/actor_card.dart';

import 'package:flutter/material.dart';

class ActorsSection extends StatelessWidget {
  final StatisticsModel statisticsModel;

  const ActorsSection({Key? key, required this.statisticsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
        child: ActorCard(actor: statisticsModel.captains),
      ),
      Expanded(child: ActorCard(actor: statisticsModel.stores))
    ]);
  }
}

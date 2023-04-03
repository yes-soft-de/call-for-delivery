import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/screen/statistics_screen.dart';
import 'package:c4d/module_statistics/ui/widget/actors_section.dart';
import 'package:c4d/module_statistics/ui/widget/order/orders_section.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:flutter/material.dart';

class StatisticsLoadedState extends States {
  final StatisticsScreenState screenState;
  final String? error;
  final bool empty;
  final StatisticsModel? statistics;

  StatisticsLoadedState(this.screenState, this.statistics,
      {this.empty = false, this.error})
      : super(screenState);

  String? id;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStatistics();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.homeDataEmpty,
          onRefresh: () {
            screenState.getStatistics();
          });
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          OrdersSection(statisticsOrder: statistics!.orders),
          Expanded(child: ActorsSection(statisticsModel: statistics!)),
        ],
      ),
    );
  }
}

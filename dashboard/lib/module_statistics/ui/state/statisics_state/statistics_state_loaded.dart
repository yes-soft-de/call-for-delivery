import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_statistics/model/statistics_model.dart';
import 'package:c4d/module_statistics/ui/screen/statistics_screen.dart';
import 'package:c4d/module_statistics/ui/widget/captains_section.dart';
import 'package:c4d/module_statistics/ui/widget/orders_section.dart';
import 'package:c4d/module_statistics/ui/widget/stores_section.dart';
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
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Column(
        children: [
          OrdersSection(statisticsOrder: statistics!.orders),
          CaptainsSection(statisticsCaptains: statistics!.captains),
          StoresSection(statisticsStores: statistics!.stores)
        ],
      ),
    );
  }
}

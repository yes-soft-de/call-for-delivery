import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_main/model/report_model.dart';
import 'package:c4d/module_main/model/statistics_model.dart';
import 'package:c4d/module_main/sceen/home_screen.dart';
import 'package:c4d/module_main/widget/animation.dart';
import 'package:c4d/module_main/widget/home_widget_tile.dart';
import 'package:c4d/module_main/widget/order_statistic_ui.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/global/screen_type.dart';

class HomeLoadedState extends States {
  final HomeScreenState screenState;
  final String? error;
  final bool empty;
  final ReportModel? model;
  final StatisticsModel? statistics;

  HomeLoadedState(this.screenState, this.model, this.statistics,
      {this.empty = false, this.error})
      : super(screenState);

  String? id;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getReport();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.homeDataEmpty,
          onRefresh: () {
            screenState.getReport();
          });
    }
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: SizedBox(
        child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            children: [
              HomeWidgetTile(model?.pendingOrdersCount.toString() ?? '',
                  S.current.pending),
              HomeWidgetTile(model?.ongoingOrdersCount.toString() ?? '',
                  S.current.countOngoingOrders),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              HomeWidgetTile(model?.allOrdersCount.toString() ?? '',
                  S.current.allOrdersCount),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              HomeWidgetTile(model?.todayDeliveredOrdersCount.toString() ?? '',
                  S.current.last24CountOrder),
              HomeWidgetTile(
                  model?.previousWeekDeliveredOrdersCount.toString() ?? '',
                  S.current.last7WeekOrders),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              HomeWidgetTile(model?.inactiveStoresCount.toString() ?? '',
                  S.current.storesInActive),
              HomeWidgetTile(model?.activeStoresCount.toString() ?? '',
                  S.current.storesActive),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              HomeWidgetTile(model?.inactiveCaptainsCount.toString() ?? '',
                  S.current.inActiveCaptains),
              HomeWidgetTile(model?.activeCaptainsCount.toString() ?? '',
                  S.current.captains),
            ]),
      ),
    );
  }
}

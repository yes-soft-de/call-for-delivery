import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_main/model/report_model.dart';
import 'package:c4d/module_main/model/statistics_model.dart';
import 'package:c4d/module_main/sceen/home_screen.dart';
import 'package:c4d/module_main/widget/animation.dart';
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
              widgetTile(context, model?.pendingOrdersCount.toString() ?? '',
                  S.current.pending),
              widgetTile(context, model?.ongoingOrdersCount.toString() ?? '',
                  S.current.countOngoingOrders),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              widgetTile(context, model?.allOrdersCount.toString() ?? '',
                  S.current.allOrdersCount),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              widgetTile(
                  context,
                  model?.todayDeliveredOrdersCount.toString() ?? '',
                  S.current.last24CountOrder),
              widgetTile(
                  context,
                  model?.previousWeekDeliveredOrdersCount.toString() ?? '',
                  S.current.last7WeekOrders),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              widgetTile(context, model?.inactiveStoresCount.toString() ?? '',
                  S.current.storesInActive),
              widgetTile(context, model?.activeStoresCount.toString() ?? '',
                  S.current.storesActive),
              Padding(
                padding: const EdgeInsets.only(right: 32, left: 32),
                child: Divider(
                  thickness: 2.5,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              widgetTile(context, model?.inactiveCaptainsCount.toString() ?? '',
                  S.current.inActiveCaptains),
              widgetTile(context, model?.activeCaptainsCount.toString() ?? '',
                  S.current.captains),
            ]),
      ),
    );
  }

  Widget widgetTile(BuildContext context, String count, String title) {
    return Container(
      width: !ScreenType.isDesktop(screenState.context)
          ? MediaQuery.of(screenState.context).size.width * 0.5
          : MediaQuery.of(screenState.context).size.width * 0.25,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: AnimatedLiquidCircularProgressIndicator(
                ValueKey(title), int.parse(count)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: 180),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.85),
                  Theme.of(context).colorScheme.primary.withOpacity(0.9),
                  Theme.of(context).colorScheme.primary.withOpacity(0.95),
                  Theme.of(context).colorScheme.primary,
                ]),
                color: Theme.of(screenState.context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

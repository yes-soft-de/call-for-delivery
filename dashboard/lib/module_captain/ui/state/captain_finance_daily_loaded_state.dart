import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/new_captain_finance_daily_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_finance_daily_screen.dart';
import 'package:c4d/module_captain/ui/widget/captain_finance_daily_widget.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';

class CaptainFinanceDailyLoadedState extends States {
  final CaptainFinanceDailyScreenState screenState;
  final String? error;
  final bool empty;
  // final List<CaptainFinanceDailyModel>? model;
  final List<NewCaptainFinanceDailyModel>? model;
  CaptainFinanceDailyLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getAccount();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getAccount();
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: getCaptains(context)));
  }

  List<Widget> getCaptains(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in model ?? <NewCaptainFinanceDailyModel>[]) {
      if ((!element.captainName!.contains(screenState.search ?? '') &&
              !element.captainProfileId!
                  .toString()
                  .contains(screenState.search ?? '')) &&
          screenState.search != null) {
        continue;
      }
      widgets.add(CaptainFinanceDailyWidget(
        model: element,
      ));
    }

    return widgets;
  }
}

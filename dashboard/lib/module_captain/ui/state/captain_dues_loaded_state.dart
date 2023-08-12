import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_dues_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_dues_screen.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';

class CaptainDuesLoadedState extends States {
  final CaptainDuesScreenState screenState;
  final String? error;
  final bool empty;
  // final List<CaptainFinanceDailyModel>? model;
  final List<CaptainDuesModel>? model;
  CaptainDuesLoadedState(this.screenState, this.model,
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
        child: Column(
      children: [
        Flexible(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: model?.length ?? 0,
          itemBuilder: (context, index) {
            return null;
          },
        )),
      ],
    ));
  }
}

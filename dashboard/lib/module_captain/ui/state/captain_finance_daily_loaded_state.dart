import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/model/captain_finance_daily_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_finance_daily_screen.dart';
import 'package:c4d/module_captain/ui/widget/captain_finance_daily_widget.dart';
import 'package:flutter/material.dart';

class CaptainFinanceDailyLoadedState extends States {
  final CaptainFinanceDailyScreenState screenState;
  final String? error;
  final bool empty;
  final List<CaptainFinanceDailyModel>? model;
  CaptainFinanceDailyLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: model?.length,
            itemBuilder: (context, index) {
              return CaptainFinanceDailyWidget(
                model: model?[index],
              );
            },
          ),
        )
      ],
    );
  }
}

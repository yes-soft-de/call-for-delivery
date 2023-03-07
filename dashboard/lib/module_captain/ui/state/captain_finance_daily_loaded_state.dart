import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/new_captain_finance_daily_model.dart';
import 'package:c4d/module_captain/request/captain_daily_finance_request.dart';
import 'package:c4d/module_captain/ui/screen/captain_finance_daily_screen.dart';
import 'package:c4d/module_captain/ui/widget/captain_finance_daily_widget.dart';
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AnimatedContainer(
                    height: 40,
                    padding: EdgeInsets.all(8),
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: screenState.currentIndex != 0
                              ? Colors.grey
                              : Colors.white,
                          width: 1),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(25),
                          bottomStart: Radius.circular(25)),
                      color: screenState.currentIndex == 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.background,
                    ),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        screenState.currentIndex = 0;
                        screenState.filter =
                            CaptainDailyFinanceRequest(isPaid: 176);
                        screenState.refresh();
                        print(screenState.filter.isPaid);
                        screenState.manager.getCaptainsFinanceDailyNew(
                            screenState, screenState.filter);
                      },
                      child: Text(
                        S.current.unpaidCaptainFinanceDaily,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: screenState.currentIndex != 0
                              ? Colors.black
                              : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    height: 40,
                    padding: EdgeInsets.all(8),
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: screenState.currentIndex != 1
                                ? Colors.grey
                                : Colors.white,
                            width: 1),
                        borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(25),
                            bottomEnd: Radius.circular(25)),
                        color: screenState.currentIndex == 1
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.background),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        screenState.currentIndex = 1;
                        screenState.filter =
                            CaptainDailyFinanceRequest(isPaid: null);
                        screenState.refresh();
                        print(screenState.filter.isPaid);
                        screenState.manager.getCaptainsFinanceDailyNew(
                            screenState, screenState.filter);
                      },
                      child: Text(
                        S.current.all,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: screenState.currentIndex != 1
                              ? Colors.black
                              : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                      ),
                    ),
                    // Text(S.current.hidden),
                  ),
                ),
              ]),
        ),
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

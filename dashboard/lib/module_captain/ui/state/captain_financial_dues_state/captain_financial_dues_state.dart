import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_captain/model/captain_financial_dues.dart';
import 'package:c4d/module_captain/ui/screen/captain_financial_dues_screen.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';

class CaptainFinancialDuesStateLoaded extends States {
  List<CaptainFinancialDuesModel>? dues;
  final CaptainFinancialDuesScreenState screenState;
  CaptainFinancialDuesStateLoaded(this.screenState, this.dues)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getDues(context));
  }

  List<Widget> getDues(context) {
    List<Widget> widgets = [];
    dues?.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.of(context).pushNamed(
                  CaptainsRoutes.CAPTAIN_DUES_DETAILS,
                  arguments: element);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 0.5,
                        offset: const Offset(-1, 0),
                        color: Theme.of(context).colorScheme.background),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // financial cycleDate
                    Center(
                        child: Text(
                      S.current.financialDuesCycle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: verticalBubble(context,
                                  subtitle: element.startDate,
                                  title: S.current.cycleStart)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 32,
                              height: 2.5,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          Expanded(
                              child: verticalBubble(context,
                                  title: S.current.cycleEnd,
                                  subtitle: element.endDate)),
                        ],
                      ),
                    ),
                    // financial summery
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: verticalBubble(context,
                                  title: S.current.sumCaptainFinancialDues,
                                  subtitle: FixedNumber.getFixedNumber(element
                                          .total.sumCaptainFinancialDues) +
                                      ' ${S.current.sar}')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 32,
                              height: 2.5,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          Expanded(
                              child: verticalBubble(context,
                                  title: S.current.sumPaymentsToCaptainFinance,
                                  subtitle: FixedNumber.getFixedNumber(
                                          element.total.sumPaymentsToCaptain) +
                                      ' ${S.current.sar}')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print(element.total.advancePayment);
                              },
                              child: verticalBubble(context,
                                  title: S.current.total,
                                  subtitle: FixedNumber.getFixedNumber(
                                          element.total.total) +
                                      ' ${S.current.sar}',
                                  background: element.total.advancePayment ==
                                          null
                                      ? null
                                      : (element.total.advancePayment == 160
                                          ? Colors.green
                                          : element.total.advancePayment == 159
                                              ? Colors.red
                                              : Theme.of(screenState.context)
                                                  .disabledColor)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 32,
                              height: 2.5,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          Expanded(
                              child: verticalBubble(
                            context,
                            title: S.current.financeStatus,
                            subtitle: FinanceHelper.getStatusString(
                                element.status.toInt()),
                            background: FinanceHelper.getFinanceStatusColor(
                                element.status.toInt()),
                            subtitleText: true,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
    });
    return widgets;
  }

  Widget getVerticalTile(BuildContext context,
      {required String title,
      required String subtitle,
      Color? backgroundColor}) {
    return Column(
      children: [
        Text(title),
        Container(
            color: backgroundColor ?? Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                subtitle,
                style: TextStyle(
                    color: backgroundColor != null ? Colors.white : null),
              ),
            )),
      ],
    );
  }

  Widget verticalBubble(BuildContext context,
      {required String title,
      required String subtitle,
      Color? background,
      bool subtitleText = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: background ?? Theme.of(context).colorScheme.background,
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title,
              style: TextStyle(
                  fontSize: 14,
                  color: background != null ? Colors.white : null)),
          subtitle: Text(subtitle,
              style: TextStyle(
                  color: background != null ? Colors.white : null,
                  fontSize: subtitleText ? 14 : null)),
        ),
      ),
    );
  }
}

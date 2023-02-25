import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_daily_finance_model.dart';
import 'package:c4d/module_plan/ui/widget/paymetns_widget.dart';
import 'package:c4d/module_plan/ui/widget/vertical_bubble.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:flutter/material.dart';

class DailyWidget extends StatelessWidget {
  final num amount;
  final num alreadyHadAmount;
  final int financeType;
  final num financeSystemPlan;
  final int isPaid;
  final bool withBonus;
  final num bonus;
  final List<PaymentModel> payments;
  const DailyWidget({
    Key? key,
    required this.alreadyHadAmount,
    required this.amount,
    required this.bonus,
    required this.financeSystemPlan,
    required this.financeType,
    required this.isPaid,
    required this.withBonus,
    required this.payments,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> packages = [
      S.current.planByHours,
      S.current.planByOrders,
      S.current.planByOrderCount
    ];
    return Container(
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
            // financial summery
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: VerticalBubble(
                          title: S.current.todayProfit,
                          subtitle:
                              '${FixedNumber.getFixedNumber(amount)} ${S.current.sar}')),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 2.5,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  Expanded(
                      child: VerticalBubble(
                          title: S.current.totalEarnedProfit,
                          subtitle:
                              '${FixedNumber.getFixedNumber(alreadyHadAmount)} ${S.current.sar}')),
                ],
              ),
            ),
            // finance type .
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: VerticalBubble(
                          title: S.current.myPlan,
                          subtitle: packages[financeType - 1])),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 2.5,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  Expanded(
                      child: VerticalBubble(
                          title: S.current.plan,
                          subtitle: financeSystemPlan.toString())),
                ],
              ),
            ),
            // bonus
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: VerticalBubble(
                        title: S.current.bonus,
                        subtitle:
                            '${FixedNumber.getFixedNumber(bonus)} ${S.current.sar}',
                        background: withBonus ? Colors.green : Colors.red),
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
                      child: VerticalBubble(
                          title: S.current.financeStatus,
                          subtitle: FinanceHelper.getStatusString(isPaid),
                          background:
                              FinanceHelper.getFinanceStatusColor(isPaid))),
                ],
              ),
            ),
            Visibility(
              visible: payments.isEmpty,
              child: ElevatedButton(
                onPressed: () {
                  List<Widget> widgets = [];
                  payments.forEach((element) {
                    widgets.add(PaymentsWidget(
                      amount: element.amount,
                      note: element.note,
                      paymentDate: element.paymentDate,
                    ));
                  });
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return Column(
                          children: widgets,
                        );
                      });
                },
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(S.current.payments)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

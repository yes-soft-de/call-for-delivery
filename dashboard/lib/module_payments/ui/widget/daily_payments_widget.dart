import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/ui/widgets/bubble_widget.dart';
import 'package:c4d/module_payments/model/captain_daily_finance.dart';
import 'package:c4d/module_payments/ui/widget/paymetns_widget.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
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
  final Function(num, String) onPay;
  final Function(int, num, String) onEdit;
  final Function(int) onDelete;
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
    required this.onPay,
    required this.onDelete,
    required this.onEdit,
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
                      child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.current.duesByFilter,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      // color:
                                      //      Colors.white
                                      //     : null
                                    )),
                                Text(
                                    '${FixedNumber.getFixedNumber(amount) + FixedNumber.getFixedNumber(bonus)} ${S.current.sar}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      // color: background != null
                                      //     ? Colors.white
                                      //     : null
                                    ))
                              ],
                            ),
                          ))
                      //  VerticalBubble(
                      //     title: S.current.duesByFilter,
                      //     subtitle:
                      //         '${FixedNumber.getFixedNumber(amount)} ${S.current.sar}')
                      ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     width: 32,
                  //     height: 2.5,
                  //     color: Theme.of(context).colorScheme.background,
                  //   ),
                  // ),
                  // Expanded(
                  //     child: VerticalBubble(
                  //         tile: S.current.totalEarnedProfit,
                  //         subtitle:
                  //             '${FixedNumber.getFixedNumber(alreadyHadAmount)} ${S.current.sar}')),
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
                          title: S.current.totalEarnedProfit,
                          subtitle:
                              '${FixedNumber.getFixedNumber(alreadyHadAmount)} ${S.current.sar}')),

                  // Expanded(
                  //     child: VerticalBubble(
                  //         title: S.current.plan,
                  //         subtitle: financeSystemPlan.toString())),
                ],
              ),
            ),
            // bonus
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Expanded(
                  //   child: VerticalBubble(
                  //       title: S.current.bonus,
                  //       subtitle:
                  //           '${FixedNumber.getFixedNumber(bonus)} ${S.current.sar}',
                  //       background: withBonus ? Colors.green : null),
                  // ),
                  Expanded(
                    child: VerticalBubble(
                        title: S.current.bonus,
                        subtitle:
                            '${FixedNumber.getFixedNumber(bonus)} ${S.current.sar}',
                        background: withBonus ? Colors.green : null),
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
                          subtitle: FinanceHelper.getDailyFinance(isPaid),
                          background:
                              FinanceHelper.getFinanceStatusColor(isPaid))),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: payments.isNotEmpty,
                  child: ElevatedButton(
                    onPressed: () {
                      List<Widget> widgets = [];
                      payments.forEach((element) {
                        widgets.add(PaymentsWidget(
                          amount: element.amount,
                          note: element.note,
                          paymentDate: element.paymentDate,
                          delete: onDelete,
                          onEdit: onEdit,
                          id: element.id,
                        ));
                      });
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return Scaffold(
                              appBar: CustomC4dAppBar.appBar(
                                context,
                                title: '',
                                icon: Icons.cancel,
                              ),
                              body: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: widgets,
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(S.current.showPayments)),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    final _amount = TextEditingController();
                    final _note = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              scrollable: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(child: Text(S.current.addaPayment)),
                                  Flexible(
                                    child: Text(DateTime.now()
                                        .toString()
                                        .substring(0, 10)),
                                  ),
                                ],
                              ),
                              content: Container(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(S.current.paymentAmount),
                                      subtitle: CustomFormField(
                                        onChanged: () {
                                          setState(() {});
                                        },
                                        numbers: true,
                                        controller: _amount,
                                        hintText: '100',
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(S.current.note),
                                      subtitle: CustomFormField(
                                        controller: _note,
                                        minLines: 2,
                                        maxLines: 3,
                                        onChanged: () {
                                          setState(() {});
                                        },
                                        hintText: S.current.note,
                                        last: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                ElevatedButton(
                                    onPressed: _amount.text.isEmpty ||
                                            _note.text.isEmpty
                                        ? null
                                        : () {
                                            Navigator.of(context).pop();
                                            onPay(
                                                num.tryParse(_amount.text) ?? 0,
                                                _note.text);
                                          },
                                    child: Text(
                                      S.current.pay,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _amount.clear();
                                      _note.clear();
                                    },
                                    child: Text(
                                      S.current.cancel,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ))
                              ],
                            );
                          });
                        });
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(S.current.pay)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_daily_finance.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyWidget extends StatelessWidget {
  int? id;
  final num amount;
  final num alreadyHadAmount;
  final int financeType;
  final num financeSystemPlan;
  final int isPaid;
  final bool withBonus;
  final num bonus;
  final DateTime createdAt;
  final List<PaymentModel> payments;
  final Function(num, String) onPay;

  DailyWidget(
      {Key? key,
      required this.alreadyHadAmount,
      required this.amount,
      required this.bonus,
      required this.financeSystemPlan,
      required this.financeType,
      required this.isPaid,
      required this.withBonus,
      required this.payments,
      required this.onPay,
      this.id,
      required this.createdAt})
      : super(key: key);
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
          color: Theme.of(context).primaryColor.withOpacity(0.7),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      DateFormat('yyyy/M/dd').format(createdAt),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  )),
            ),
            // financial summery
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Container(
                          height: 50,
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
                                Text(S.current.dues,
                                    // S.current.duesByFilter,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(
                                    '${FixedNumber.getFixedNumber(amount + bonus)} ${S.current.sar}',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ))
                              ],
                            ),
                          ))),
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
                      child: Container(
                          height: 40,
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
                                Text(S.current.myPlan,
                                    style: TextStyle(
                                      fontSize: 15,
                                    )),
                                Text(packages[financeType - 1],
                                    style: TextStyle(
                                      fontSize: 14,
                                    ))
                              ],
                            ),
                          ))),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        S.current.totalEarnedProfit +
                                            '(${S.current.advanced})',
                                        style: TextStyle(
                                          fontSize: 15,
                                          // color:
                                          //      Colors.white
                                          //     : null
                                        )),
                                    Text(
                                        '${FixedNumber.getFixedNumber(alreadyHadAmount)} ${S.current.sar}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          // color: background != null
                                          //     ? Colors.white
                                          //     : null
                                        ))
                                  ],
                                ),
                              ))),
                    ])),
            // bonus
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: withBonus
                          ? Colors.green
                          : Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        title: Text(
                            S.current.bonus +
                                ' : ${FixedNumber.getFixedNumber(bonus)} ${S.current.sar}',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    withBonus ? Colors.white : Colors.black)),
                      ),
                    ),
                  )),
                  // Expanded(
                  //   child: VerticalBubble(
                  //       title: S.current.bonus,
                  //       subtitle:
                  //           '${FixedNumber.getFixedNumber(bonus)} ${S.current.sar}',
                  //       background: withBonus ? Colors.green : null),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 2.5,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  // Expanded(
                  //     child: VerticalBubble(
                  //         title: S.current.financeStatus,
                  //         subtitle: FinanceHelper.getDailyFinance(isPaid),
                  //         background:
                  //             FinanceHelper.getFinanceStatusColor(isPaid))),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: FinanceHelper.getFinanceStatusColor(isPaid),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        title: Text(FinanceHelper.getDailyFinance(isPaid),
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 16,
                // ),
                Container(
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {
                      final _amount = TextEditingController();
                      final _note = TextEditingController();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                scrollable: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(S.current.addaPayment)),
                                    Flexible(
                                      child: Text(DateFormat('yyyy/M/dd')
                                          .format(DateTime.now())),
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
                                                  num.tryParse(_amount.text) ??
                                                      0,
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
                    child: Text(
                      S.current.pay,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

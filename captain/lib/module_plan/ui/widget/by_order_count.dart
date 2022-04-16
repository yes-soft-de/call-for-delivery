import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:flutter/material.dart';

class FinanceByCountOrder extends StatelessWidget {
  final num countOrdersInMonth;
  final num salary;
  final num bounceMinCountOrdersInMonth;
  final num bounceMaxCountOrdersInMonth;
  final num monthCompensation;
  const FinanceByCountOrder(
      {Key? key,
      required this.countOrdersInMonth,
      required this.salary,
      required this.bounceMinCountOrdersInMonth,
      required this.bounceMaxCountOrdersInMonth,
      required this.monthCompensation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              color: Theme.of(context).backgroundColor,
              offset: const Offset(-1, 0),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              horizontalsTile(S.current.countOrdersInMonth,
                  FixedNumber.getFixedNumber(countOrdersInMonth)),
              horizontalsTile(S.current.salary,
                  FixedNumber.getFixedNumber(salary) + ' ${S.current.sar}'),
              horizontalsTile(
                  S.current.bounceMinCountOrdersInMonth,
                  FixedNumber.getFixedNumber(bounceMinCountOrdersInMonth) +
                      ' ${S.current.sar}'),
              horizontalsTile(
                  S.current.bounceMaxCountOrdersInMonth,
                  FixedNumber.getFixedNumber(bounceMaxCountOrdersInMonth) +
                      ' ${S.current.sar}'),
              horizontalsTile(
                  S.current.monthCompensation,
                  FixedNumber.getFixedNumber(monthCompensation) +
                      ' ${S.current.sar}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalsTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(bottom: 8.0, top: 0),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            subtitle,
            style: TextStyle(
                color: Colors.green.shade600, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

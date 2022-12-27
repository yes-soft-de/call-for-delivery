import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';

class FinanceByHours extends StatelessWidget {
  final num countHours;
  final num salary;
  final num compensationForEveryOrder;
  final bool active;
  const FinanceByHours(
      {Key? key,
      required this.countHours,
      required this.salary,
      required this.compensationForEveryOrder,
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          color: active ? null : Theme.of(context).scaffoldBackgroundColor,
          gradient: active
              ? LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  Theme.of(context).colorScheme.primary.withOpacity(0.9),
                  Theme.of(context).colorScheme.primary,
                ])
              : null,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              color: active
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                  : Theme.of(context).backgroundColor,
              offset: const Offset(-1, 0),
            )
          ],
        ),
        duration: const Duration(milliseconds: 350),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              horizontalsTile(
                  S.current.countHours, FixedNumber.getFixedNumber(countHours)),
              horizontalsTile(S.current.salary,
                  FixedNumber.getFixedNumber(salary) + ' ${S.current.sar}'),
              horizontalsTile(
                  S.current.compensationForEveryOrder,
                  FixedNumber.getFixedNumber(compensationForEveryOrder) +
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: active ? Colors.white : null),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            subtitle,
            style: TextStyle(
                color: active ? Colors.white : Colors.green.shade600,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

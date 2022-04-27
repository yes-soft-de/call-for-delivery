import 'package:c4d/generated/intl/messages_ar.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class AccountBalanceDetailsCard extends StatelessWidget {
  final String categoryName;
  final num bounceCountOrdersInMonth;
  final num amount;
  final num countKilometersFrom;
  final num countKilometersTo;
  final num bounce;

  final num captainTotalCategory;
  final num contOrderCompleted;
  final num countOfOrdersLeft;
  final String? message;
  final bool active;
  const AccountBalanceDetailsCard(
      {Key? key,
      required this.categoryName,
      required this.bounceCountOrdersInMonth,
      required this.amount,
      required this.countKilometersFrom,
      required this.countKilometersTo,
      required this.bounce,
      required this.active,
      required this.captainTotalCategory,
      required this.contOrderCompleted,
      required this.countOfOrdersLeft,
      this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color:
                    active ? null : Theme.of(context).scaffoldBackgroundColor,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      categoryName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: active ? Colors.white : null),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0)
                          .copyWith(left: 16, right: 16),
                      child: DottedLine(
                        direction: Axis.horizontal,
                        dashColor: Theme.of(context).backgroundColor,
                        lineThickness: 2.5,
                        dashRadius: 25,
                      ),
                    ),
                    horizontalsTile(
                        S.current.countKilometersFrom,
                        FixedNumber.getFixedNumber(countKilometersFrom) +
                            ' ${S.current.km}'),
                    horizontalsTile(
                        S.current.countKilometersTo,
                        FixedNumber.getFixedNumber(countKilometersTo) +
                            ' ${S.current.km}'),
                    horizontalsTile(
                        S.current.amount,
                        FixedNumber.getFixedNumber(amount) +
                            ' ${S.current.sar}'),
                    horizontalsTile(
                        S.current.bounceCountOrdersInMonth,
                        FixedNumber.getFixedNumber(bounceCountOrdersInMonth) +
                            ' ${S.current.order.substring(2)}'),
                    horizontalsTile(
                        S.current.bounce,
                        FixedNumber.getFixedNumber(bounce) +
                            ' ${S.current.sar}'),
                    horizontalsTile(
                        S.current.contOrderCompleted,
                        FixedNumber.getFixedNumber(contOrderCompleted) +
                            ' ${S.current.order.substring(2)}'),
                    horizontalsTile(
                        S.current.countOfOrdersLeft,
                        FixedNumber.getFixedNumber(countOfOrdersLeft) +
                            ' ${S.current.order.substring(2)}'),
                    horizontalsTile(
                        S.current.captainTotalCategory,
                        FixedNumber.getFixedNumber(captainTotalCategory) +
                            ' ${S.current.sar}'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    message ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
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
                  color: active ? Colors.white : null,
                  fontSize: 14),
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

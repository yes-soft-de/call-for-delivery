import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class OrderCashConflictCard extends StatelessWidget {
  final String orderNumber;
  final String createdDate;
  final Color? background;
  final String captainAnswer;
  final String storeAnswer;
  final String captain;
  final String store;
  OrderCashConflictCard(
      {required this.orderNumber,
      required this.createdDate,
      this.background,
      required this.captainAnswer,
      required this.storeAnswer,
      required this.captain,
      required this.store});

  @override
  Widget build(BuildContext context) {
    var color = background ?? Theme.of(context).colorScheme.primary;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(colors: [
            color.withOpacity(0.85),
            color.withOpacity(0.85),
            color.withOpacity(0.9),
            color.withOpacity(0.93),
            color.withOpacity(0.95),
            color,
          ])),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // order number & create date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.orderNumber, subtitle: orderNumber),
                verticalTile(context,
                    title: S.current.createdDate, subtitle: createdDate),
              ],
            ),
            // divider
            divider(context),
            // order date & create date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(
                  context,
                  title: S.current.captain + ' (${captain})',
                  subtitle: captainAnswer,
                  fontSize: 12
                ),
                verticalTile(
                  context,
                  title: S.current.store + ' (${store})',
                  subtitle: storeAnswer,
                  fontSize: 12
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalTile(context,
      {required String title, required String subtitle, double? fontSize}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: Theme.of(context).textTheme.button?.color),
        ),
        Text(subtitle,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(fontWeight: FontWeight.normal,)),
      ],
    );
  }

  Widget divider(context) {
    Color dividerColor = Theme.of(context).textTheme.button!.color!;
    return Divider(
      thickness: 2,
      indent: 16,
      endIndent: 16,
      color: dividerColor,
    );
  }
}

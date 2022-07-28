import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class ActionOrderCard extends StatelessWidget {
  final String orderStatus;
  final String createdDate;
  final String createdBy;
  final String action;
  final Color? background;
  final IconData? icon;
  ActionOrderCard(
      {required this.orderStatus,
      required this.createdDate,
      this.background,
      this.icon,
      required this.createdBy,
      required this.action});

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
            // action & date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.action, subtitle: action),
                verticalTile(context,
                    title: S.of(context).actionDate, subtitle: createdDate),
              ],
            ),
            // divider
            divider(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.actionBy, subtitle: createdBy),
                verticalTile(context,
                    title: S.current.currentOrderStatus, subtitle: orderStatus),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalTile(context,
      {required String title, required String subtitle}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.button?.color),
        ),
        Text(subtitle,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(fontWeight: FontWeight.normal)),
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

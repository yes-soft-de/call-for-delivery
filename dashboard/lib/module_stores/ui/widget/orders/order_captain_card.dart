import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class CaptainNotCard extends StatelessWidget {
  final String storeName;
  final String branchName;
  final String captainName;
  final String createdDate;
  CaptainNotCard(
      {required this.storeName,
        required this.captainName,
        required this.createdDate,
        required this.branchName,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
            Theme.of(context).colorScheme.primary.withOpacity(0.9),
            Theme.of(context).colorScheme.primary.withOpacity(0.93),
            Theme.of(context).colorScheme.primary.withOpacity(0.95),
            Theme.of(context).colorScheme.primary,
          ])),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.storeName, subtitle: storeName),
                verticalTile(context,
                    title: S.current.branch, subtitle: branchName),
              ],
            ),
            // divider
            divider(context),
            // order date & create date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.captain, subtitle: captainName),
                verticalTile(context,
                    title: S.current.createdDate, subtitle: createdDate),
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
              color: Theme.of(context).backgroundColor),
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
    Color dividerColor = Theme.of(context).backgroundColor;
    return Divider(
      thickness: 2,
      indent: 16,
      endIndent: 16,
      color: dividerColor,
    );
  }
}
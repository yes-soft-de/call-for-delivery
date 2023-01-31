import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderDistanceConflict extends StatelessWidget {
  final String orderNumber;
  final String storeOwner;
  final String branchName;
  final String captain;
  final Color? background;
  final double distance;
  final String? conflictReason;
  final Function() onEdit;
  final Function() onEditExtra;
  OrderDistanceConflict({
    required this.orderNumber,
    this.background,
    required this.distance,
    required this.onEdit,
    required this.storeOwner,
    required this.branchName,
    required this.captain,
    required this.conflictReason,
    required this.onEditExtra,
  });

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: IconButton(
                      onPressed: onEdit,
                      icon: Icon(
                        Icons.edit_road_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: IconButton(
                      onPressed: onEditExtra,
                      icon: Icon(
                        Icons.add_road_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ),
              ],
            ),
            // order number & order status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.orderNumber, subtitle: orderNumber),
                verticalTile(context,
                    title: S.current.storeOwner, subtitle: storeOwner),
              ],
            ),
            // divider
            divider(context),
            // order date & create date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.branch, subtitle: branchName),
                verticalTile(context,
                    title: S.current.captain, subtitle: captain),
              ],
            ),
            // divider
            divider(context),
            // order cost
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.distance,
                    subtitle: distance.toStringAsFixed(2) + ' ' + S.current.km),
                Visibility(
                  visible: conflictReason != null,
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              conflictReason ?? '',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ))
                    ],
                  ),
                )
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

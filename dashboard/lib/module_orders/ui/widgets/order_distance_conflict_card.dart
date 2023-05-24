// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

enum ActionType {
  addKiloMeter,
  editCoordinates;

  /// the value is [ActionType.addKiloMeter]
  static ActionType get defaultValue => ActionType.addKiloMeter;
}

class OrderDistanceConflict extends StatelessWidget {
  final String orderNumber;
  final String storeOwner;
  final String branchName;
  final String captain;
  final Color? background;
  final String distance;
  final String? conflictReason;
  final Function() onEdit;

  OrderDistanceConflict({
    required this.orderNumber,
    this.background,
    required this.distance,
    required this.onEdit,
    required this.storeOwner,
    required this.branchName,
    required this.captain,
    required this.conflictReason,
  });

  @override
  Widget build(BuildContext context) {
    var color = background ?? Theme.of(context).colorScheme.primary;
    var whiteText =
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white);
    var radius = 10.0;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
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
            // order number & order status
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              storeOwner,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.normal),
                            ),
                            VDivider(),
                            Text(
                              branchName,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      // divider
                      HDivider(),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '#$orderNumber',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: color),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${S.current.captain}: $captain',
                      style: whiteText,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: num.tryParse(distance) != null,
                      child: Text(
                        '${S.current.distance}: $distance ${S.current.km}',
                        style: whiteText,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: num.tryParse(distance) == null,
                      child: Text(
                        '${S.current.theEdit}: $distance',
                        style: whiteText,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: _elevatedButtonStyle(),
              onPressed: () {
                onEdit();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit_note, color: color),
                  SizedBox(width: 10),
                  Text(
                    S.current.caseDetailsAndMakeAction,
                    style: TextStyle(color: color, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VDivider extends StatelessWidget {
  const VDivider({
    super.key,
    this.dividerColor,
  });

  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      indent: 2,
      endIndent: 2,
      color: dividerColor ?? Theme.of(context).textTheme.labelLarge!.color!,
    );
  }
}

class HDivider extends StatelessWidget {
  HDivider({
    super.key,
    this.dividerColor,
  });

  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 5,
      endIndent: 5,
      color: dividerColor ?? Theme.of(context).textTheme.labelLarge!.color!,
    );
  }
}

ButtonStyle _elevatedButtonStyle({Color color = Colors.amber}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(color),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

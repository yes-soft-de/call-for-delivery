import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/icon_info_button.dart';
import 'package:c4d/module_subscription/ui/widget/package_card/info_button.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';

class OwnerOrderCard extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String deliveryDate;
  final String createdDate;
  final num orderCost;
  final String note;
  final Color? background;
  OwnerOrderCard(
      {required this.orderNumber,
      required this.orderStatus,
      required this.createdDate,
      required this.deliveryDate,
      required this.orderCost,
      required this.note,
      this.background});

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
            InfoButtonOrder(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(S.current.note),
                        content: Container(child: Text(note)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(S.current.close)),
                        ],
                      );
                    });
              },
            ),
            // order number & order status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.orderNumber, subtitle: orderNumber),
                verticalTile(context,
                    title: S.current.orderStatus, subtitle: orderStatus),
              ],
            ),
            // divider
            divider(context),
            // order date & create date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.deliverDate, subtitle: deliveryDate),
                verticalTile(context,
                    title: S.current.createdDate, subtitle: createdDate),
              ],
            ),
            // divider
            divider(context),
            // order cost
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.cost, subtitle: FixedNumber.getFixedNumber(orderCost) + ' ' + S.current.sar),
                Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Theme.of(context).textTheme.button?.color,
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

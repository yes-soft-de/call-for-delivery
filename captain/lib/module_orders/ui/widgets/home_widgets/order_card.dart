import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/ui/widgets/home_widgets/icon_info_button.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String deliveryDate;
  final String orderCost;
  final String note;
  final String destination;
  OrderCard(
      {required this.orderNumber,
      required this.orderStatus,
      required this.deliveryDate,
      required this.orderCost,
      required this.note,
      required this.destination
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                      title: S.current.destination, subtitle: destination),
                ],
              ),
              // divider
              divider(context),
              // order cost
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  verticalTile(context,
                      title: S.current.cost, subtitle: orderCost),
                  Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Theme.of(context).backgroundColor,
                  )
                ],
              ),
            ],
          ),
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

class NearbyOrdersCard extends StatelessWidget {
  final String orderNumber;
  final String deliveryDate;
  final String orderCost;
  final String distance;
  final String note;
  final String branchName;
  const NearbyOrdersCard(
      {required this.orderNumber,
      required this.distance,
      required this.deliveryDate,
      required this.orderCost,
      required this.note,
      required this.branchName});

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
                    title: S.current.deliverDate, subtitle: deliveryDate),
                verticalTile(context,
                    title: S.current.destination, subtitle: distance),
              ],
            ),
            // divider
            divider(context),
            // order cost
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.cost, subtitle: orderCost),
                Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Theme.of(context).backgroundColor,
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

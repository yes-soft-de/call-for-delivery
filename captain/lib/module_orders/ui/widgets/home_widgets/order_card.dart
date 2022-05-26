import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String deliveryDate;
  final String orderCost;
  final String? note;
  final String destination;
  final bool credit;
  final Color? background;
  final String? primaryTitle;
  final bool orderIsMain;
  const OrderCard(
      {required this.orderNumber,
      required this.orderStatus,
      required this.deliveryDate,
      required this.orderCost,
      required this.note,
      required this.destination,
      required this.credit,
      this.orderIsMain = false,
      this.primaryTitle,
      this.background});

  @override
  Widget build(BuildContext context) {
    var color = background ?? Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
              Visibility(
                visible: orderIsMain || primaryTitle != null,
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.tag,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amber),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          primaryTitle ?? S.current.groupOrder,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
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
              horizontalTile(context,
                  title: S.current.deliverDate, subtitle: deliveryDate),
              // divider
              divider(context),
              // order cost
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Visibility(
                    visible: credit,
                    child: verticalTile(context,
                        title: S.current.cost, subtitle: S.current.paid),
                    replacement: verticalTile(context,
                        title: S.current.cost,
                        subtitle: orderCost + ' ' + S.current.sar),
                  ),
                  Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Theme.of(context).textTheme.button?.color,
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

  Widget horizontalTile(context,
      {required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      ),
    );
  }

  Widget divider(context) {
    Color dividerColor =
        Theme.of(context).textTheme.button?.color ?? Colors.white;
    return Divider(
      height: 8,
      thickness: 1.5,
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
  final String? note;
  final String branchName;
  final bool credit;
  final bool orderIsMain;
  final String? primaryTitle;
  final Color? background;
  const NearbyOrdersCard(
      {required this.orderNumber,
      required this.distance,
      required this.deliveryDate,
      required this.orderCost,
      required this.note,
      required this.branchName,
      required this.credit,
      this.orderIsMain = false,
      this.background,
      this.primaryTitle});

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
            Visibility(
              visible: orderIsMain || primaryTitle != null,
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.tag,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.amber),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        primaryTitle ?? S.current.groupOrder,
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
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
                Visibility(
                  visible: credit,
                  child: verticalTile(context,
                      title: S.current.cost, subtitle: S.current.paid),
                  replacement: verticalTile(context,
                      title: S.current.cost,
                      subtitle: orderCost + ' ' + S.current.sar),
                ),
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
    Color dividerColor =
        Theme.of(context).textTheme.button?.color ?? Colors.white;
    return Divider(
      height: 8,
      thickness: 1.5,
      indent: 16,
      endIndent: 16,
      color: dividerColor,
    );
  }
}

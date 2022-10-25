import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/ui/widgets/home_widgets/icon_info_button.dart';
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
  final String orderCost;
  final Widget distance;
  final String? branchToDestination;
  final String? note;
  final String branchName;
  final bool credit;
  final bool orderIsMain;
  final String? primaryTitle;
  final Color? background;
  final String storeName;
  final Function() acceptOrder;
  const NearbyOrdersCard(
      {required this.orderNumber,
      this.branchToDestination,
      required this.distance,
      required this.orderCost,
      required this.note,
      required this.branchName,
      required this.credit,
      this.orderIsMain = false,
      this.background,
      this.primaryTitle,
      required this.storeName,
      required this.acceptOrder});

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
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Row(
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
                    ],
                  ),
                ),
                Spacer(),
                Visibility(
                  visible: note != null,
                  child: InfoButtonOrder(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text(S.current.note),
                              content: Container(child: Text(note ?? '')),
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
                ),
              ],
            ),
            // order number & order date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                verticalTile(context,
                    title: S.current.orderNumber, subtitle: orderNumber),
                verticalTile(context,
                    title: S.current.store,
                    subtitle: storeName + ' | ' + branchName),
              ],
            ),
            // divider
            divider(context),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.carSide,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        size: 15,
                      ),
                      Text(
                        S.current.currentLocation,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                  dotedDivider(context),
                  distance,
                  dotedDivider(context),
                  Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.box,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        size: 15,
                      ),
                      Text(
                        S.current.receivingLocation,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                  dotedDivider(context),
                  Text(
                    (branchToDestination ?? S.current.unknown) +
                        ' ${S.current.km}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textScaleFactor: 1,
                  ),
                  dotedDivider(context),
                  Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.home,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        size: 15,
                      ),
                      Text(
                        S.current.deliveryDestination,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            divider(context),
            // order cost & accept order
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                  visible: orderCost != '0' || credit,
                  child: Visibility(
                    visible: credit,
                    child: verticalTile(context,
                        title: S.current.paymentMethod,
                        subtitle: S.current.paid),
                    replacement: verticalTile(context,
                        title: S.current.paymentMethod,
                        subtitle: orderCost +
                            ' ' +
                            S.current.sar +
                            ' | ' +
                            S.current.cash),
                  ),
                ),
                Visibility(
                  replacement: ElevatedButton.icon(
                    onPressed: () {
                      acceptOrder();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green, shape: StadiumBorder()),
                    label: Text(
                      S.current.accept,
                      style: Theme.of(context).textTheme.button,
                    ),
                    icon: const Icon(
                      Icons.thumb_up_alt_rounded,
                      color: Colors.white,
                    ),
                  ),
                  visible: false,
                  child: Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Theme.of(context).textTheme.button?.color,
                  ),
                ),
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

  Widget verticalTileForDistance(context,
      {required String title, required Widget subtitle}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.button?.color),
        ),
        distance,
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

  Widget dotedDivider(context) {
    Color dividerColor =
        Theme.of(context).textTheme.button?.color ?? Colors.white;
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: dividerColor),
        ),
      ],
    );
  }
}

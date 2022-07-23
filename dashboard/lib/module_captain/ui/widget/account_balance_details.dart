import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../module_orders/model/order/order_model.dart';

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
  final List<OrderModel> orders;
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
      this.message,
      required this.orders})
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
                            ' ${S.current.sOrder}'),
                    horizontalsTile(
                        S.current.bounce,
                        FixedNumber.getFixedNumber(bounce) +
                            ' ${S.current.sar}'),
                    horizontalsTile(
                        S.current.contOrderCompleted,
                        FixedNumber.getFixedNumber(contOrderCompleted) +
                            ' ${S.current.sOrder}',
                        toOrder: true),
                    horizontalsTile(
                        S.current.countOfOrdersLeft,
                        FixedNumber.getFixedNumber(countOfOrdersLeft) +
                            ' ${S.current.sOrder}'),
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

  Widget horizontalsTile(String title, String subtitle,
      {bool toOrder = false, BuildContext? context}) {
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(bottom: 8.0, top: 0),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: InkWell(
              onTap: toOrder
                  ? () {
                      showDialog(
                          context: context!,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(S.current.orders),
                              content: Column(
                                children: getOrders(context),
                              ),
                              scrollable: true,
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(S.current.close))
                              ],
                            );
                          });
                    }
                  : null,
              child: Text(
                title,
                style: TextStyle(
                    decoration: toOrder ? TextDecoration.underline : null,
                    fontWeight: FontWeight.bold,
                    color: active ? Colors.white : null),
              ),
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

  List<Widget> getOrders(context) {
    List<Widget> widgets = [];
    orders.forEach((element) {
      widgets.add(
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(StoresRoutes.ORDER_STATUS_SCREEN,
                arguments: element.id);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              children: [
                // order number
                Column(
                  children: [
                    Text(
                      S.current.orderNumber,
                      style: Theme.of(context).textTheme.button,
                    ),
                    Text(
                      element.id.toString(),
                      style: TextStyle(color: Theme.of(context).disabledColor),
                    ),
                  ],
                ),
                // store name
                VerticalDivider(
                  thickness: 2.5,
                  color: Theme.of(context).disabledColor,
                ),
                Column(
                  children: [
                    Text(
                      S.current.storeName,
                      style: Theme.of(context).textTheme.button,
                    ),
                    Text(
                      (element.storeName ?? S.current.unknown) +
                          '(${element.branchName})',
                      style: TextStyle(color: Theme.of(context).disabledColor),
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 2.5,
                  color: Theme.of(context).disabledColor,
                ),
                // delivery date
                Column(
                  children: [
                    Text(
                      S.current.deliverDate,
                      style: Theme.of(context).textTheme.button,
                    ),
                    Text(
                      element.deliveryDate,
                      style: TextStyle(color: Theme.of(context).disabledColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
    return widgets;
  }

}

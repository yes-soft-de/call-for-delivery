import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';

class OrderCashCard extends StatelessWidget {
  final String orderNumber;
  final String deliveryDate;
  final String createdDate;
  final num orderCost;
  final Color? background;
  final Function(int) answer;
  OrderCashCard(
      {required this.orderNumber,
      required this.createdDate,
      required this.deliveryDate,
      required this.orderCost,
      this.background,
      required this.answer});

  @override
  Widget build(BuildContext context) {
    var color = background ?? Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        Container(
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
                // order number & order status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    verticalTile(context,
                        title: S.current.orderNumber, subtitle: orderNumber),
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
                        title: S.current.cost,
                        subtitle: FixedNumber.getFixedNumber(orderCost) +
                            ' ' +
                            S.current.sar),
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
        Padding(
          padding: const EdgeInsets.only(right: 12.0, left: 12.0),
          child: Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, shape: StadiumBorder()),
                  onPressed: () {
                    answer(1);
                  },
                  child: Text(
                    S.current.financePaid,
                    style: TextStyle(color: Colors.white),
                  )),
              Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red, shape: StadiumBorder()),
                  onPressed: () {
                    answer(2);
                  },
                  child: Text(
                    S.current.financeUnPaid,
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        )
      ],
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

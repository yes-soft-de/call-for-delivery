import 'package:flutter/material.dart';

class OrdersDetailsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? cardColor;
  final Function()? onTap;

  const OrdersDetailsCard(
      {Key? key, required this.title, required this.value, this.cardColor, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Card(
              color: cardColor ?? Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Container(
                    constraints: BoxConstraints(minHeight: 35, minWidth: 35),
                    child: Center(
                        child: Text(
                      value,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ))),
              )),
        ),
        Text(title, style: Theme.of(context).textTheme.titleMedium)
      ],
    );
  }
}

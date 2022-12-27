import 'package:c4d/consts/order_status.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class CustomStep extends StatelessWidget {
  final OrderStatusEnum status;
  final int currentIndex;
  CustomStep({required this.status, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: currentIndex >= StatusHelper.getOrderStatusIndex(status)
            ? LinearGradient(colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.85),
                Theme.of(context).colorScheme.primary.withOpacity(0.85),
                Theme.of(context).colorScheme.primary.withOpacity(0.9),
                Theme.of(context).colorScheme.primary.withOpacity(0.93),
                Theme.of(context).colorScheme.primary.withOpacity(0.95),
                Theme.of(context).colorScheme.primary,
              ])
            : null,
        color: currentIndex >= StatusHelper.getOrderStatusIndex(status)
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).disabledColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(
            currentIndex >= StatusHelper.getOrderStatusIndex(status)
                ? 18.0
                : 14),
        child: Text(
          '${StatusHelper.getOrderStatusIndex(status) + 1}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

class CustomStepForStore extends StatelessWidget {
  final OrderStatusEnum status;
  final int currentIndex;
  CustomStepForStore({required this.status, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex >= StatusHelper.getOrderStatusIndex(status)
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(
            currentIndex >= StatusHelper.getOrderStatusIndex(status)
                ? 18.0
                : 14),
        child: Text(
          '${StatusHelper.getOrderStatusIndexForStore(status) + 1}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

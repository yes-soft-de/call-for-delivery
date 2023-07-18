import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/payment_history_model.dart';
import 'package:flutter/material.dart';

Color get _blue => const Color(0xff2C5085);
Color get _yellow => const Color(0xffFFF975);

class PaymentWidget extends StatelessWidget {
  final PaymentHistoryModel model;

  const PaymentWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.attach_money,
              color: _yellow,
              size: 40,
              weight: 1,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  S.current.totalReceivedByTheSpecifiedDate,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            Card(
              color: _yellow,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
                child: Text(
                  S.current.valueRiyal(model.subscriptionCost.toString()),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: _blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

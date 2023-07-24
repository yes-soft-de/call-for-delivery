import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/model/receipts_model.dart';
import 'package:flutter/material.dart';

class PaymentWidget extends StatelessWidget {
  final ReceiptsModel model;
  final void Function() onPressed;

  const PaymentWidget({
    super.key,
    required this.model,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff434083),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  S.current.toBePaid,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  S.current.valueRiyal(model.subscriptionCost.toString()),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: model.hasTpPay ? Colors.amber : Colors.white,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: Color(0xff434083),
                  ),
                  Text(
                    S.current.registerPayment,
                    style: TextStyle(
                      color: Color(0xff434083),
                    ),
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

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_previous_payments_model.dart';
import 'package:flutter/material.dart';

Color get _primary => Color(0xff7E7ED4);
Color get _white => Colors.white;
Color get _grey => Colors.grey;

class PaymentWidget extends StatelessWidget {
  final CaptainPreviousPaymentsModel model;
  final void Function() onPressed;

  const PaymentWidget({
    super.key,
    required this.model,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _primary,
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
                  S.current.valueRiyal(model.toBePaid.toString()),
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
                backgroundColor: model.hasTpPay ? _white : _grey,
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

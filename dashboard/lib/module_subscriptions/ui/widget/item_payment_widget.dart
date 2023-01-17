import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/model/store_subscriptions_financial.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemPaymentWidget extends StatelessWidget {
  final PaymentModel paymentModel;
  Function()? onPressed;
  ItemPaymentWidget({required this.paymentModel, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).backgroundColor,
          ),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onTap: paymentModel.note != null
                ? () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            title: Text(S.current.note),
                            content: Container(
                              child: Text(paymentModel.note ?? ''),
                            ),
                          );
                        });
                  }
                : null,
            leading: const Icon(Icons.credit_card_rounded),
            title: Text(S.current.paymentAmount),
            subtitle: Text(FixedNumber.getFixedNumber(paymentModel.amount) +
                ' ${S.current.sar}'),
            trailing: SizedBox(
              width: 150,
              child: Row(
                children: [
                  Text(
                      DateFormat('yyyy/M/dd').format(paymentModel.paymentDate)),
                  Spacer(),
                  IconButton(onPressed: onPressed, icon: Icon(Icons.delete))
                ],
              ),
            ),
          )),
    );
  }
}

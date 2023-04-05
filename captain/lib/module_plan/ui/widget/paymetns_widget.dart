import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentsWidget extends StatelessWidget {
  final String? note;
  final num amount;
  final DateTime paymentDate;
  const PaymentsWidget({
    Key? key,
    required this.note,
    required this.amount,
    required this.paymentDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.background,
          ),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onTap: note != null
                ? () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            title: Text(S.current.note),
                            // ignore: avoid_unnecessary_containers
                            content: Container(
                              child: Text(note ?? ''),
                            ),
                          );
                        });
                  }
                : null,
            leading: const Icon(Icons.credit_card_rounded),
            title: Text(S.current.paymentAmount),
            subtitle: Text(FixedNumber.getFixedNumber(amount)),
            trailing: SizedBox(
              width: 150,
              child: Row(
                children: [
                  Text(DateFormat('yyyy/M/dd').format(paymentDate)),
                  const SizedBox(
                    width: 16,
                  ),
                  Visibility(
                    visible: false,
                    child: IconButton(
                        splashRadius: 15,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlertDialog(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    content: S
                                        .current.areYouSureToDeleteThisPayment);
                              });
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

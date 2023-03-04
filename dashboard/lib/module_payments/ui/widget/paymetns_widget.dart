import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentsWidget extends StatelessWidget {
  final int id;
  final String? note;
  final num amount;
  final DateTime paymentDate;
  final Function(int, num, String) onEdit;
  final Function(int) delete;
  const PaymentsWidget({
    Key? key,
    required this.note,
    required this.amount,
    required this.paymentDate,
    required this.onEdit,
    required this.delete,
    required this.id,
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
                    visible: true,
                    child: IconButton(
                        splashRadius: 15,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlertDialog(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    delete(id);
                                  },
                                  content:
                                      S.current.areYouSureToDeleteThisPayment,
                                  oneAction: false,
                                );
                              });
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                  Visibility(
                    visible: true,
                    child: IconButton(
                        splashRadius: 15,
                        onPressed: () {
                          final _amount = TextEditingController();
                          _amount.text = amount.toString();
                          final _note = TextEditingController();
                          _note.text = note ?? '';
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return AlertDialog(
                                    scrollable: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    title: Text(S.current.paymentFromStore),
                                    content: Container(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title:
                                                Text(S.current.paymentAmount),
                                            subtitle: CustomFormField(
                                              onChanged: () {
                                                setState(() {});
                                              },
                                              numbers: true,
                                              controller: _amount,
                                              hintText: '100',
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(S.current.note),
                                            subtitle: CustomFormField(
                                              controller: _note,
                                              hintText: S.current.note,
                                              last: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      ElevatedButton(
                                          onPressed: _amount.text.isEmpty
                                              ? null
                                              : () {
                                                  Navigator.of(context).pop();
                                                  onEdit(
                                                      id,
                                                      num.tryParse(
                                                              _amount.text) ??
                                                          0,
                                                      _note.text);
                                                },
                                          child: Text(
                                            S.current.pay,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            _amount.clear();
                                            _note.clear();
                                          },
                                          child: Text(
                                            S.current.cancel,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ))
                                    ],
                                  );
                                });
                              });
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

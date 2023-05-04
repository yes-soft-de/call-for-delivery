import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/stores_dues/store_dues_model.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/helpers/date_utilts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StoreDuesMonthlyCard extends StatelessWidget {
  final StoreDuesModel model;
  final Function(num, String) onPay;

  const StoreDuesMonthlyCard(
      {Key? key, required this.model, required this.onPay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                getMonthFName(model.month),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.blue[900]),
              ),
              _DataRow(
                title: S.current.dues,
                value: '${model.amount} ${S.current.sar}',
              ),
              _DataRow(
                title: _getToBePaidFieldTitle(model.toBePaid),
                value: '${model.toBePaid.abs()} ${S.current.sar}',
              ),
              _PaymentStatus(model: model, onPay: onPay)
            ],
          ),
        ),
      ),
    );
  }
}

String _getToBePaidFieldTitle(int toBePaid) {
  if (toBePaid < 0) {
    return S.current.prePayments;
  }
  return S.current.leftToPay;
}

class _DataRow extends StatelessWidget {
  final String title;
  final String value;
  const _DataRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // TODO: use Theme.of(context).colorScheme
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.blue[900]),
            ),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.blue[900]),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentStatus extends StatelessWidget {
  final StoreDuesModel model;
  final Function(num, String) onPay;

  const _PaymentStatus({Key? key, required this.model, required this.onPay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // all paid
    if (model.toBePaid <= 0)
      return Card(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          child: Text(
            S.current.allPaid,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      );
    // unPaid
    else if (model.toBePaid == model.amount) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PayButton(
            model: model,
            onPay: onPay,
          ),
          Expanded(
            flex: 2,
            child: Card(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Center(
                  child: Text(
                    S.current.unPaid,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
      // partially paid
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PayButton(
            model: model,
            onPay: onPay,
          ),
          Expanded(
            flex: 2,
            child: Card(
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Center(
                  child: Text(
                    S.current.partiallyPaid,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}

class _PayButton extends StatelessWidget {
  final StoreDuesModel model;
  final Function(num, String) onPay;

  const _PayButton({
    Key? key,
    required this.model,
    required this.onPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: InkWell(
        onTap: () {
          final _amount = TextEditingController();
          final _note = TextEditingController();
          showPaymentDialog(context, _amount, _note);
        },
        child: Card(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Center(
              child: Text(
                S.current.pay,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showPaymentDialog(BuildContext context,
      TextEditingController _amount, TextEditingController _note) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text(S.current.addaPayment)),
                  Flexible(
                    child: Text(DateFormat('yyyy/M/dd').format(DateTime.now())),
                  ),
                ],
              ),
              content: Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(S.current.paymentAmount),
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
                        minLines: 2,
                        maxLines: 3,
                        onChanged: () {
                          setState(() {});
                        },
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
                            onPay(num.tryParse(_amount.text) ?? 0, _note.text);
                          },
                    child: Text(
                      S.current.pay,
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _amount.clear();
                      _note.clear();
                    },
                    child: Text(
                      S.current.cancel,
                      style: Theme.of(context).textTheme.labelLarge,
                    ))
              ],
            );
          });
        });
  }
}

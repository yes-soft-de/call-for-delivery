import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/request/add_payment_to_captain_request.dart';
import 'package:c4d/module_payments/ui/widget/selectable_item.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color get _blue => Color(0xff4A51C9);

class AddPaymentToCaptainDialog extends StatefulWidget {
  final Function(AddPaymentToCaptainRequest request) onConfirmed;

  const AddPaymentToCaptainDialog({super.key, required this.onConfirmed});

  @override
  State<AddPaymentToCaptainDialog> createState() =>
      _AddPaymentToCaptainDialogState();
}

class _AddPaymentToCaptainDialogState extends State<AddPaymentToCaptainDialog> {
  var _key = GlobalKey<FormState>();
  var _paymentController = TextEditingController();
  var _noteController = TextEditingController();
  CaptainPaymentType _type = CaptainPaymentType.cash;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.addPayment,
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    DateFormat('yyyy/mm/dd').format(DateTime.now()),
                    style: textTheme.titleLarge,
                  ),
                ],
              ),
              SizedBox(height: 10),
              // payment filed
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.current.paymentAmount),
                  CustomFormField(
                    controller: _paymentController,
                    numbers: true,
                    hintText: '100',
                    onChanged: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              // note filed
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.current.note),
                  CustomFormField(
                    controller: _noteController,
                    hintText: S.current.note,
                    maxLines: 3,
                  ),
                ],
              ),
              SizedBox(height: 10),
              // payment type
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableItem<CaptainPaymentType>(
                    onTap: () {
                      _type = CaptainPaymentType.cash;
                      setState(() {});
                    },
                    selectedValue: _type,
                    title: '${S.current.cash} (${S.current.byHand})',
                    value: CaptainPaymentType.cash,
                    thumpSize: 25,
                  ),
                  SelectableItem<CaptainPaymentType>(
                    onTap: () {
                      _type = CaptainPaymentType.bankTransfer;
                      setState(() {});
                    },
                    selectedValue: _type,
                    title: S.current.bankTransfer,
                    value: CaptainPaymentType.bankTransfer,
                    thumpSize: 25,
                  ),
                ],
              ),
              SizedBox(height: 30),
              // buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: _blue),
                    onPressed: (_paymentController.text.isNotEmpty)
                        ? () {
                            var request = AddPaymentToCaptainRequest(
                              amount:
                                  num.tryParse(_paymentController.text) ?? 0,
                              captainId: -1,
                              type: _type,
                              note: _noteController.text,
                            );
                            widget.onConfirmed(request);
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(S.current.pay),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: _blue),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(S.current.cancel),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

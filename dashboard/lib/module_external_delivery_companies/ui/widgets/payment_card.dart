import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/selectable_item.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatefulWidget {
  final Function(PaymentType paymentType) onPaymentTypeChange;
  final Function(int? cashLimit) onCashLimitChange;
  final PaymentType paymentType;
  final int? cashLimit;

  const PaymentCard({
    super.key,
    required this.onPaymentTypeChange,
    required this.paymentType,
    required this.cashLimit,
    required this.onCashLimitChange,
  });

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  late PaymentType paymentType;
  bool flag = true;
  var cashLimitTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      paymentType = widget.paymentType;
      cashLimitTextController.text = widget.cashLimit?.toString() ?? '';
    }
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.paymentMethod),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableItem<PaymentType>(
                  value: PaymentType.card,
                  onTap: () {
                    paymentType = PaymentType.card;
                    setState(() {});
                    widget.onPaymentTypeChange(paymentType);
                  },
                  selectedValue: paymentType,
                  title: S.current.card,
                ),
                SelectableItem<PaymentType>(
                  value: PaymentType.cash,
                  onTap: () {
                    paymentType = PaymentType.cash;
                    setState(() {});
                    widget.onPaymentTypeChange(paymentType);
                  },
                  selectedValue: paymentType,
                  title: S.current.cash,
                ),
                SelectableItem<PaymentType>(
                  value: PaymentType.all,
                  onTap: () {
                    paymentType = PaymentType.all;
                    setState(() {});
                    widget.onPaymentTypeChange(paymentType);
                  },
                  selectedValue: paymentType,
                  title: S.current.all,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _Form(
                      textController: cashLimitTextController,
                      onChange: (value) {
                        widget.onCashLimitChange(int.tryParse(value ?? ''));
                      },
                    ),
                    SizedBox(width: 10),
                    Text(S.current.sar),
                  ],
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                  child: Text(
                    S.current.ifNoValuesSetAllOrderWillBeSent,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({
    required this.textController,
    required this.onChange,
  });

  final TextEditingController textController;
  final Function(String? value) onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      child: Container(
        width: 100,
        child: CustomFormField(
          radius: 10,
          backgroundColor: Colors.white,
          controller: textController,
          numbers: true,
          onChanged: () {
            onChange(textController.text);
          },
        ),
      ),
    );
  }
}

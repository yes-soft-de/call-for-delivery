import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/selectable_item.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatefulWidget {
  final Function(PaymentType paymentType) onChange;
  final PaymentType paymentType;

  const PaymentCard(
      {super.key, required this.onChange, required this.paymentType});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  late PaymentType paymentType;
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      paymentType = widget.paymentType;
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
                    widget.onChange(paymentType);
                  },
                  selectedValue: paymentType,
                  title: S.current.card,
                ),
                SelectableItem<PaymentType>(
                  value: PaymentType.cash,
                  onTap: () {
                    paymentType = PaymentType.cash;
                    setState(() {});
                    widget.onChange(paymentType);
                  },
                  selectedValue: paymentType,
                  title: S.current.cash,
                ),
                SelectableItem<PaymentType>(
                  value: PaymentType.all,
                  onTap: () {
                    paymentType = PaymentType.all;
                    setState(() {});
                    widget.onChange(paymentType);
                  },
                  selectedValue: paymentType,
                  title: S.current.all,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



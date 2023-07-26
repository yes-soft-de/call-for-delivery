import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

enum PaymentType {
  cash,
  notSpecified,
  card;
  
  static PaymentType fromInt(int paymentType) {
    if (paymentType == 236) return PaymentType.cash;
    if (paymentType == 235) return PaymentType.notSpecified;
    return PaymentType.card;
  }

  String get paymentTypeName {
    if (this == PaymentType.cash) return S.current.cash;
    if (this == PaymentType.notSpecified) return S.current.skipped;
    return S.current.card;
  }

  Color get paymentTypeColor {
    if (this == PaymentType.cash) return Color(0xff434083);
    if (this == PaymentType.notSpecified) return Colors.red;
    return Colors.amber;
  }

}

class PaymentCard extends StatelessWidget {
  final String paymentValue;
  final PaymentType paymentType;
  final String date;

  PaymentCard({
    required this.paymentValue,
    required this.paymentType,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        color: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: new BoxDecoration(
            border: BorderDirectional(
              start: BorderSide(width: 8, color: paymentType.paymentTypeColor),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  paymentValue,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  paymentType.paymentTypeName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  date,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

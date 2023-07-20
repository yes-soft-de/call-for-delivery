import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

Color get _blue => const Color(0xff2C5085);
Color get _red => Colors.red;
Color get _lightBlue => const Color(0xffF2FAFD);

enum PaymentType {
  cash,
  bankTransfer;

  /// default value is [PaymentType.cash]
  static PaymentType fromInt(int paymentType) {
    if (paymentType == 236) return PaymentType.cash;
    if (paymentType == 225 || paymentType == 226 || paymentType == 227) {
      return PaymentType.bankTransfer;
    }
    return PaymentType.cash;
  }

  String get paymentTypeName {
    if (this == PaymentType.cash) return S.current.cash;
    return S.current.bankTransfer;
  }

  Color get paymentTypeColor {
    if (this == PaymentType.cash) return _blue;
    return _red;
  }
}

class PaymentCard extends StatelessWidget {
  final String paymentValue;
  final PaymentType paymentType;
  final String date;

  const PaymentCard({
    required this.paymentValue,
    required this.paymentType,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        color: _lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
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

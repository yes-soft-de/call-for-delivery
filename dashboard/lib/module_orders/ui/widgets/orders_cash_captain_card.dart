import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/ui/widgets/bubble_widget.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';

class OrdersCashCaptainCard extends StatelessWidget {
  final String captainName;
  final int orderId;
  final num amount;
  final int flag;
  final String createdAt;
  final String? captainNote;
  final num storeAmount;
  const OrdersCashCaptainCard(
      {Key? key,
      required this.amount,
      required this.captainName,
      required this.createdAt,
      required this.flag,
      required this.orderId,
      required this.captainNote,
      required this.storeAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 0.5,
                offset: const Offset(-1, 0),
                color: Theme.of(context).backgroundColor),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // financial date & orderID
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: VerticalBubble(
                          title: S.current.deliverDate, subtitle: createdAt)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 2.5,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Expanded(
                      child: VerticalBubble(
                          title: S.current.orderNumber,
                          subtitle: '#' + orderId.toString())),
                ],
              ),
            ),
            // captain
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 145,
                child: VerticalBubble(
                  title: S.current.orderCashWithCaptain,
                  subtitle:
                      FixedNumber.getFixedNumber(amount) + ' ${S.current.sar}',
                ),
              ),
            ),
            Visibility(
              visible: captainNote != null,
              child: Flushbar(
                title: S.current.captainNote,
                message: captainNote ?? '',
                borderRadius: BorderRadius.circular(25),
                flushbarStyle: FlushbarStyle.FLOATING,
                backgroundColor: Colors.amber,
              ),
            ),
            // store
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: VerticalBubble(
                      title: S.current.orderPrice,
                      subtitle: FixedNumber.getFixedNumber(storeAmount) +
                          ' ${S.current.sar}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 2.5,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Expanded(
                      child: VerticalBubble(
                    title: S.current.orderCashStatus,
                    subtitle: FinanceHelper.getStatusString(flag),
                    background: FinanceHelper.getFinanceStatusColor(flag),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

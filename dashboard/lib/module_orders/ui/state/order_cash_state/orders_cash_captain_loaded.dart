import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/captain_cash_orders_finance.dart';
import 'package:c4d/module_orders/ui/screens/order_cash_captain_screen.dart';
import 'package:c4d/module_orders/ui/widgets/bubble_widget.dart';
import 'package:c4d/module_orders/ui/widgets/orders_cash_captain_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';

class OrdersCashCaptainLoadedState extends States {
  OrdersCashCaptainScreenState screenState;
  CaptainCashOrdersFinanceModel model;
  OrdersCashCaptainLoadedState(this.screenState, this.model)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    var total = model.total;
    return CustomListView.custom(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: VerticalBubble(
                radius: BorderRadius.circular(0),
                title: S.current.sumAmountWithCaptain,
                subtitle:
                    FixedNumber.getFixedNumber(total.sumAmountWithCaptain) +
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
                radius: BorderRadius.circular(0),
                title: S.current.sumPaymentsToCaptain,
                subtitle:
                    FixedNumber.getFixedNumber(total.sumPaymentsToCaptain) +
                        ' ${S.current.sar}',
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 120, right: 120),
        child: VerticalBubble(
          radius: BorderRadius.circular(0),
          title: S.current.total,
          background: total.advancePayment ? Colors.green : Colors.red,
          subtitle:
              FixedNumber.getFixedNumber(total.total) + ' ${S.current.sar}',
          subtitleText: true,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Divider(
          indent: 16,
          endIndent: 16,
          thickness: 2.5,
          color: Theme.of(context).backgroundColor,
        ),
      ),
      Column(
        children: getOrders(),
      )
    ]);
  }

  List<Widget> getOrders() {
    var context = screenState.context;
    List<Widget> widgets = [];
    model.orders.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: OrdersCashCaptainCard(
          amount: element.amount,
          captainName: element.captainName,
          createdAt: element.createdAt,
          flag: element.flag,
          orderId: element.orderId,
        ),
      ));
    });
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/hive/util/argument_hive_helper.dart';
import 'package:c4d/module_orders/model/captain_cash_orders_finance.dart';
import 'package:c4d/module_orders/ui/screens/order_cash_captain_screen.dart';
import 'package:c4d/module_orders/ui/widgets/bubble_widget.dart';
import 'package:c4d/module_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/module_orders/ui/widgets/orders_cash_captain_card.dart';
import 'package:c4d/module_payments/payments_routes.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersCashCaptainLoadedState extends States {
  OrdersCashCaptainScreenState screenState;
  CaptainCashOrdersFinanceModel model;
  OrdersCashCaptainLoadedState(this.screenState, this.model)
      : super(screenState) {
    if (model.total.sumAmountWithCaptain > 0) {
      screenState.canMakePayment = true;
      screenState.paymentLimit = model.total.sumAmountWithCaptain;
      screenState.refresh();
    }
  }

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
                title: S.current.sumPaymentsFromCaptain,
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
      // bar
      FilterBar(
        cursorRadius: BorderRadius.circular(25),
        animationDuration: Duration(milliseconds: 350),
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: screenState.currentIndex,
        borderRadius: BorderRadius.circular(25),
        floating: true,
        height: 40,
        cursorColor: Theme.of(context).colorScheme.primary,
        items: [
          FilterItem(label: S.current.unPaidOrder),
          FilterItem(
            label: S.current.paidOrder,
          ),
        ],
        onItemSelected: (index) {
          screenState.currentIndex = index;
          screenState.refresh();
        },
        selectedContent: Theme.of(context).textTheme.button!.color!,
        unselectedContent: Theme.of(context).textTheme.headline6!.color!,
      ),

      //
      Column(
        children: screenState.currentIndex == 0 ? getOrders() : getPayments(),
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
          captainNote: element.captainNote,
          storeAmount: element.storeAmount,
        ),
      ));
    });
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }

  List<Widget> getPayments() {
    List<Widget> widgets = [];
    model.finishedPayment.forEach((element) {
      var create = DateFormat.jm()
              .format(DateHelper.convert(element.createdAt?.timestamp)) +
          ' 📅 ' +
          DateFormat.Md()
              .format(DateHelper.convert(element.createdAt?.timestamp));

      widgets.add(
        OrdersCashCaptainCard(
          amount: element.amount ?? 0,
          captainName: element.captainName ?? S.current.unknown,
          createdAt: create,
          flag: element.flag ?? -1,
          orderId: element.orderId ?? -1,
          captainNote: element.captainNote,
          storeAmount: element.storeAmount ?? 0,
        ),
      );
    });
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}

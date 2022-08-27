import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/module_subscription/model/store_subscriptions_financial.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/helpers/subscription_status_helper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class StoreSubscriptionsFinanceDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      StoreSubscriptionsFinanceDetailsScreenState();
}

class StoreSubscriptionsFinanceDetailsScreenState
    extends State<StoreSubscriptionsFinanceDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  late StoreSubscriptionsFinanceModel model;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is StoreSubscriptionsFinanceModel) {
      model = args;
    }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.financeSubscriptionDetails),
        body: CustomListView.custom(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      Theme.of(context).colorScheme.primary.withOpacity(0.9),
                      Theme.of(context).colorScheme.primary,
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getDetails(),
                ),
              ),
            ),
            Column(
              children: getPayments(),
            )
          ],
        ));
  }

  Widget getDetails() {
    return Column(
      children: [
        Text(
          model.packageName,
          style: TextStyle(
              color: Theme.of(context).textTheme.button?.color,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding:
              const EdgeInsets.only(right: 16.0, left: 16, top: 16, bottom: 16),
          child: DottedLine(
            dashColor: Theme.of(context).backgroundColor,
            lineThickness: 2.5,
            dashRadius: 25,
          ),
        ),
        RowBubble(
            firstBubble: verticalBubble(
                subtitle: model.startDate, title: S.current.subscriptionDate),
            secondBubble: verticalBubble(
                subtitle: model.endDate, title: S.current.expirationData)),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.subscriptionStatus),
            secondBubble: verticalBubble(
                title: SubscriptionsStatusHelper.getStatusMessage(model.status),
                background:
                    SubscriptionsStatusHelper.getStatusColor(model.status))),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.packageType),
            secondBubble: verticalBubble(
                title: model.packageType == 1
                    ? S.current.packageTypeOnOrder
                    : S.current.packageTypeRegular)),
        // subscription details
        Divider(
          thickness: 2.5,
          color: Theme.of(context).backgroundColor,
          indent: 32,
          endIndent: 32,
        ),
        Visibility(
          visible: model.ordersExceedGeographicalRange.isNotEmpty,
          child: Column(
            children: [
              RowBubble(
                  firstBubble: verticalBubble(
                      title: S.current.ordersExceedGeographicalRange),
                  secondBubble: verticalBubble(
                      title: model.ordersExceedGeographicalRange.length
                              .toString() +
                          ' ' +
                          S.current.sOrder)),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Scaffold(
                            appBar: CustomC4dAppBar.appBar(context,
                                title: S.current.order),
                            body: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                    children: getOrders(context,
                                        model.ordersExceedGeographicalRange),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(S.current.close))
                              ],
                            ),
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  child: Text(
                    S.current.showAll,
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
        //
        Divider(
          thickness: 2.5,
          color: Theme.of(context).backgroundColor,
          indent: 32,
          endIndent: 32,
        ),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.totalExtraDistance),
            secondBubble: verticalBubble(
                title:
                    FixedNumber.getFixedNumber(model.total.totalDistanceExtra)
                            .toString() +
                        ' ${S.current.sar}')),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.extraCost),
            secondBubble: verticalBubble(
                title: FixedNumber.getFixedNumber(model.total.extraCost)
                        .toString() +
                    ' ${S.current.sar}')),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.packageCost),
            secondBubble: verticalBubble(
                title: FixedNumber.getFixedNumber(model.total.packageCost)
                        .toString() +
                    ' ${S.current.sar}')),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.captainsOffer),
            secondBubble: verticalBubble(
                title: FixedNumber.getFixedNumber(model.total.captainOffer)
                        .toString() +
                    ' ${S.current.sar}')),
        Visibility(
          visible: model.captainsOffer.isNotEmpty,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(), primary: Colors.amber),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(S.current.captainOffers),
                        scrollable: true,
                        content: Container(
                          child: Column(
                            children: getCaptainOffers(model),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(S.current.cancel))
                        ],
                      );
                    });
              },
              child: Text(
                S.current.captainOffers,
                style: TextStyle(color: Colors.white),
              )),
        ),

        RowBubble(
            firstBubble: verticalBubble(title: S.current.sumPayments),
            secondBubble: verticalBubble(
                title:
                    model.total.sumPayments.toString() + ' ${S.current.sar}')),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.requiredToPay),
            secondBubble: verticalBubble(
                title: FixedNumber.getFixedNumber(model.total.requiredToPay)
                        .toString() +
                    ' ${S.current.sar}')),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            indent: 16,
            endIndent: 16,
            thickness: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        Container(
          constraints: BoxConstraints(minWidth: 125, maxWidth: 150),
          child: verticalBubble(
              subtitle: model.total.total.toString() + ' ${S.current.sar}',
              title: S.current.leftToPay,
              background: model.total.advancePayment == false
                  ? Colors.green
                  : Colors.red),
        )
      ],
    );
  }

  List<Widget> getCaptainOffers(StoreSubscriptionsFinanceModel model) {
    List<Widget> widgets = [];
    model.captainsOffer.forEach((element) {
      var date = DateFormat.yMEd()
              .format(DateHelper.convert(element.startDate?.timestamp)) +
          ' ' +
          DateFormat.jm()
              .format(DateHelper.convert(element.startDate?.timestamp));
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          tileColor: Theme.of(context).backgroundColor,
          title: Text(FixedNumber.getFixedNumber(element.price ?? 0) +
              ' ${S.current.sar}'),
          subtitle: Text(date),
        ),
      ));
    });
    return widgets;
  }

  List<Widget> getOrders(context, List<OrderModel> orders) {
    List<Widget> widgets = [];
    orders.forEach((element) {
      widgets.add(
        InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(OrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id);
            },
            child: OwnerOrderCard(
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              note: element.note,
              orderCost: element.orderCost,
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              orderIsMain: element.orderIsMain,
            )),
      );
    });
    return widgets;
  }

  Widget RowBubble(
      {required Widget firstBubble, required Widget secondBubble}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: firstBubble),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 32,
              height: 2.5,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          Expanded(child: secondBubble),
        ],
      ),
    );
  }

  Widget verticalBubble(
      {required String title,
      String? subtitle,
      Color? background,
      bool subtitleText = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: background ?? Theme.of(context).backgroundColor,
      ),
      child: Visibility(
        visible: subtitle != null,
        replacement: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: background != null ? Colors.white : null)),
        ),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title,
              style: TextStyle(
                  fontSize: 14,
                  color: background != null ? Colors.white : null)),
          subtitle: Text(subtitle ?? '',
              style: TextStyle(
                  color: background != null ? Colors.white : null,
                  fontSize: subtitleText ? 14 : null)),
        ),
      ),
    );
  }

  List<Widget> getPayments() {
    List<Widget> widgets = [];
    model.paymentsFromStore.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).backgroundColor,
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onTap: element.note != null
                  ? () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              title: Text(S.current.note),
                              content: Container(
                                child: Text(element.note ?? ''),
                              ),
                            );
                          });
                    }
                  : null,
              leading: const Icon(Icons.credit_card_rounded),
              title: Text(S.current.paymentAmount),
              subtitle: Text(FixedNumber.getFixedNumber(element.amount) +
                  ' ${S.current.sar}'),
              trailing: SizedBox(
                child:
                    Text(DateFormat('yyyy/M/dd').format(element.paymentDate)),
              ),
            )),
      ));
    });
    if (widgets.isNotEmpty) {
      widgets.insert(
        0,
        const Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16),
          child: Divider(
            thickness: 2,
          ),
        ),
      );
    }
    return widgets;
  }
}

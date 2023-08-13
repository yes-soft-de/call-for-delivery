import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order_captain_logs_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/orders_captain_screen.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/icon_info_button.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderCaptainLogsLoadedState extends States {
  OrderCaptainLogsScreenState screenState;
  OrderCaptainLogsModel orders;
  OrderCaptainLogsLoadedState(this.screenState, this.orders)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders(context));
  }

  List<Widget> getOrders(context) {
    List<Widget> widgets = [];
    widgets.add(Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.boxes,
                  color: Theme.of(context).disabledColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                  child: Text(
                    S.current.countOrders,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                    child: Text(
                  orders.countOrders.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).disabledColor,
                      fontWeight: FontWeight.bold),
                ))
              ],
            ),
          ),
        ),
        Visibility(
          visible: orders.cashOrder != null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.boxes,
                    color: Theme.of(context).disabledColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                    child: Text(
                      S.current.totalCashOrder,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                      child: Text(
                    FixedNumber.getFixedNumber(orders.cashOrder ?? 0) +
                        ' ' +
                        S.current.sar,
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            ),
          ),
        )
      ],
    ));
    orders.orders.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.of(screenState.context).pushNamed(
                  OrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id);
            },
            child: _CaptainOrderCard(
              captainProfileId: element.captainProfileId,
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              orderCost: element.orderCost,
              note: element.note,
              orderIsMain: false,
              captainProfit: element.captainProfit ?? 0,
            ),
          ),
        ),
      ));
    });
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}

class _CaptainOrderCard extends StatelessWidget {
  final String orderNumber;
  final String orderStatus;
  final String deliveryDate;
  final String createdDate;
  final num orderCost;
  final String? note;
  final bool orderIsMain;
  final int? captainProfileId;
  final num captainProfit;

  _CaptainOrderCard({
    required this.orderNumber,
    required this.orderStatus,
    required this.createdDate,
    required this.deliveryDate,
    required this.orderCost,
    required this.note,
    required this.orderIsMain,
    required this.captainProfileId,
    required this.captainProfit,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(colors: [
                color.withOpacity(0.85),
                color.withOpacity(0.85),
                color.withOpacity(0.9),
                color.withOpacity(0.93),
                color.withOpacity(0.95),
                color,
              ])),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Visibility(
                  visible: orderIsMain,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.tag,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.amber),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.current.groupOrder,
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Spacer(),
                      Visibility(
                        visible: note != null,
                        child: InfoButtonOrder(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(S.current.note),
                                    content: Container(child: Text(note ?? '')),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(S.current.close)),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                  replacement: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      SizedBox(),
                      Visibility(
                        visible: note != null,
                        child: InfoButtonOrder(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(S.current.note),
                                    content: Container(child: Text(note ?? '')),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(S.current.close)),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // order number & order status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    verticalTile(context,
                        title: S.current.orderNumber, subtitle: orderNumber),
                    verticalTile(context,
                        title: S.current.orderStatus, subtitle: orderStatus),
                  ],
                ),
                // divider
                divider(context),
                // order date & create date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    verticalTile(
                      context,
                      title: S.current.deliverDate,
                      subtitle: deliveryDate,
                    ),
                    verticalTile(context,
                        title: S.current.createdDate, subtitle: createdDate),
                  ],
                ),

                // divider
                divider(context),
                // order cost
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    verticalTile(context,
                        title: S.current.cost,
                        subtitle: FixedNumber.getFixedNumber(orderCost) +
                            ' ' +
                            S.current.sar),
                    verticalTile(context,
                        title: S.current.captainProfit,
                        subtitle: FixedNumber.getFixedNumber(captainProfit) +
                            ' ' +
                            S.current.sar),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget verticalTile(context,
      {required String title, required String subtitle}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.labelLarge?.color),
        ),
        Text(subtitle,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.normal)),
      ],
    );
  }

  Widget divider(context) {
    Color dividerColor = Theme.of(context).textTheme.labelLarge!.color!;
    return Divider(
      thickness: 2,
      indent: 16,
      endIndent: 16,
      color: dividerColor,
    );
  }
}

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/model/order_details/order_details_model.dart';
import 'package:c4d/module_bid_orders/ui/screens/orders/order_details_screen.dart';
import 'package:c4d/module_bid_orders/ui/widgets/custom_step.dart';
import 'package:c4d/module_bid_orders/ui/widgets/progress_order_status.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class OngoingOrderDetailsStateLoaded extends States {
  OrderDetailsModel orderInfo;
  final OrderDetailsScreenState screenState;
  OngoingOrderDetailsStateLoaded(
      this.screenState,
      this.orderInfo,
      ) : super(screenState) {
    screenState.refresh();
  }
  @override
  Widget getUI(BuildContext context) {
    var decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).backgroundColor);
    return CustomListView.custom(
      children: [
        // svg picture
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 16,
            right: 16,
          ),
          child: OrderProgressionHelper.getStatusIcon(
              orderInfo.orderState, 175, context),
        ),
        // steps
        Padding(
          padding:
          const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8),
          child: Flex(
            direction: Axis.horizontal,
            children:
            getStepper(StatusHelper.getOrderStatusIndex(orderInfo.orderState)),
          ),
        ),
        // order status
        Padding(
          padding:
          const EdgeInsets.only(right: 8.0, left: 8, bottom: 24, top: 16),
          child: ListTile(
            onTap:orderInfo.orderState != OrderStatusEnum.CANCELLED ? () {
              Navigator.of(context).pushNamed('',
//                  OrdersRoutes.OWNER_TIME_LINE_SCREEN,
                  arguments: orderInfo.id);
            } : null,
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: StatusHelper.getOrderStatusColor(orderInfo.orderState)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  StatusHelper.getOrderStatusIcon(orderInfo.orderState),
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            trailing: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: StatusHelper.getOrderStatusColor(orderInfo.orderState)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      orderInfo.deliveryDate ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white)),
                )),
            title: Text(
              StatusHelper.getOrderStatusMessages(orderInfo.orderState),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                  StatusHelper.getOrderStatusDescriptionMessages(
                      orderInfo.orderState),
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ),

        // order details tile
        ListTile(
          title: Text(S.current.orderDetails + ' #${orderInfo.id}'),
          leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).backgroundColor),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.info_rounded),
              )),
        ),
        // date widgets
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: decoration,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.delivery_dining_rounded),
                  title: Text(S.current.deliver),
                  subtitle: Text(orderInfo.deliveryDate ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: DottedLine(
                      dashColor: Theme.of(context).disabledColor,
                      lineThickness: 2.5,
                      dashRadius: 25),
                ),
                ListTile(
                  leading: Icon(Icons.access_time_filled_rounded),
                  title: Text(S.current.created),
                  subtitle: Text(orderInfo.createdDate),
                ),
              ],
            ),
          ),
        ),

        // payments
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: decoration,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.payment,
                  ),
                  title: Text(S.current.paymentMethod),
                  subtitle: Text(orderInfo.payment == 'cash'
                      ? S.current.cash
                      : S.current.card),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: DottedLine(
                      dashColor: Theme.of(context).disabledColor,
                      lineThickness: 2.5,
                      dashRadius: 25),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 75,
        ),
      ],
    );
  }

  List<Widget> getStepper(int currentIndex) {
    List<Widget> steps = [
      CustomStep(status: OrderStatusEnum.WAITING, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                    StatusHelper.getOrderStatusIndex(
                        OrderStatusEnum.GOT_CAPTAIN)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStep(
          status: OrderStatusEnum.GOT_CAPTAIN, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                    StatusHelper.getOrderStatusIndex(
                        OrderStatusEnum.IN_STORE)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStep(status: OrderStatusEnum.IN_STORE, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                    StatusHelper.getOrderStatusIndex(
                        OrderStatusEnum.DELIVERING)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStep(
          status: OrderStatusEnum.DELIVERING, currentIndex: currentIndex),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Opacity(
            opacity: 0.65,
            child: Container(
              height: 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: currentIndex <
                    StatusHelper.getOrderStatusIndex(
                        OrderStatusEnum.FINISHED)
                    ? Theme.of(screenState.context).disabledColor
                    : Theme.of(screenState.context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      CustomStep(status: OrderStatusEnum.FINISHED, currentIndex: currentIndex),
    ];
    return steps;
  }

  bool redo = false;

}
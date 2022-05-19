import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_bidorder/model/order/bidorder_details_model.dart';
import 'package:c4d/module_bidorder/ui/screens/bidorder_details/bidorder_details_screen.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/widgets/custom_step.dart';
import 'package:c4d/module_orders/ui/widgets/progress_order_status.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';

class BidOrderDetailsStateLoaded extends States {
  BidOrderDetailsModel orderInfo;
  final BidOrderDetailsScreenState screenState;
  BidOrderDetailsStateLoaded(
    this.screenState,
    this.orderInfo,
  ) : super(screenState) {}
  bool dialogShowed = false;
  var confirmMessagesStates = [
    OrderStatusEnum.IN_STORE,
    OrderStatusEnum.DELIVERING
  ];
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
              orderInfo.state, 175, context),
        ),
        // steps
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, left: 16, right: 16, bottom: 8),
          child: Flex(
            direction: Axis.horizontal,
            children:
                getStepper(StatusHelper.getOrderStatusIndex(orderInfo.state)),
          ),
        ),
        // order status
        Padding(
          padding:
              const EdgeInsets.only(right: 8.0, left: 8, bottom: 24, top: 16),
          child: ListTile(
            onTap: orderInfo.state != OrderStatusEnum.CANCELLED
                ? () {
                    Navigator.of(context).pushNamed(
                        OrdersRoutes.OWNER_TIME_LINE_SCREEN,
                        arguments: orderInfo.id);
                  }
                : null,
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: StatusHelper.getOrderStatusColor(orderInfo.state)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  StatusHelper.getOrderStatusIcon(orderInfo.state),
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            trailing: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: StatusHelper.getOrderStatusColor(orderInfo.state)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      Moment.now().from(orderInfo.deliveryDate).toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white)),
                )),
            title: Text(
              StatusHelper.getOrderStatusMessages(orderInfo.state),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                  StatusHelper.getOrderStatusDescriptionMessages(
                      orderInfo.state),
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ),

        // chat
        Visibility(
          visible: orderInfo.roomID != null,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(-0.2, 0)),
                ],
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.85),
                    Theme.of(context).colorScheme.primary.withOpacity(0.85),
                    Theme.of(context).colorScheme.primary.withOpacity(0.9),
                    Theme.of(context).colorScheme.primary.withOpacity(0.93),
                    Theme.of(context).colorScheme.primary.withOpacity(0.95),
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onTap: () {
                    Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                        arguments: ChatArgument(
                            roomID: orderInfo.roomID ?? '',
                            userID: orderInfo.captainID,
                            userType: 'captain'));
                  },
                  leading: Icon(
                    Icons.chat_bubble_rounded,
                    color: Theme.of(context).textTheme.button?.color,
                  ),
                  title: Text(S.current.chatRoom),
                  textColor: Theme.of(context).textTheme.button?.color,
                  subtitle: Text(S.current.chatWithCaptain),
                  trailing: Icon(Icons.arrow_forward_rounded,
                      color: Theme.of(context).textTheme.button?.color),
                ),
              ),
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
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 8, top: 8),
          child: Container(
            decoration: decoration,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.delivery_dining_rounded),
                  title: Text(S.current.deliverDate),
                  subtitle: Text(orderInfo.deliveryDateString),
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
                  title: Text(S.current.createdDate),
                  subtitle: Text(orderInfo.createdDate),
                ),
              ],
            ),
          ),
        ),
        // details
        Padding(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 8, top: 8),
          child: Container(
            decoration: decoration,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.store_rounded,
                  ),
                  title: Text(S.current.branch),
                  subtitle: Text(orderInfo.branchName),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: DottedLine(
                      dashColor: Theme.of(context).disabledColor,
                      lineThickness: 2.5,
                      dashRadius: 25),
                ),
                Visibility(
                  visible: orderInfo.image != null,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.image,
                        ),
                        title: Text(S.current.orderImage),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: CustomNetworkImage(
                                height: 100,
                                imageSource: orderInfo.image ?? '',
                                width: 100,
                              ),
                            ),
                          ),
                        ),
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
                ListTile(
                  leading: Icon(
                    Icons.info,
                  ),
                  title: Text(S.current.orderDetails),
                  subtitle: Text(orderInfo.note),
                ),
              ],
            ),
          ),
        ),
        // payments
        Padding(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 8, top: 8),
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
                ListTile(
                  leading: Icon(Icons.price_change_rounded),
                  title: Text(S.current.orderCostWithDeliveryCost),
                  subtitle: Text(
                      FixedNumber.getFixedNumber(orderInfo.orderCost) +
                          ' ' +
                          S.current.sar),
                ),
                Visibility(
                  visible: orderInfo.captainOrderCost != null,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: DottedLine(
                            dashColor: Theme.of(context).disabledColor,
                            lineThickness: 2.5,
                            dashRadius: 25),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.money,
                        ),
                        title: Text(S.current.captainOrderCost),
                        subtitle: Text(FixedNumber.getFixedNumber(
                                orderInfo.captainOrderCost ?? 0) +
                            ' ' +
                            S.current.sar),
                      ),
                      Visibility(
                        visible: orderInfo.attention != null,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: DottedLine(
                              dashColor: Theme.of(context).disabledColor,
                              lineThickness: 2.5,
                              dashRadius: 25),
                        ),
                      ),
                      Visibility(
                        visible: orderInfo.attention != null,
                        child: ListTile(
                          leading: Icon(
                            Icons.info,
                          ),
                          title: Text(S.current.captainPaymentNote),
                          subtitle: Text(orderInfo.attention ?? ''),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // category
        Padding(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 8, top: 8),
          child: Container(
            decoration: decoration,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.account_box,
                  ),
                  title: Text(S.current.orderCategory),
                  subtitle: Text(orderInfo.categoryName),
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
}

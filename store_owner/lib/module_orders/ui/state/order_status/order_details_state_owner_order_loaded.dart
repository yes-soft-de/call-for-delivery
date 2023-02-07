import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_deep_links/helper/laubcher_link_helper.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/confirm_captain_location_request.dart';
import 'package:c4d/module_orders/request/order_cash_request.dart';
import 'package:c4d/module_orders/ui/screens/order_details/order_details_screen.dart';
import 'package:c4d/module_orders/ui/widgets/custom_step.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_button.dart';
import 'package:c4d/module_orders/ui/widgets/progress_order_status.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/components/rating_form.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/request/rating_request.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsStateOwnerOrderLoaded extends States {
  OrderDetailsModel orderInfo;
  final OrderDetailsScreenState screenState;
  OrderDetailsStateOwnerOrderLoaded(
    this.screenState,
    this.orderInfo,
  ) : super(screenState) {
    if (confirmMessagesStates.contains(orderInfo.state) &&
        orderInfo.isCaptainArrived == null &&
        screenState.alertFlag) {
      screenState.alertFlag = false;
      showOwnerAlertConfirm();
    } else {}
    if (orderInfo.state == OrderStatusEnum.WAITING) {
      screenState.canRemoveIt = orderInfo.canRemove;
    }
    screenState.refresh();
  }
  bool dialogShowed = false;
  var confirmMessagesStates = [
    OrderStatusEnum.IN_STORE,
    OrderStatusEnum.DELIVERING
  ];
  @override
  Widget getUI(BuildContext context) {
    var decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.background);
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
        // captain name
        Visibility(
            visible: orderInfo.captainName != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 75,
                decoration: BoxDecoration(
                    color: StatusHelper.getOrderStatusColor(orderInfo.state),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.delivery_dining_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 220,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: orderInfo.state ==
                                              OrderStatusEnum.FINISHED
                                          ? S.current
                                                  .orderHandledDoneByCaptain +
                                              ' '
                                          : S.current.orderHandledByCaptain +
                                              ' ',
                                      style: TextStyle(color: Colors.white)),
                                  TextSpan(
                                      text: orderInfo.captainName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ],
                              ),
                              softWrap: true,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 75,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(25),
                              bottomEnd: Radius.circular(25))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              orderInfo.captainRating,
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
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
        // captain confirmation
        Visibility(
            visible: confirmMessagesStates.contains(orderInfo.state),
            child: OrderButton(
              backgroundColor: Colors.orange,
              icon: Icons.question_mark_rounded,
              onTap: () {
                showOwnerAlertConfirm();
              },
              subtitle: orderInfo.isCaptainArrived == null
                  ? (S.current.NotConfirmed)
                  : (orderInfo.isCaptainArrived == true
                      ? S.current.captainInStore
                      : S.current.captainNotInStore),
              title: S.current.captainLocation,
            )),
        // captain finance confirmation
        Visibility(
            visible: OrderStatusEnum.FINISHED == orderInfo.state,
            child: OrderButton(
              backgroundColor: Colors.orange,
              icon: Icons.question_mark_rounded,
              onTap: () {
                showConfirmOrderCash();
              },
              subtitle: orderInfo.isCashPaymentConfirmedByStore == null
                  ? (S.current.NotConfirmed)
                  : (orderInfo.isCashPaymentConfirmedByStore == 1
                      ? S.current.financePaid
                      : S.current.financeUnPaid),
              title: S.current.confirmOrderCash,
            )),

        // rate
        Visibility(
          visible: orderInfo.roomID != null,
          child: Padding(
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.amber.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(-0.2, 0)),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.amber.withOpacity(0.85),
                    Colors.amber.withOpacity(0.85),
                    Colors.amber.withOpacity(0.9),
                    Colors.amber.withOpacity(0.93),
                    Colors.amber.withOpacity(0.95),
                    Colors.amber,
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
                    final TextEditingController controller =
                        TextEditingController();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return RatingForm(
                            message: S.current.rateCaptainMessage,
                            onPressed: (rate) {
                              Navigator.of(context).pop();
                              screenState.rateCaptain(RatingRequest(
                                  rated: orderInfo.captainID,
                                  rating: rate,
                                  comment: controller.text,
                                  orderId: orderInfo.id));
                            },
                            title: S.current.rateCaptain,
                            controller: controller,
                          );
                        });
                  },
                  leading: Icon(
                    Icons.star_rounded,
                    size: 30,
                    color: Theme.of(context).textTheme.labelLarge?.color,
                  ),
                  title: Text(S.current.rating),
                  textColor: Theme.of(context).textTheme.labelLarge?.color,
                  subtitle: Text(S.current.rateCaptain),
                  trailing: Icon(Icons.arrow_forward_rounded,
                      color: Theme.of(context).textTheme.labelLarge?.color),
                ),
              ),
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
                    color: Theme.of(context).textTheme.labelLarge?.color,
                  ),
                  title: Text(S.current.chatRoom),
                  textColor: Theme.of(context).textTheme.labelLarge?.color,
                  subtitle: Text(S.current.chatWithCaptain),
                  trailing: Icon(Icons.arrow_forward_rounded,
                      color: Theme.of(context).textTheme.labelLarge?.color),
                ),
              ),
            ),
          ),
        ),
        // chat with whatsapp
        Visibility(
          visible: orderInfo.captainPhone != null,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(-0.2, 0)),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.85),
                    Colors.green.withOpacity(0.85),
                    Colors.green.withOpacity(0.9),
                    Colors.green.withOpacity(0.93),
                    Colors.green.withOpacity(0.95),
                    Colors.green,
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
                    var url = 'https://wa.me/${orderInfo.captainPhone}';
                    canLaunch(url).then((value) {
                      if (value) {
                        launch(url);
                      }
                    });
                  },
                  leading: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Theme.of(context).textTheme.labelLarge?.color,
                  ),
                  title: Text(S.current.whatsapp),
                  textColor: Theme.of(context).textTheme.labelLarge?.color,
                  subtitle: Text(S.current.whatsappWithCaptain),
                  trailing: Icon(Icons.arrow_forward_rounded,
                      color: Theme.of(context).textTheme.labelLarge?.color),
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
                  color: Theme.of(context).colorScheme.background),
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
                Visibility(
                  visible: orderInfo.note != null,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: DottedLine(
                        dashColor: Theme.of(context).disabledColor,
                        lineThickness: 2.5,
                        dashRadius: 25),
                  ),
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
                Visibility(
                  visible: orderInfo.pdf != null,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.attach_file_rounded,
                        ),
                        title: Text(S.current.attachedFile),
                      ),
                      InkWell(
                        onTap: () {
                          var url = orderInfo.pdf?.pdfPreview;
                          canLaunch(url ?? '').then((value) {
                            if (value) {
                              launch(url ?? '');
                            } else {
                              Fluttertoast.showToast(
                                  msg: S.current.unavailable);
                            }
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Icon(
                                  FontAwesomeIcons.filePdf,
                                  color: Colors.red,
                                  size: 100,
                                ),
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
                Visibility(
                  visible: orderInfo.note != null,
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                    ),
                    title: Text(S.current.orderDetails),
                    subtitle: Text(orderInfo.note ?? ''),
                  ),
                ),
                Visibility(
                    visible: orderInfo.kilometer != null,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: DottedLine(
                              dashColor: Theme.of(context).disabledColor,
                              lineThickness: 2.5,
                              dashRadius: 25),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.roundabout_left_rounded,
                          ),
                          title: Text(S.current.ProvideDistanceInKm),
                          subtitle: Text(orderInfo.kilometer.toString() +
                              ' ${S.current.km}'),
                        ),
                      ],
                    )),
                Visibility(
                    visible: orderInfo.paidToProvider != null,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: DottedLine(
                              dashColor: Theme.of(context).disabledColor,
                              lineThickness: 2.5,
                              dashRadius: 25),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.roundabout_left_rounded,
                          ),
                          title: Text(S.current.orderCostHandedByCaptain),
                          subtitle: Text(FinanceHelper.getStatusString(
                              orderInfo.paidToProvider?.toInt())),
                        ),
                      ],
                    ))
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
        // customers
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
                  title: Text(S.current.recipientName),
                  subtitle: Text(orderInfo.customerName),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: DottedLine(
                      dashColor: Theme.of(context).disabledColor,
                      lineThickness: 2.5,
                      dashRadius: 25),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      var url = 'tel:+${orderInfo.customerPhone}';
                      canLaunch(url).then((value) {
                        if (value) {
                          launch(url);
                        }
                      });
                    },
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(S.current.recipientPhoneNumber),
                      subtitle: Text(orderInfo.customerPhone),
                      trailing: Icon(Icons.arrow_forward),
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      String url = '';
                      if (orderInfo.destinationCoordinate != null) {
                        url = LauncherLinkHelper.getMapsLink(
                            orderInfo.destinationCoordinate?.latitude ?? 0,
                            orderInfo.destinationCoordinate?.longitude ?? 0);
                      } else if (orderInfo.destinationLink != null) {
                        url = orderInfo.destinationLink ?? '';
                      }
                      canLaunch(url).then((value) {
                        if (value) {
                          launch(url);
                        } else {
                          Fluttertoast.showToast(msg: S.current.invalidMapLink);
                        }
                      });
                    },
                    child: ListTile(
                      leading: Icon(Icons.location_pin),
                      title: Text(S.current.locationOfCustomer),
                      subtitle: Visibility(
                        replacement: Text(S.current.destinationUnavailable),
                        visible: orderInfo.storeBranchToClientDistance != null,
                        child: Text(S.current.distance +
                            ' ' +
                            (orderInfo.storeBranchToClientDistance ??
                                S.current.unknown) +
                            ' ${S.current.km}'),
                      ),
                      trailing: Icon(Icons.arrow_forward),
                    ),
                  ),
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
  void showFlush(context, bool answer) {
    late Flushbar flushbar;
    flushbar = Flushbar(
      borderRadius: BorderRadius.circular(25),
      onStatusChanged: (status) {
        if (FlushbarStatus.DISMISSED == status && !redo) {
          screenState.manager.confirmCaptainLocation(
              screenState,
              ConfirmCaptainLocationRequest(
                  orderId: orderInfo.id, isCaptainArrived: answer));
        }
      },
      duration: Duration(seconds: 5),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: S.current.warnning,
      message: S.current.sendingReport,
      icon: Icon(
        Icons.warning,
        size: 28.0,
        color: Colors.white,
      ),
      mainButton: TextButton(
          onPressed: () {
            redo = true;
            screenState.refresh();
            flushbar.dismiss();
            screenState.currentState =
                OrderDetailsStateOwnerOrderLoaded(screenState, orderInfo);
            screenState.refresh();
          },
          child: Text(
            S.of(context).redo,
            style: Theme.of(context).textTheme.labelLarge,
          )),
    )..show(context);
  }

  void showOwnerAlertConfirm() {
    var context = screenState.context;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(S.current.warnning),
            content: Container(
              child: Text(S.of(context).confirmingCaptainLocation),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showFlush(context, true);
                  },
                  child: Text(S.of(context).yes)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showFlush(context, false);
                  },
                  child: Text(S.of(context).no))
            ],
          );
        });
  }

  void showConfirmOrderCash() {
    var context = screenState.context;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(S.current.warnning),
            content: Container(
              child: Text(S.of(context).confirmingIfReceiveOrderCost),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    screenState.manager.confirmOrderCashFinance(screenState,
                        OrderCashRequest(orderID: orderInfo.id, paid: 1));
                  },
                  child: Text(S.of(context).yes)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    screenState.manager.confirmOrderCashFinance(screenState,
                        OrderCashRequest(orderID: orderInfo.id, paid: 2));
                  },
                  child: Text(S.of(context).no))
            ],
          );
        });
  }
}

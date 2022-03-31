import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_deep_links/helper/laubcher_link_helper.dart';
import 'package:c4d/module_orders/model/order/order_details_model.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/widgets/order_details_widget/alert_container.dart';
import 'package:c4d/module_orders/ui/widgets/order_details_widget/order_button.dart';
import 'package:c4d/module_orders/ui/widgets/order_details_widget/provide_distance.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/custom_step.dart';
import 'package:c4d/module_orders/utils/icon_helper/order_progression_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/flat_bar.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsCaptainOrderLoadedState extends States {
  OrderDetailsModel orderInfo;
  final OrderStatusScreenState screenState;
  OrderDetailsCaptainOrderLoadedState(
    this.screenState,
    this.orderInfo,
  ) : super(screenState);
  bool speaking = false;
  final TextEditingController noteController = TextEditingController();
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title: S.current.orderDetails),
      body: CustomListView.custom(
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
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                  )),
              title: Text(
                StatusHelper.getOrderStatusMessages(orderInfo.state),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                    StatusHelper.getOrderStatusDescriptionMessages(
                        orderInfo.state),
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          Visibility(
              visible: orderInfo.rating != null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).colorScheme.primary),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          S.current.currentRating,
                          style: Theme.of(context).textTheme.button,
                        ),
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating:
                              double.tryParse(orderInfo.rating ?? '0') ?? 0,
                          glowColor: Colors.amberAccent,
                          minRating: 0.0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          onRatingUpdate: (rating) {},
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_rounded,
                            color: Colors.amberAccent,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          S.current.HisComment,
                          style: Theme.of(context).textTheme.button,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                orderInfo.ratingComment ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          // with order type we can get order widgets
          Visibility(
              replacement: details(context),
              visible: orderInfo.state != OrderStatusEnum.CANCELLED,
              child: Column(
                children: [
                  // select bar
                  FilterBar(
                    cursorRadius: BorderRadius.circular(25),
                    animationDuration: const Duration(milliseconds: 350),
                    backgroundColor: Theme.of(context).backgroundColor,
                    currentIndex: screenState.currentIndex,
                    borderRadius: BorderRadius.circular(25),
                    floating: true,
                    height: 40,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    items: [
                      FilterItem(label: S.current.controlPanel),
                      FilterItem(label: S.current.orderDetails),
                    ],
                    onItemSelected: (index) {
                      screenState.currentIndex = index;
                      screenState.refresh();
                    },
                    selectedContent: Theme.of(context).textTheme.button!.color!,
                    unselectedContent:
                        Theme.of(context).textTheme.headline6!.color!,
                  ),
                  AnimatedSwitcher(
                    key: ObjectKey(orderInfo),
                    duration: const Duration(milliseconds: 450),
                    reverseDuration: const Duration(milliseconds: 450),
                    child: screenState.currentIndex == 1
                        ? SizedBox(key: UniqueKey(), child: details(context))
                        : SizedBox(
                            child: control(context),
                          ),
                  ),
                ],
              )),
          Container(
            height: 75,
          ),
        ],
      ),
    );
  }

  Widget details(BuildContext context) {
    var decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).backgroundColor);
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        // order details tile
        ListTile(
          title: Text(S.current.orderDetails + ' #${orderInfo.id}'),
          leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).backgroundColor),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.info_rounded),
              )),
        ),
        // date widgets
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: decoration,
            child: ListTile(
              leading: const Icon(Icons.delivery_dining_rounded),
              title: Text(S.current.deliverDate),
              subtitle: Text(orderInfo.deliveryDateString),
            ),
          ),
        ),
        // customers
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: decoration,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
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
                      leading: const Icon(Icons.phone),
                      title: Text(S.current.recipientPhoneNumber),
                      subtitle: Text(orderInfo.customerPhone),
                      trailing: const Icon(Icons.arrow_forward),
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
                      leading: const Icon(Icons.location_pin),
                      title: Text(S.current.locationOfCustomer),
                      subtitle: orderInfo.distance != null
                          ? Text(orderInfo.distance ?? '')
                          : Text(S.current.destination +
                              ' ' +
                              S.current.destinationUnavailable),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // details
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: decoration,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.store_rounded,
                  ),
                  title: Text(S.current.store),
                  subtitle: Text(orderInfo.storeName),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: DottedLine(
                      dashColor: Theme.of(context).disabledColor,
                      lineThickness: 2.5,
                      dashRadius: 25),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.store_rounded,
                  ),
                  title: Text(S.current.branch),
                  subtitle: Text(orderInfo.branchName),
                ),
                Visibility(
                  visible: orderInfo.branchPhone != null,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: DottedLine(
                        dashColor: Theme.of(context).disabledColor,
                        lineThickness: 2.5,
                        dashRadius: 25),
                  ),
                ),
                Visibility(
                  visible: orderInfo.branchPhone != null,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        var url = 'tel:+${orderInfo.branchPhone}';
                        canLaunch(url).then((value) {
                          if (value) {
                            launch(url);
                          }
                        });
                      },
                      child: ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(S.current.branchPhone),
                        subtitle: Text(orderInfo.branchPhone ?? ''),
                        trailing: const Icon(Icons.arrow_forward),
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
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    leading: const Icon(
                      Icons.location_on_rounded,
                    ),
                    onTap: () {
                      String url = '';
                      if (orderInfo.branchCoordinate != null) {
                        url = LauncherLinkHelper.getMapsLink(
                            orderInfo.branchCoordinate?.latitude ?? 0,
                            orderInfo.branchCoordinate?.longitude ?? 0);
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
                    title: Text(S.current.branchLocation),
                    subtitle: orderInfo.branchDistance != null
                        ? Text(orderInfo.branchDistance ?? '')
                        : Text(S.current.destination +
                            ' ' +
                            S.current.destinationUnavailable),
                    trailing: const Icon(Icons.arrow_forward_rounded),
                  ),
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
                        leading: const Icon(
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
                  leading: const Icon(
                    Icons.info,
                  ),
                  title: Text(S.current.orderDetails),
                  subtitle: Text(orderInfo.note),
                  trailing: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () async {
                        screenState.speak(orderInfo.note);

                        screenState.refresh();
                      },
                      icon: const Icon(Icons.record_voice_over_rounded),
                    ),
                  ),
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
                  leading: const Icon(
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
                  leading: const Icon(Icons.price_change_rounded),
                  title: Text(S.current.orderCostWithDeliveryCost),
                  subtitle: Text(orderInfo.orderCost.toStringAsFixed(1) +
                      ' ' +
                      S.current.sar),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget control(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          _getNextStageCard(context),
          // chat
          Visibility(
            visible: orderInfo.usedAs == false &&
                OrderStatusEnum.WAITING == orderInfo.state,
            child: OrderButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: Icons.contact_support_rounded,
              subtitle: S.current.canConnectHint,
              title: S.current.canConnect,
              onTap: () {
                screenState.createChatRoom(orderInfo.id);
              },
            ),
          ),
          // chat
          Visibility(
            visible: orderInfo.roomID != null,
            child: OrderButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: Icons.chat_bubble_rounded,
              subtitle: S.current.chatWithStoreOwner,
              title: S.current.chatRoom,
              onTap: () {
                Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                    arguments: ChatArgument(
                        roomID: orderInfo.roomID ?? '', userType: 'store'));
              },
            ),
          ),
          // location
          Row(
            children: [
              Expanded(
                child: OrderButton(
                  backgroundColor: Colors.red[900]!,
                  icon: Icons.location_on_rounded,
                  subtitle: S.current.storeLocation,
                  title: S.current.location,
                  onTap: () {
                    String url = '';
                    if (orderInfo.branchCoordinate != null) {
                      url = LauncherLinkHelper.getMapsLink(
                          orderInfo.branchCoordinate?.latitude ?? 0,
                          orderInfo.branchCoordinate?.longitude ?? 0);
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
                  short: true,
                ),
              ),
              Expanded(
                child: OrderButton(
                  backgroundColor: Colors.red[900]!,
                  icon: Icons.location_history_rounded,
                  subtitle: S.current.destinationPoint,
                  title: S.current.location,
                  short: true,
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
                ),
              ),
            ],
          ),
          // whatsapp
          Row(
            children: [
              Expanded(
                child: OrderButton(
                  backgroundColor: Colors.green[600]!,
                  icon: Icons.whatsapp,
                  subtitle: S.current.whatsappWithStoreOwner,
                  title: S.current.whatsapp,
                  onTap: () {
                    var url = 'https://wa.me/${orderInfo.storePhone}';
                    canLaunch(url).then((value) {
                      if (value) {
                        launch(url);
                      }
                    });
                  },
                  short: true,
                ),
              ),
              Expanded(
                child: OrderButton(
                  backgroundColor: Colors.green[600]!,
                  icon: Icons.whatsapp,
                  subtitle: S.current.whatsappWithClient,
                  title: S.current.whatsapp,
                  short: true,
                  onTap: () {
                    var url = 'https://wa.me/${orderInfo.customerPhone}';
                    canLaunch(url).then((value) {
                      if (value) {
                        launch(url);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
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
                    : StatusHelper.getOrderStatusColor(orderInfo.state),
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
                    : StatusHelper.getOrderStatusColor(orderInfo.state),
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
                    : StatusHelper.getOrderStatusColor(orderInfo.state),
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
                    : StatusHelper.getOrderStatusColor(orderInfo.state),
              ),
            ),
          ),
        ),
      ),
      CustomStep(status: OrderStatusEnum.FINISHED, currentIndex: currentIndex),
    ];
    return steps;
  }

  Widget _getNextStageCard(BuildContext context) {
    if (orderInfo.state == OrderStatusEnum.FINISHED) {
      return const SizedBox();
    } else if (orderInfo.state == OrderStatusEnum.DELIVERING) {
      return Column(
        children: [
          AlertContainer(
            subtitle: orderInfo.payment == 'cash'
                ? S.current.finishingOrderMessageWithPayment
                : S.current.finishingOrderMessage,
            title: S.current.warnning,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProvideDistance(
                thirdField: Visibility(
                  visible: screenState.paymentController.text != '' &&
                      orderInfo.orderCost !=
                          num.tryParse(screenState.paymentController.text),
                  child: ScalingWidget(
                    child: CustomFormField(
                      hintText: S.current.collectedPaymentNote,
                      controller: noteController,
                      last: true,
                    ),
                  ),
                ),
                onChanged: () {
                  screenState.refresh();
                },
                payment: orderInfo.payment == 'cash',
                callBack: (distance, payment) {
                  var index = StatusHelper.getOrderStatusIndex(orderInfo.state);
                  screenState.requestOrderProgress(UpdateOrderRequest(
                      id: int.tryParse(screenState.orderId ?? '-1'),
                      state: StatusHelper.getStatusString(
                          OrderStatusEnum.values[index + 1]),
                      distance: distance,
                      paymentNote: noteController.text.trim(),
                      orderCost: double.tryParse(payment ?? 'n')));
                },
                controller: screenState.distanceCalculator,
                controller2: screenState.paymentController,
              )),
          Visibility(
            visible: screenState.paymentController.text != '' &&
                orderInfo.orderCost !=
                    num.tryParse(screenState.paymentController.text),
            child: ScalingWidget(
              child: AlertContainer(
                background: Theme.of(context).colorScheme.error,
                title: S.current.collectedPaymentNotMatch,
                subtitle: null,
              ),
            ),
          ),
        ],
      );
    } else {
      return OrderButton(
          backgroundColor: StatusHelper.getOrderStatusColor(orderInfo.state),
          icon: OrderProgressionHelper.getButtonIcon(orderInfo.state),
          subtitle: OrderProgressionHelper.getNextStageHintMessage(
              orderInfo.state, context),
          onTap: () {
            var index = StatusHelper.getOrderStatusIndex(orderInfo.state);
            screenState.requestOrderProgress(UpdateOrderRequest(
              id: int.tryParse(screenState.orderId ?? '-1'),
              state: StatusHelper.getStatusString(
                  OrderStatusEnum.values[index + 1]),
            ));
          },
          title: OrderProgressionHelper.getNextStageHelper(
            orderInfo.state,
            context,
          ));
    }
  }
}

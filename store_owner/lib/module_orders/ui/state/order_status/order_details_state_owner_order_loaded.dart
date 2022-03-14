import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_deep_links/helper/laubcher_link_helper.dart';
import 'package:c4d/module_deep_links/service/deep_links_service.dart';
import 'package:c4d/module_orders/model/order_details_model.dart';
import 'package:c4d/module_orders/ui/screens/order_details/order_details_screen.dart';
import 'package:c4d/module_orders/ui/widgets/custom_step.dart';
import 'package:c4d/module_orders/ui/widgets/progress_order_status.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/components/rating_form.dart';
import 'package:c4d/utils/request/rating_request.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsStateOwnerOrderLoaded extends States {
  OrderDetailsModel orderInfo;
  final _distanceCalculator = TextEditingController();
  final OrderDetailsScreenState screenState;
  OrderDetailsStateOwnerOrderLoaded(
    this.screenState,
    this.orderInfo,
  ) : super(screenState) {
    if (orderInfo.destinationCoordinate != null) {
      distance = S.current.calculating;
      screenState.refresh();
      DeepLinksService.getDistance(LatLng(
              orderInfo.destinationCoordinate?.latitude ?? 0,
              orderInfo.destinationCoordinate?.longitude ?? 0))
          .then((value) {
        distance = value.toStringAsFixed(1);
        screenState.refresh();
      });
    }
  }
  String? distance;
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
        // rate
        Visibility(
          visible: orderInfo.roomID != null,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                                  comment: controller.text));
                            },
                            title: S.current.rateCaptain,
                            controller: controller,
                          );
                        });
                  },
                  leading: Icon(
                    Icons.star_rounded,
                    size: 30,
                    color: Theme.of(context).textTheme.button?.color,
                  ),
                  title: Text(S.current.rating),
                  textColor: Theme.of(context).textTheme.button?.color,
                  subtitle: Text(S.current.rateCaptain),
                  trailing: Icon(Icons.arrow_forward_rounded,
                      color: Theme.of(context).textTheme.button?.color),
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
          title: Text(S.current.orderDetails),
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
        // customers
        Padding(
          padding: const EdgeInsets.all(16.0),
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
                            orderInfo.destinationCoordinate?.latitude ?? 0);
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
                      subtitle: distance != null
                          ? Text(
                              S.current.distance + ' $distance ' + S.current.km)
                          : Text(S.current.distance + ' ' + S.current.unknown),
                      trailing: Icon(Icons.arrow_forward),
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
                ListTile(
                  leading: Icon(Icons.price_change_rounded),
                  title: Text(S.current.orderCostWithDeliveryCost),
                  subtitle: Text(orderInfo.orderCost.toStringAsFixed(1) +
                      ' ' +
                      S.current.sar),
                ),
              ],
            ),
          ),
        ),
        // with order type we can get order widgets
        Visibility(
            visible: orderInfo.state != OrderStatusEnum.CANCELLED,
            child: Container()),
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

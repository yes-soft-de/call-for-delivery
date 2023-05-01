import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/hive/util/argument_hive_helper.dart';
import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_captain/ui/screen/captains_assign_order_screen.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_deep_links/helper/laubcher_link_helper.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/add_extra_distance_request.dart';
import 'package:c4d/module_orders/ui/widgets/order_widget/order_button.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/module_stores/ui/screen/order/order_details_screen.dart';
import 'package:c4d/module_stores/ui/widget/orders/custom_step.dart';
import 'package:c4d/module_stores/ui/widget/orders/progress_order_status.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/helpers/phone_number_formtter.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../module_orders/model/order_details_model.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class OrderDetailsStateOwnerOrderLoaded extends States {
  OrderDetailsModel orderInfo;
  final _distanceCalculator = TextEditingController();
  final OrderDetailsScreenState screenState;
  OrderDetailsStateOwnerOrderLoaded(
    this.screenState,
    this.orderInfo,
  ) : super(screenState) {
    screenState.canRemoveOrder = orderInfo.canRemove;
  }
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
            replacement: Visibility(
              visible: orderInfo.state != OrderStatusEnum.FINISHED &&
                  orderInfo.state != OrderStatusEnum.CANCELLED,
              child: OrderButton(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          ArgumentHiveHelper().setCurrentOrderID(
                              screenState.orderId.toString());
                          return getIt<CaptainAssignOrderScreen>();
                        });
                  },
                  backgroundColor: Colors.orange,
                  icon: Icons.delivery_dining_rounded,
                  subtitle: S.current.assignCaptainHint,
                  title: S.current.assignCaptain),
            ),
            visible: orderInfo.captainName != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints(minHeight: 75),
                decoration: BoxDecoration(
                    color: StatusHelper.getOrderStatusColor(orderInfo.state),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.delivery_dining_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 200,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: orderInfo.state ==
                                            OrderStatusEnum.FINISHED
                                        ? S.current.orderHandledDoneByCaptain +
                                            ' '
                                        : S.current.orderHandledByCaptain + ' ',
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text: orderInfo.captainName,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                scrollable: true,
                                                title: Text(S.current.profile),
                                                content: Column(
                                                  children: [
                                                    ClipOval(
                                                      child: CustomNetworkImage(
                                                          height: 100,
                                                          width: 100,
                                                          imageSource: orderInfo
                                                                  .captain
                                                                  ?.images
                                                                  ?.image ??
                                                              ''),
                                                    ),
                                                    Text(
                                                        orderInfo.captainName ??
                                                            S.current.unknown),
                                                    SelectableText(
                                                      PhoneNumberFormatter
                                                              .format(orderInfo
                                                                  .captain
                                                                  ?.phone) ??
                                                          '',
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                        locale:
                                                            Locale.fromSubtags(
                                                                languageCode:
                                                                    'en'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                CaptainsRoutes
                                                                    .CAPTAIN_PROFILE,
                                                                arguments:
                                                                    orderInfo
                                                                        .captain
                                                                        ?.id);
                                                      },
                                                      child:
                                                          Text(S.current.more))
                                                ],
                                              );
                                            });
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Visibility(
                      visible: orderInfo.state != OrderStatusEnum.FINISHED &&
                          orderInfo.state != OrderStatusEnum.CANCELLED,
                      child: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return CustomAlertDialog(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      screenState.manager.unAssignedOrder(
                                          screenState.orderId, screenState);
                                    },
                                    content:
                                        S.current.areYouSureAboutRependingOrder,
                                    oneAction: false);
                              });
                        },
                        color: Colors.white,
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
            onLongPress: () {
              Navigator.of(screenState.context).pushNamed(
                  OrdersRoutes.ORDERS_ACTIONS_LOGS_SCREEN,
                  arguments: orderInfo.id);
            },
            onTap: () {
              Navigator.of(screenState.context).pushNamed(
                  StoresRoutes.ORDER_TIMELINE_SCREEN,
                  arguments: orderInfo.id);
            },
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
        // order log
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: OrderButton(
              backgroundColor: Colors.grey[800]!,
              icon: Icons.history,
              subtitle: null,
              onTap: () {
                Navigator.of(screenState.context).pushNamed(
                    OrdersRoutes.ORDERS_ACTIONS_LOGS_SCREEN,
                    arguments: orderInfo.id);
              },
              title: S.current.orderLogHistory),
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
        // order details tile
        ListTile(
          title: Text(S.current.orderDetails + ' #${screenState.orderId}'),
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
                    onLongPress: () {
                      final reason = TextEditingController();
                      final distance = TextEditingController();
                      final form_key = GlobalKey<FormState>();
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: Text(S.current.updateDistance),
                              content: SizedBox(
                                height: 240,
                                child: Form(
                                  key: form_key,
                                  child: Column(
                                    children: [
                                      CustomFormField(
                                        controller: distance,
                                        hintText: S.current.distance +
                                            ' 10 ${S.current.km}',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      CustomFormField(
                                        controller: reason,
                                        hintText: S.current.reason,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (form_key.currentState
                                                    ?.validate() ==
                                                true) {
                                              Navigator.of(context).pop();
                                              screenState.manager.addExtraDistance(
                                                  screenState,
                                                  AddExtraDistanceRequest(
                                                      id: orderInfo.id,
                                                      storeBranchToClientDistanceAdditionExplanation:
                                                          reason.text.trim(),
                                                      destination: null,
                                                      additionalDistance:
                                                          double.parse(
                                                              distance.text)));
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: S.current
                                                      .pleaseEnterValidDistance);
                                            }
                                          },
                                          child: Text(S.current.update)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    onDoubleTap: () {
                      final reason = TextEditingController();
                      final coord = TextEditingController();
                      final form_key = GlobalKey<FormState>();
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: Text(S.current.updateDistance),
                              content: SizedBox(
                                height: 240,
                                child: Form(
                                  key: form_key,
                                  child: Column(
                                    children: [
                                      CustomFormField(
                                        controller: coord,
                                        hintText: S.current.coordinates +
                                            ' 12.4,15.8',
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      CustomFormField(
                                        controller: reason,
                                        hintText: S.current.reason,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (form_key.currentState
                                                    ?.validate() ==
                                                true) {
                                              if (coord.text
                                                      .split(',')
                                                      .length ==
                                                  2) {
                                                Navigator.of(context).pop();
                                                screenState.manager
                                                    .updateDistance(
                                                        screenState,
                                                        AddExtraDistanceRequest(
                                                            id: orderInfo.id,
                                                            storeBranchToClientDistanceAdditionExplanation:
                                                                reason.text
                                                                    .trim(),
                                                            destination: {
                                                              'lat': coord.text
                                                                  .trim()
                                                                  .split(',')[0]
                                                                  .trim(),
                                                              'lon': coord.text
                                                                  .trim()
                                                                  .split(',')[1]
                                                                  .trim(),
                                                            }));
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: S.current
                                                        .pleaseEnterValidCoord);
                                              }
                                            }
                                          },
                                          child: Text(S.current.update)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
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
                      subtitle: orderInfo.destinationCoordinate != null
                          ? Text(S.current.distance +
                              ' ${orderInfo.storeBranchToClientDistance} ' +
                              S.current.km)
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
                  title: Text(S.current.storeName),
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
                ListTile(
                  leading: Icon(
                    Icons.info,
                  ),
                  title: Text(S.current.orderDetails),
                  subtitle: SelectableLinkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        Fluttertoast.showToast(msg: 'Invalid link');
                      }
                    },
                    text: '${orderInfo.note}',
                  ),
                ),
              ],
               
            ),
          ),
        ),
        // entered
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: decoration,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.storefront,
                  ),
                  title: Text(S.current.confirmCaptainLocation),
                  subtitle: Visibility(
                      replacement: Text(S.current.unknown),
                      visible: orderInfo.isCaptainArrived != null,
                      child: Text(orderInfo.isCaptainArrived == true
                          ? S.current.confirmed
                          : S.current.unconfirmed)),
                ),
                Visibility(
                    visible: orderInfo.paidToProvider != null &&
                        orderInfo.payment == 'cash',
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
                          leading: Icon(Icons.money),
                          title: Text(S.current.captainPaidToProvider),
                          subtitle: Text(FinanceHelper.getStatusString(
                              orderInfo.paidToProvider?.toInt() ?? -1)),
                        ),
                      ],
                    )),
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
                          leading: Icon(FontAwesomeIcons.locationArrow),
                          title: Text(S.current.distanceProvidedByCaptain),
                          subtitle: Text(FixedNumber.getFixedNumber(
                                  orderInfo.kilometer ?? 0) +
                              ' ${S.current.km}'),
                        ),
                        Visibility(
                            visible:
                                orderInfo.storeBranchToClientDistance != null,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: DottedLine(
                                      dashColor:
                                          Theme.of(context).disabledColor,
                                      lineThickness: 2.5,
                                      dashRadius: 25),
                                ),
                                ListTile(
                                  leading: Icon(FontAwesomeIcons.satellite),
                                  title: Text(
                                      S.current.storeBranchToClientDistance),
                                  subtitle: Text(
                                      (orderInfo.storeBranchToClientDistance ??
                                              '') +
                                          ' ${S.current.km}'),
                                ),
                              ],
                            )),
                      ],
                    )),
                Visibility(
                    visible: orderInfo.captainOrderCost != null &&
                        orderInfo.payment == 'cash',
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
                          leading: Icon(FontAwesomeIcons.moneyBill),
                          title: Text(S.current.orderCashWithCaptain),
                          subtitle: Text(FixedNumber.getFixedNumber(
                                  orderInfo.captainOrderCost ?? 0) +
                              ' ${S.current.sar}'),
                        ),
                      ],
                    )),
                Visibility(
                    visible: orderInfo.captainOrderCost != null &&
                        orderInfo.payment == 'cash' &&
                        orderInfo.captainOrderCost != orderInfo.orderCost &&
                        orderInfo.noteCaptainOrderCost != null,
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
                          leading: Icon(FontAwesomeIcons.info),
                          title: Text(S.current.captainNote),
                          subtitle: Text(orderInfo.noteCaptainOrderCost ?? ''),
                        ),
                      ],
                    )),
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

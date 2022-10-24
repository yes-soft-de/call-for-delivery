import 'package:badges/badges.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:c4d/module_my_notifications/model/notification_model.dart';
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/text_style/text_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyNotificationsLoadedState extends States {
  MyNotificationsScreenState screenState;
  List<NotificationModel> model;
  MyNotificationsLoadedState(this.screenState, this.model)
      : super(screenState) {
    DateTime? date = DateTime.tryParse(
        NotificationsPrefHelper().getNewLocalNotification() ?? '');
    if (date != null) {
      model.forEach((element) {
        if (date.isBefore(element.dateTime) ||
            date.isAtSameMomentAs(element.dateTime)) {
          element.seen = false;
          print(element.dateTime);
          print(date);
        }
      });
      screenState.refresh();
    }
  }
  bool markAll = false;
  bool sorted = false;
  String listTile = S.current.sortByEarlier;
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: screenState.markerMode,
        child: ScalingWidget(
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              List<String> notifications = [];
              model.forEach((element) {
                if (element.marked) {
                  notifications.add(element.id.toString());
                }
              });
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                        onPressed: () {
                          Navigator.of(context).pop();
                          screenState.deleteNotifications(notifications);
                        },
                        content: S.current
                            .areYouSureAboutDeleteSelectedNotifications);
                  });
            },
            child: const Icon(Icons.delete_rounded),
          ),
        ),
      ),
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.notifications,
          canGoBack: true,
          onTap: screenState.markerMode ? () {} : null,
          widget: screenState.markerMode
              ? Checkbox(
                  value: markAll,
                  onChanged: (bool? check) {
                    markAll = check ?? false;
                    model.forEach((element) {
                      element.marked = check ?? false;
                    });
                    screenState.refresh();
                  })
              : null,
          actions: [
            Visibility(
              visible: screenState.markerMode,
              child: CustomC4dAppBar.actionIcon(context, onTap: () {
                screenState.markerMode = false;
                model.forEach((element) {
                  element.marked = false;
                });
                screenState.refresh();
              }, icon: Icons.close_rounded),
            )
          ]),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: RefreshIndicator(
            onRefresh: () {
              return screenState.getNotifications();
            },
            child: Stack(
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/notifications.png',
                  width: 220,
                )),
                ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    Visibility(
                      visible: screenState.markerMode == false,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          left: 10,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: () {
                              if (sorted) {
                                sorted = false;
                                listTile = S.current.sortByEarlier;
                                model = model.reversed.toList();
                              } else {
                                sorted = true;
                                model = model.reversed.toList();
                                listTile = S.current.sortedByLatest;
                              }
                              screenState.refresh();
                            },
                            minLeadingWidth: 4,
                            leading: FaIcon(
                              FontAwesomeIcons.sortAmountDown,
                              color: Theme.of(context).disabledColor,
                              size: 18,
                            ),
                            title: Text(
                              listTile,
                              style: StyleText.categoryStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: screenState.markerMode,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                            left: 10,
                          ),
                          child: Text(
                            '${getSelectedItem()}' + ' ' + S.current.selected,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: ListView(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: getNotification(context)),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  List<Widget> getNotification(BuildContext context) {
    List<Widget> children = [];
    model.forEach((element) {
      bool subOrder = false;
      if (element.title == 'طلب فرعي جديد') {
        subOrder = true;
      }
      children.add(Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: InkWell(
          onLongPress: () {
            screenState.markerMode = true;
            element.marked = true;
            screenState.refresh();
          },
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    title: Text(element.title),
                    content: Container(
                      child: Text(element.body),
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          Widget: Text(S.current.cancel))
                    ],
                  );
                });
          },
          child: Slidable(
            key: ValueKey(element.orderNumber),
            groupTag: '0',
            // The start action pane is the one at the left or the top side.
            endActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),

              // A pane can dismiss the Slidable.
              dismissible: null,
              dragDismissible: false,
              // All actions are defined in the children parameter.
              children: [
                Visibility(
                  visible: subOrder == false,
                  child: SlidableAction(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    label: S.current.delete,
                    icon: Icons.delete,
                    onPressed: (context) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  screenState.deleteNotification(
                                      element.id.toString());
                                },
                                content: S.current
                                    .areYouSureAboutDeleteThisNotification);
                          });
                    },
                  ),
                ),
                Visibility(
                  visible: subOrder,
                  child: SlidableAction(
                    backgroundColor: Colors.green,
                    label: S.current.accept,
                    icon: Icons.thumb_up_alt_rounded,
                    onPressed: (context) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  screenState.manager.updateOrder(
                                      screenState,
                                      UpdateOrderRequest(
                                          id: int.tryParse(
                                              element.orderNumber ?? ''),
                                          state: StatusHelper.getStatusString(
                                              OrderStatusEnum.IN_STORE)));
                                  screenState.deleteNotification(
                                      element.id.toString());
                                },
                                content: S.current.confirmAcceptSubOrder);
                          });
                    },
                  ),
                ),
                Visibility(
                  visible: subOrder,
                  child: SlidableAction(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    label: S.current.reject,
                    icon: Icons.thumb_down,
                    onPressed: (context) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialog(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  screenState.manager.removeOrderSub(
                                      screenState,
                                      OrderNonSubRequest(
                                        orderID: int.tryParse(
                                            element.orderNumber ?? ''),
                                      ));
                                  screenState.deleteNotification(
                                      element.id.toString());
                                },
                                content: S.current.confirmRemoveSubOrder);
                          });
                    },
                  ),
                ),
              ],
            ),
            child: Row(
              children: [
                Badge(
                  showBadge: element.seen ? false : true,
                  position: BadgePosition(top: -2, end: -3),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).backgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.notifications,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        element.body +
                            (element.orderNumber != null
                                ? ', (${S.current.orderNumber} ${element.orderNumber})'
                                : ''),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        element.date,
                        style:
                            TextStyle(color: Theme.of(context).disabledColor),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: screenState.markerMode,
                  child: Checkbox(
                      value: element.marked,
                      onChanged: (bool? check) {
                        element.marked = check ?? false;
                        screenState.refresh();
                      }),
                ),
              ],
            ),
          ),
        ),
      ));
    });
    NotificationsPrefHelper().clearNewLocalNotifications();
    return children;
  }

  int getSelectedItem() {
    int count = 0;
    model.forEach((element) {
      if (element.marked) {
        count++;
      }
    });
    return count;
  }
}

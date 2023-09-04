import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_my_notifications/model/notification_model.dart';
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyNotificationsLoadedState extends States {
  MyNotificationsScreenState screenState;
  List<NotificationModel> model;
  MyNotificationsLoadedState(this.screenState, this.model) : super(screenState);
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
                        oneAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                          screenState.deleteNotifications(notifications);
                        },
                        content: S.current
                            .areYouSureAboutDeleteSelectedNotifications);
                  });
            },
            child: Icon(Icons.delete_rounded),
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
      body: RefreshIndicator(
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
            Column(
              mainAxisSize: MainAxisSize.min,
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
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: InkWell(
                            onLongPress: () {
                              screenState.markerMode = true;
                              model[index].marked = true;
                              screenState.refresh();
                            },
                            onTap: () {
                              if (model[index].orderId != null) {
                                print(model[index].orderId);
                                Navigator.of(context).pushNamed(
                                    OrdersRoutes.ORDER_STATUS_SCREEN,
                                    arguments: model[index].orderId);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        title: Text(model[index].title),
                                        content: Container(
                                          child: Text(model[index].body),
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(S.current.cancel))
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Slidable(
                              key: ValueKey(model[index].id),
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
                                  SlidableAction(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                    label: S.current.delete,
                                    icon: Icons.delete,
                                    onPressed: (context) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomAlertDialog(
                                                oneAction: true,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  screenState
                                                      .deleteNotification(
                                                          model[index]
                                                              .id
                                                              .toString());
                                                },
                                                content: S.current
                                                    .areYouSureAboutDeleteThisNotification);
                                          });
                                    },
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.notifications,
                                        color: Theme.of(context).disabledColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                model[index].title,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Flexible(
                                              child: Text(
                                                (model[index].id != null
                                                    ? '(${S.current.admin} ${model[index].adminName})'
                                                    : ''),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          model[index].message ?? '',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                        Text(
                                          model[index].date ?? '',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .disabledColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: screenState.markerMode,
                                    child: Checkbox(
                                        value: model[index].marked,
                                        onChanged: (bool? check) {
                                          model[index].marked = check ?? false;
                                          screenState.refresh();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

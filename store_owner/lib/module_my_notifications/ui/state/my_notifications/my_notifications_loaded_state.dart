import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:c4d/module_my_notifications/notification_model.dart';
import 'package:c4d/module_my_notifications/ui/screen/my_notifications_screen.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/text_style/text_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyNotificationsLoadedState extends States {
  MyNotificationsScreenState screenState;
  List<NotificationModel> model;
  MyNotificationsLoadedState(this.screenState, this.model) : super(screenState);
  bool markAll = false;

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: screenState.markerMode,
        child: ScalingWidget(
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () {},
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
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    Visibility(
                      visible: screenState.markerMode == false,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          left: 10,
                        ),
                        child: ListTile(
                          onTap: () {},
                          minLeadingWidth: 4,
                          leading: FaIcon(
                            FontAwesomeIcons.sortAmountDown,
                            color: Theme.of(context).disabledColor,
                            size: 18,
                          ),
                          title: Text(
                            S.of(context).sortByEarlier,
                            style: StyleText.categoryStyle,
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
                          physics: ScrollPhysics(),
                          children: getNotification(context)),
                    ),
                    SizedBox(
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
      children.add(Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
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
                          child: Text(S.current.cancel))
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
              extentRatio: 0.2,
              // A pane can dismiss the Slidable.
              dismissible: null,
              dragDismissible: false,
              // All actions are defined in the children parameter.
              children: [
                Flexible(
                  child: Container(
                    color: Theme.of(context).colorScheme.error,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete_rounded,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
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
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        element.body,
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

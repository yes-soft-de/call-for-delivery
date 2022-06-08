import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_my_notifications/model/update_model.dart';
import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/text_style/text_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UpdatesLoadedState extends States {
  UpdateScreenState screenState;
  List<UpdateModel> model;
  UpdatesLoadedState(this.screenState, this.model) : super(screenState);
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
            child: Icon(Icons.delete_rounded),
          ),
        ),
      ),
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.notices,
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
            return screenState.getNotices();
          },
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                    physics: ScrollPhysics(),
                    children: getNotification(context)),
              ),
              SizedBox(
                height: 75,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getNotification(BuildContext context) {
    bool isDark = getIt<ThemePreferencesHelper>().isDarkMode();
    List<Widget> children = [];
    int index = 0;
    model.forEach((element) {
      children.add(Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: InkWell(
          // onLongPress: () {
          //   screenState.markerMode = true;
          //   element.marked = true;
          //   screenState.refresh();
          // },
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
                      child: Text(element.msg),
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
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(-0.5, 0),
                  color: isDark
                      ? Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.5)
                      : Theme.of(context).backgroundColor,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Slidable(
                key: ValueKey(element.id),
                groupTag: '0',
                // The start action pane is the one at the left or the top side.
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.amber[100]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.notifications_active_rounded,
                          color: Colors.amber,
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
                            element.msg,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            element.date,
                            style: TextStyle(
                                color: Theme.of(context).disabledColor),
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
          ),
        ),
      ));
      index++;
      if (index != model.length) {
        children.add(Divider(
          thickness: 2,
          color: Theme.of(context).backgroundColor,
        ));
      }
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

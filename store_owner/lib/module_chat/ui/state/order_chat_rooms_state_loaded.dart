import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_chat/model/chat_rooms_model.dart';
import 'package:c4d/module_chat/ui/screens/chat_rooms_screen.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/text_style/text_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderChatRoomsLoadedState extends States {
  OrderChatRoomsScreenState screenState;
  List<ChatRoomsModel> model;
  OrderChatRoomsLoadedState(this.screenState, this.model) : super(screenState);
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
          title: S.current.enquiries,
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
            return screenState.getRooms();
          },
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
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
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
        padding: const EdgeInsets.all(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // onLongPress: () {
            //   screenState.markerMode = true;
            //   element.marked = true;
            //   screenState.refresh();
            // },
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                  arguments: ChatArgument(
                      roomID: element.roomId,
                      userType: 'captain',
                      userID: element.captainId));
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
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CustomNetworkImage(
                          height: 50,
                          imageSource: element.images ?? '',
                          width: 50,
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
                            element.captainName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            S.current.enquiryAboutOrder +
                                ' #${element.orderId}',
                                maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: screenState.markerMode,
                      replacement: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            ),
                          )),
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

import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_chat/model/chat_rooms_model.dart';
import 'package:c4d/module_chat/ui/screens/ongoing_chat_rooms_screen.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/progresive_image.dart';
import 'package:c4d/utils/components/rating_form.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/request/rating_request.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

class OngoingOrderChatLoadedState extends States {
  OngoingOrderChatScreenState screenState;
  List<ChatRoomsModel> model;
  OngoingOrderChatLoadedState(this.screenState, this.model)
      : super(screenState);
  bool markAll = false;
  bool sorted = false;
  String listTile = S.current.sortByEarlier;
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return screenState.getRooms();
        },
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
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
                            S.current.chatRoomOrder + ' #${element.orderId}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          final TextEditingController controller =
                              TextEditingController();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return RatingForm(
                                    onPressed: (rate) {
                                      Navigator.of(context).pop();
                                      screenState.rateCaptain(RatingRequest(
                                          comment: controller.text,
                                          rating: rate,
                                          rated: element.captainId,
                                          orderId: int.tryParse(
                                                  element.orderId ?? '') ??
                                              -1));
                                    },
                                    message: S.current.rateCaptainMessage,
                                    title: S.current.rateCaptain,
                                    controller: controller);
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber, shape: StadiumBorder()),
                        child: Text(
                          S.current.rateCaptain,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        )),
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
}

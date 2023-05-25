import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_my_notifications/model/update_model.dart';
import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart';
import 'package:c4d/module_my_notifications/ui/widget/update_card.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/text_style/text_style.dart';

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
          title: S.current.adsAndOffers,
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: model.length,
                  itemBuilder: (context, index) {
                    return UpdateCard(update: model[index]);
                  },
                ),
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

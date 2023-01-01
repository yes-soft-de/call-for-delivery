import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/model/captain_activity_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_activity_model.dart';
import 'package:c4d/module_captain/ui/widget/captain_activity_card.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:intl/intl.dart';

class CaptainsActivityLoadedState extends States {
  final CaptainsActivityScreenState screenState;
  final String? error;
  final bool empty;
  final List<CaptainActivityModel>? model;
  CaptainsActivityLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }

  String? id;
  String? search;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.stateManager.getCaptains(screenState);
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.stateManager.getCaptains(screenState);
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: getCaptains(context)));
  }

  List<Widget> getCaptains(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in model ?? <CaptainActivityModel>[]) {
      if (!element.captainName.contains(search ?? '') && search != null) {
        continue;
      }
      widgets.add(CaptainActivityCard(
        key: ValueKey(element.id),
        id: element.id,
        captainName: element.captainName,
        image: element.image,
        orderCount: element.ordersCount,
      ));
    }

    if (model != null) {
      widgets.insert(
          0,
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
                child: CustomDeliverySearch(
                  hintText: S.current.searchForCaptain,
                  onChanged: (s) {
                    if (s == '' || s.isEmpty) {
                      search = null;
                      screenState.refresh();
                    } else {
                      search = s;
                      screenState.refresh();
                    }
                  },
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      onTap: () {
                        showDatePicker(
                                context: context,
                                builder: (context, widget) {
                                  bool isDark = getIt<ThemePreferencesHelper>()
                                      .isDarkMode();

                                  if (isDark == false)
                                    return widget ?? SizedBox();
                                  return Theme(
                                      data: ThemeData.dark().copyWith(
                                          primaryColor: Colors.indigo),
                                      child: widget ?? SizedBox());
                                },
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime.now())
                            .then((value) {
                          if (value != null) {
                            screenState.filter?.fromDate = value;
                            screenState.refresh();
                            screenState.stateManager.getCaptainsFilter(
                                screenState, screenState.filter!);
                          }
                        });
                      },
                      title: Text(S.current.firstDate),
                      subtitle: Text(screenState.filter?.fromDate != null
                          ? DateFormat('yyyy/M/d').format(
                              screenState.filter?.fromDate ?? DateTime.now())
                          : S.current.chooseFromDate),
                    ),
                  ),
                ),
              ),
            ],
          ));
    }

    return widgets;
  }
}

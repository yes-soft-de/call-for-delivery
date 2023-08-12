import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/model/captain_activity_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_activity_model.dart';
import 'package:c4d/module_captain/ui/widget/captain_activity_card.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/costom_search.dart';
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
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              CustomDeliverySearch(
                hintText: S.current.searchForCaptain,
                onChanged: (s) {
                  if (s == '' || s.isEmpty) {
                    search = null;
                  } else {
                    search = s;
                  }
                  screenState.refresh();
                },
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).colorScheme.background,
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
                                        bool isDark =
                                            getIt<ThemePreferencesHelper>()
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
                                  screenState.filter.fromDate = value;
                                  screenState.stateManager.getCaptainsFilter(
                                      screenState, screenState.filter);
                                }
                              });
                            },
                            title: Text(S.current.firstDate),
                            subtitle: Text(screenState.filter.fromDate != null
                                ? DateFormat('yyyy/M/d').format(
                                    screenState.filter.fromDate ??
                                        DateTime.now())
                                : '0000/00/00'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 32,
                        height: 2.5,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      builder: (context, widget) {
                                        bool isDark =
                                            getIt<ThemePreferencesHelper>()
                                                .isDarkMode();
                                        if (isDark == false)
                                          return widget ?? SizedBox();
                                        return Theme(
                                            data: ThemeData.dark().copyWith(
                                                primaryColor: Colors.indigo),
                                            child: widget ?? SizedBox());
                                      },
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime.now())
                                  .then(
                                (value) {
                                  if (value != null) {
                                    screenState.filter.toDate = value;
                                    screenState.stateManager.getCaptainsFilter(
                                        screenState, screenState.filter);
                                  }
                                },
                              );
                            },
                            title: Text(S.current.endDate),
                            subtitle: Text(screenState.filter.toDate != null
                                ? DateFormat('yyyy/M/d').format(
                                    screenState.filter.toDate ?? DateTime.now())
                                : '0000/00/00'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: model?.length ?? 0,
            itemBuilder: (context, index) {
              if (model != null) {
                if (model![index]
                    .captainName
                    .toLowerCase()
                    .contains(search?.toLowerCase() ?? '')) {
                  return CaptainActivityCard(
                    key: ValueKey(model![index].id),
                    id: model![index].id,
                    captainName: model![index].captainName,
                    image: model![index].image,
                    orderCount: model![index].ordersCount,
                    last24CountOrder: model![index].last24CountOrder,
                    todayCountOrder: model![index].todayCountOrder,
                    filter: screenState.filter,
                  );
                }
              }

              return SizedBox();
            },
          ),
        ),
      ],
    ));
  }
}

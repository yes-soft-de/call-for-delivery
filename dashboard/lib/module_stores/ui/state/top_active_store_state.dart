import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/top_active_store_model.dart';
import 'package:c4d/module_stores/ui/screen/top_active_store_screen.dart';
import 'package:c4d/module_stores/ui/widget/top_store_acticity_widget.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopActiveStoreLoaded extends States {
  final TopActiveStoreScreenState screenState;
  final String? error;
  final bool empty;
  final List<TopActiveStoreModel>? model;

  TopActiveStoreLoaded(this.screenState, this.model,
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
          screenState.getTopActivityStore();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getTopActivityStore();
          });
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                            screenState.stateManager.filterStoreActivity(
                                screenState, screenState.filter!);
                          }
                        });
                      },
                      title: Text(S.current.firstDate),
                      subtitle: Text(
                        screenState.filter?.fromDate != null
                            ? DateFormat('yyyy/M/d').format(
                                screenState.filter?.fromDate ?? DateTime.now())
                            : DateFormat('yyyy/M/d').format(DateTime.now()),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 32,
                  height: 2.5,
                  color: Theme.of(context).backgroundColor,
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
                                initialDate: DateTime.now(),
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
                                firstDate: DateTime(2021),
                                lastDate: DateTime.now())
                            .then((value) {
                          if (value != null) {
                            screenState.filter?.toDate = value;
                            screenState.refresh();
                            screenState.stateManager.filterStoreActivity(
                                screenState, screenState.filter!);
                          }
                        });
                      },
                      title: Text(S.current.endDate),
                      subtitle: Text(screenState.filter?.toDate != null
                          ? DateFormat('yyyy/M/d').format(
                              screenState.filter?.toDate ?? DateTime.now())
                          : DateFormat('yyyy/M/d').format(DateTime.now())),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: model!.length,
            itemBuilder: (context, index) =>
                TopStoreActivityWidget(model![index]),
          ),
        ),
      ],
    );
  }
}

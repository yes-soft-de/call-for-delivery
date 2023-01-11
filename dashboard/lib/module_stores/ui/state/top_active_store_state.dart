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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              // Expanded(
              //   child: CustomDeliverySearch(
              //     hintText: S.current.search,
              //     onChanged: (s) {
              //       if (s == '' || s.isEmpty) {
              //         search = null;
              //         screenState.refresh();
              //       } else {
              //         search = s;
              //         screenState.refresh();
              //       }
              //     },
              //   ),
              // ),
              // SizedBox(
              //   width: 8,
              // ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            builder: (context, widget) {
                              bool isDark =
                                  getIt<ThemePreferencesHelper>().isDarkMode();

                              if (isDark == false) return widget ?? SizedBox();
                              return Theme(
                                  data: ThemeData.dark()
                                      .copyWith(primaryColor: Colors.indigo),
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
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Container(
                      child: Text(
                        screenState.filter?.fromDate != null
                            ? DateFormat('yyyy/M/d').format(
                                screenState.filter?.fromDate ?? DateTime.now())
                            : S.current.chooseFromDate,
                      ),
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

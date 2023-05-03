import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/stores_dues/stores_dues.dart';
import 'package:c4d/module_stores/ui/screen/stores_dues/stores_dues_screen.dart';
import 'package:c4d/module_stores/ui/widget/stores_dues/store_dues_card.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';

class StoresDuesLoadedState extends States {
  final StoresDuesScreenState screenState;
  final String? error;
  final bool empty;

  final List<StoresDuesModel>? model;

  StoresDuesLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStoresDues();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStoresDues();
          });
    }
    return FixedContainer(
        child: ListView.builder(
      itemCount: model?.length ?? 0,
      itemBuilder: (context, index) {
        if (screenState.search == null) {
          return StoreDuesCard(model: model?[index]);
        } else if (model?[index]
                .storeOwnerName
                ?.contains(screenState.search ?? '') ??
            false) {
          return StoreDuesCard(model: model?[index]);
        }

        return SizedBox();
      },
    ));
  }
}

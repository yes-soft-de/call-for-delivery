import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/top_active_store_model.dart';
import 'package:c4d/module_stores/ui/screen/top_active_store_screen.dart';
import 'package:c4d/module_stores/ui/widget/top_store_acticity_widget.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:flutter/material.dart';

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
    return ListView.builder(
      itemCount: model!.length,
      itemBuilder: (context, index) => TopStoreActivityWidget(model![index]),
    );
  }
}

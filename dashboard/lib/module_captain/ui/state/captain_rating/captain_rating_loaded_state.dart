import 'package:c4d/module_captain/model/captain_rating_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_rating_screen.dart';
import 'package:c4d/module_captain/ui/widget/captain_rating_card.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';

class CaptainsRatingLoadedState extends States {
  final CaptainsRatingScreenState screenState;
  final String? error;
  final bool empty;
  final List<CaptainRatingModel>? model;
  CaptainsRatingLoadedState(this.screenState, this.model,
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
          CustomDeliverySearch(
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
          Flexible(
            child: ListView.builder(
              itemCount: model?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (model != null &&
                    model![index]
                        .captainName
                        .toLowerCase()
                        .contains(search?.toLowerCase() ?? '')) {
                  return CaptainRatingCard(
                    key: ValueKey(model![index].id),
                    id: model![index].id,
                    captainName: model![index].captainName,
                    image: model![index].image,
                    captainRating: model![index].rating,
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

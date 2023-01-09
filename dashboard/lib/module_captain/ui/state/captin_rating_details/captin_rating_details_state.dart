import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/components/empty_screen.dart';
import '../../../../utils/components/error_screen.dart';
import '../../../model/captin_rating_details_model.dart';
import '../../screen/captin_rating_details_state.dart';
import '../../widget/captain_rating_detail_widget.dart';

class CaptinRatingDetailsLoadedState extends States {
  final CaptinRatingDetailsScreenState screenState;
  final String? error;
  final bool empty;
  List<CaptainRatingDetailsModel>? model;

  CaptinRatingDetailsLoadedState(this.screenState, this.model,
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
          screenState.getCaptainRating();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCaptainRating();
          });
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
                alignment: AlignmentDirectional.centerStart,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      S.current.numberofRatings,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      model!.length.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                )),
          ),
          Expanded(
            flex: 7,
            child: ListView.builder(
              itemCount: model!.length,
              itemBuilder: (context, index) {
                return ItemRatingWidget(
                  storeOwnerName: model![index].storeOwnerName,
                  // comment: model![index].comment,
                  comment: model![index].comment,
                  rate: model![index].rating,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

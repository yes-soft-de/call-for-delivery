import 'package:c4d/abstracts/states/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/components/empty_screen.dart';
import '../../../../utils/components/error_screen.dart';
import '../../../model/captin_rating_details_model.dart';
import '../../screen/captin_rating_details_state.dart';
import '../../widget/captain_profile/custom_captain_profile_tile.dart';

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
                      S.current.numberofratings,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      model!.length.toString(),
                      style: TextStyle(color: Colors.white),
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
                  captainRatingDetailsModel: model![index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ItemRatingWidget extends StatelessWidget {
  final CaptainRatingDetailsModel captainRatingDetailsModel;
  const ItemRatingWidget({Key? key, required this.captainRatingDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        children: [
          CustomListTile(
            // title: S.current.storeOwner,
            title: captainRatingDetailsModel.storeOwnerName,
            subTitle: '',
            // subTitle: captainRatingDetailsModel.storeOwnerName,
            iconData: Icons.store,
          ),
          CustomListTile(
            title: S.current.rateCaptain,
            subTitle: '',
            // subTitle: captainRatingDetailsModel.rating.toString(),
            iconData: Icons.star,
            leading: Container(
              // height: 50,
              // color: Colors.red,
              child: RatingBarIndicator(
                rating: captainRatingDetailsModel.rating.toDouble(),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ),
          ),
          CustomListTile(
            title: captainRatingDetailsModel.comment == ''
                ? S.current.nocomment
                : captainRatingDetailsModel.comment,
            subTitle: '',
            iconData: Icons.comment,
          ),
        ],
      ),
    );
  }
}

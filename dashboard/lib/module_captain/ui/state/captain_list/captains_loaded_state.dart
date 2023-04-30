import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/inActiveModel.dart';
import 'package:c4d/module_captain/ui/screen/captains_list_screen.dart';
import 'package:c4d/module_captain/ui/widget/captain_card.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';

class CaptainsLoadedState extends States {
  final CaptainsScreenState screenState;
  final String? error;
  final bool empty;
  final List<InActiveModel>? model;

  CaptainsLoadedState(this.screenState, this.model,
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
          screenState.getCaptains();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCaptains();
          });
    }
    return FixedContainer(
        child: Column(
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
        Flexible(
          child: ListView.builder(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: model?.length ?? 0,
            itemBuilder: (context, index) {
              if (model != null) {
                if (search != null &&
                    !model![index].captainName.contains(search ?? '')) {
                  return SizedBox();
                }
                return CaptainCard(
                  key: ValueKey(model![index].captainID),
                  captainId: model![index].captainID,
                  captainName: model![index].captainName == '0'
                      ? model![index].phoneNumber
                      : model![index].captainName,
                  image: model![index].image,
                  verificationStatus: model![index].verificationStatus,
                  profileID: model![index].profileID,
                );
              }
              return SizedBox();
            },
          ),
        ),
      ],
    ));
  }
}

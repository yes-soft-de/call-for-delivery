import 'package:c4d/module_captain/ui/widget/captain_card.dart';
import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_captain/model/inActiveModel.dart';
import 'package:c4d/module_captain/ui/screen/in_active_captains_screen.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/components/progresive_image.dart';

class InCaptainActiveLoadedState extends States {
  final InActiveCaptainsScreenState screenState;
  final String? error;
  final bool empty;
  final List<InActiveModel>? model;

  InCaptainActiveLoadedState(this.screenState, this.model,
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
        child: CustomListView.custom(children: getCaptains(context)));
  }

  List<Widget> getCaptains(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in model ?? <InActiveModel>[]) {
      if (!element.captainName.contains(search ?? '') && search != null) {
        continue;
      }

      widgets.add(CaptainCard(
        onTap: () {
          Navigator.of(context).pushNamed(CaptainsRoutes.CAPTAIN_PROFILE,
              arguments: element.captainID);
        },
        key: ValueKey(element.captainID),
        captainId: element.captainID,
        captainName: element.captainName == '0'
            ? element.phoneNumber
            : element.captainName,
        image: element.image,
        verificationStatus: element.verificationStatus,
      ));
    }
    if (model != null) {
      widgets.insert(
          0,
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
          ));
    }
    return widgets;
  }
}

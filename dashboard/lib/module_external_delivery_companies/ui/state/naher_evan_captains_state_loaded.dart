import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/naher_evan_captains_model.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/naher_evan_captains_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/evan_captain_card.dart';
import 'package:c4d/utils/components/costom_search.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';

class NaherEvanCaptainsStateLoaded extends States {
  NaherEvanCaptainsScreenState screenState;
  List<NaherEvanCaptainsModel> captains;

  NaherEvanCaptainsStateLoaded(this.screenState, this.captains)
      : super(screenState);

  String? id;
  String? search;

  @override
  Widget getUI(BuildContext context) {
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
            itemCount: captains.length,
            itemBuilder: (context, index) {
              if (search != null &&
                  !captains[index]
                      .captainName
                      .toLowerCase()
                      .contains(search?.toLowerCase() ?? '')) {
                return SizedBox();
              }
              return EvanCaptainCard(
                key: ValueKey(captains[index].captainID),
                captainId: captains[index].captainID,
                captainName: captains[index].captainName,
                image: captains[index].image,
                verificationStatus: captains[index].status,
                profileID: captains[index].profileID,
              );
            },
          ),
        ),
      ],
    ));
  }
}

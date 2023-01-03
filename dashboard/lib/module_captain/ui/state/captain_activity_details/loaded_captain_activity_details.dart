import 'package:c4d/module_captain/ui/screen/captain_activity_details_screen.dart';
import 'package:c4d/module_captain/ui/widget/captain_activity__details_card.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../abstracts/states/state.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/components/empty_screen.dart';
import '../../../../utils/components/error_screen.dart';
import '../../../model/captain_activity_details_model.dart';

class LoadedCaptainActivityDetails extends States {
  final CaptainActivityDetailsScreenState screenState;
  final String? error;
  final bool empty;
  List<CaptainActivityDetailsModel>? model;

  LoadedCaptainActivityDetails(this.screenState, this.model,
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
          screenState.getCaptainActivityDetails();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getCaptainActivityDetails();
          });
    }
    return FixedContainer(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                FontAwesomeIcons.boxes,
                color: Theme.of(context).disabledColor,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                child: Text(
                  S.current.countOrders,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).disabledColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                  child: Text(
                model!.length.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).disabledColor,
                    fontWeight: FontWeight.bold),
              ))
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: model!.length,
            itemBuilder: (context, index) {
              return CardCaptainActivityDetails(model: model![index]);
            },
          ),
        ),
      ],
    ));
  }
}

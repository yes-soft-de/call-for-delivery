import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_external_delivery_companies/model/naher_evan_captain_model.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/naher_evan_captain_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:flutter/material.dart';

class NaherEvanCaptainStateLoaded extends States {
  NaherEvanCaptainScreenState screenState;
  NaherEvanCaptainModel captain;

  NaherEvanCaptainStateLoaded(this.screenState, this.captain)
      : super(screenState);

  String? id;
  String? search;

  @override
  Widget getUI(BuildContext context) {
    return FixedContainer(child: Placeholder());
  }
}

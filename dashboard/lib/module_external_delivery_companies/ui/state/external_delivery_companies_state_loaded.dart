import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart';
import 'package:flutter/material.dart';

class ExternalDeliveryCompaniesStateLoaded extends States {
  final ExternalDeliveryCompaniesScreenState _screenState;
  ExternalDeliveryCompaniesStateLoaded(this._screenState) : super(_screenState);

  @override
  Widget getUI(BuildContext context) {
    return Placeholder();
  }
}

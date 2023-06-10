import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/assign_order_to_external_company_screen.dart';
import 'package:flutter/material.dart';

class AssignOrderToExternalCompanyStateLoaded extends States {
  final AssignOrderToExternalCompanyScreenState _screenState;
  final List<CompanyModel> _companies;

  AssignOrderToExternalCompanyStateLoaded(this._screenState, this._companies)
      : super(_screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [Placeholder()],
        ),
      ),
    );
  }
}

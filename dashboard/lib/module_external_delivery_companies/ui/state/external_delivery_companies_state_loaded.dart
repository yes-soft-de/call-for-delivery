import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/add_new_copany_dialog.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/company_card.dart';
import 'package:flutter/material.dart';

class ExternalDeliveryCompaniesStateLoaded extends States {
  final ExternalDeliveryCompaniesScreenState _screenState;
  final List<Company> _companies;

  ExternalDeliveryCompaniesStateLoaded(this._screenState, this._companies)
      : super(_screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CompanyCard(company: _companies[index]);
                },
                itemCount: _companies.length,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff024D92),
                ),
                child: Text(S.current.addNewCompany),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AddCompanyDialog();
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

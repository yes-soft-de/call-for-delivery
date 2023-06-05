import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/widgets/company_setting_card.dart';
import 'package:flutter/material.dart';

class DeliveryCompanyAllSettingsStateLoaded extends States {
  final DeliveryCompanyAllSettingsScreenState _screenState;
  final List<CompanySetting> _companySetting;

  DeliveryCompanyAllSettingsStateLoaded(this._screenState, this._companySetting)
      : super(_screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CompanySettingCard(
                    companySetting: _companySetting[index],
                  );
                },
                itemCount: _companySetting.length,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text(S.current.addNewCompany),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Placeholder();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}



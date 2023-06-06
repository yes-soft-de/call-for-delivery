import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/external_delivery_companies_routes.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/delete_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/update_company_criterial_status_request.dart';
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
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CompanySettingCard(
                    onDelete: () {
                      _screenState
                          .deleteCompanyCriterial(DeleteCompanyCriterialRequest(
                        id: _companySetting[index].id,
                      ));
                    },
                    onStatusChange: () {
                      _screenState.updateCompanyCriterialStatus(
                        UpdateCompanyCriterialStatusRequest(
                          id: _companySetting[index].id,
                          status: _companySetting[index].isActive,
                        ),
                      );
                    },
                    company: _screenState.company,
                    companySetting: _companySetting[index],
                  );
                },
                itemCount: _companySetting.length,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff024D92),
                ),
                child: Text(S.current.addSetting),
                onPressed: () {
                  Navigator.pushNamed(
                      context,
                      ExternalDeliveryCompaniesRoutes
                          .EDIT_Delivery_COMPANY_SETTINGS_SCREEN,
                      arguments: [
                        CompanySetting.empty(),
                        _screenState.company,
                        true,
                      ]).then(
                    (value) {
                      if (value is bool && value)
                        _screenState.getCompanySetting();
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

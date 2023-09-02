import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/create_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/update_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/edit_delivery_company_setting_screen.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditDeliveryCompanySettingScreenStateManager extends StateManagerHandler {
  final ExternalDeliveryCompaniesService _service;

  EditDeliveryCompanySettingScreenStateManager(this._service);

  Stream<States> get stateStream => stateSubject.stream;

  void updateCompanyCriterial(EditDeliveryCompanySettingScreenState screenState,
      UpdateCompanyCriterialRequest request) {
    _service.updateCompanyCriterial(request).then(
      (value) {
        if (screenState.context.mounted) {
          Navigator.pop(screenState.context, true);
        }
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.dataUpdatedSuccessfully,
          );
        }
      },
    );
  }

  void createCompanyCriterial(EditDeliveryCompanySettingScreenState screenState,
      CreateCompanyCriteria request) {
    _service.createCompanyCriterial(request).then(
      (value) {
        if (screenState.context.mounted) {
          Navigator.pop(screenState.context, true);
        }
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.companyCriterialAddedSuccessfully,
          );
        }
      },
    );
  }
}

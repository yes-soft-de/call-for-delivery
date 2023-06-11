import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_setting.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/delete_company_criteria_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_criterial_request/update_company_criterial_status_request.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/delivery_company_all_settings_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/delivery_copmany_all_settings_state_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class DeliveryCompanyAllSettingsStateManager {
  final ExternalDeliveryCompaniesService _service;
  final PublishSubject<States> _stateSubject = PublishSubject();

  DeliveryCompanyAllSettingsStateManager(this._service);

  Stream<States> get stateStream => _stateSubject.stream;

  void getCompanySetting(
      DeliveryCompanyAllSettingsScreenState screenState, int companyId) {
    _stateSubject.add(LoadingState(screenState));

    _service.getCompanyCriterial(companyId).then(
      (value) {
        if (value.hasError) {
          _stateSubject.add(ErrorState(screenState, onPressed: () {
            getCompanySetting(screenState, companyId);
          }, title: '', error: value.error, hasAppbar: false, size: 200));
        } else if (value.isEmpty) {
          _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
            getCompanySetting(screenState, companyId);
          },
              title: '',
              emptyMessage: S.current.homeDataEmpty,
              hasAppbar: false));
        } else {
          value as CompanySetting;
          _stateSubject.add(
            DeliveryCompanyAllSettingsStateLoaded(screenState, value.data),
          );
        }
      },
    );
  }

  void deleteCompanyCriterial(DeliveryCompanyAllSettingsScreenState screenState,
      DeleteCompanyCriterialRequest request) {
    _stateSubject.add(LoadingState(screenState));

    _service.deleteCompanyCriterial(request).then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.companyCriterialDeletedSuccessfully,
          );
        }
        screenState.getCompanySetting();
      },
    );
  }

  void updateCompanyCriterialStatus(
      DeliveryCompanyAllSettingsScreenState screenState,
      UpdateCompanyCriterialStatusRequest request) {
    _service.updateCompanyCriterialStatus(request).then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
          screenState.getCompanySetting();
        } else {
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.companyCriterialUpdatedSuccessfully,
          );
        }
      },
    );
  }
}

import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/create_new_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/delete_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/update_delivery_company_request.dart';
import 'package:c4d/module_external_delivery_companies/request/company_request/update_delivery_company_status_request.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_delivery_companies_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/external_delivery_companies_state_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExternalDeliveryCompaniesStateManager extends StateManagerHandler {
  final ExternalDeliveryCompaniesService _service;

  ExternalDeliveryCompaniesStateManager(this._service);

  Stream<States> get stateStream => stateSubject.stream;

  void getExternalCompanies(ExternalDeliveryCompaniesScreenState screenState) {
    stateSubject.add(LoadingState(screenState));

    _service.getAllCompanies().then(
      (value) {
        if (value.hasError) {
          stateSubject.add(ErrorState(screenState, onPressed: () {
            getExternalCompanies(screenState);
          }, title: '', error: value.error, hasAppbar: false, size: 200));
        } else if (value.isEmpty) {
          stateSubject.add(
            ExternalDeliveryCompaniesStateLoaded(screenState, []),
          );
        } else {
          value as CompanyModel;
          stateSubject.add(
            ExternalDeliveryCompaniesStateLoaded(screenState, value.data),
          );
        }
      },
    );
  }

  void updateCompany(ExternalDeliveryCompaniesScreenState screenState,
      UpdateDeliveryCompanyRequest request) {
    stateSubject.add(LoadingState(screenState));

    _service.updateCompany(request).then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.dataUpdatedSuccessfully,
          );
        }
        screenState.getExternalCompanies();
      },
    );
  }

  void createNewCompany(ExternalDeliveryCompaniesScreenState screenState,
      CreateNewDeliveryCompanyRequest request) {
    stateSubject.add(LoadingState(screenState));

    _service.createNewCompany(request).then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.companyAddedSuccessfully,
          );
        }
        screenState.getExternalCompanies();
      },
    );
  }

  void deleteCompany(ExternalDeliveryCompaniesScreenState screenState,
      DeleteDeliveryCompanyRequest request) {
    stateSubject.add(LoadingState(screenState));

    _service.deleteCompany(request).then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.companyDeletedSuccessfully,
          );
        }
        screenState.getExternalCompanies();
      },
    );
  }

  void updateCompanyStatus(ExternalDeliveryCompaniesScreenState screenState,
      UpdateDeliveryCompanyStatusRequest request) {
    _service.updateCompanyStatus(request).then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
          screenState.getExternalCompanies();
        } else {
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.dataUpdatedSuccessfully,
          );
          screenState.getExternalCompanies();
        }
      },
    );
  }
}

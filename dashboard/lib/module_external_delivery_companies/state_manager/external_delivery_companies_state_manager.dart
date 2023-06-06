import 'package:c4d/abstracts/states/empty_state.dart';
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
import 'package:rxdart/rxdart.dart';

@injectable
class ExternalDeliveryCompaniesStateManager {
  final ExternalDeliveryCompaniesService _service;
  final PublishSubject<States> _stateSubject = PublishSubject();

  ExternalDeliveryCompaniesStateManager(this._service);

  Stream<States> get stateStream => _stateSubject.stream;

  void getExternalCompanies(ExternalDeliveryCompaniesScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));

    _service.getAllCompanies().then(
      (value) {
        if (value.hasError) {
          _stateSubject.add(ErrorState(screenState, onPressed: () {
            getExternalCompanies(screenState);
          }, title: '', error: value.error, hasAppbar: false, size: 200));
        } else if (value.isEmpty) {
          _stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
            getExternalCompanies(screenState);
          },
              title: '',
              emptyMessage: S.current.homeDataEmpty,
              hasAppbar: false));
        } else {
          value as CompanyModel;
          _stateSubject.add(
            ExternalDeliveryCompaniesStateLoaded(screenState, value.data),
          );
        }
      },
    );
  }

  void updateCompany(ExternalDeliveryCompaniesScreenState screenState,
      UpdateDeliveryCompanyRequest request) {
    _stateSubject.add(LoadingState(screenState));

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
    _stateSubject.add(LoadingState(screenState));

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
    _stateSubject.add(LoadingState(screenState));

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
        }
      },
    );
  }
}

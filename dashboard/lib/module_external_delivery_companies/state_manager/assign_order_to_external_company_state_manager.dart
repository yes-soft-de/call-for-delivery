import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/company_model.dart';
import 'package:c4d/module_external_delivery_companies/request/assign_order_to_external_company/assign_order_to_external_company_request.dart';
import 'package:c4d/module_external_delivery_companies/service/external_delivery_companies_service.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/assign_order_to_external_company_screen.dart';
import 'package:c4d/module_external_delivery_companies/ui/state/assign_order_to_external_company_state_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssignOrderToExternalCompanyStateManager extends StateManagerHandler {
  final ExternalDeliveryCompaniesService _service;

  AssignOrderToExternalCompanyStateManager(this._service);

  Stream<States> get stateStream => stateSubject.stream;

  void getExternalCompanies(
      AssignOrderToExternalCompanyScreenState screenState) {
    stateSubject.add(LoadingState(screenState));

    _service.getAllCompanies().then(
      (value) {
        if (value.hasError) {
          stateSubject.add(ErrorState(screenState, onPressed: () {
            getExternalCompanies(screenState);
          }, title: '', error: value.error, hasAppbar: false, size: 200));
        } else if (value.isEmpty) {
          stateSubject.add(EmptyState(screenState, size: 200, onPressed: () {
            getExternalCompanies(screenState);
          },
              title: '',
              emptyMessage: S.current.homeDataEmpty,
              hasAppbar: false));
        } else {
          value as CompanyModel;
          stateSubject.add(
            AssignOrderToExternalCompanyStateLoaded(screenState, value.data),
          );
        }
      },
    );
  }

  void assignOrderToExternalCompany(
    AssignOrderToExternalCompanyScreenState screenState,
    AssignOrderToExternalCompanyRequest request,
  ) {
    _service.assignOrderToExternalCompany(request).then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          if (screenState.context.mounted) {
            Navigator.pop(screenState.context, true);
          }
          CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.orderAssignedToCompanySuccessfully,
          );
        }
      },
    );
  }
}

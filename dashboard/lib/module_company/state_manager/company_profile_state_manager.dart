import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_company/model/company_model.dart';
import 'package:c4d/module_company/request/create_company_profile.dart';
import 'package:c4d/module_company/service/company_service.dart';
import 'package:c4d/module_company/ui/screen/company_profile_screen.dart';
import 'package:c4d/module_company/ui/state/company_profile/company_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompanyProfileStateManager extends StateManagerHandler {
  final CompanyService _companyService;

  Stream<States> get stateStream => stateSubject.stream;

  CompanyProfileStateManager(this._companyService);

  void getCompanyProfile(CompanyProfileScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _companyService.getCompanyProfile().then((value) {
      if (value.isEmpty) {
        stateSubject.add(CompanyLoadedState(screenState, null, empty: true));
      } else if (value.hasError) {
        stateSubject
            .add(CompanyLoadedState(screenState, null, error: value.error));
      } else {
        CompanyProfileModel model = value as CompanyProfileModel;
        stateSubject.add(
            CompanyLoadedState(screenState, model.data, error: value.error));
      }
    });
  }

  void createProfile(
      CompanyProfileScreenState screenState, CreateCompanyProfile request) {
    stateSubject.add(LoadingState(screenState));

    _companyService.createCompanyProfile(request).then((value) {
      if (value.hasError) {
        getCompanyProfile(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getCompanyProfile(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.companyProfileCreatedSuccessfully);
      }
    });
  }

  void updateStore(
      CompanyProfileScreenState screenState, CreateCompanyProfile request) {
    stateSubject.add(LoadingState(screenState));

    _companyService.UpdateCompanyProfile(request).then((value) {
      if (value.hasError) {
        getCompanyProfile(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error ?? '');
      } else {
        getCompanyProfile(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.companyProfileUpdatedSuccessfully);
      }
    });
  }
}

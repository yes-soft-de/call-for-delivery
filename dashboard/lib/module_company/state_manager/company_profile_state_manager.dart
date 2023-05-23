import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_company/model/company_model.dart';
import 'package:c4d/module_company/request/create_company_profile.dart';
import 'package:c4d/module_company/service/company_service.dart';
import 'package:c4d/module_company/ui/screen/company_profile_screen.dart';
import 'package:c4d/module_company/ui/state/company_profile/company_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class CompanyProfileStateManager {
  final CompanyService _companyService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CompanyProfileStateManager(this._companyService);

  void getCompanyProfile(CompanyProfileScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _companyService.getCompanyProfile().then((value) {
      if (value.isEmpty) {
        _stateSubject.add(CompanyLoadedState(screenState, null, empty: true));
      } else if (value.hasError) {
        _stateSubject
            .add(CompanyLoadedState(screenState, null, error: value.error));
      } else {
        CompanyProfileModel model = value as CompanyProfileModel;
        _stateSubject.add(
            CompanyLoadedState(screenState, model.data, error: value.error));
      }
    });
  }

  void createProfile(
      CompanyProfileScreenState screenState, CreateCompanyProfile request) {
    _stateSubject.add(LoadingState(screenState));

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
    _stateSubject.add(LoadingState(screenState));

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

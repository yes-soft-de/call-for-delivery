import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/model/company_info_model.dart';
import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_about/ui/screen/company_info/company_info_screen.dart';
import 'package:c4d/module_about/ui/states/company_info/company_info_loaded_state.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';

@injectable
class CompanyInfoStateManager {
  final AboutService _service;
  final AuthService _authService;
  final ProfileService _profileService;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CompanyInfoStateManager(
    this._service,
    this._authService,
    this._profileService,
  );
  void getCompanyInfo(CompanyInfoScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));

    _service.getCompanyInfo().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getCompanyInfo(screenState);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getCompanyInfo(screenState);
        }, title: '', emptyMessage: S.current.homeDataEmpty, hasAppbar: false));
      } else {
        value as CompanyInfoModel;
        _stateSubject
            .add(CompanyInfoLoadedState(screenState, company: value.data));
      }
    });
  }
}

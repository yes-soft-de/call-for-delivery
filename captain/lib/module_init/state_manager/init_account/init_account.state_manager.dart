import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:c4d/module_init/service/init_account/init_account.service.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account_captain_init_profile/init_account_captain_init_profile.dart';
import 'package:c4d/module_init/ui/state/init_account_captain_profile_created/init_account_captain_profile_created.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';

@injectable
class InitAccountStateManager {
  final InitAccountService _initAccountService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  InitAccountStateManager(
    this._initAccountService,
    this._authService,
    this._uploadService,
  );

  void getRoleInit(InitAccountScreenState screen) {
    getCaptainScreen(screen);
  }

  void submitProfile(
      CreateCaptainProfileRequest request, InitAccountScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    Future.wait([
      _uploadService.uploadImage(request.captainImage!.path),
      _uploadService.uploadImage(request.driving!.path),
      _uploadService.uploadImage(request.mechanic!.path),
      _uploadService.uploadImage(request.idImage!.path)
    ]).then((value) {
      if (value[0] != null &&
          value[1] != null &&
          value[2] != null &&
          value[3] != null) {
        request.image = value[0];
        request.drivingLicence = value[1];
        request.mechanicLicence = value[2];
        request.identity = value[3];
        _stateSubject.add(LoadingState(screenState));
        _initAccountService.createCaptainProfile(request).then((value) {
          if (value.hasError) {
            _stateSubject.add(InitAccountCaptainInitProfile(screenState));
            screenState.showMessage(value.error, false);
          } else {
            _stateSubject.add(InitAccountStateProfileCreated(screenState));
          }
        });
      } else {
        _stateSubject.add(InitAccountCaptainInitProfile(screenState));
        screenState.showMessage(S.current.errorUploadingImages, false);
      }
    });
  }

  void getCaptainScreen(InitAccountScreenState screenState) {
    _stateSubject.add(InitAccountCaptainInitProfile(screenState));
  }
}

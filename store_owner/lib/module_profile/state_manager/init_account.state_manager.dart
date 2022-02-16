import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_profile/ui/screen/init_account_screen.dart';
import 'package:c4d/module_profile/ui/states/init_account/init_account_profile_success.dart';
import 'package:c4d/module_profile/ui/states/init_account/init_account_profile_loaded.dart';
import 'package:c4d/module_profile/ui/states/init_account/init_account_profile_state_loading.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class InitAccountStateManager {
  final ProfileService _profileService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  InitAccountStateManager(
    this._profileService,
    this._authService,
    this._uploadService,
  );
  void createProfile(
      ProfileRequest request, InitAccountScreenState screenState) {
    _stateSubject.add(
        InitAccountStateLoading(screenState, S.current.uploadingAndSubmitting));
    _profileService.createStoreProfile(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(InitAccountStateProfileLoaded(screenState));
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        _stateSubject.add(InitAccountStateSuccess(screenState));
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.uploadProfileSuccess)
            .show(screenState.context);
      }
    });
  }
}

import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/edit_profile/edit_profile.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class EditProfileStateManager {
  final _stateSubject = PublishSubject<States>();
  final ImageUploadService _imageUploadService;
  final ProfileService _profileService;
  final AuthService _authService;

  EditProfileStateManager(
    this._imageUploadService,
    this._profileService,
    this._authService,
  );

  Stream<States> get stateStream => _stateSubject.stream;

  void getProfile(ProfileScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _profileService.getProfile().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getProfile(screenState);
        }, title: S.current.profile));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getProfile(screenState);
        }, title: S.current.profile, emptyMessage: S.current.homeDataEmpty));
      } else {
        value as ProfileModel;
        _stateSubject.add(ProfileStateInit(screenState, value.data));
      }
    });
  }
}

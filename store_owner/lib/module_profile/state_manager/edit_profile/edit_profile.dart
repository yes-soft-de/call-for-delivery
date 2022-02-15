import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_loading/profile_loading.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/states/profile_state_got_profile/profile_state_got_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state_no_profile/profile_state_no_profile.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class EditProfileStateManager {
  final _stateSubject = PublishSubject<ProfileState>();
  final ImageUploadService _imageUploadService;
  final ProfileService _profileService;
  final AuthService _authService;

  EditProfileStateManager(
    this._imageUploadService,
    this._profileService,
    this._authService,
  );

  Stream<ProfileState> get stateStream => _stateSubject.stream;

  void getProfile(EditProfileScreenState screenState) {
    _stateSubject.add(ProfileStateLoading(screenState));
    _profileService.getProfile().then((value) {
      if (value == null) {
        _stateSubject
            .add(ProfileStateNoProfile(screenState, ProfileRequest(), false));
      } else {
        _stateSubject.add(ProfileStateGotProfile(
          screenState,
          ProfileRequest(
              name: value.name,
              image: value.image,
              phone: value.phone,
              drivingLicence: value.drivingLicence,
              city: value.city,
              branch: '-1',
              bankName: value.bankName,
              bankAccountNumber: value.accountID,
              stcPay: value.stcPay,
              car: value.car,
              age: value.age.toString(),
              mechanicLicense: value.mechanicLicense,
              identity: value.identity),
          false,
        ));
      }
    });
  }
}

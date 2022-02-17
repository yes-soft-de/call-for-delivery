import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_subscription/service/subscription_service.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class InitSubscriptionStateManager {
  final SubscriptionService _initAccountService;
  final ProfileService _profileService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject =
      PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  InitSubscriptionStateManager(
    this._initAccountService,
    this._profileService,
    this._authService,
    this._uploadService,
  );

}

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_profile/ui/states/activity_state/activity_state.dart';

@injectable
class ActivityStateManager {
  final ProfileService _profileService;
  final AuthService _authService;
  ActivityStateManager(this._profileService, this._authService);

  final _stateSubject = PublishSubject<ActivityState>();

  Stream<ActivityState> get stateStream => _stateSubject.stream;
}

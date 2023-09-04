import 'package:c4d/module_profile/ui/states/activity_state/activity_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ActivityStateManager {
  ActivityStateManager();

  final _stateSubject = PublishSubject<ActivityState>();

  dispose() {
    _stateSubject.close();
  }

  Stream<ActivityState> get stateStream => _stateSubject.stream;
}

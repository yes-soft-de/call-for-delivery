import 'package:c4d/di/di_config.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../module_my_notifications/my_notifications_module.dart';

@singleton
@injectable
class GlobalStateManager {
  final PublishSubject _stateSubject = PublishSubject();
  Stream get stateStream => _stateSubject.stream;

  void update() {
    _stateSubject.add(DateTime.now().toString());
  }

  void goToAdAndOffers() {
    _stateSubject.add(getIt<MyNotificationsModule>().updateScreen);
  }
}

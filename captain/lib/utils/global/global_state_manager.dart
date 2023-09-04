import 'package:c4d/module_my_notifications/ui/screen/update_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
@injectable
class GlobalStateManager {
  final PublishSubject _stateSubject = PublishSubject();
  Stream get stateStream => _stateSubject.stream;

  void update() {
    _stateSubject.add(DateTime.now().toString());
  }

  void goToAdAndOffers() {
    _stateSubject.add(const UpdateScreen());
  }
}

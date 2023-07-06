import 'package:store_web/di/di_config.dart';
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

 
}

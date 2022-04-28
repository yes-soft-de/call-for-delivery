import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainsHiveHelper {
  var box = Hive.box('Helper');

  void setCurrentCaptainID(int captainID) {
    box.put('captainID', captainID);
  }

  int getCurrentCaptainID() {
    return box.get('captainID') ?? -1;
  }
}

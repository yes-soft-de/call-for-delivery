import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

/* This helper we will used it to store argument and data needed to our screens */
/* This is very useful to get & update our needed arguments data safely */

@injectable
class ArgumentHiveHelper {
  var _box = Hive.box('Arguments');

  /* Users ID's */
  //captain
  void setCurrentCaptainID(String id) {
    _box.put('captainID', id);
  }

  String? getCurrentCaptainID() {
    return _box.get('captainID');
  }
  //store

  void setCurrentStoreID(String id) {
    _box.put('storeID', id);
  }

  String? getCurrentStoreID() {
    return _box.get('storeID');
  }

  void setCurrentOrderID(String id) {
    _box.put('orderID', id);
  }

  String? getCurrentOrderID() {
    return _box.get('orderID');
  }

  Future<void> clean() async {
    await _box.clear();
    return;
  }
}

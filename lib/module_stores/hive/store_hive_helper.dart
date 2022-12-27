import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoresHiveHelper {
  var box = Hive.box('Helper');

  void setCurrentStoreID(int storeID) {
    box.put('storeID', storeID);
  }

  int getCurrentStoreID() {
    return box.get('storeID') ?? -1;
  }
}

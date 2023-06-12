import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class MyNotificationHiveHelper {
  var box = Hive.box('My Notification');

  void setLastNotificationSeenId(int id) {
    box.put('last notification id', id);
  }

  int? getLastNotificationSeenId() {
    var id = box.get('last notification id');

    if (id is int) return id;
    return null;
  }
}
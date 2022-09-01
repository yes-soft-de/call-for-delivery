import 'package:c4d/di/di_config.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsPrefHelper {
  var box = Hive.box('Notifications');
  // ignore: non_constant_identifier_names
  final NEW_NOTIFICATION = 'new_notifications';
  void setNotificationPath(String ringtone) {
    box.put('Ringtone', ringtone);
  }

  String getNotification() {
    return box.get('Ringtone') ?? 'assets/sounds/ringtone1.wav';
  }

  void setHomeIndex(int index) {
    box.put('homeIndex', index);
  }

  int getHomeIndex() {
    return box.get('homeIndex') ?? 0;
  }

  void setFarOrders(bool show) {
    box.put('far_orders', show);
  }

  bool getFarOrder() {
    return box.get('far_orders') ?? false;
  }

  void setNewLocalNotification() {
    if (getNewLocalNotification() == null) {
      box.put(NEW_NOTIFICATION, DateTime.now().toIso8601String());
      getIt<GlobalStateManager>().update();
    }
  }

  String? getNewLocalNotification() {
    return box.get(NEW_NOTIFICATION);
  }

  void clearNewLocalNotifications() {
    box.delete(NEW_NOTIFICATION);
  }
}

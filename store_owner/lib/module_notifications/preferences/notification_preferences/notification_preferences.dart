import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsPrefHelper {
  var box = Hive.box('Notifications');
  void setNotificationPath(String ringtone) {
    box.put('Ringtone', ringtone);
  }

  String getNotification() {
    return box.get('Ringtone') ?? 'assets/sounds/ringtone1.wav';
  }
}

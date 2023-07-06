import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class HiveSetUp {
  static Future<void> init() async {
    await Hive.initFlutter();
    await adapterRegistration();
    await publicBoxes();
  }

  static Future<void> adapterRegistration() async {}

  static Future<void> publicBoxes() async {
    await Hive.openBox('Authorization');
    await Hive.openBox('Theme');
    await Hive.openBox('Localization');
    await Hive.openBox('Init');
    await Hive.openBox('Chat');
    await Hive.openBox('Order');
    await Hive.openBox('Notifications');
    await Hive.openBox('My Notification');
    await Hive.openBox('Suggestions');
    await Hive.openBox('Profile');
    await Hive.openBox('Subscription');
    await Hive.openBox('Payment');
  }
}

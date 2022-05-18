import 'dart:convert';
import 'dart:math';
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soundpool/soundpool.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:sound_mode/sound_mode.dart';

@injectable
class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final PublishSubject<Map<String, dynamic>> _onNotificationReceived =
      PublishSubject();

  Stream<Map<String, dynamic>> get onLocalNotificationStream =>
      _onNotificationReceived.stream;

  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('icon');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(requestSoundPermission: true);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void showNotification(RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    IOSNotificationDetails iOSPlatformChannelSpecifics =
        const IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: false,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'C4D_notification_test',
      'C4D Notification test',
      'Showing notifications while the app running',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: true,
      playSound: false,
      channelShowBadge: true,
      enableLights: true,
      enableVibration: true,
      onlyAlertOnce: false,
      category: 'Local',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
        int.tryParse(message.messageId ?? '1') ?? Random().nextInt(1000000),
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: json.encode(message.data));
    playSound();
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      var data = json.decode(payload);
      _onNotificationReceived.add(data);
    }
  }

  Future<void> playSound() async {
    Soundpool pool = Soundpool.fromOptions();
    var sound = await rootBundle
        .load(NotificationsPrefHelper().getNotification())
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    RingerModeStatus ringerStatus = await SoundMode.ringerModeStatus;
    if (ringerStatus == RingerModeStatus.normal) {
      pool.play(sound,
          repeat: NotificationsPrefHelper().getNotification().contains('2')
              ? 3
              : 0);
    }
  }
}

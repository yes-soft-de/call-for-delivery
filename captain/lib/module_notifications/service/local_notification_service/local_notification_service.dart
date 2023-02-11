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
import 'dart:io' as io;
@injectable
class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final PublishSubject<Map<String, dynamic>> _onNotificationReceived =
      PublishSubject();

  Stream<Map<String, dynamic>> get onLocalNotificationStream =>
      _onNotificationReceived.stream;

  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('icon');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(requestSoundPermission: true);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    if (io.Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification);
  }

  void showNotification(RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails();

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'Local_notification',
      'Local Notification',
      channelDescription: 'Showing notifications while the app running',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: true,
      playSound: true,
      channelShowBadge: true,
      enableLights: true,
      enableVibration: true,
      onlyAlertOnce: false,
      category: AndroidNotificationCategory.event,
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

  Future selectNotification(NotificationResponse? notification) async {
    if (notification?.payload != null) {
      var data = json.decode(notification!.payload!);
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

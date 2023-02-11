import 'dart:convert';
import 'dart:io' as io;
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

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
  }

  Future selectNotification(NotificationResponse? notification) async {
    if (notification?.payload != null) {
      var data = json.decode(notification!.payload!);
      _onNotificationReceived.add(data);
    }
  }
}

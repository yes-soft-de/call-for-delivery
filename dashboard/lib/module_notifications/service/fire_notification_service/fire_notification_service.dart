import 'dart:async';
import 'dart:io' as p;
import 'package:c4d/module_chat/chat_routes.dart';
import 'package:c4d/module_chat/model/chat_argument.dart';
import 'package:c4d/module_notifications/model/notification_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:c4d/module_notifications/repository/notification_repo.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';

@injectable
class FireNotificationService {
  final NotificationsPrefHelper _prefHelper;
  final NotificationRepo _notificationRepo;

  FireNotificationService(
    this._prefHelper,
    this._notificationRepo,
  );

  static final PublishSubject<RemoteMessage> _onNotificationReceived =
      PublishSubject();

  Stream<RemoteMessage> get onNotificationStream => _onNotificationReceived.stream;

  static StreamSubscription? iosSubscription;

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    if (p.Platform.isIOS) {
      await _fcm.requestPermission();
    }
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // var isActive = _prefHelper.getIsActive();
    await refreshNotificationToken();
  }

  Future<void> refreshToken() async {
    try {
      var token = await _fcm.getToken();
      _notificationRepo.postToken(token);
    } catch (e) {}
  }

  Future<void> deleteToken() async {
    _notificationRepo.postToken(null);
  }

  Future<void> refreshNotificationToken() async {
    var token = await _fcm.getToken();
    if (token != null) {
      // And Subscribe to the changes
      try {
        _notificationRepo.postToken(token);
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          _onNotificationReceived.add(message);
          Logger().info('FireNotificationService', 'onMessage: $message');
        });
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          NotificationModel notificationModel =
              NotificationModel.fromJson(message.data);
          SchedulerBinding.instance?.addPostFrameCallback(
            (_) {
              if (notificationModel.navigateRoute == ChatRoutes.chatRoute) {
                Navigator.pushNamed(GlobalVariable.navState.currentContext!,
                    notificationModel.navigateRoute ?? '',
                    arguments: ChatArgument(
                        roomID:
                            notificationModel.chatNotification?.roomID ?? '',
                        userID: notificationModel.chatNotification?.senderID,
                        userType: null));
              } else {
                Navigator.pushNamed(GlobalVariable.navState.currentContext!,
                    notificationModel.navigateRoute ?? '',
                    arguments: notificationModel.argument);
              }
            },
          );
        });
        FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  static Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
    _onNotificationReceived.add(message);
    return Future<void>.value();
  }
}

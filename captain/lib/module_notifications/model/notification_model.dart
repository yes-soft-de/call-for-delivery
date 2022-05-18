import 'dart:convert';
import 'dart:math';

class NotificationModel {
  dynamic argument;
  ChatNotification? chatNotification;
  String? navigateRoute;
  NotificationModel({this.argument, this.chatNotification, this.navigateRoute});
  NotificationModel.fromJson(Map<String, dynamic> json) {
    argument = json['argument'];
    navigateRoute = json['navigate_route']?.toString();
    chatNotification = json['chatNotification'] != null
        ? ChatNotification.fromJson(json['chatNotification'])
        : null;
  }
}

class ChatNotification {
  String? roomID;
  int? senderID;
  ChatNotification({this.roomID, this.senderID});
  ChatNotification.fromJson(dynamic json) {
    if ((json is Map<String, dynamic>) == false) {
      json = JsonDecoder(json);
    }
    roomID = json['roomId'];
    senderID = json['userId'];
  }
}

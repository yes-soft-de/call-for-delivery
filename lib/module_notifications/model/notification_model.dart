import 'dart:convert';
import 'dart:developer';

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
  ChatNotification.fromJson(dynamic jjson) {
    if (jjson is String) {
      jjson = json.decode(jjson);
    }
    roomID = jjson['roomId'];
    senderID = int.tryParse(jjson['userId'] ?? '');
  }
}

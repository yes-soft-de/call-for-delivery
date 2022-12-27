import 'package:c4d/utils/logger/logger.dart';

class NoticeResponse {
  NoticeResponse({
    this.statusCode,
    this.msg,
    this.data,
  });

  NoticeResponse.fromJson(dynamic json) {
    try {
      statusCode = json['status_code'];
      msg = json['msg'];
      if (json['Data'] != null) {
        data = [];
        json['Data'].forEach((v) {
          data?.add(Data.fromJson(v));
        });
      }
    } catch (e) {
      statusCode = '-1';
      Logger().error('Notice Response', e.toString(), StackTrace.current);
    }
  }
  String? statusCode;
  String? msg;
  List<Data>? data;
}

class Data {
  Data({this.id, this.title, this.msg, this.appType});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    msg = json['msg'];
    appType = json['appType'];
  }
  int? id;
  String? title;
  String? msg;
  String? appType;
}

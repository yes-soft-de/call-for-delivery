import 'package:c4d/module_notice/model/notice_model.dart';

class NoticeRequest {
  int? id;
  String? title;
  String? msg;
  String? appType;
  List<NoticeImage>? images;

  NoticeRequest({this.id, this.title, this.msg, this.appType, this.images});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['msg'] = msg;
    map['appType'] = appType;
    map['images'] = images?.map((e) => e.image).toList();
    return map;
  }
}

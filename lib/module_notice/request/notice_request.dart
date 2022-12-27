class NoticeRequest {
  int? id;
  String? title;
  String? msg;
  String? appType;

  NoticeRequest({this.id, this.title, this.msg, this.appType});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['msg'] = msg;
    map['appType'] = appType;
    return map;
  }
}

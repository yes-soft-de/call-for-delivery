import 'created_at.dart';

class Datum {
  int? id;
  String? title;
  String? msg;
  CreatedAt? createdAt;

  Datum({this.id, this.title, this.msg, this.createdAt});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        title: json['title'] as String?,
        msg: json['msg'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : CreatedAt.fromJson(json['createdAt'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'msg': msg,
        'createdAt': createdAt?.toJson(),
      };
}

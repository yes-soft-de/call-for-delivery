import 'created_at.dart';

class Datum {
  int? id;
  String? title;
  String? msg;
  CreatedAt? createdAt;
  List<String>? images; 

  Datum({this.id, this.title, this.msg, this.createdAt, this.images});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        title: json['title'] as String?,
        msg: json['msg'] as String?,
        images: (json['images'] as List?)?.map((e) {
          return e['image'] as String;
        }).toList(),
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

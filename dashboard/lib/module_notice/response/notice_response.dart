// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
      Logger.error('Notice Response', e.toString(), StackTrace.current);
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

    images = (json['images'] as List?)?.map((e) {
      return ImageResponse.fromMap(e);
    }).toList();
  }

  int? id;
  String? title;
  String? msg;
  String? appType;
  List<ImageResponse>? images;
}

class ImageResponse {
  int? id;
  String? image;

  ImageResponse({
    this.id,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
    };
  }

  factory ImageResponse.fromMap(Map<String, dynamic> map) {
    return ImageResponse(
      id: map['id'] != null ? map['id'] as int : null,
      image: map['image']['image'] != null
          ? map['image']['image'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageResponse.fromJson(String source) =>
      ImageResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

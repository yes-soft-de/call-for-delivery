import 'data.dart';

class Dataum {
  Data? data;

  Dataum({this.data});

  factory Dataum.fromJson(Map<String, dynamic> json) => Dataum(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}

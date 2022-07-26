import 'data.dart';

class Data {
  Data? data;

  Data({this.data});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}

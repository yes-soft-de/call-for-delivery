import 'datum.dart';

class Data {
  Datum? data;

  Data({this.data});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json['data'] == null
            ? null
            : Datum.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'Data': data?.toJson(),
      };
}

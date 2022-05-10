import 'detail.dart';
import 'total.dart';

class Data {
  List<Detail>? detail;
  Total? total;

  Data({this.detail, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => Detail.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] == null
            ? null
            : Total.fromJson(json['total'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'detail': detail?.map((e) => e.toJson()).toList(),
        'total': total?.toJson(),
      };
}

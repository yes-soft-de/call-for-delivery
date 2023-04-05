import 'package:c4d/module_statistics/response/stores_counts/stores_counts.dart';

class Stores {
  StoresCounts? count;

  Stores({this.count});

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        count: json['count'] == null
            ? null
            : StoresCounts.fromJson(json['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'count': count?.toJson(),
      };
}

import 'stores_counts.dart';

class Stores {
  StoresCounts? counts;

  Stores({this.counts});

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        counts: json['count'] == null
            ? null
            : StoresCounts.fromJson(json['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'counts': counts?.toJson(),
      };
}

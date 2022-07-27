import 'count_stores.dart';

class Stores {
  CountStores? countStores;

  Stores({this.countStores});

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        countStores: json['count'] == null
            ? null
            : CountStores.fromJson(json['count'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'count': countStores?.toJson(),
      };
}

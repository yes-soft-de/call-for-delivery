import 'count_stores.dart';

class Stores {
  CountStores? countStores;

  Stores({this.countStores});

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        countStores: json['countStores'] == null
            ? null
            : CountStores.fromJson(json['countStores'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'countStores': countStores?.toJson(),
      };
}
